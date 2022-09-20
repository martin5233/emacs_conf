(require 'hideshow)
(require 'cl-seq)
(if (featurep 'uuid)
    (require 'uuid))
(require 'jiralib)
(require 'org-jira)
(require 'ma-jira-cache)

(defgroup ma nil
  "Martins customizations"
)

(defcustom ma-make-target "world"
  "Make target for SIMPACK builds"
  :type '(choice (const "world")
                 (const "simpack-gui")
                 (const "simpack-gui-runtime")
                 (const "simpack-slv")
                 (const "simpack-slv-runtime")
                 (const "solver")
                 (const "DoRunTests")
                 (const "ParserTest")
                 (const "RWCmpTest")
                 (const "COMModel")
                 (const "_simpack-script-runner")
                  )
  :group 'ma
)

(defcustom ma-build-dir "/scratch/apel/new_arch/obj/64"
  "Build directory for SIMPACK builds"
  :type '(choice (const "/scratch/apel/new_arch/obj/64")
                 (const "/scratch/apel/new_arch/obj/dbg64")
                 (const "/scratch/apel/new_arch/obj/opt-g")
                 )
  :group 'ma
)

(defun ma-kill-old-buffers ()
  "Kill buffers from end of buffer list (not used recently) until no more than 50 buffers are left. Remove temporary buffers and org mode files first."
  (interactive)
  (save-excursion
    (dolist (buffer (buffer-list))
      (if (and (or (string-match "^\*" (buffer-name buffer))
                   (string-match "\.org$" (buffer-name buffer))
                   (string-match "\.hpp$" (buffer-name buffer)))
               (not (processp (get-buffer-process buffer)))
               (not (buffer-modified-p buffer)))
          (kill-buffer buffer)))

    (dolist (buffer (reverse (nthcdr 50 (buffer-list))))
      (unless (or (eq buffer (current-buffer))
                  (buffer-modified-p buffer)
                  (processp (get-buffer-process buffer)))
        (kill-buffer buffer))))
)

(defun ma-switch-to-compilation-buffer ()
   "Switches to the compilation buffer"
   (interactive)
   (switch-to-buffer "*compilation*")
)

(global-set-key [?\C-c ?c]    'ma-switch-to-compilation-buffer)

(defun ma-switch-to-ebrowse-buffer ()
   "Switches to the ebrowse buffer"
   (interactive)
   (if (not (get-buffer "*Tree*"))
       (ma-update-ebrowse-db)
     (switch-to-buffer "*Tree*")
     )
)

(add-hook 'c++-mode-hook
	  (lambda ()
	    (local-set-key [?\C-c ?t] 'ma-switch-to-ebrowse-buffer)))

(defun ma-create-scratch-buffer nil
       "create a scratch buffer"
       (interactive)
       (switch-to-buffer (get-buffer-create "*scratch*"))
       (lisp-interaction-mode))

(defun ma-update-ebrowse-db ()
  "Update the database for Ebrowse"
  (interactive)
  (if (get-buffer "*Tree*")
      (kill-buffer "*Tree*"))
  (shell-command "cd /scratch/apel/new_arch; find develop/src/ooa -name '*.h' -o -name '*.cpp' | fgrep -v '.#' | ebrowse --output-file=/scratch/apel/new_arch/.ebrowse")
  (find-file "/scratch/apel/new_arch/.ebrowse")
  (bury-buffer "*Tree*")
)

(defun ma-run-cmake-and-compile ()
  "Run CMake in the current build directory"
  (interactive)
  (compile (concat "cd " ma-build-dir "; cmake .; ~/bin/my_compile " ma-build-dir " " ma-make-target))
)

(defun ma-is-windows-buffer(buffer)
  "Check if the given buffer belongs to a file stored on a Windows disk accessed via WSL."
  (string-match "^/mnt/[cd]/" (buffer-file-name buffer)))

(setq compilation-transform-file-match-alist '(("^D:\\\\users\\\\apel\\\\new_arch\\\\develop\\\\\\([a-zA-Z\\\\]*\\.cpp\\)"  "/mnt/d/users/apel/new_arch/develop/\\1")))

(defun ma-transform-compilation-file-name (filename)
  "Transform Windows filename to filename as accessible through WSL."
  (replace-regexp-in-string "^D:/users/apel/new_arch/" "/mnt/d/users/apel/new_arch/develop/" (string-replace "\\" "/" filename)))

(setq compilation-parse-errors-filename-function 'ma-transform-compilation-file-name)

(defun ma-compile-command ()
  "Return compilation command to use"
  (if (boundp 'ma-compile-command)
      ma-compile-command
    (cond (work-linux-remote
           (if (ma-is-windows-buffer (current-buffer)) "/mnt/c/windows/system32/cmd.exe /c D:/users/apel/compile_win.bat" "~/bin/my_remote_compile.sh"))
          (t                 "~/bin/my_compile"))))

(defun ma-run-compile ()
  "Run compilation"
  (interactive)
  (setq comp-command (ma-compile-command))
  (if (or (boundp 'ma-build-dir) (stringp 'ma-build-dir))
      (setq comp-command (concat comp-command " " ma-build-dir)))
  (if (or (boundp 'ma-make-target) (stringp 'ma-make-target))
      (setq comp-command (concat comp-command " " ma-make-target)))
  (print comp-command)

  (if (ma-is-windows-buffer (current-buffer))
      (let ((process-connection-type nil))              ;; This avoids processes hanging on WSL, when attempting to start
        (compile comp-command))
    (compile comp-command))
  )

(defun ma-run-sjs ()
  "Run sjs script."
  (interactive)
  (let* ((script-name (file-local-name (buffer-file-name)))
         (ld-lib-path (concat "LD_LIBRARY_PATH=" ma-build-dir "/run/bin/linux64;"))
         (slv (concat ma-build-dir "/run/bin/linux64/simpack-slv"))
         (local-cmd (mapconcat 'identity (list slv "-s" script-name) " "))
         (cmd (concat ld-lib-path local-cmd)))
    (compile cmd)))

(if work
    (progn
      (add-hook 'cmake-mode-hook
	             (lambda ()
;;	               (local-set-key [?\C-c ?m]    'ma-run-cmake-and-compile)
	               (local-set-key [?\C-c ?\C-c] 'ma-run-compile)))
      (add-hook 'c-mode-hook
	             (lambda ()
;;	               (local-set-key [?\C-c ?m]    'ma-run-cmake-and-compile)
	               (local-set-key [?\C-c ?\C-c] 'ma-run-compile)))
      (add-hook 'c++-mode-hook
	             (lambda ()
;;	               (local-set-key [?\C-c ?m]    'ma-run-cmake-and-compile)
	               (local-set-key [?\C-c ?\C-c] 'ma-run-compile)))
      (add-hook 'js-mode-hook
	             (lambda ()
	               (local-set-key [?\C-c ?\C-c] 'ma-run-sjs)))
      ))

(if home
    (progn
      (add-hook 'c-mode-hook
                (lambda()
                  (local-set-key (kbd "C-c C-c") 'compile)))
      (add-hook 'c++-mode-hook
                (lambda()
                  (local-set-key (kbd "C-c C-c") 'compile)))
      ))

(require 'notifications)
(defun ma-send-desktop-notification (summary body timeout)
  "notify via dbus"
(if work-linux-local
  (notifications-notify :title summary
                        :body body
                        :timeout timeout
                        :urgency "low"
                        :transient t)
  (message (concat message body))))

(defun ma-compile-notify (buffer message)
  (ma-send-desktop-notification "emacs compile" message 2000))

(push 'ma-compile-notify compilation-finish-functions)

(defun ma-rm-namespaces ()
  "Remove common namespace prefixes in marked region"
  (interactive)
  (if (use-region-p)
      (save-excursion
        (let* ((start (region-beginning))
               (end (region-end)))
          (progn
            (dolist (namespace (list "std" "NSBase" "NSModel" "llvm"))
              (goto-char start)
              (while (search-forward (concat namespace "::") end t)
                (replace-match "")
)))))))

(defun ma-show-agenda-if-hidden ()
  "Show Org agenda of today if it is currently hidden. Returns t, if it already was visible, otherwise nil"
  (interactive)
  (let* ((buf (get-buffer "*Org Agenda*")))
    (if (not buf)
      (progn
        (org-agenda-list 1)
        nil)
      (if (not (get-buffer-window buf))
          (progn
            (switch-to-buffer buf)
            nil)
        t)
      )
    )
)
(add-hook 'kill-emacs-query-functions
          'ma-show-agenda-if-hidden)

(if work
    (progn
      (run-with-idle-timer 600 t 'ma-show-agenda-if-hidden)))

(defun ma-instrument-func ()
  "Adds a Logger statement to the current function displaying its name upon entry and exit"
  (interactive)
  (setq funcname (which-function))
  (beginning-of-defun)
  (forward-line 2)
  (insert "Logger::INFO << \"" funcname "\" << \" entered\\n\";\n")
  (forward-line -1)
  (c-indent-line)
  (end-of-defun)
  (forward-line -1)
  (insert "Logger::INFO << \"" funcname "\" << \" exited\\n\";\n")
  (forward-line -1)
  (c-indent-line)
)

(defun ma-lowercase-args (&rest args)
  "Convert all arguments to lowercase"
  (let ((arg1 (nth 0 args)))
    (set-text-properties 0 (length arg1) nil arg1)
    (downcase arg1)))

(advice-add 'cmake-symbol-at-point :filter-return #'ma-lowercase-args)

(defconst ma-simpack-copyright "Copyright Dassault Systemes Simulia Corp.")
(defcustom ma-skip-copyright nil "Skip copyright update upon save, if set"
  :type 'boolean)
(make-variable-buffer-local 'ma-skip-copyright)

(defun ma-create-or-update-copyright ()
  "Scans the current buffer for a copyright string.
If one exists, it is updated to the correct formatting, if necessary.  If
not, a copyright comment is inserted at the start of the file."
  (when (and (string= major-mode "c++-mode") (not ma-skip-copyright))
    (save-excursion
      (goto-char (point-min))
      (let ((pos (re-search-forward "Copyright " 1000 t)))
        (if pos
            (let* ((copyright-start (- pos 10))
                   (in-comment (comment-only-p copyright-start pos))
                   (candidate (buffer-substring-no-properties copyright-start
                                                              (+ copyright-start (length ma-simpack-copyright))))
                   (done (string= candidate ma-simpack-copyright)))
              (when (not done)
                (hs-show-block)
                (goto-char copyright-start)
                (kill-line)
                (insert ma-simpack-copyright)))
          (progn
            (goto-char (point-min))
            (insert (concat "/*\n * " ma-simpack-copyright "\n */\n"))
            ))))))

(defun ma-insert-random-uuid()
  (interactive)
  (insert (uuid)))

(defun ma-get-password ()
  (let* ((host "message.emea.3ds.com")
         (found (nth 0 (auth-source-search :max 1
                                           :host host
                                           :require '(:user :secret)
                                           :create nil))))
    (if found
        (let* ((secret (plist-get found :secret))
               (password (if (functionp secret) (funcall secret) secret))
               (save-func (plist-get found :save-function)))
          (when (functionp save-func)
            (funcall save-func))
          password)
      nil)))

(defun ma-grep-setup-erase-date()
  "Remove date from start of grep buffers to avoid matching the current date by grep-regexp-alist"
  (save-excursion
    (make-variable-buffer-local 'compilation-auto-jump-to-first-error)
    (setq compilation-auto-jump-to-first-error nil)
    (let ((inhibit-read-only t))
      (goto-char (point-min))
      (if (re-search-forward "^Grep started at " nil t)
          (delete-region (line-beginning-position) (line-end-position)))
      )))

(add-hook 'grep-setup-hook 'ma-grep-setup-erase-date)

(defconst ma-src-trees
  '(("master" . "/scratch/apel/new_arch/")
    ("2023" . (concat work-remote-url "/scratch/apel/new_arch_2023.Y/"))
    ("Windows" . "/mnt/e/users/apel/new_arch/")))


(defun ma-choose-file-in-other-tree()
  "Takes the file displayed in the current buffer and choose the same file in another tree.
   This uses trees defined via ma-src-trees and offers each one of them to the user.
   Returns the filename in the other tree."
  (let* ((cur-file (buffer-file-name))
         (entry (cl-find-if (lambda(item)
                              (let* ((len (length (cdr item)))
                                     (to (if (> len (length cur-file)) nil len)))
                                (equal (cdr item) (substring cur-file 0 to))))
                            ma-src-trees)))
         (when entry
           (let* ((old-prefix (cdr entry))
                  (reduced-list (remove entry ma-src-trees))
                  (collection (mapcar 'car reduced-list))
                  (choice (completing-read "Choose alternate tree: " collection))
                  (new-filename (concat (cdr (assoc choice ma-src-trees)) (substring cur-file (length old-prefix)))))
             new-filename
           )
        )
  ))

(defun ma-find-file-in-other-tree()
  "Takes the file displayed in the current buffer and opens the same file in another tree.
   This uses trees defined via ma-src-trees and offers each one of them to the user."
  (interactive)
  (let ((other-file (ma-choose-file-in-other-tree)))
    (if other-file
        (find-file-other-window other-file)
      (message "Current file not found in any tree")
      )))

(defun ma-diff-file-in-other-tree()
  "Takes the file displayed in the current buffer and diffs it against the same file in another tree."
  (interactive)
  (let ((other-file (ma-choose-file-in-other-tree))
        (this-buffer (current-buffer)))
    (if other-file
        (ediff-buffers (find-file-other-window other-file) this-buffer)
      (message "Current file not found in any tree")
      ))
  )

(defun ma-ifdef-region()
  (interactive)
  (if (region-active-p)
      (progn
        (narrow-to-region (region-beginning) (region-end))
        (goto-char (point-min))
        (insert "#ifdef SPCK_QTSCRIPT\n")
        (goto-char (point-max))
        (insert "#endif\n")
        (widen)
        )
    (progn
      (goto-char (line-beginning-position))
      (insert "#ifdef SPCK_QTSCRIPT\n")
      (goto-char (line-end-position))
      (insert "\n#endif"))))

(defconst powershell-exe "/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe")
(defun ma-browse-url (url &optional new-window)
  "Opens link via powershell.exe."
  (when (request-url-file-p url)
    (let* ((src-path (substring url 7))
           (filename (file-name-nondirectory src-path)))
      (copy-file src-path (concat "/mnt/c/temp/" filename))
      (setq url (concat "file://C:/temp/" filename))))
  (let ((quotedUrl (format "start '%s'" url)))
    (apply 'call-process powershell-exe
           nil 0 nil (list "-Command" quotedUrl))))

(if (file-executable-p powershell-exe)
    (setq-default browse-url-browser-function 'ma-browse-url)
    (setq-default browse-url-browser-function 'browse-url-firefox))


(defcustom ma-current-dev "" "Number of current SPCK issue to work on."
  :type '(string)
  :group 'ma)

(defconst ma-devs-basedir "/ssh:MAL1@dell1254cem:devs/")

(defun ma-set-current-dev (&optional all-cached-issues)
  "Set current dev issue."
  (interactive "P")
  (let* ((issue-key (ma-select-jira-issue all-cached-issues)))
    (unless (string-match "^SPCK-\\([0-9]+\\)$" issue-key)
      (error "Unexpected SPCK issue number format"))
    (setq ma-current-dev (string-to-number (match-string 1 issue-key)))))
(global-set-key (kbd "C-c m s") 'ma-set-current-dev)

(defun ma--current-dev-dir()
  "Return the directory belonging to the current directory for the dev issue stored in ma-current-dev"
  (concat ma-devs-basedir ma-current-dev))

(defun ma-dired-current-dev()
  "Open dired in the directory for the current dev issue."
  (interactive)
  (unless ma-current-dev
    (ma-set-current-dev))
  (let ((dir (ma--current-dev-dir)))
    (unless (file-exists-p dir)
      (progn
        (message (concat "Downloading data for SPCK-" ma-current-dev))
        (shell-command (concat "ssh MAL1@dell1254cem /home/home_dev/MAL1/perl/download_jira_attachments.pl " ma-current-dev) (generate-new-buffer (concat "*Download " ma-current-dev "*")))))
    (dired (file-truename (ma--current-dev-dir)))))
(global-set-key (kbd "C-c m d") 'ma-dired-current-dev)

(defun ma-browse-current-dev()
  "Open browser with the current dev issue."
  (interactive)
  (browse-url (concat jiralib-url "/browse/SPCK-" ma-current-dev)))
(global-set-key (kbd "C-c m b") 'ma-browse-current-dev)

(defun ma-insert-current-dev()
  "Insert the current dev issue number at point."
  (interactive)
  (insert ma-current-dev))
(global-set-key (kbd "C-c m i") 'ma-insert-current-dev)

(defun ma-insert-separator()
  "Insert a separator line consisting of asterisks before the current function.
   The file is scanned for existing separator lines and inserts a
   line with the maximum length of any existing separator lines.
   If no separator lines exist, a line of length 80 will be
   inserted. A warning is issued, if the length of separator
   lines is inconsistent in the file.  Point is not modified."
  (interactive)
  (let ((longest 0)
        (shortest 1000))
    (save-mark-and-excursion
      (goto-char (point-min))
      (while (and (not (eobp)) (re-search-forward "^//\\*+[:space:]*$" nil t))
        (let ((len (length (match-string 0))))
          (setq longest (max longest len))
          (setq shortest (min shortest len))))
      (if (eq longest 0)
          (setq longest 80)
        (when (not (eq longest shortest))
          (message "Asterisk separators are not consistent."))))
    (save-mark-and-excursion
      (c-beginning-of-defun)
      (let ((end (point)))
        (c-end-of-defun -1)
        (let ((start (point)))
          (delete-region start end)
          (insert (concat "\n//" (make-string (- longest 2) ?*) "\n\n")))))))

(defun ma-select-jira-issue(all-cached-issues)
  "Select a jira issue using completion."
  (let* ((issues (if all-cached-issues
                     (ma-jira-cache-keys)
                   (jiralib-do-jql-search "project = SPCK AND issuetype = Development AND status = \"In Progress\" AND assignee in (currentUser())")))
         (keys (cl-mapcar 'org-jira-get-issue-key issues)))
    (completing-read "Select JIRA issue: " keys)))


(provide 'ma-funcs)
