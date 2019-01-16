;;; atl-stash.el --- Interface to Atlassian Stash    -*- lexical-binding: t; -*-

;; Copyright (C) 2014  Martin Apel

;; Author: Martin Apel <martin.apel@web.de>
;; Keywords: vc, comm

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Interface to Atlassian Stash
;; Provides functions to display Stash status for current user (pull requests to review, own pull requests)

;;; Code:
(require 'request)
(require 'password-cache)
(require 'json)
(require 'auth-source)
(require 'url-parse)
(require 'magit)
(require 'cl)

;; Custom variables

(defgroup stash nil
  "Stash settings."
  :group 'vc)

(defcustom stash-url "https://spck-stash.ux.dsone.3ds.com:7990"
  "URL of Stash server"
  :group 'stash)

(defcustom stash-repos nil
  "Mapping from repository name to location, where it is available"
  :type 'alist
  :group 'stash)

(defcustom stash-reviewer-shortcuts nil
  "Mapping from reviewer's name to his shortcut"
  :type 'alist
  :group 'stash)

(defcustom stash-target-branch-regex "^origin/master$"
  "A regular expression matching possible target branches to merge to during stash-create-pull-request"
  :type 'regexp
  :group 'stash)

;; Local variables belonging to this mode
(defvar stash-mode-line-string "" "This variable contains the status of open pull requests from Stash")
(defvar stash-last-repo-update nil "This variable contains the last time the repository list has been updated")
(defvar stash-repo-list nil "List of Stash projects and repositories")
(defvar stash-access-headers nil "Headers needed to access Stash")
(defvar stash-open-pr-count 0 "Number of open pull-requests to review")
(defvar stash-own-pr-count 0 "Number of own pull-requests to review")
(defvar stash-num-repos-to-update 0 "Number of repositories to update")
(defvar stash-pr-data nil "Alist, which stores the JSON data returned for the pull requests in each repository.
It is indexed by a string concatenated from the project and repository name in Stash, separated by a slash.
The right hand side is equal to the JSON string returned by Stash for that repository, which contains the data
for all open pull requests")
(defvar stash-show-pending nil "t if user initiated a show of all pull requests, while the data was asynchronously retrieved")
(defvar stash-force-update nil)
(defvar stash-pull-request-create-finalize-hook nil)

(make-variable-buffer-local 'stash-pull-request-create-finalize-hook)

(defvar stash-mode-map
  (let ((map (make-sparse-keymap)))
    (set-keymap-parent map special-mode-map)
    (define-key map (kbd "a") 'stash-approve-pull-request)              ;; done
    (define-key map (kbd "b") 'stash-browse-pull-request)               ;; done
    (define-key map (kbd "c") 'stash-create-pull-request)               ;; done
    (define-key map (kbd "d") 'stash-decline-pull-request)
    (define-key map (kbd "g") 'stash-show-pull-requests)                ;; done
    (define-key map (kbd "l") 'stash-show-pull-request-log)             ;; done
    (define-key map (kbd "m") 'stash-merge-pull-request)
    (define-key map (kbd "n") 'stash-next-pull-request)                 ;; done
    (define-key map (kbd "p") 'stash-prev-pull-request)                 ;; done
    (define-key map (kbd "r") 'stash-review-pull-request)               ;; done
    (define-key map (kbd "TAB") 'stash-pull-request-expand-or-collapse) ;; done
    map)
  "Keymap for Stash mode")

(defvar stash-pull-request-create-mode-map
  (let ((map (make-sparse-keymap)))
    (set-keymap-parent map text-mode-map)
    (define-key map (kbd "C-c C-c") 'stash-create-pull-request-finalize)
    (define-key map (kbd "C-c C-k") 'stash-create-pull-request-abort)
    map)
  "Keymap for Stash pull request creation mode")

(defface stash-section-title
  '((((class color) (background light))
     :background "grey11")
    (((class color) (background dark))
     :background "grey80"))
  "Face for section titles."
)



;; Local functions

(defun stash-init-headers ()
  "Initialize headers variable stash-access-headers for Stash access"
  (unless stash-access-headers
    (let* ((auth-source-creation-prompts '((user . "Stash user at %h: ")
                                           (secret . "Stash Password: ")))
           (hostname (url-host (url-generic-parse-url stash-url)))
           (found (nth 0 (auth-source-search :max 1
                                             :host hostname
                                             :require '(:user :secret)
                                             :create t))))
      (when found
        (let* ((user (plist-get found :user))
               (secret (plist-get found :secret))
               (password (if (functionp secret) (funcall secret) secret))
               (save-func (plist-get found :save-function))
               (auth (concat "Basic " (base64-encode-string (concat user ":" password)))))
          (when (functionp save-func)
            (funcall save-func))
          (setq stash-access-headers (list '("Content-Type" . "application/json") (cons "Authorization" auth))))))))

(defun stash-update-projects-if-necessary ()
  "Update the list of projects and repositories for stash"
  (if (or stash-force-update (not (and (floatp stash-last-repo-update) (< (- (float-time) stash-last-repo-update) 10000))))
      (progn
        (message "Updating Stash project and repository list")
        (setq stash-repo-list nil)
        (request (concat stash-url "/rest/api/1.0/projects")
                 :headers stash-access-headers
                 :parser 'json-read
                 :sync t
                 :success (function*
                           (lambda (&key data &allow-other-keys)
                             (let* ((values (assoc-default 'values data)))
                               (dotimes (i (length values))
                                 (stash-update-repositories (assoc-default 'key (aref values i)))
                                 )
                               )
                             ))
                 )
        (setq stash-last-repo-update (float-time))
        )
    )
  )

(defun stash-update-repositories (project)
  "Returns the list of repositories for the given project"
  (request (concat stash-url (format "/rest/api/1.0/projects/%s/repos" project))
           :headers stash-access-headers
           :parser 'json-read
           :sync t
           :success (function*
                     (lambda (&key data &allow-other-keys)
                       (let ((values (assoc-default 'values data))
                             (result nil))
                         (progn
                           (dotimes (i (length values))
                             (push (assoc-default 'slug (aref values i)) result))
                           (add-to-list 'stash-repo-list (cons project result)))
                         )))
           )
  )

(defun stash-decompose-stash-info (data)
  "Decompose information delivered by Stash and put the result info stash-mode-line-string"
  (let ((values (assoc-default 'values data)))
    (progn
      (dotimes (i (length values))
        (let* ((value (aref values i))
               (author (assoc-default 'name (assoc-default 'user (assoc-default 'author value))))
               (reviewers (assoc-default 'reviewers value))
               (saw-myself-in-reviewers nil))
          (progn
            (if (string-equal author (upcase (user-login-name)))
                (setq stash-own-pr-count (1+ stash-own-pr-count)))
            (dotimes (j (length reviewers))
              (let* ((reviewer (aref reviewers j))
                     (name (assoc-default 'name (assoc-default 'user reviewer)))
                     (approved (assoc-default 'approved reviewer)))
                (if (and (string-equal name (upcase (user-login-name))) (eq approved :json-false))
                    (setq saw-myself-in-reviewers t))
                ))
            (if saw-myself-in-reviewers
                (setq stash-open-pr-count (1+ stash-open-pr-count)))
            )
          )
        )
      (setq stash-num-repos-to-update (1- stash-num-repos-to-update))
      (if (= stash-num-repos-to-update 0)
          (progn
            (setq stash-mode-line-string (format "%d/%d" stash-own-pr-count stash-open-pr-count))
            (force-mode-line-update)
            (if stash-show-pending
                (progn
                  (setq stash-show-pending nil)
                  (stash-show-pull-requests-internal)))
            )
        )
      )
    )
  )

(defun stash-update-stash-info ()
  "Provide information about the current state of Stash pull requests"
  (stash-init-headers)
  (stash-update-projects-if-necessary)
  (setq stash-open-pr-count 0)
  (setq stash-own-pr-count 0)
  (setq stash-num-repos-to-update 0)
  (setq stash-pr-data nil)
  (dolist (project stash-repo-list)
    (setq stash-num-repos-to-update (+ stash-num-repos-to-update (length (cdr project)))))

  (dolist (project stash-repo-list)
    (dolist (repo (cdr project))
      (request (concat stash-url (format "/rest/api/1.0/projects/%s/repos/%s/pull-requests" (car project) repo))
               :headers stash-access-headers
               :parser 'json-read
               :sync nil
               :success (function*
                         (lambda (&key data &allow-other-keys)
                           (push (cons (concat (car project) "/" repo) (assoc-default 'values data)) stash-pr-data)
                           (stash-decompose-stash-info data)
                           ))))))


(defun stash-pr-to-id (pr)
  "Constructs a unique string identifier for this pull request"
  (let* ((project (assoc-default 'key (assoc-default 'project (assoc-default 'repository (assoc-default 'toRef pr)))))
         (repo (assoc-default 'slug (assoc-default 'repository (assoc-default 'toRef pr))))
         (id (assoc-default 'id pr)))
    (format "%s/%s:%s" project repo id)))

(defun stash-id-to-pr (id)
  "Retrieves the pull request identified by id. Id must have been constructed by a call to stash-pr-to-id."
  (string-match "\\([A-Za-z0-9\\-]+\\)/\\([A-Za-z0-9\-_]+\\):\\([0-9]+\\)" id)
  (let* ((project (match-string 1 id))
         (repo (match-string 2 id))
         (pr-id (string-to-number (match-string 3 id)))
         (pr-list (assoc-default (concat project "/" repo) stash-pr-data))
         (result nil))
    (dotimes (i (length pr-list))
      (let ((pr (aref pr-list i)))
        (if (eq pr-id (assoc-default 'id pr))
            (setq result pr))))
    result))

(defun stash-map-reviewer (reviewer)
  "Map REVIEWER by looking him up in `stash-reviewer-shortcuts'.
If the reviewer is listed there, his shortcut
is returned.  If the reviewer is not found, the original string is returned."
  (let ((mapped (assoc-default reviewer stash-reviewer-shortcuts)))
    (if mapped mapped reviewer)))

(defun stash-gen-pr-info (pr short)
  "Generate a description string for the given pull request. If short is t, generate a one line description, otherwise a multi-line description."
  (let* ((author (assoc-default 'name (assoc-default 'user (assoc-default 'author pr))))
         (repo (assoc-default 'slug (assoc-default 'repository (assoc-default 'toRef pr))))
         (title (assoc-default 'title pr))
         (shortened-title (if (> (length title) 72) (concat (substring title 0 70) "...") title))
         (id (assoc-default 'id pr))
         (descr (assoc-default 'description pr))
         (reviewer-list (assoc-default 'reviewers pr))
         (reviewers-accepted nil)
         (reviewers-waiting nil)
         (line "")
         )
    (dotimes (i (length reviewer-list))
      (let* ((reviewer (aref reviewer-list i))
             (reviewer-name (assoc-default 'name (assoc-default 'user reviewer)))
               (approved (not (eq (assoc-default 'approved reviewer) :json-false)))
               (text (stash-map-reviewer reviewer-name))
               )
        (if approved
            (push text reviewers-accepted)
          (push text reviewers-waiting))))
    (setq line (format "%-13s #%-5d %-8s %-75s  Waiting: %-20s  Accepted: %-s"
                       repo id author shortened-title
                       (mapconcat 'identity (sort reviewers-waiting 'string<) ",")
                       (mapconcat 'identity (sort reviewers-accepted 'string<) ",")))
    (if (and (not short) descr)
        (setq line (concat line "\n" (replace-regexp-in-string "\r" "" descr) "\n")))
    (propertize line 'pr (stash-pr-to-id pr))))

(defun stash-am-i-reviewer (pr)
  "Returns true, if the current user is listed as a reviewer in the given pull request and he has not approved yet."
  (let ((reviewers (assoc-default 'reviewers pr))
        (saw-myself-in-reviewers nil))
    (dotimes (i (length reviewers))
      (let* ((reviewer (aref reviewers i))
             (name (assoc-default 'name (assoc-default 'user reviewer)))
             (approved (assoc-default 'approved reviewer)))
        (if (and (string-equal name (upcase (user-login-name))) (eq approved :json-false))
            (setq saw-myself-in-reviewers t))
        ))
    saw-myself-in-reviewers))

(defun stash-am-i-author (pr)
  "Returns true, if the current user is the author of this pull request."
  (let ((author (assoc-default 'name (assoc-default 'user (assoc-default 'author pr)))))
    (string-equal author (upcase (user-login-name)))))

(defun stash-show-section(title predicate)
  "Display a section of pull-requests passing the predicate function."
  (insert (concat (propertize title 'face 'stash-section-title) "\n"))
  (dolist (project-entry stash-pr-data)
    (let ((prdata-for-repo (cdr project-entry)))
      (dotimes (i (length prdata-for-repo))
        (let ((pr (aref prdata-for-repo i)))
          (if (funcall predicate pr)
              (insert (concat "\n" (stash-gen-pr-info pr t))))))))
  )

(defun stash-show-pull-requests-internal()
  "Actually show all currently pending pull requests"
  (switch-to-buffer (set-buffer (get-buffer-create "*Stash*")))
  (let ((buffer-read-only nil))
    (erase-buffer)
    (stash-show-section "OPEN PULL REQUESTS TO REVIEW" 'stash-am-i-reviewer)
    (insert "\n\n")
    (stash-show-section "OWN PULL REQUESTS" 'stash-am-i-author)
    (insert "\n\n")
    (stash-show-section "OTHER PULL REQUESTS" '(lambda(pr) (and (not (stash-am-i-author pr)) (not (stash-am-i-reviewer pr)))))
    (insert "\n")
    (stash-mode)
    (goto-char (point-min))
    (stash-next-pull-request)))

(defun stash-get-current-pr()
  "Retrieve the current pull request from the cursor location"
  (stash-id-to-pr (get-text-property (point) 'pr))
  )

(defun stash-merge-base(repo-dir from-branch to-branch)
  "Call git merge-base with the two branches and return the merge base as a string"
  (let ((git-dir-opt (concat "--git-dir=" repo-dir "/.git")))
    (magit-call-git git-dir-opt "fetch" "origin")
    (magit-git-string git-dir-opt "merge-base" from-branch to-branch)))

(defun stash-find-target-branch(repo-dir source-branch)
  "Determine the branch, from which the target branch was branched off. This will be used as the target branch, where to merge to.
   In case multiple branches are available, let the user choose."
  (let* ((git-dir-opt (concat "--git-dir=" repo-dir "/.git"))
         (filter (lambda(elem) (and (string-match-p stash-target-branch-regex elem) elem)))
         (remote-branches (mapcar 's-trim (magit-git-lines git-dir-opt "branch" "-r")))
         (matching-remote-branches (delq nil (mapcar filter remote-branches)))
         (merge-base (magit-git-string git-dir-opt "merge-base" source-branch matching-remote-branches))
         (target-candidates (mapcar 's-trim (magit-git-lines git-dir-opt "branch" "-r" "--contains" merge-base)))
         (matching-target-candidates (delq nil (mapcar filter target-candidates))))
    (substring
     (if (eq (length matching-target-candidates) 1)
         (car matching-target-candidates)
       (completing-read "Please choose target branch: " matching-target-candidates)) 7)))
;;
;; Interactive commands
;;

(defun stash-show-pull-requests()
  "Show all currently pending pull requests"
  (interactive)
  (if (> stash-num-repos-to-update 0)
      (setq stash-show-pending t)
    (stash-show-pull-requests-internal)
  ))

(defun stash-pull-request-expand-or-collapse()
  "Expand or collapse current pull request"
  (interactive)
  (if (get-text-property (point) 'pr)
      (let* ((buffer-read-only nil)
             (cur-pr (stash-get-current-pr))
             (cur-pos (+ (point) 1))
             (prev-change (previous-single-property-change cur-pos 'pr))
             (next-change (next-single-property-change cur-pos 'pr))
             (start (or prev-change (point)))
             (end   (or next-change (- (point-max) 1)))
             (expand (eq (line-number-at-pos start) (line-number-at-pos end))))
        (delete-region start end)
        (goto-char start)
        (insert (stash-gen-pr-info cur-pr (not expand)))
        (goto-char start)
        (when expand
          (fill-region (line-beginning-position 2) (line-end-position 2) t))
      )
  ))

(defun stash-next-pull-request()
  "Navigate to the next pull request"
  (interactive)
  (let* ((pr (get-text-property (point) 'pr))
         (cur-pr pr))
    (while (and (not (eobp)) (or (not cur-pr) (eq cur-pr pr)))
      (let ((pos (next-single-property-change (point) 'pr)))
        (if pos
            (progn
              (setq cur-pr (get-text-property pos 'pr))
              (goto-char pos))
          (setq cur-pr t)))))
  )

(defun stash-prev-pull-request()
  "Navigate to the prev pull request"
  (interactive)
  (let* ((pr (get-text-property (point) 'pr))
         (cur-pr pr))
    (while (and (not (bobp)) (or (not cur-pr) (eq cur-pr pr)))
      (let ((pos (previous-single-property-change (point) 'pr)))
        (if pos
            (progn
              (setq cur-pr (get-text-property pos 'pr))
              (goto-char pos))
          (setq cur-pr t)))))
  )

(defun stash-browse-pull-request()
  "Open the pull request under the cursor in a browser"
  (interactive)
  (let ((pr (stash-get-current-pr)))
    (if pr
        (browse-url (assoc-default 'href (aref (assoc-default 'self (assoc-default 'links pr)) 0))))))

(defun stash-create-pull-request()
  "Opens the browser on the page to create a pull request for the current branch"
  (interactive)
  (let* ((default-directory (magit-read-repository nil))
         (project "SPCK")
         (repo (car (rassoc default-directory stash-repos)))
         (source-branch (substring (magit-get-upstream-branch) 7))
         (target-branch (stash-find-target-branch default-directory (concat "origin/" source-branch)))
         (merge-base (stash-merge-base default-directory (concat "origin/" source-branch) (concat "origin/" target-branch))))
    (unless repo
      (user-error "Directory %s is not registered in stash-repos"))
    (set-buffer (get-buffer-create "*Stash Create Pull Request*"))
    (erase-buffer)
    (message (concat "Calling git log " merge-base "..origin/" source-branch))
    (insert (s-join "\n" (magit-git-lines "log" "--format=format:%B" (concat merge-base "..origin/" source-branch))))
    (goto-char (point-min))
    (forward-line 1)
    (insert "\n")
    (stash-pull-request-create-mode)
    (add-hook 'stash-pull-request-create-finalize-hook
              (apply-partially 'stash-post-pull-request
                               (current-buffer) source-branch target-branch project repo) nil t)
    (pop-to-buffer (current-buffer))
    ))


(defun stash-post-pull-request(editbuffer source-branch target-branch project repo)
  (with-current-buffer editbuffer
    (goto-char (point-min))
    (let* ((title (buffer-substring-no-properties (line-beginning-position) (line-end-position)))
           (descr (buffer-substring-no-properties (line-beginning-position 2) (point-max)))
           (url (concat stash-url (format "/rest/api/1.0/projects/%s/repos/%s/pull-requests" project repo)))
           (body `(("title" . ,title)
                   ("description" . ,descr)
                   ("state" . "OPEN")
                   ("open" . t)
                   ("closed" . ,json-false)
                   ("fromRef" .
                    (("id" . ,(concat "refs/heads/" source-branch))
                     ("repository" .
                      (("slug" . ,repo)
                       ("name" . ,json-null)
                       ("project" . (("key" . ,project)))))))
                   ("toRef" .
                    (("id" . ,(concat "refs/heads/" target-branch))
                     ("repository" .
                      (("slug" . ,repo)
                       ("name" . ,json-null)
                       ("project" . (("key" . ,project)))))))
                   ("locked" . ,json-false)))
           (body-encoded (json-encode-alist body)))
      (request url
               :headers stash-access-headers
               :type "POST"
               :data body-encoded
               :parser 'json-read
               :sync t)
      )))

(defun stash-create-pull-request-finalize()
  "Actually create the pull request with the data entered into the current buffer."
  (interactive)
  (run-hooks 'stash-pull-request-create-finalize-hook)
  (kill-buffer (current-buffer)))

(defun stash-create-pull-request-abort()
  "Abort creating a pull request."
  (interactive)
  (kill-buffer (current-buffer)))

(defun stash-review-pull-request()
  "Open a magit diff buffer for the current pull request"
  (interactive)
  (let* ((pr (stash-get-current-pr))
        (from-branch (replace-regexp-in-string "^refs/heads/" "origin/" (assoc-default 'id (assoc-default 'fromRef pr))))
        (to-branch (replace-regexp-in-string "^refs/heads/" "origin/" (assoc-default 'id (assoc-default 'toRef pr))))
        (repo (assoc-default 'slug (assoc-default 'repository (assoc-default 'fromRef pr))))
        (repo-dir (assoc-default repo stash-repos))
        (default-directory repo-dir)
        (merge-base (stash-merge-base repo-dir from-branch to-branch)))
    (magit-diff (concat merge-base ".." from-branch))))

(defun stash-approve-pull-request()
  "Approve current pull request"
  (interactive)
  (let* ((pr (stash-get-current-pr))
         (project (assoc-default 'key (assoc-default 'project (assoc-default 'repository (assoc-default 'toRef pr)))))
         (repo (assoc-default 'slug (assoc-default 'repository (assoc-default 'toRef pr))))
         (id (assoc-default 'id pr))
         (author (assoc-default 'name (assoc-default 'user (assoc-default 'author pr))))
         (title (assoc-default 'title pr))
         (url (concat stash-url (format "/rest/api/1.0/projects/%s/repos/%s/pull-requests/%s/approve" project repo id))))
    (when (yes-or-no-p (format "Approve pull %s by %s?" title author))
      (message (concat "Sending to " url))
      (request url
               :headers stash-access-headers
               :type "POST"
               :parser 'json-read
               :sync t)
      (stash-update-stash-info)
      (stash-show-pull-requests)
      )))

(defun stash-show-pull-request-log()
  "Show log of the branch belonging to the current pull request"
  (interactive)
  (let* ((pr (stash-get-current-pr))
         (from-branch (replace-regexp-in-string "^refs/heads/" "origin/" (assoc-default 'id (assoc-default 'fromRef pr))))
         (to-branch (replace-regexp-in-string "^refs/heads/" "origin/" (assoc-default 'id (assoc-default 'toRef pr))))
         (repo (assoc-default 'slug (assoc-default 'repository (assoc-default 'fromRef pr))))
         (repo-dir (assoc-default repo stash-repos))
         (default-directory repo-dir)
         (merge-base (stash-merge-base repo-dir from-branch to-branch))
         (default-directory repo-dir))
    (magit-log (list (concat merge-base ".." from-branch)))))

(define-derived-mode stash-mode special-mode "Stash"
  "Stash mode to provide access to pull requests in Stash"
  (buffer-disable-undo)
  )

(define-derived-mode stash-pull-request-create-mode text-mode "Stash Create Pull Request"
  "Mode to create pull requests in Stash"
  )

(provide 'atl-stash)
;;; atl-stash.el ends here
