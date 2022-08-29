(require 'jiralib)
(require 'org-jira)
(require 'savehist)

(defvar ma-jira-key-to-summary-alist nil)
(defvar ma-jira-issues-to-retrieve nil)

(add-to-list 'savehist-additional-variables 'ma-jira-issues-to-retrieve)

(defun ma-marginalia-jira--fill-cache()
  "Transform the response from the JIRA server to fill the cache."
  (message "Filling cache with JIRA issue ids and summaries")
  (let* ((issues (jiralib-do-jql-search "assignee in (currentUser())"))
         (keys (cl-mapcar 'org-jira-get-issue-key issues))
         (summaries (cl-mapcar 'org-jira-get-issue-summary issues)))

    (setq ma-jira-issues-to-retrieve (remove-duplicates (append ma-jira-issues-to-retrieve keys) :test 'string=))
    (setq ma-jira-key-to-summary-alist (cl-pairlis keys summaries))))

(defun ma-marginalia-jira--annotator (cand)
  (let ((summary (cdr (assoc cand ma-jira-key-to-summary-alist))))
    (if summary
        (marginalia--fields (summary :truncate 1.0 :face 'marginalia-value))
      (marginalia--fields ("Unknown" :truncate 1.0 :face 'marginalia-value)))))

;; (defun ma-marginalia-jira--completing-read-advice(prompt collection &optional predicate
;;                                                          require-match initial-input
;;                                                          hist def inherit-input-method)
;;   (message "Advice called")
;;   (when (arrayp collection)
;;     (mapcar (lambda(entry)
;;               (when (stringp entry)
;;                 (message (concat "Found entry " entry))))
;;             collection))
;;   )



(eval-after-load 'marginalia
  (lambda ()
;;    (advice-add #'completing-read-default :before #'ma-marginalia-jira--completing-read-advice)
    (add-to-list 'marginalia-prompt-categories '("JIRA" . jira))
    (add-to-list 'marginalia-command-categories '(org-roam-node-find . jira))
    (add-to-list 'marginalia-annotator-registry
                 '(jira ma-marginalia-jira--annotator))))

(run-with-idle-timer 30 nil 'ma-marginalia-jira--fill-cache)
