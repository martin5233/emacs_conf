(require 'hideshow)

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
                 (const "fat4fem")
                 (const "_simpack-doe-master")
                 (const "GUIUtils")
                  )
  :group 'ma
)

(defcustom ma-build-dir "/scratch/apel/new_arch/obj/32"
  "Build directory for SIMPACK builds"
  :type '(choice (const "/scratch/apel/new_arch/obj/32")
                 (const "/scratch/apel/new_arch/obj/dbg32")
                 (const "/scratch/apel/new_arch/obj/64")
                 (const "/scratch/apel/new_arch/obj/opt-g")
                 )
  :group 'ma
)

(defun ma-compare-to-trunk ()
  "Compare the file in the current buffer to the corresponding file in the trunk"
  (interactive)
  (let* ((cur-buf (current-buffer))
         (cur-buf-path (buffer-file-name cur-buf))
         (proc-buf (get-buffer-create "*my_svn*"))
         (trunk-buf-name (concat "*" (file-name-nondirectory cur-buf-path) ".trunk*"))
         (trunk-buf (get-buffer-create trunk-buf-name)))
    (set-buffer proc-buf)
    (delete-region (point-min) (point-max))
    (call-process "svn" nil proc-buf nil "info" cur-buf-path)
    (re-search-backward "^URL: \\(.*\\)" nil t)
    (setq url (match-string 1))
    (setq trunk-url (replace-regexp-in-string "/branches/CP_[0-9]+_[0-9]+/" "/trunk/" url))
    (set-buffer trunk-buf)
    (delete-region (point-min) (point-max))
    (shell-command (concat "svn cat -r HEAD " trunk-url) trunk-buf)
    (kill-buffer proc-buf)
    (ediff-buffers cur-buf trunk-buf)
)
)

(global-set-key [?\C-x ?v ?y] 'ma-compare-to-trunk)


(defun ma-merge-to-branch ()
  "Compare the file in the current buffer, with the corresponding file in current branch"
  (interactive)
  (let* ((cur-buf (current-buffer))
         (cur-buf-path (buffer-file-name cur-buf))
         (rel-path (file-relative-name cur-buf-path "/scratch/apel/new_arch/develop"))
         (branch-buf-path (concat "/scratch2/apel/SIMPACK_9.5_Branch/develop/" rel-path))
         (branch-buf (find-file-noselect branch-buf-path)))
    (ediff-buffers cur-buf branch-buf)
    )
)
  

(defun ma-merge-to-trunk ()
  "Compare the file in the current buffer, with the corresponding file in current branch"
  (interactive)
  (let* ((cur-buf (current-buffer))
         (cur-buf-path (buffer-file-name cur-buf))
         (rel-path (file-relative-name cur-buf-path "/scratch/apel/new_arch/develop"))
         (branch-buf-path (concat "/scratch/apel/s_9XXXX/develop/" rel-path))
         (branch-buf (find-file-noselect branch-buf-path)))
    (ediff-buffers cur-buf branch-buf)
    )
)
  

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

(defun ma-debug-simpack-gui ()
   "Calls gdb with simpack-gui"
   (interactive)
   (gdb "gdb -i=mi /scratch/apel/new_arch/obj/dbg32/run/bin/linux32/simpack-gui")
)

(defun ma-debug-simpack-slv ()
   "Calls gdb with simpack-slv"
   (interactive)
   (gdb "gdb -i=mi /scratch/apel/new_arch/obj/dbg32/run/bin/linux32/simpack-slv")
)

(defun ma-debug-ParserTest ()
   "Calls gdb with ParserTest"
   (interactive)
   (gdb "gdb -i=mi /scratch/apel/new_arch/obj/dbg32/run/bin/linux32/ParserTest")
)

(defun ma-debug-RunAllTests ()
   "Calls gdb with RunAllTests"
   (interactive)
   (gdb "gdb -i=mi /scratch/apel/new_arch/obj/dbg32/run/bin/linux32/RunAllTests")
)

(add-hook 'c++-mode-hook
	  (lambda ()
	    (local-set-key [?\C-c ?g] 'ma-debug-simpack-gui)
	    (local-set-key [?\C-c ?s] 'ma-debug-simpack-slv)
	    (local-set-key [?\C-c ?p] 'ma-debug-ParserTest)
	    (local-set-key [?\C-c ?r] 'ma-debug-RunAllTests)))


(defun ma-assistant ()
  "runs qt assistant"
  (interactive)
  (let ((p (get-process "assistant")))
    (if p
        (process-send-string p (concat "activateKeyword " (current-word) "\n"))
        (let ((q (start-process "assistant" nil "spckAssistant" "-enableRemoteControl")))
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
(global-set-key "\M-p" 'ma-occur-at-point)

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
  (compile "cd /scratch/apel/new_arch/obj/32; cmake .; ~/bin/my_compile /scratch/apel/new_arch/obj/32")
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

(add-hook 'cmake-mode-hook
	  (lambda ()
	    (local-set-key [?\C-c ?m]    'ma-run-cmake-and-compile)
	    (local-set-key [?\C-c ?\C-c] 'ma-run-compile)))


(require 'dbus)
(defun ma-send-desktop-notification (summary body timeout)
  "call notification-daemon method METHOD with ARGS over dbus"
  (dbus-call-method
   :session                        ; use the session (not system) bus
   "org.freedesktop.Notifications" ; service name
   "/org/freedesktop/Notifications"   ; path name
   "org.freedesktop.Notifications" "Notify" ; Method
   "emacs"
   0
   ""
   summary
   body
   '(:array)
   '(:array :signature "{sv}")
   ':int32 timeout))
    
(defun ma-compile-notify (buffer message)
  (ma-send-desktop-notification "emacs compile" message 2000))

(setq compilation-finish-function 'ma-compile-notify)

(defun ma-edit-changelog ()
  "Edit a given file's changelog. This automatically expands the hidden header comment
   and positions the cursor to the right location"

  (hs-show-all)
  (goto-char (point-min))
  (if (re-search-forward "\[[0-9]+:[0-9]+\]" nil t)
      (forward-char)
    )
)

(add-hook 'server-visit-hook
          'ma-edit-changelog)


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
        NIL)
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

(provide 'ma-funcs)
