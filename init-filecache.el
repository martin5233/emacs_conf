(require 'filecache)

(when work-win
  (setq file-cache-find-command "C:/cygwin64/bin/find.exe"))

(defun ma-fill-file-cache ()
  "Fill the file cache with certain directories"
  (interactive)
  (let ((basedir (if work-win "E:/users/apel/" "/scratch/apel/")))
    (message "ma-fill-file-cache called")
    (file-cache-add-directory-using-find (concat basedir "new_arch/develop/build"))
    (file-cache-add-directory-using-find (concat basedir "new_arch/develop/resources"))
    (file-cache-add-directory-using-find (concat basedir "new_arch/develop/scripts"))
    (file-cache-add-directory-using-find (concat basedir "new_arch/develop/src"))
    (message "ma-fill-file-cache finished")
    )
)

(defun ma-fill-file-cache-with-testmodels ()
  "Fill the file cache with testmodels"
  (interactive)
  (let ((basedir (if work-win "E:/users/apel/spcktest/" "/TESTDATA/NA-Test/")))
    (file-cache-add-file-list (find-lisp-find-files (concat basedir "TestModels") "\.sys$"))
    (file-cache-add-file-list (find-lisp-find-files (concat basedir "TestModels") "\.spck$"))))

(defun ma-fill-file-cache-delayed ()
  "Fill the file cache with certain directories in idle time, but not now"
  (interactive)
  (let* ((idle (current-idle-time))
         (remain 0))
    (if idle
        (setq remain (+ (cadr idle) 30))
      (setq remain 30))
     (run-with-idle-timer remain nil 'ma-fill-file-cache))
)

(if work
    (progn
      (run-with-idle-timer 300 nil 'ma-fill-file-cache-with-testmodels)
      (ma-fill-file-cache-delayed)))
