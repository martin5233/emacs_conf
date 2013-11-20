(defcustom cmake-mode-cmake-executable "cmake"
 "*The name of the cmake executable.
This can be either absolute or looked up on `exec-path'."
 ;; Don't use (file :must-match t).  It doesn't know about `exec-path'.
 :type 'file
 :group 'cmake)

(defun cmake-command-run (type &optional topic)
 "Runs the command cmake with the arguments specified.  The
optional argument topic will be appended to the argument list."
 (interactive "s")
 (let* ((bufname (concat "*CMake" type (if topic "-") topic "*"))
        (buffer  (get-buffer bufname))
        )
   (if buffer
       (display-buffer buffer 'not-this-window)
     ;; Buffer doesn't exist.  Create it and fill it
     (setq buffer (generate-new-buffer bufname))
     (setq command (concat cmake-mode-cmake-executable " " type " " topic))
     (message "Running %s" command)
     ;; We don't want the contents of the shell-command running to the
     ;; minibuffer, so turn it off.  A value of nil means don't automatically
     ;; resize mini-windows.
     (setq resize-mini-windows-save resize-mini-windows)
     (setq resize-mini-windows nil)
     (shell-command command buffer)
     ;; Save the original window, so that we can come back to it later.
     ;; save-excursion doesn't seem to work for this.
     (setq window (selected-window))
     ;; We need to select it so that we can apply special modes to it
     (select-window (display-buffer buffer 'not-this-window))
     (cmake-mode)
     (toggle-read-only t)
     ;; Restore the original window
     (select-window window)
     (setq resize-mini-windows resize-mini-windows-save)
     )
   )
 )

(defun cmake-help-list-commands ()
 "Prints out a list of the cmake commands."
 (interactive)
 (cmake-command-run "--help-command-list")
 )

(defvar cmake-help-command-history nil "Topic read history.")

(require 'thingatpt)
(defun cmake-get-topic (type)
 "Gets the topic from the minibuffer input.  The default is the word the cursor is on."
 (interactive)
 (let* ((default-entry (word-at-point))
        (input (read-string
                (format "CMake %s (default %s): " type default-entry) ; prompt
                nil ; initial input
                'cmake-help-command-history ; command history
                default-entry ; default-value
                )))
   (if (string= input "")
       (error "No argument given")
     input))
 )


(defun cmake-help-command ()
 "Prints out the help message corresponding to the command the cursor is on."
 (interactive)
 (setq command (cmake-get-topic "command"))
 (cmake-command-run "--help-command" (downcase command))
 )
