(setq home (string-match "^martin$" (user-login-name)))
(setq work (string-match "^apel$" (user-login-name)))

(if work
    (setq url-proxy-services
          '(("http" . "proxy.intec.dom:3128")
            ("https" . "proxy.intec.dom:3128")
            ("no_proxy" . "intec.dom")))
)

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(setq el-get-user-package-directory "~/.emacs.d")

(add-to-list 'load-path "~/.emacs.d/ma-funcs")
(require 'ma-funcs)

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(setq el-get-sources
      '((:name tempo
    :type builtin
    :features tempo
    :after (progn
        (tempo-define-template "change-hist-new-line" '( n " *            |                    |           " p))
                  (add-hook 'c-mode-common-hook
             (lambda() (local-set-key (kbd "S-<return>") 'tempo-template-change-hist-new-line)))
        ))
   (:name tempo-snippets
    :type http
    :url "http://nschum.de/src/emacs/tempo-snippets/tempo-snippets.el")
   (:name expand-region
    :after (global-set-key "\M-o" 'er/expand-region))
   (:name multiple-cursors
    :after (progn
        (global-set-key (kbd "C-c C-n") 'mc/mark-next-like-this)
        (global-set-key (kbd "C-c C-p") 'mc/mark-previous-like-this)
        (global-set-key (kbd "C-c C-a") 'mc/mark-all-like-this-in-defun)
        (global-set-key (kbd "C-c C-|") 'mc/edit-lines)))
   (:name etags-select
    :after (progn
             (add-hook 'c-mode-common-hook
                       (lambda()
                         (local-set-key (kbd "M-.") 'etags-select-find-tag-at-point)))
        (setq etags-select-go-if-unambiguous t)
        (setq etags-select-use-short-name-completion t)))
   (:name org-mode
    :branch "maint")
   (:name http-post-simple
    :type http
    :url "http://www.emacswiki.org/emacs/download/http-post-simple.el"
    :features http-post-simple)
   ;; (:name org-toodledo
   ;;  :type github
   ;;  :pkgname "christopherjwhite/org-toodledo"
   ;;  :features org-toodledo
   ;;  :depends (org-mode http-post-simple))
   (:name uniquify
    :type builtin
    :features uniquify
    :after (setq uniquify-buffer-name-style 'post-forward-angle-brackets))
   (:name magit
    :after (global-set-key (kbd "C-c C-z") 'magit-status))
   (:name csv-mode)
   (:name llvm-mode)
   (:name ascii-table)
   (:name crontab-mode)
   (:name browse-kill-ring)
   (:name wgrep)
   (:name generic
    :type builtin)
   (:name skeleton
    :type builtin)
   (:name smex
    :after (global-set-key (kbd "M-x") 'smex))
   (:name auto-insert
    :type builtin
    :depends skeleton
    :after (progn
        (add-hook 'find-file-hook 'auto-insert)
        (define-auto-insert "\\.h\\'" 'header-skeleton)
        ))
   (:name files
    :type builtin)
   (:name password-cache
         :type builtin)
   (:name subword
         :type builtin
    :after (add-hook 'c-mode-common-hook
           (lambda()
             (local-set-key (kbd "M-<left>") 'subword-backward)
             (local-set-key (kbd "M-<right>") 'subword-forward)
             (subword-mode t))))
;;   (:name ma-funcs
   (:name desktop
    :type builtin
;;    :depends ma-funcs
    :after (progn
             (desktop-save-mode t)
             (add-hook 'kill-emacs-hook 'ma-kill-old-buffers)))
   (:name cmake-mode
    :after (add-hook 'cmake-mode-hook
                     '(lambda ()
                        (local-set-key [?\C-c ?\C-d] 'cmake-help-command))))
   (:name idle-highlight-mode)
   (:name auto-complete-emacs-lisp)
   (:name smartparens
          :after (progn (smartparens-mode)
			(sp-local-pair 'c++-mode "<" ">")
			(sp-local-pair 'c++-mode "{" nil :post-handlers '("[i]\n||\n[i]"))))
   ))

(if work
    (setq el-get-sources
     (append el-get-sources
        '((:name filecache
           :type builtin)
          (:name doxymacs)
          (:name ac-etags
           :type github
           :pkgname "syohex/emacs-ac-etags"
           :after (ac-etags-setup))
          (:name org-jira
           :type github
           :pkgname "baohaojun/org-jira"
           :after (setq jiralib-url "https://jira.intec.dom:8443"))
          (:name restclient
           :type github
           :pkgname "pashky/restclient.el")
          ))))

(setq my-packages (mapcar 'el-get-source-name el-get-sources))

(el-get 'sync my-packages)

;; For some strange reason org-toodledo does not play well with el-get
(setq load-path (cons (expand-file-name "~/.emacs.d/org-toodledo-master") load-path))
(require 'org-toodledo)
(load "~/.emacs.d/init-org-toodledo")

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
 '(c-default-style
   (quote
    ((c-mode . "cc-mode")
     (c++-mode . "cc-mode")
     (java-mode . "java")
     (other . "gnu"))))
 '(c-offsets-alist
   (quote
    ((incomposition . +)
     (inmodule . +)
     (composition-close . 0)
     (module-close . 0)
     (composition-open . 0)
     (module-open . 0)
     (cpp-define-intro c-lineup-cpp-define +)
     (substatement-label . 2)
     (string . c-lineup-dont-change)
     (c . c-lineup-C-comments)
     (defun-open . 0)
     (defun-close . 0)
     (defun-block-intro . +)
     (class-open . 0)
     (class-close . 0)
     (inline-close . 0)
     (func-decl-cont . +)
     (knr-argdecl-intro . +)
     (knr-argdecl . 0)
     (topmost-intro . 0)
     (topmost-intro-cont . 0)
     (member-init-intro . +)
     (member-init-cont . c-lineup-multi-inher)
     (inher-intro . +)
     (inher-cont . c-lineup-multi-inher)
     (block-open . 0)
     (block-close . 0)
     (brace-list-open . 0)
     (brace-list-close . 0)
     (brace-list-intro . +)
     (brace-list-entry . 0)
     (brace-entry-open . 0)
     (statement . 0)
     (statement-cont . +)
     (statement-block-intro . +)
     (statement-case-intro . +)
     (statement-case-open . 0)
     (substatement . +)
     (substatement-open . 0)
     (case-label . 0)
     (access-label . -)
     (label . 2)
     (do-while-closure . 0)
     (else-clause . 0)
     (catch-clause . 0)
     (comment-intro . c-lineup-comment)
     (arglist-intro . +)
     (arglist-cont . 0)
     (arglist-cont-nonempty . c-lineup-arglist)
     (arglist-close . +)
     (stream-op . c-lineup-streamop)
     (inclass . +)
     (cpp-macro .
                [0])
     (cpp-macro-cont . c-lineup-dont-change)
     (friend . 0)
     (objc-method-intro .
                        [0])
     (objc-method-args-cont . c-lineup-ObjC-method-args)
     (objc-method-call-cont . c-lineup-ObjC-method-call)
     (extern-lang-open . 0)
     (extern-lang-close . 0)
     (inextern-lang . +)
     (namespace-open . 0)
     (namespace-close . 0)
     (innamespace . 0)
     (template-args-cont c-lineup-template-args +)
     (inlambda . c-lineup-inexpr-block)
     (lambda-intro-cont . +)
     (inexpr-statement . 0)
     (inexpr-class . +)
     (inline-open . 0))))
 '(c-style-variables-are-local-p nil)
 '(calendar-holidays
   (quote
    ((holiday-fixed 1 1 "New Year's Day")
     (holiday-float 1 1 3 "Martin Luther King Day")
     (holiday-fixed 2 2 "Groundhog Day")
     (holiday-fixed 2 14 "Valentine's Day")
     (holiday-float 2 1 3 "President's Day")
     (holiday-fixed 3 17 "St. Patrick's Day")
     (holiday-fixed 4 1 "April Fools' Day")
     (holiday-float 5 0 2 "Mother's Day")
     (holiday-float 5 1 -1 "Memorial Day")
     (holiday-fixed 6 14 "Flag Day")
     (holiday-float 6 0 3 "Father's Day")
     (holiday-fixed 7 4 "Independence Day")
     (holiday-float 9 1 1 "Labor Day")
     (holiday-float 10 1 2 "Columbus Day")
     (holiday-fixed 10 31 "Halloween")
     (holiday-fixed 11 11 "Veteran's Day")
     (holiday-float 11 4 4 "Thanksgiving")
     (holiday-easter-etc)
     (holiday-fixed 12 25 "Christmas")
     (if calendar-christian-all-holidays-flag
         (append
          (holiday-fixed 1 6 "Epiphany")
          (holiday-julian 12 25 "Eastern Orthodox Christmas")
          (holiday-greek-orthodox-easter)
          (holiday-fixed 8 15 "Assumption")
          (holiday-advent 0 "Advent")))
     (solar-equinoxes-solstices)
     (holiday-sexp calendar-daylight-savings-starts
                   (format "Daylight Saving Time Begins %s"
                           (solar-time-string
                            (/ calendar-daylight-savings-starts-time
                               (float 60))
                            calendar-standard-time-zone-name)))
     (holiday-sexp calendar-daylight-savings-ends
                   (format "Daylight Saving Time Ends %s"
                           (solar-time-string
                            (/ calendar-daylight-savings-ends-time
                               (float 60))
                            calendar-daylight-time-zone-name))))))
 '(calendar-mark-holidays-flag t)
 '(cc-other-file-alist
   (quote
    (("\\.cc\\'"
      (".hh" ".h"))
     ("\\.hh\\'"
      (".cc" ".C"))
     ("\\.c\\'"
      (".h"))
     ("Impl\\.h\\'"
      ("Impl.cpp" ".h"))
     ("\\.h\\'"
      (".c" ".cc" ".C" ".CC" ".cxx" ".cpp" "Impl.h"))
     ("\\.C\\'"
      (".H" ".hh" ".h"))
     ("\\.H\\'"
      (".C" ".CC"))
     ("\\.CC\\'"
      (".HH" ".H" ".hh" ".h"))
     ("\\.HH\\'"
      (".CC"))
     ("\\.c\\+\\+\\'"
      (".h++" ".hh" ".h"))
     ("\\.h\\+\\+\\'"
      (".c++"))
     ("\\.cpp\\'"
      (".hpp" ".hh" ".h"))
     ("\\.hpp\\'"
      (".cpp"))
     ("\\.cxx\\'"
      (".hxx" ".hh" ".h"))
     ("\\.hxx\\'"
      (".cxx")))))
 '(cc-search-directories
   (quote
    ("." "/usr/include" "/usr/local/include/*" "/scratch/apel/new_arch/develop/src/ooa")))
 '(comment-style (quote plain))
 '(compilation-ask-about-save nil)
 '(compilation-auto-jump-to-first-error t)
 '(compilation-read-command nil)
 '(compilation-scroll-output (quote first-error))
 '(compilation-search-path (quote ("/scratch/apel/new_arch")))
 '(compilation-skip-threshold 2)
 '(compilation-skip-visited t)
 '(confirm-kill-emacs (quote yes-or-no-p))
 '(copyright-limit 10000)
 '(copyright-regexp
   "\\(Copyright (c) \\)\\([-0-9, ';/*%#\\n\\t]*[0-9]+\\), \\(?:INTEC GmbH\\|\\SIMPACK AG\\|Simpack AG\\)")
 '(cperl-continued-statement-offset 0)
 '(cperl-indent-level 3)
 '(dabbrev-case-fold-search nil)
 '(default-input-method "german-postfix")
 '(desktop-restore-eager 20)
 '(desktop-save (quote ask-if-new))
 '(dired-auto-revert-buffer (quote dired-directory-changed-p))
 '(dirtrack-list (quote ("^apel@[a-zA-Z0-9]+ \\[\\(.*\\)\\]" 1)))
 '(ediff-split-window-function (quote split-window-horizontally))
 '(ediff-window-setup-function (quote ediff-setup-windows-plain))
 '(european-calendar-style nil)
 '(ff-always-in-other-window t)
 '(ff-always-try-to-create nil)
 '(ff-ignore-include nil)
 '(file-cache-filter-regexps
   (quote
    ("~$" "\\.o$" "\\.rpo$" "\\.exe$" "\\.a$" "\\.elc$" ",v$" "\\.output$" "\\.$" "#$" "\\.class$" "\\.bak$" "\\.svn-base$" "\\.html$" "\\.svn" "\\.so$" "\\.dll$" "CMakeFiles" "extern/share" "extern/linux" "extern/win" "partners" "/obj/" "^project\\.pj$" "\\.sbr$" "\\.tes$" "\\.intinfo$" "\\.dim$")))
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
 '(log-edit-hook (quote (log-edit-insert-cvs-template log-edit-show-files)))
 '(make-backup-files nil)
 '(message-from-style (quote default))
 '(message-send-mail-function (quote smtpmail-send-it))
 '(minibuffer-message-timeout 2 t)
 '(mouse-yank-at-point t)
 '(nxml-child-indent 3)
 '(org-toodledo-inhibit-https t)
 '(org-toodledo-password "uENfYn30UIzJZs5f1h4s")
 '(org-toodledo-sync-on-save "yes")
 '(org-toodledo-userid "td50effa7ae84c9")
 '(package-archives
   (quote
    (("gnu" . "http://elpa.gnu.org/packages/")
     ("marmalade" . "http://marmalade-repo.org/packages/"))))
 '(password-cache-expiry 3600)
 '(remote-file-name-inhibit-cache nil)
 '(require-final-newline t)
 '(safe-local-variable-values
   (quote
    ((tags-file-name . "/scratch2/apel/llvm-3.1.src/TAGS")
     (tags-file-name . "/scratch2/apel/llvm-3.0.src/TAGS")
     (tags-file-name . "/scratch/apel/new_arch/.tags")
     (tags-file-name "/scratch2/apel/llvm-3.0.src/TAGS")
     (tags-file-name "/scratch/apel/new_arch/.tags")
     (tags-table-list "/scratch2/apel/llvm-3.0.src/TAGS")
     (tags-table-list "/scratch/apel/new_arch/.tags")
     (tags-table-list
      (quote
       ("/scratch/apel/new_arch/.tags")))
     (tags-table-list
      (quote
       ("/scratch2/apel/llvm-3.0.src/TAGS")))
     (ma-build-dir)
     (ma-make-target)
     (ma-make-target . undef)
     (crontab-host . build-linux)
     (crontab-host . redhat64)
     (crontab-apply-after-save . t)
     (ma-compile-command . "~/bin/my_compile")
     (ma-compile-command . "make -C /home/home_dev/apel/llvm_test/obj"))))
 '(save-abbrevs nil)
 '(scroll-bar-mode (quote right))
 '(send-mail-function nil)
 '(show-paren-mode t nil (paren))
 '(show-paren-style (quote parenthesis))
 '(smartparens-global-mode t)
 '(smtpmail-local-domain "simpack.de")
 '(smtpmail-smtp-server "exchange.intec.dom")
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
 '(tool-bar-mode nil)
 '(tramp-default-method "ssh")
 '(tramp-default-proxies-alist nil)
 '(truncate-lines t)
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
(put 'narrow-to-region 'disabled nil)

(add-to-list 'default-frame-alist
                       '(font . "DejaVu Sans Mono-10"))

(defalias 'yes-or-no-p 'y-or-n-p)

(global-set-key [delete] 'delete-char)
(global-set-key [?\C-c ?\C-g] 'goto-line)
(global-set-key [?\C-x ?\C-b] 'ibuffer)
(global-set-key [?\C-c ?\C-r] 'rgrep)
(global-unset-key [?\C-x ?\C-c])
(global-set-key [?\C-x ?\C-c ?\C-x] 'save-buffers-kill-terminal)
(global-set-key "\M- " 'dabbrev-expand)
(global-set-key (kbd "C-.") 'goto-last-change)
(global-set-key (kbd "<kp-end>") 'shell)
(global-set-key (kbd "<kp-next>") '(lambda () "Open init.el" (interactive) (find-file "~/.emacs.d/init.el")))

(windmove-default-keybindings)

(browse-kill-ring-default-keybindings)

(add-hook 'kill-emacs-query-functions
          (lambda() (yes-or-no-p "All change packages reviewed?")))

(add-hook 'c-mode-common-hook
       (lambda ()
            (imenu-add-to-menubar "Functions")
            (local-set-key [?\C-c ?\C-o] 'ff-find-other-file)
            (local-set-key [?\C-c ?\C-s] 'hs-show-block)
            (local-set-key (kbd "C-M-a") 'beginning-of-defun)
            (local-set-key (kbd "C-M-e") 'end-of-defun)
            (local-set-key [delete] 'c-electric-delete-forward)
            (local-set-key [?\C-c ?=] 'align-regexp)

            (c-toggle-hungry-state 1)
            (flyspell-prog-mode)
            (cwarn-mode)
            (hs-minor-mode)
            (ac-etags-ac-setup)
            (hs-hide-initial-comment-block)))


(add-hook 'python-mode-hook
  '(lambda ()
     (local-unset-key [?\C-C ?\C-r])
     (imenu-add-to-menubar "Functions")))

(add-hook 'shell-mode-hook
          'dirtrack-mode)

(add-hook 'after-save-hook
  'executable-make-buffer-file-executable-if-script-p)

(server-start)

(global-font-lock-mode 1)


(global-set-key [f2] 'customize-group)


(setq-default ediff-ignore-similar-regions t)

(add-to-list 'auto-mode-alist '("\\.sjs$" . javascript-mode))
