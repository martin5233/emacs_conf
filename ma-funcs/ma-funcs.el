(require 'hideshow)
(if (featurep 'uuid)
    (require 'uuid))

(defgroup ma nil
  "Martins customizations"
)

(defcustom ma-make-target "world"
  "Make target for SIMPACK builds"
  :type '(choice (const "world")
                 (const "simpack-gui")
                 (const "simpack-slv")
                 (const "solver")
                 (const "DoRunTests")
                 (const "ParserTest")
                 (const "RWCmpTest")
                 (const "simpack-post")
                 (const "_simpack-doe-master")
                 (const "GUIUtils")
                 (const "DoE")
                 (const "Model")
                 (const "_simpack-sfx")
                 (const "DocQtScript")
                 (const "DocCOMInterface")
                 (const "COMModel")
                  )
  :group 'ma
)

(defcustom ma-build-dir "/scratch/apel/new_arch/obj/32"
  "Build directory for SIMPACK builds"
  :type '(choice (const "/scratch/apel/new_arch/obj/32")
                 (const "/scratch/apel/new_arch/obj/dbg32")
                 (const "/scratch/apel/new_arch/obj/64")
                 (const "/scratch/apel/new_arch/obj/opt-g")
                 (const "/scratch/apel/new_arch/obj/gcc-4.8")
                 (const "/scratch/apel/new_arch/obj/gcc-4.9")
                 (const "/scratch/apel/new_arch/obj/qt5")
                 )
  :group 'ma
)

(defun show-frame (&optional frame)
  "Show the current Emacs frame or the FRAME given as argument.
   And make sure that it really shows up!"
  (raise-frame)
  ; yes, you have to call this twice. Don’t ask me why…
  ; select-frame-set-input-focus calls x-focus-frame and does a bit of
  ; additional magic.
  (select-frame-set-input-focus (selected-frame))
  (select-frame-set-input-focus (selected-frame)))


(defun ma-kill-old-buffers ()
  "Kill buffers from end of buffer list (not used recently) until no more than 50 buffers are left. Remove temporary buffers first."
  (interactive)
  (save-excursion
    (dolist (buffer (buffer-list))
      (if (and (or (string-match "^\*" (buffer-name buffer))
                   (string-match "\.hpp$" (buffer-name buffer)))
               (not (processp (get-buffer-process buffer))))
          (kill-buffer buffer)))

    (dolist (buffer (reverse (nthcdr 50 (buffer-list))))
      (unless (eq buffer (current-buffer))
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

(defun ma-assistant ()
  "runs qt assistant"
  (interactive)
  (let ((p (get-process "assistant")))
    (if p
        (process-send-string p (concat "activateKeyword " (current-word) "\n"))
        (let ((q (start-process "assistant" nil "/home/home_dev/MAL1/bin/Linux/spckAssistant" "-enableRemoteControl")))
          (process-send-string q (concat "activateKeyword " (current-word) "\n")))
        )
    )
)
(global-set-key [f11] 'ma-assistant)


(defun ma-occur-at-point ()
  "Run occur for word at point"
  (interactive)
  (if (not (use-region-p))
      (er/mark-word))
  (occur (buffer-substring (region-beginning) (region-end)))
  (select-window (get-buffer-window "*Occur*"))
)
(global-set-key "\M-O" 'ma-occur-at-point)

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

(defun ma-run-compile ()
  "Run compilation"
  (interactive)
  (if (boundp 'ma-compile-command)
      (setq comp-command ma-compile-command)
    (setq comp-command "~/bin/my_compile"))
  (if (or (boundp 'ma-build-dir) (stringp 'ma-build-dir))
      (setq comp-command (concat comp-command " " ma-build-dir)))
  (if (or (boundp 'ma-make-target) (stringp 'ma-make-target))
      (setq comp-command (concat comp-command " " ma-make-target)))
  (print comp-command)
  (compile comp-command)
)

(defun ma-run-atlas-package ()
  "Run atlassian-package on top-level directory the current buffer belongs to"
  (interactive)
  (let ((cur-dir default-directory))
    (while (and (not (string-equal cur-dir "/")) (not (file-exists-p (concat cur-dir "pom.xml"))))
      (setq cur-dir (file-name-directory (directory-file-name cur-dir))))
    (let ((default-directory cur-dir))
      (compile "atlas-package"))))

(add-hook 'cmake-mode-hook
	  (lambda ()
	    (local-set-key [?\C-c ?m]    'ma-run-cmake-and-compile)
	    (local-set-key [?\C-c ?\C-c] 'ma-run-compile)))

(add-hook 'c-mode-hook
	  (lambda ()
	    (local-set-key [?\C-c ?m]    'ma-run-cmake-and-compile)
	    (local-set-key [?\C-c ?\C-c] 'ma-run-compile)))

(add-hook 'c++-mode-hook
	  (lambda ()
	    (local-set-key [?\C-c ?m]    'ma-run-cmake-and-compile)
	    (local-set-key [?\C-c ?\C-c] 'ma-run-compile)))

(add-hook 'java-mode-hook
          (lambda()
            (local-set-key [?\C-c ?\C-c] 'ma-run-atlas-package)))

(require 'notifications)
(defun ma-send-desktop-notification (summary body timeout)
  "notify via dbus"
  (notifications-notify :title summary
                        :body body
                        :timeout timeout
                        :urgency "low"
                        :transient t))

(defun ma-compile-notify (buffer message)
  (ma-send-desktop-notification "emacs compile" message 2000))

(setq compilation-finish-function 'ma-compile-notify)

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

(defun ma-setup-ediff ()
  "Sets up the editor for ediff"
  (interactive)
  (window-configuration-to-register 'e)
  (frameset-to-register 'f)
  (set-frame-parameter nil 'top 0)
  (set-frame-parameter nil 'left 0)
  (set-frame-parameter nil 'width 240)
  (set-frame-parameter nil 'height 64)
  (show-frame)
)

(defun ma-cleanup-ediff ()
  "Restores the previous configuration after ediff"
  (interactive)
  (jump-to-register 'e)
  (jump-to-register 'f)
)

(defface ma-magit-highlight-remote-face
  '((t :inherit magit-branch-remote
       :underline t))
  "Face for highlighting remote branches with specific text in them."
  :group 'ma)

(defun ma-magit-highlight-own-branch (&rest args)
  "Highlight branches matching my trigram"
  (let* ((arglist (car args))
         (len (length arglist))
         (arg1 (nth 1 arglist)))
    (if (and (stringp arg1) (string-match "origin/SPCK-[0-9]+-MAL1-" arg1))
      (append (butlast arglist (- len 5)) (list 'ma-magit-highlight-remote-face) (last arglist (- len 6)))
    arglist)))

(advice-add 'magit-insert-branch-1 :filter-args #'ma-magit-highlight-own-branch)

(defun ma-lowercase-args (&rest args)
  "Convert all arguments to lowercase"
  (let ((arg1 (nth 0 args)))
    (set-text-properties 0 (length arg1) nil arg1)
    (downcase arg1)))

(advice-add 'cmake-symbol-at-point :filter-return #'ma-lowercase-args)

(add-hook 'ediff-before-setup-hook 'ma-setup-ediff)
(add-hook 'ediff-quit-hook 'ma-cleanup-ediff)

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

(defun ma-offlineimap-get-password (host)
  (let* ((auth-source-creation-prompts '((user . "Offlineimap user at %h: ")
                                         (secret . "Offlineimap Password: ")))
         (found (nth 0 (auth-source-search :max 1
                                           :host host
                                           :require '(:user :secret)
                                           :create t))))
    (if found
        (let* ((secret (plist-get found :secret))
               (password (if (functionp secret) (funcall secret) secret))
               (save-func (plist-get found :save-function)))
          (when (functionp save-func)
            (funcall save-func))
          password)
      nil)))

(provide 'ma-funcs)
