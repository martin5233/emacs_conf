(setq home (string-match "^martin$" (user-login-name)))
(setq work (string-match "^apel$" (user-login-name)))

(setq load-path (cons "/usr/share/emacs/site-lisp/apel" load-path))
(setq load-path (cons "/usr/share/emacs/site-lisp/doxymacs" load-path))

(require 'alist)

(defalias 'perl-mode 'cperl-mode)

(add-to-list 'default-frame-alist
                       '(font . "DejaVu Sans Mono-10"))

(remove-alist 'auto-mode-alist '"\\.[fF]\\'")
(set-alist 'auto-mode-alist "\\.h\\'" 'c++-mode)
(set-alist 'auto-mode-alist "\\.l\\'" 'c++-mode)
(set-alist 'auto-mode-alist "CMakeLists\\.txt\\'"  'cmake-mode)
(set-alist 'auto-mode-alist "\\.cmake\\'"          'cmake-mode)
(set-alist 'auto-mode-alist "\\.ll\\'"             'llvm-mode)
(set-alist 'auto-mode-alist "\\.org\\'"            'org-mode)
(set-alist 'auto-mode-alist "\\.sjs\\'"            'javascript-mode)

(setq load-path (cons (expand-file-name "~/.emacs.d") load-path))
(setq load-path (cons (expand-file-name "~/.emacs.d/org-toodledo-master") load-path))
(setq load-path (cons (expand-file-name "~/.emacs.d/org-jira") load-path))
(setq load-path (cons (expand-file-name "~/.emacs.d/restclient") load-path))

(tool-bar-mode 0)

(require 'tempo)

(tempo-define-template "change-hist-new-line"
                       '( n " *            |                    |           " p))

(require 'tempo-snippets)

(tempo-define-snippet "c-for-it"
  '(> "for (" (p "Type: " type) "::iterator " (p "Iterator: " it) " = "
      (p "Container: " container) ".begin(); "
      (s it) " != " (s container) ".end(); ++" (s it) ")" n  "{" > n > p r n "}" >)
  "fori"
  "Insert a C++ for loop iterating over an STL container."
  nil)

(tempo-define-snippet "c-for-const-it"
  '(> "for (" (p "Type: " type) "::const_iterator " (p "Iterator: " it) " = "
      (p "Container: " container) ".begin(); "
      (s it) " != " (s container) ".end(); ++" (s it) ")" n  "{" > n > p r n "}" >)
  "forc"
  "Insert a C++ for loop iterating over an STL container."
  nil)

(tempo-define-snippet "c-for-it-templ"
  '(> "for (" (p "Type: " type) "::iterator<" (p "Class: " class) "> "  (p "Iterator: " it) " = "
      (p "Container: " container) ".begin<" (s class) ">(); "
      (s it) " != " (s container) ".end<" (s class) ">(); ++" (s it) ")" n  "{" > n > p r n "}" >)
  "tfori"
  "Insert a C++ for loop iterating over a templated container."
  nil)

(tempo-define-snippet "c-for-const-it-templ"
  '(> "for (" (p "Type: " type) "::const_iterator<" (p "Class: " class) "> "  (p "Iterator: " it) " = "
      (p "Container: " container) ".begin<" (s class) ">(); "
      (s it) " != " (s container) ".end<" (s class) ">(); ++" (s it) ")" n  "{" > n > p r n "}" >)
  "tforc"
  "Insert a C++ for loop iterating over a templated container."
  nil)

(autoload 'csv-mode "csv-mode" "Major mode for editing comma-separated value files." t)
(autoload 'cmake-mode "cmake-mode" "Major mode for editing CMakeLists.txt." t)
(autoload 'llvm-mode "llvm-mode" "Major mode for editing LLVM bitcode files." t)
(autoload 'ascii-table "ascii-table" "Show an ascii table." t)
(autoload 'crontab-mode "crontab-mode" "Major mode for editing crontab files" t)
(autoload 'w3m-browse-url "w3m-load" "Ask a WWW browser to show a URL." t)
(autoload 'erc "erc" "IRC" t)
(autoload 'erc-nick-notify-mode "erc-nick-notify" "Minor mode that calls `erc-nick-notify-cmd' when his nick gets mentioned in an erc channel" t)
(eval-after-load 'erc '(erc-nick-notify-mode t))

(require 'imenu_ext)
(require 'klaralv)
(require 'uniquify)
(require 'browse-kill-ring)
(require 'org-protocol)
(require 'org-feed)
(require 'wgrep)
(require 'subword)
(require 'midnight)
(require 'smex)
(require 'find-lisp)
(require 'filecache)
(if work
    (progn
      (require 'mu4e)
      (require 'org-mu4e)))
(require 'org-toodledo)
(require 'socks)

(setq socks-noproxy '("localhost"))

(if work
    (progn
      (setq jiralib-url "http://jiratest.intec.dom:8080")
      (require 'org-jira)
      (require 'doxymacs)
      )
)

(defalias 'yes-or-no-p 'y-or-n-p)

(global-set-key [delete] 'delete-char)
(global-set-key [?\C-c ?\C-g] 'goto-line)
(global-set-key [?\C-c ?\C-b] 'browse-url-at-point)
(global-set-key [?\C-x ?\C-b] 'ibuffer)
(global-set-key [?\C-x ?v ?y] 'ma-compare-to-trunk)
(global-set-key [?\C-c ?c]    'ma-switch-to-compilation-buffer)
(global-set-key [?\C-c ?a]    'org-agenda)
(global-set-key [?\C-c ?\C-r] 'rgrep)
(global-unset-key [?\C-x ?\C-c])
(global-set-key [?\C-x ?\C-c ?\C-x] 'save-buffers-kill-terminal)
(global-set-key [f11] 'ma-assistant)
(global-set-key "\M- " 'dabbrev-expand)
(global-set-key "\M-o" 'er/expand-region)
(global-set-key "\M-p" 'ma-occur-at-point)
(global-set-key (kbd "C-.") 'goto-last-change)
(global-set-key (kbd "C-c SPC") 'ace-jump-mode)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "<kp-end>") 'shell)
(global-set-key (kbd "<kp-down>") 'mu4e)
(global-set-key (kbd "<kp-next>") '(lambda () "Open .emacs" (interactive) (find-file "~/.emacs")))
(global-set-key (kbd "C-c C-n") 'mc/mark-next-like-this)
(global-set-key (kbd "C-c C-p") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-a") 'mc/mark-all-like-this-in-defun)
(global-set-key (kbd "C-c C-|") 'mc/edit-lines)
(global-set-key [f12] 'ma-show-tmux)
(global-set-key (kbd "C-c +") 'increment-integer-at-point)
(global-set-key (kbd "C-c -") 'decrement-integer-at-point)

(windmove-default-keybindings)

(smex-initialize)

(setq kdab-qt-documentation "file:///home/home_dev/apel/doc/doc.trolltech.com/4.6/XXX.html")

(defgroup ma nil
  "Martins customizations"
)

(defcustom ma-make-target "world"
  "Make target for SIMPACK builds"
  :type '(choice (const "world")
                 (const "simpack-gui")
                 (const "simpack-slv")
                 (const "DoRunTests")
                 (const "ParserTest")
                 (const "RWCmpTest")
                 (const "simpack-post")
                 (const "_simpack-doe-master")
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

(require 'files)
(dir-locals-set-class-variables 'new_arch
 '((c++-mode
  (ma-compile-command . "~/bin/my_compile")
  (tags-file-name . "/scratch/apel/new_arch/.tags"))
   (c-mode
    (ma-compile-command . "~/bin/my_compile")
    (tags-file-name . "/scratch/apel/new_arch/.tags"))
   ))

(dir-locals-set-class-variables 'llvm_test
 '((c++-mode
  (ma-compile-command . "make -C /home/home_dev/apel/llvm_test/obj")
  (ma-make-target . nil)
  (ma-build-dir . nil)
  (tags-file-name . "/scratch2/apel/llvm-3.1.src/TAGS"))
  (cmake-mode
  (ma-compile-command . "make -C /home/home_dev/apel/llvm_test/obj")
  (ma-make-target . nil)
  (ma-build-dir . nil))))

(dir-locals-set-class-variables 'llvm_src
 '((c++-mode
  (tags-file-name . "/scratch2/apel/llvm-3.1.src/TAGS"))))

(dir-locals-set-class-variables 'atomic
 '((c++-mode
    (ma-compile-command . "make -C /home/home_dev/apel/atomic/obj")
    (ma-make-target . nil)
    (ma-build-dir . nil))))

(dir-locals-set-directory-class  "/scratch/apel/new_arch/develop/" 'new_arch)
(dir-locals-set-directory-class  "/home/home_dev/apel/llvm_test/" 'llvm_test)
(dir-locals-set-directory-class  "/scratch2/apel/llvm-3.1.src" 'llvm_src)
(dir-locals-set-directory-class  "/usr/local/include/llvm" 'llvm_src)
(dir-locals-set-directory-class  "/home/home_dev/apel/atomic/" 'atomic)

(browse-kill-ring-default-keybindings)

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

(defun ma-switch-to-ebrowse-buffer ()
   "Switches to the ebrowse buffer"
   (interactive)
   (if (not (get-buffer "*Tree*"))
       (ma-update-ebrowse-db)
     (switch-to-buffer "*Tree*")
     )
)

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

(defun ma-occur-at-point ()
  "Run occur for word at point"
  (interactive)
  (if (not (use-region-p))
      (er/mark-word))
  (occur (buffer-substring (region-beginning) (region-end)))
  (select-window (get-buffer-window "*Occur*"))
)

(defun ma-remove-schedule-entry ()
  "Remove a scheduled date from an entry"
  (interactive)
  (if (org-entry-is-done-p) (org-schedule t))
)

(defun ma-fill-file-cache ()
  "Fill the file cache with certain directories"
  (interactive)
  (progn
    (message "ma-fill-file-cache called")
    (file-cache-add-directory-using-find "/scratch/apel/new_arch/develop/build")
    (file-cache-add-directory-using-find "/scratch/apel/new_arch/develop/resources")
    (file-cache-add-directory-using-find "/scratch/apel/new_arch/develop/scripts")
    (file-cache-add-directory-using-find "/scratch/apel/new_arch/develop/src")
    (message "ma-fill-file-cache finished")
    )
)

(defun ma-fill-file-cache-with-testmodels ()
  "Fill the file cache with testmodels"
  (interactive)
  (file-cache-add-file-list (find-lisp-find-files "/TESTDATA/NA-Test/TestModels" "\.sys$"))
  (file-cache-add-file-list (find-lisp-find-files "/TESTDATA/NA-Test/TestModels" "\.spck$"))
)

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

(add-hook 'kill-emacs-query-functions
          'ma-show-agenda-if-hidden)
(add-hook 'kill-emacs-query-functions
          (lambda() (yes-or-no-p "All change packages reviewed?")))

;; Remove buffers after EDiff is finished
(add-hook 'ediff-cleanup-hook 
          (lambda () (ediff-janitor t nil)))

(add-hook 'c-mode-common-hook
       (lambda ()
            (imenu-add-to-menubar "Functions")
            (local-set-key [?\C-c ?\C-c] 'ma-run-compile)
            (local-set-key [?\C-c ?\C-o] 'ff-find-other-file)
            (local-set-key (quote [S-return]) (quote tempo-template-change-hist-new-line))
            (local-set-key [?\C-c ?\C-s] 'hs-show-block)
            (local-set-key (kbd "C-M-a") 'beginning-of-defun)
            (local-set-key (kbd "C-M-e") 'end-of-defun)
            (local-set-key [?\C-c ?m]    'ma-run-cmake-and-compile)
            (local-set-key [delete] 'c-electric-delete-forward)
            (local-set-key [?\C-c ?=] 'align-regexp)
            (local-set-key (kbd "M-<left>") 'subword-backward)
            (local-set-key (kbd "M-<right>") 'subword-forward)
            (local-set-key (kbd "M-.") 'etags-select-find-tag-at-point)
            (local-unset-key (kbd "C-c C-n"))
            (local-unset-key (kbd "C-c C-p"))

            (c-toggle-hungry-state 1)
            (doxymacs-mode)
            (doxymacs-font-lock)
            (flyspell-prog-mode)
            (cwarn-mode)
            (subword-mode t)
            (hs-minor-mode)
            (smartscan-mode)
            (hs-hide-initial-comment-block)))

(add-hook 'c++-mode-hook
       (lambda ()
         (local-set-key [?\C-c ?\C-d] 'kdab-lookup-qt-documentation)
         (local-set-key [?\C-c ?\C-i] 'kdab-insert-header)
         (local-set-key [?\C-c ?g] 'ma-debug-simpack-gui)
         (local-set-key [?\C-c ?s] 'ma-debug-simpack-slv)
         (local-set-key [?\C-c ?p] 'ma-debug-ParserTest)
         (local-set-key [?\C-c ?r] 'ma-debug-RunAllTests)
         (local-set-key [?\C-c ?t] 'ma-switch-to-ebrowse-buffer)
         (tempo-snippets-add-mode-abbrev 'tempo-template-c-for-const-it "forc")
         (tempo-snippets-add-mode-abbrev 'tempo-template-c-for-it "fori")
         (tempo-snippets-add-mode-abbrev 'tempo-template-c-for-it-templ "tfori")
         (tempo-snippets-add-mode-abbrev 'tempo-template-c-for-const-it-templ "tforc")))

(add-hook 'cmake-mode-hook
  '(lambda ()
          (smartscan-mode)
          (local-set-key [?\C-c ?\C-c] 'ma-run-compile)
          (local-set-key [?\C-c ?\C-d] 'cmake-help-command)))

(add-hook 'python-mode-hook
  '(lambda ()
     (local-unset-key [?\C-C ?\C-r])
     (smartscan-mode)
     (imenu-add-to-menubar "Functions")))

(add-hook 'gdb-mode-hook
  '(lambda ()
          (local-set-key (kbd "C-r") 'gdb-restore-windows)
          (tool-bar-mode 1)))

(add-hook 'shell-mode-hook
          'dirtrack-mode)

(add-hook 'after-save-hook
  'executable-make-buffer-file-executable-if-script-p)
(autoload 'autoinsert "auto-insert" "Automatically insert templates into empty files" t)

(add-hook 'find-file-hook 'auto-insert)
(define-auto-insert "\\.h\\'" 'header-skeleton)

;; (add-hook 'erc-before-connect
;;           '(lambda (server port nick)
;;              (shell-command "/usr/bin/ssh -A -f -n -N root@martin5233.dyndns.org &")))

(server-start)

(global-font-lock-mode 1)

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
  (setq comp-command ma-compile-command)
  (if (or (boundp 'ma-build-dir) (stringp 'ma-build-dir))
      (setq comp-command (concat comp-command " " ma-build-dir)))
  (if (or (boundp 'ma-make-target) (stringp 'ma-make-target))
      (setq comp-command (concat comp-command " " ma-make-target)))
  (print comp-command)
  (compile comp-command)
)

(if work
    (progn
      (run-with-idle-timer 300 nil 'ma-fill-file-cache-with-testmodels)
      (run-with-idle-timer 600 t 'ma-show-agenda-if-hidden)
      (ma-fill-file-cache-delayed)))

(require 'desktop)
;; Has to be after loading desktop
(add-hook 'kill-emacs-hook 'ma-kill-old-buffers)
(require 'password)
(require 'psvn)
(require 'skeleton)
(require 'generic)

(define-skeleton header-skeleton
  "Define a C++ header file skeleton"
  ""
"#ifndef __" (upcase (file-name-sans-extension (file-name-nondirectory buffer-file-name))) "_H__\n"
"#define __" (upcase (file-name-sans-extension (file-name-nondirectory buffer-file-name))) "_H__\n\n"
"#include \"base/WinExportDefs.h\"\n\n"
"namespace " (skeleton-read "Namespace name?") "\n"
"{\n\n"
"class SPCK_XXX_EXPORT " (file-name-sans-extension (file-name-nondirectory buffer-file-name)) "\n"
"{\n"
"public:\n\n"
"private:\n"
"   // Not implemented to prevent copying\n"
"   " (file-name-sans-extension (file-name-nondirectory buffer-file-name)) "(const " (file-name-sans-extension (file-name-nondirectory buffer-file-name)) "&);\n"
"   " (file-name-sans-extension (file-name-nondirectory buffer-file-name)) "& operator=(const " (file-name-sans-extension (file-name-nondirectory buffer-file-name)) "&);\n"
"};\n"
"}\n"
"#endif // __" (upcase (file-name-sans-extension (file-name-nondirectory buffer-file-name))) "_H__\n"
)

(defconst my-doxymacs-function-comment-template
 '((let ((next-func (doxymacs-find-next-func)))
     (if next-func
    (list
     'l
     '> "/*!" 'n
     "* " 'p '> 'n
     "* " '> 'n
     (doxymacs-parm-tempo-element (cdr (assoc 'args next-func)))
     (unless (string-match
                   (regexp-quote (cdr (assoc 'return next-func)))
                   doxymacs-void-types)
       '(l "*" > n
           "* \\return " (p "Returns: ") > 'n))
     "*/" '> 'n '>)
       (progn
    (error "Can't find next function declaraton.")
    nil))))
 "My template for function documentation.")

(defconst my-doxymacs-blank-multiline-comment-template
 '(> "/*!" n "* " p > n "* " > n "*/" > n >)
 "My template for a blank multiline doxygen comment.")

(defconst my-doxymacs-blank-singleline-comment-template
 '(> "//! " p)
 "My template for a blank single line doxygen comment.")

(define-generic-mode
  'spck-mode
  '("!")
  '("body"
    "constr"
    "control"
    "ens"
    "express"
    "force"
    "joint"
    "marker"
    "poly"
    "prim"
    "road"
    "refsys"
    "sensor"
    "slv"
    "substr"
    "subvar"
    "track"
    "timex"
    "view"
    "yout")
  '(
    ("\\(\\$[A-Za-z0-9_]+\\)" 1 font-lock-variable-name-face)
    ("\\([+-]?[0-9]\\.[0-9]+E[+-][0-9]+\\)" 1 font-lock-constant-face)
    ("'\\([^']+\\)'" 1 font-lock-string-face)
    )
  '("\\.sys$" "\\.ani$" "\\.spck$")
  (list
   (function
    (lambda ()
      (setq imenu-generic-expression
       '((nil "(.*\\(\\$[A-Za-z0-9_]+\\).*) *=" 1)))
      (imenu-add-menubar-index)
      (local-set-key [?\C-c ?\C-j] 'imenu))))
  "A mode for SIMPACK model files"
)

(load-file (expand-file-name "~/.emacs.d/cmake-doc.el"))
(load-file (expand-file-name "~/.emacs.d/align-by-current-symbol.el"))

(setq org-default-notes-file "~/org/notes.org")
(global-set-key [f1] 'org-capture)
(global-set-key [f2] 'customize-group)

(if work
 (setq org-agenda-files (quote ("~/ownCloud/geburtstage.org" "~/org/na.org" "~/org/devs.org" "~/ownCloud/private.org")))
 (setq org-agenda-files (quote ("~/ownCloud/geburtstage.org" "~/ownCloud/private.org")))
)

(if work
(setq url-proxy-services (quote (("http" . "proxy.intec.dom:3128") ("https" . "proxy.intec.dom:3128"))))
)

(setq-default ediff-ignore-similar-regions t)

;; mu4e customization
(setq mu4e-bookmarks
      '( ("maildir:/INBOX AND NOT flag:trashed"     "INBOX" ?i)
         ("flag:unread"                             "Unread" ?u)
         ("maildir:\"/Devel.MKS.Reviews to do\""    "Reviews" ?r)
         )
)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-matching-paren-on-screen nil)
 '(browse-kill-ring-no-duplicates t)
 '(browse-url-browser-function (quote ((".*" . browse-url-firefox))))
 '(browse-url-firefox-program "/home/home_dev/apel/tools/firefox/firefox")
 '(c-basic-offset 3)
 '(c-cleanup-list (quote (scope-operator compact-empty-funcall)))
 '(c-default-style (quote ((c-mode . "cc-mode") (c++-mode . "cc-mode") (java-mode . "java") (other . "gnu"))))
 '(c-offsets-alist (quote ((incomposition . +) (inmodule . +) (composition-close . 0) (module-close . 0) (composition-open . 0) (module-open . 0) (cpp-define-intro c-lineup-cpp-define +) (substatement-label . 2) (string . c-lineup-dont-change) (c . c-lineup-C-comments) (defun-open . 0) (defun-close . 0) (defun-block-intro . +) (class-open . 0) (class-close . 0) (inline-close . 0) (func-decl-cont . +) (knr-argdecl-intro . +) (knr-argdecl . 0) (topmost-intro . 0) (topmost-intro-cont . 0) (member-init-intro . +) (member-init-cont . c-lineup-multi-inher) (inher-intro . +) (inher-cont . c-lineup-multi-inher) (block-open . 0) (block-close . 0) (brace-list-open . 0) (brace-list-close . 0) (brace-list-intro . +) (brace-list-entry . 0) (brace-entry-open . 0) (statement . 0) (statement-cont . +) (statement-block-intro . +) (statement-case-intro . +) (statement-case-open . 0) (substatement . +) (substatement-open . 0) (case-label . 0) (access-label . -) (label . 2) (do-while-closure . 0) (else-clause . 0) (catch-clause . 0) (comment-intro . c-lineup-comment) (arglist-intro . +) (arglist-cont . 0) (arglist-cont-nonempty . c-lineup-arglist) (arglist-close . +) (stream-op . c-lineup-streamop) (inclass . +) (cpp-macro . [0]) (cpp-macro-cont . c-lineup-dont-change) (friend . 0) (objc-method-intro . [0]) (objc-method-args-cont . c-lineup-ObjC-method-args) (objc-method-call-cont . c-lineup-ObjC-method-call) (extern-lang-open . 0) (extern-lang-close . 0) (inextern-lang . +) (namespace-open . 0) (namespace-close . 0) (innamespace . 0) (template-args-cont c-lineup-template-args +) (inlambda . c-lineup-inexpr-block) (lambda-intro-cont . +) (inexpr-statement . 0) (inexpr-class . +) (inline-open . 0))))
 '(c-style-variables-are-local-p nil)
 '(calendar-holidays (quote ((holiday-fixed 1 1 "New Year's Day") (holiday-float 1 1 3 "Martin Luther King Day") (holiday-fixed 2 2 "Groundhog Day") (holiday-fixed 2 14 "Valentine's Day") (holiday-float 2 1 3 "President's Day") (holiday-fixed 3 17 "St. Patrick's Day") (holiday-fixed 4 1 "April Fools' Day") (holiday-float 5 0 2 "Mother's Day") (holiday-float 5 1 -1 "Memorial Day") (holiday-fixed 6 14 "Flag Day") (holiday-float 6 0 3 "Father's Day") (holiday-fixed 7 4 "Independence Day") (holiday-float 9 1 1 "Labor Day") (holiday-float 10 1 2 "Columbus Day") (holiday-fixed 10 31 "Halloween") (holiday-fixed 11 11 "Veteran's Day") (holiday-float 11 4 4 "Thanksgiving") (holiday-easter-etc) (holiday-fixed 12 25 "Christmas") (if calendar-christian-all-holidays-flag (append (holiday-fixed 1 6 "Epiphany") (holiday-julian 12 25 "Eastern Orthodox Christmas") (holiday-greek-orthodox-easter) (holiday-fixed 8 15 "Assumption") (holiday-advent 0 "Advent"))) (solar-equinoxes-solstices) (holiday-sexp calendar-daylight-savings-starts (format "Daylight Saving Time Begins %s" (solar-time-string (/ calendar-daylight-savings-starts-time (float 60)) calendar-standard-time-zone-name))) (holiday-sexp calendar-daylight-savings-ends (format "Daylight Saving Time Ends %s" (solar-time-string (/ calendar-daylight-savings-ends-time (float 60)) calendar-daylight-time-zone-name))))))
 '(calendar-mark-holidays-flag t)
 '(cc-other-file-alist (quote (("\\.cc\\'" (".hh" ".h")) ("\\.hh\\'" (".cc" ".C")) ("\\.c\\'" (".h")) ("Impl\\.h\\'" ("Impl.cpp" ".h")) ("\\.h\\'" (".c" ".cc" ".C" ".CC" ".cxx" ".cpp" "Impl.h")) ("\\.C\\'" (".H" ".hh" ".h")) ("\\.H\\'" (".C" ".CC")) ("\\.CC\\'" (".HH" ".H" ".hh" ".h")) ("\\.HH\\'" (".CC")) ("\\.c\\+\\+\\'" (".h++" ".hh" ".h")) ("\\.h\\+\\+\\'" (".c++")) ("\\.cpp\\'" (".hpp" ".hh" ".h")) ("\\.hpp\\'" (".cpp")) ("\\.cxx\\'" (".hxx" ".hh" ".h")) ("\\.hxx\\'" (".cxx")))))
 '(cc-search-directories (quote ("." "/usr/include" "/usr/local/include/*" "/scratch/apel/new_arch/develop/src/ooa")))
 '(comment-style (quote plain))
 '(compilation-ask-about-save nil)
 '(compilation-auto-jump-to-first-error t)
 '(compilation-read-command nil)
 '(compilation-scroll-output t)
 '(compilation-search-path (quote ("/scratch/apel/new_arch")))
 '(compilation-skip-threshold 2)
 '(compilation-skip-visited t)
 '(confirm-kill-emacs (quote yes-or-no-p))
 '(copyright-limit 10000)
 '(copyright-regexp "\\(Copyright (c) \\)\\([-0-9, ';/*%#\\n\\t]*[0-9]+\\), \\(?:INTEC GmbH\\|\\SIMPACK AG\\|Simpack AG\\)")
 '(cperl-continued-statement-offset 0)
 '(cperl-indent-level 3)
 '(dabbrev-case-fold-search nil)
 '(default-input-method "german-postfix")
 '(desktop-restore-eager 20)
 '(desktop-save (quote ask-if-new))
 '(desktop-save-mode t)
 '(dirtrack-list (quote ("^apel@[a-zA-Z0-9]+ \\[\\(.*\\)\\]" 1)))
 '(doxymacs-blank-multiline-comment-template my-doxymacs-blank-multiline-comment-template)
 '(doxymacs-blank-singleline-comment-template my-doxymacs-blank-singleline-comment-template)
 '(doxymacs-command-character "\\")
 '(doxymacs-doxygen-dirs (quote (("^/scratch/apel/new_arch/develop/src/ooa/" "http://simdev-server.intec.dom/na_tags" "http://simdev-server.intec.dom/na_docs"))))
 '(doxymacs-doxygen-style "JavaDoc")
 '(doxymacs-function-comment-template my-doxymacs-function-comment-template)
 '(doxymacs-use-external-xml-parser t)
 '(ediff-split-window-function (quote split-window-horizontally))
 '(ediff-window-setup-function (quote ediff-setup-windows-plain))
 '(erc-autojoin-channels-alist (quote (("freenode.net" "#gerrit" "#emacs" "#libgit2" "##spirit"))))
 '(erc-autojoin-timing (quote ident))
 '(erc-fill-column 100)
 '(erc-hide-list (quote ("JOIN" "PART" "QUIT")))
 '(erc-keywords (quote ("ardmore")))
 '(erc-modules (quote (autojoin button completion fill irccontrols list match menu move-to-prompt netsplit networks noncommands readonly ring scrolltobottom services smiley stamp spelling track)))
 '(erc-nick "ardmore")
 '(erc-nickserv-passwords (quote ((freenode (("ardmore" . "hBdL6A06wyXwFTsmDNsb"))))))
 '(erc-port 6667)
 '(erc-prompt-for-nickserv-password nil)
 '(erc-prompt-for-password nil)
 '(erc-replace-alist nil)
 '(erc-replace-mode nil)
 '(erc-server "kornbluth.freenode.net")
 '(erc-server-connect-function (quote socks-open-network-stream))
 '(erc-services-mode t)
 '(erc-track-exclude-types (quote ("JOIN" "NICK" "PART" "QUIT" "333" "353")))
 '(erc-try-new-nick-p nil)
 '(erc-user-full-name nil)
 '(etags-select-go-if-unambiguous t)
 '(etags-select-use-short-name-completion t)
 '(european-calendar-style nil)
 '(ff-always-in-other-window t)
 '(ff-always-try-to-create nil)
 '(ff-ignore-include nil)
 '(file-cache-filter-regexps (quote ("~$" "\\.o$" "\\.rpo$" "\\.exe$" "\\.a$" "\\.elc$" ",v$" "\\.output$" "\\.$" "#$" "\\.class$" "\\.bak$" "\\.svn-base$" "\\.html$" "\\.svn" "\\.so$" "\\.dll$" "CMakeFiles" "extern/share" "extern/linux" "extern/win" "partners" "/obj/" "^project\\.pj$" "\\.sbr$" "\\.tes$" "\\.intinfo$" "\\.dim$")))
 '(fill-column 120)
 '(focus-follows-mouse t)
 '(gdb-find-source-frame t)
 '(gdb-many-windows t)
 '(gdb-show-main t)
 '(global-auto-revert-mode t)
 '(gud-tooltip-mode t)
 '(guide-key-mode t)
 '(guide-key/guide-key-sequence (quote ("C-c i" "C-c s" "C-x r")))
 '(guide-key/idle-delay 0.0)
 '(guide-key/popup-window-position (quote bottom))
 '(ido-enable-flex-matching t)
 '(ido-ignore-directories (quote ("\\`CVS/" "\\`\\.\\./" "\\`\\./" "\\`\\.svn/")))
 '(ido-mode (quote buffer) nil (ido))
 '(imenu-sort-function (quote imenu--sort-by-name))
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(js-indent-level 3)
 '(latex-run-command "pdflatex")
 '(make-backup-files nil)
 '(message-from-style (quote default))
 '(message-send-mail-function (quote smtpmail-send-it))
 '(minibuffer-message-timeout 2 t)
 '(mouse-yank-at-point t)
 '(mu4e-drafts-folder "/Drafts")
 '(mu4e-get-mail-command "offlineimap")
 '(mu4e-maildir "/scratch/apel/.Maildir")
 '(mu4e-my-email-addresses (quote ("martin.apel@simpack.de" "martin.apel@web.de")))
 '(mu4e-sent-folder "/Sent")
 '(mu4e-show-images t)
 '(mu4e-trash-folder "/Trash")
 '(mu4e-update-interval 300)
 '(mu4e-use-fancy-chars t)
 '(nxml-child-indent 3)
 '(org-agenda-custom-commands (quote (("w" "Work agenda only" agenda "" ((org-agenda-files (quote ("~/org/na.org" "~/org/devs.org"))))) ("h" "Home agenda only" agenda "" ((org-agenda-files (quote ("~/ownCloud/private.org" "~/ownCloud/geburtstage.org"))))) ("s" "Unscheduled items" alltodo "" ((org-agenda-skip-function (quote (org-agenda-skip-entry-if (quote scheduled) (quote nottodo) (quote todo)))))) ("r" "Activities to report" tags "REPORT" ((org-agenda-remove-tags t) (org-agenda-prefix-format "") (org-agenda-todo-keyword-format "%-17s") (ps-landscape-mode t) (ps-number-of-columns 1)) ("~/org/Activities.pdf")))))
 '(org-agenda-repeating-timestamp-show-all nil)
 '(org-agenda-skip-deadline-prewarning-if-scheduled t)
 '(org-agenda-skip-scheduled-if-deadline-is-shown t)
 '(org-agenda-start-on-weekday nil)
 '(org-capture-templates (quote (("d" "DevIssue from MKS" entry (file "~/org/devs.org") "* ASSIGNED %:description  :REPORT:
%:initial
" :immediate-finish t) ("g" "General" entry (file+olp "~/org/na.org" "Unsorted") "** TODO %?") ("m" "TODO from Mail" entry (file+olp "~/org/na.org" "Unsorted") "** TODO %a" :immediate-finish t))))
 '(org-feed-alist (quote (("DRadio Forschung aktuell" "http://www.dradio.de/rss/podcast/sendungen/forschak/" "~/org/podcasts.org" "DRadio Forschung aktuell" :formatter ma-format-dradio-feed-entry) ("DRadio Zeitfragen" "http://www.dradio.de/rss/podcast/sendungen/zeitfragen/" "~/org/podcasts.org" "DRadio Zeitfragen" :formatter ma-format-dradio-feed-entry) ("DRadio Umwelt und Verbraucher" "http://www.dradio.de/rss/podcast/sendungen/umweltundverbraucher/" "~/org/podcasts.org" "DRadio Umwelt und Verbraucher" :formatter ma-format-dradio-feed-entry) ("DRadio Computer und Kommunikation" "http://www.dradio.de/rss/podcast/sendungen/computer/" "~/org/podcasts.org" "DRadio Computer und Kommunikation" :formatter ma-format-dradio-feed-entry) ("FLOSS" "http://www.leoville.tv/podcasts/floss.xml" "~/org/podcasts.org" "FLOSS" :formatter ma-format-dradio-feed-entry))))
 '(org-scheduled-past-days 5)
 '(org-sort-agenda-notime-is-late nil)
 '(org-toodledo-inhibit-https t)
 '(org-toodledo-password "uENfYn30UIzJZs5f1h4s")
 '(org-toodledo-sync-on-save "yes")
 '(org-toodledo-userid "td50effa7ae84c9")
 '(package-archives (quote (("gnu" . "http://elpa.gnu.org/packages/") ("marmalade" . "http://marmalade-repo.org/packages/"))))
 '(password-cache-expiry 3600)
 '(remote-file-name-inhibit-cache nil)
 '(require-final-newline t)
 '(safe-local-variable-values (quote ((tags-file-name . "/scratch2/apel/llvm-3.1.src/TAGS") (tags-file-name . "/scratch2/apel/llvm-3.0.src/TAGS") (tags-file-name . "/scratch/apel/new_arch/.tags") (tags-file-name "/scratch2/apel/llvm-3.0.src/TAGS") (tags-file-name "/scratch/apel/new_arch/.tags") (tags-table-list "/scratch2/apel/llvm-3.0.src/TAGS") (tags-table-list "/scratch/apel/new_arch/.tags") (tags-table-list (quote ("/scratch/apel/new_arch/.tags"))) (tags-table-list (quote ("/scratch2/apel/llvm-3.0.src/TAGS"))) (ma-build-dir) (ma-make-target) (ma-make-target . undef) (crontab-host . build-linux) (crontab-host . redhat64) (crontab-apply-after-save . t) (ma-compile-command . "~/bin/my_compile") (ma-compile-command . "make -C /home/home_dev/apel/llvm_test/obj"))))
 '(save-abbrevs nil)
 '(scroll-bar-mode (quote right))
 '(send-mail-function nil)
 '(show-paren-mode t nil (paren))
 '(show-paren-style (quote parenthesis))
 '(smartscan-symbol-selector "symbol")
 '(smtpmail-local-domain "simpack.de")
 '(smtpmail-smtp-server "exchange.intec.dom")
 '(socks-server (quote ("Default server" "localhost" 1080 5)))
 '(split-height-threshold 40)
 '(split-width-threshold 200)
 '(standard-indent 3)
 '(svn-log-edit-show-diff-for-commit t)
 '(tab-width 3)
 '(tags-add-tables nil)
 '(tags-revert-without-query t)
 '(tex-close-quote "\"")
 '(tex-command nil t)
 '(tex-open-quote "\"")
 '(texinfo-close-quote "''")
 '(texinfo-open-quote "``")
 '(tramp-default-method "ssh")
 '(tramp-default-proxies-alist nil)
 '(truncate-lines t)
 '(uniquify-buffer-name-style (quote post-forward-angle-brackets) nil (uniquify))
 '(use-file-dialog nil)
 '(user-full-name "Martin Apel")
 '(user-mail-address "martin.apel@simpack.de")
 '(vc-command-messages t)
 '(vc-consult-headers nil)
 '(w3m-pop-up-windows t)
 '(which-function-mode t nil (which-func)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#ffffff" :foreground "#141312" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 88 :width normal :foundry "unknown" :family "DejaVu LGC Sans Mono"))))
 '(ace-jump-face-foreground ((((class color)) (:foreground "blue" :inverse-video t))))
 '(tempo-snippets-editable-face ((((background light)) (:background "light cyan" :underline t)))))

(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

(defun ma-format-dradio-feed-entry (entry)
  "Format an entry from DRadio feeds"

    (setq descr (replace-regexp-in-string "&quot;" "\"" (or (plist-get entry :description) "???")))
    (setq title (replace-regexp-in-string "&quot;" "\"" (or (plist-get entry :title) "???")))
    (string-match "<!\\[CDATA\\[\\([^\]]*\\)\\]\\]>" descr)
    (setq descrText (replace-regexp-in-string "<[^>]+>" "" (match-string 1 descr)))
    (setq link (or (and (plist-get entry :guid-permalink)
                                      (plist-get entry :guid))
                                 (plist-get entry :link)))
    (setq wrapped (if (> (length descrText) 0) (mapconcat 'identity (org-wrap descrText 80) "\n   ") descrText))

    (decode-coding-string 
     (concat "** " title "\n"
             "   " wrapped "\n"
             "   Link: " link)
     'iso-8859-1)
)

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

(defun ma-show-tmux ()
  (interactive)
  (start-process "WMCtrl" nil "/usr/bin/wmctrl" "-a" "tmux")
  )

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


(defun ma-sync-toodledo ()
  "Sync private.org to Toodledo"
  (find-file "~/ownCloud/private.org")
  (org-toodledo-sync)
  (org-agenda "a" "a")
)

(defun ma-org-get-attachments ()
  "Retrieve the attachments of the current entry into a directory named ~/devs/<DevIssue-Id>
   and insert a link to this directory for the current entry"
  (interactive)
  (let* ((headline (nth 4 (org-heading-components)))
         (matched (string-match "^\\(\\[#[A-C]\\]\\)?\\([0-9]+\\):" headline))
         (dev-id (match-string 2 headline))
         (dir (concat "~/devs/" dev-id))
         (link (format "[[file:%s][%s]]" dir dev-id))
         )
    (progn
      ;; delete directory if it already exists
      (if (file-directory-p dir)
          (delete-directory dir t))
      (shell-command (concat "~/perl/download_mks_attachments.pl " dev-id))
      (save-excursion
        (while (not (org-at-heading-p))
          (previous-line))
        (beginning-of-line)
        (replace-string dev-id link nil (line-beginning-position) (line-end-position))
        )
      )
    )
)
  
(add-hook 'server-visit-hook
          'ma-edit-changelog)

(put 'narrow-to-region 'disabled nil)

(run-with-idle-timer 60 nil 'ma-sync-toodledo)

(defun show-frame (&optional frame)
  "Show the current Emacs frame or the FRAME given as argument.
   And make sure that it really shows up!"
  (raise-frame)
  ; yes, you have to call this twice. Don’t ask me why…
  ; select-frame-set-input-focus calls x-focus-frame and does a bit of
  ; additional magic.
  (select-frame-set-input-focus (selected-frame))
  (select-frame-set-input-focus (selected-frame)))


;; The following functions increment-integer-at-point and decrement-integer-at-point are taken from 
;; Bozhidar Batsov Emacs Redux page
(require 'thingatpt)
(defun thing-at-point-goto-end-of-integer ()
  "Go to end of integer at point."
  (let ((inhibit-changing-match-data t))
    ;; Skip over optional sign
    (when (looking-at "[+-]")
      (forward-char 1))
    ;; Skip over digits
    (skip-chars-forward "[[:digit:]]")
    ;; Check for at least one digit
    (unless (looking-back "[[:digit:]]")
      (error "No integer here"))))
(put 'integer 'beginning-op 'thing-at-point-goto-end-of-integer)

(defun thing-at-point-goto-beginning-of-integer ()
  "Go to end of integer at point."
  (let ((inhibit-changing-match-data t))
    ;; Skip backward over digits
    (skip-chars-backward "[[:digit:]]")
    ;; Check for digits and optional sign
    (unless (looking-at "[+-]?[[:digit:]]")
      (error "No integer here"))
    ;; Skip backward over optional sign
    (when (looking-back "[+-]")
        (backward-char 1))))
(put 'integer 'beginning-op 'thing-at-point-goto-beginning-of-integer)

(defun thing-at-point-bounds-of-integer-at-point ()
  "Get boundaries of integer at point."
  (save-excursion
    (let (beg end)
      (thing-at-point-goto-beginning-of-integer)
      (setq beg (point))
      (thing-at-point-goto-end-of-integer)
      (setq end (point))
      (cons beg end))))
(put 'integer 'bounds-of-thing-at-point 'thing-at-point-bounds-of-integer-at-point)

(defun thing-at-point-integer-at-point ()
  "Get integer at point."
  (let ((bounds (bounds-of-thing-at-point 'integer)))
    (string-to-number (buffer-substring (car bounds) (cdr bounds)))))
(put 'integer 'thing-at-point 'thing-at-point-integer-at-point)

(defun increment-integer-at-point (&optional inc)
  "Increment integer at point by one.

With numeric prefix arg INC, increment the integer by INC amount."
  (interactive "p")
  (let ((inc (or inc 1))
        (n (thing-at-point 'integer))
        (bounds (bounds-of-thing-at-point 'integer)))
    (delete-region (car bounds) (cdr bounds))
    (insert (int-to-string (+ n inc)))))

(defun decrement-integer-at-point (&optional dec)
  "Decrement integer at point by one.

With numeric prefix arg DEC, decrement the integer by DEC amount."
  (interactive "p")
  (increment-integer-at-point (- (or dec 1))))
