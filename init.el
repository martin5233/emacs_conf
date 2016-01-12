(setq home (string-match "^martin$" (user-login-name)))
(setq work-linux (and (string-match "^mal1$" (user-login-name)) (string-equal system-type "gnu/linux")))
(setq work-win (and (string-match "^mal1$" (user-login-name)) (or (string-equal system-type "windows-nt") (string-equal system-type "cygwin"))))
(setq work (or work-linux work-win))

(if work
    (setq url-proxy-services
          '(("http" . "192.168.208.216:3128")
            ("https" . "192.168.208.216:3128")
            ("no_proxy" . "3ds.com")))
)

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(setq el-get-user-package-directory "~/.emacs.d")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

;; These two have to be set, before el-get starts
(setq el-get-emacswiki-base-url "http://www.emacswiki.org/emacs/download/")
(setq el-get-github-default-url-type (quote https))

(setq el-get-sources
      '((:name tempo
               :type builtin
               :features tempo)
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
               :type http
               :url "http://www.emacswiki.org/emacs/download/etags-select.el"
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
        (:name org-toodledo)
        (:name uniquify
               :type builtin
               :features uniquify
               :after (setq uniquify-buffer-name-style 'post-forward-angle-brackets))
        (:name magit
               :after
               (progn
                 (when work-win (setq magit-git-executable "C:/Program Files (x86)/SmartGit/git/bin/git.exe"))
                 (global-set-key (kbd "C-c C-z") 'magit-status)))
        (:name mo-git-blame
               :after (global-set-key (kbd "C-x v g") 'mo-git-blame-current))
        (:name macrostep)
        (:name smartscan)
        (:name git-timemachine)
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
        (:name request)
        (:name smex
               :after (global-set-key (kbd "M-x") 'smex))
        (:name auto-insert
               :type builtin
               :depends skeleton
               :after (progn
                        (add-hook 'find-file-hook 'auto-insert)
                        (define-auto-insert "\\.h\\'" 'header-skeleton)
                        ))
        (:name smerge-mode
               :type builtin
               :after (add-hook 'c-mode-common-hook 'smerge-start-session))
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
        (:name desktop
               :type builtin
               :after (progn
                        (desktop-save-mode t)
                        (add-hook 'kill-emacs-hook 'ma-kill-old-buffers)))
        (:name cmake-mode
               :after (setq cmake-tab-width 3))
        (:name idle-highlight-mode)
        (:name auto-complete)
        (:name auto-complete-emacs-lisp
               :depends auto-complete)
        (:name json-snatcher)
        (:name json-mode
               :depends json-snatcher)
        (:name markdown-mode)
        (:name anchored-transpose
               :type http
               :url "http://www.emacswiki.org/emacs/download/anchored-transpose.el"
               :after (global-set-key (kbd "C-x t") 'anchored-transpose)
               )
        (:name apt-utils
               :type http
               :url "http://www.emacswiki.org/emacs/download/apt-utils.el"
               )
        (:name visual-regexp
               :after (progn
                        (global-set-key (kbd "M-%") 'vr/query-replace)
                        (global-set-key (kbd "C-M-%") 'vr/replace)))
        (:name visual-regexp-steroids)
        (:name guide-key)
        (:name helm
               :after
               (progn
                 (global-set-key (kbd "C-x b") 'helm-buffers-list)
                 (global-set-key (kbd "M-y") 'helm-show-kill-ring)
                 (helm-mode t)))
        (:name ace-window
               :after
               (global-set-key (kbd "C-x o") 'ace-window))
        (:name helm-ls-git
               :depends helm
               :after (global-set-key (kbd "C-x g") 'helm-ls-git-ls))
        (:name auto-compile
               :after (progn
                        (setq load-prefer-newer t)
                        (require 'auto-compile)
                        (auto-compile-on-load-mode 1)
                        (auto-compile-on-save-mode 1)))
        (:name graphviz-dot-mode)
        (:name diminish
               :after (progn
;;                        (eval-after-load "magit" '(diminish 'magit-auto-revert-mode))
                        (eval-after-load "cwarn" '(diminish 'cwarn-mode))
                        (eval-after-load "hideshow" '(diminish 'hs-minor-mode))
                        (eval-after-load "helm-mode" '(diminish 'helm-mode))
                        (eval-after-load "abbrev" '(diminish 'abbrev-mode))))
        ))

(if work
    (setq el-get-sources
     (append el-get-sources
        '((:name filecache
           :type builtin)
          (:name ac-etags
           :type github
           :pkgname "syohex/emacs-ac-etags"
           :after (ac-etags-setup))
          (:name org-jira
           :type github
           :pkgname "baohaojun/org-jira"
           :after (setq jiralib-url "https://spck-jira.ux.dsone.3ds.com:8443"))
          (:name restclient
           :type github
           :pkgname "pashky/restclient.el")
          (:name php-mode-improved
                 :type http
                 :url "http://www.emacswiki.org/emacs/download/php-mode-improved.el"
                 :after (add-to-list 'auto-mode-alist '("\\.php$" . php-mode)))
          (:name calfw)
          (:name mu4e
                 :depends (alert ht))
          (:name mu4e-alert
                 :depends (mu4e alert ht s))
          (:name rtags)
          (:name cmake-ide
                 :after  (progn
                           (require 'rtags)
                           (setq cmake-ide-dir "/scratch/apel/new_arch/obj/rtags")
                           (add-hook 'kill-emacs-hook 'rtags-quit-rdm t)
                           (cmake-ide-setup)))
          ))))

(if work-linux
    (setq el-get-sources
     (append el-get-sources
        '((:name doxymacs)
	  (:name uuid
		 :type http
		 :url "http://www.emacswiki.org/emacs/download/uuid.el")
	  ))))

(setq my-packages (mapcar 'el-get-source-name el-get-sources))

(el-get 'sync my-packages)

(add-to-list 'load-path "~/.emacs.d/ma-funcs")
(require 'ma-funcs)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-modes
   (quote
    (emacs-lisp-mode lisp-mode lisp-interaction-mode slime-repl-mode go-mode java-mode malabar-mode clojure-mode clojurescript-mode scala-mode scheme-mode ocaml-mode tuareg-mode coq-mode haskell-mode agda-mode agda2-mode perl-mode cperl-mode python-mode ruby-mode lua-mode tcl-mode ecmascript-mode javascript-mode js-mode js2-mode php-mode css-mode makefile-mode sh-mode fortran-mode f90-mode ada-mode xml-mode sgml-mode ts-mode sclang-mode verilog-mode qml-mode)))
 '(appt-audible nil)
 '(auth-source-debug nil)
 '(auth-sources (quote ("~/.authinfo.gpg")))
 '(auto-revert-check-vc-info nil)
 '(auto-revert-remote-files t)
 '(auto-revert-verbose nil)
 '(blink-matching-paren-on-screen nil)
 '(browse-kill-ring-no-duplicates t)
 '(browse-url-browser-function (quote ((".*" . browse-url-firefox))))
 '(browse-url-firefox-program "/home/home_dev/MAL1/tools/firefox/firefox")
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
 '(calendar-view-diary-initially-flag t)
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
 '(cperl-continued-statement-offset 0)
 '(cperl-indent-level 3)
 '(dabbrev-case-fold-search nil)
 '(default-input-method "german-postfix")
 '(desktop-globals-to-save
   (quote
    (desktop-missing-file-warning search-ring regexp-search-ring register-alist file-name-history)))
 '(desktop-restore-eager 20)
 '(desktop-save (quote ask-if-new))
 '(diary-file "~/.diary")
 '(dired-auto-revert-buffer (quote dired-directory-changed-p))
 '(dirtrack-list (quote ("^MAL1@[a-zA-Z0-9]+ \\[\\(.*\\)\\]" 1)))
 '(display-buffer-alist
   (quote
    (("\\*compilation\\*" display-buffer-use-some-window
      (window-width . 1.0)))))
 '(ediff-keep-variants nil)
 '(ediff-split-window-function (quote split-window-horizontally))
 '(ediff-window-setup-function (quote ediff-setup-windows-plain))
 '(el-get-byte-compile-at-init t)
 '(emacs-lisp-mode-hook
   (quote
    (eldoc-mode imenu-add-menubar-index checkdoc-minor-mode)))
 '(erc-nick "martin")
 '(erc-server "localhost")
 '(erc-user-full-name "Martin Apel")
 '(eudc-protocol (quote ldap))
 '(eudc-query-form-attributes (quote (name firstname email phone Uid)))
 '(eudc-server "10.29.111.1")
 '(european-calendar-style nil)
 '(excorporate-configuration "martin.APEL@3ds.com")
 '(ff-always-in-other-window t)
 '(ff-always-try-to-create nil)
 '(ff-ignore-include t)
 '(file-cache-filter-regexps
   (quote
    ("~$" "\\.o$" "\\.rpo$" "\\.exe$" "\\.a$" "\\.elc$" ",v$" "\\.output$" "\\.$" "#$" "\\.class$" "\\.bak$" "\\.svn-base$" "\\.html$" "\\.svn" "\\.so$" "\\.dll$" "CMakeFiles" "extern/share" "extern/linux" "extern/win" "partners" "/obj/" "^project\\.pj$" "\\.sbr$" "\\.tes$" "\\.intinfo$" "\\.dim$")))
 '(fill-column 120)
 '(focus-follows-mouse t)
 '(gdb-find-source-frame t)
 '(gdb-many-windows t)
 '(gdb-show-main t)
 '(git-commit-summary-max-length 72)
 '(global-auto-revert-mode t)
 '(gud-tooltip-mode t)
 '(guide-key-mode t)
 '(guide-key/guide-key-sequence (quote ("C-x r")))
 '(guide-key/idle-delay 0.0)
 '(guide-key/popup-window-position (quote bottom))
 '(helm-buffer-max-length 40)
 '(helm-completing-read-handlers-alist
   (quote
    ((describe-function . helm-completing-read-symbols)
     (describe-variable . helm-completing-read-symbols)
     (debug-on-entry . helm-completing-read-symbols)
     (find-function . helm-completing-read-symbols)
     (find-tag . helm-completing-read-with-cands-in-buffer)
     (ffap-alternate-file)
     (tmm-menubar)
     (find-file)
     (compilation-next-error-function))))
 '(helm-ff-transformer-show-only-basename nil)
 '(helm-for-files-preferred-list
   (quote
    (helm-source-file-cache helm-source-files-in-current-dir)))
 '(imenu-sort-function (quote imenu--sort-by-name))
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(js-indent-level 3)
 '(latex-run-command "pdflatex")
 '(ldap-default-base "ou=dsone,dc=dsone,dc=3ds,dc=com")
 '(ldap-default-host "10.29.111.1")
 '(ldap-host-parameters-alist
   (quote
    (("10.29.111.1" base "ou=dsone,dc=dsone,dc=3ds,dc=com" binddn "cn=SVC_SP_LDAPAUTH,ou=Managed Accounts,ou=DSDEU050,OU=EU,ou=dsone,dc=dsone,dc=3ds,dc=com" passwd "p@wist0psecret!"))))
 '(log-edit-hook (quote (log-edit-insert-cvs-template log-edit-show-files)))
 '(magit-cherry-pick-arguments (quote ("-x")))
 '(magit-commit-extend-override-date t)
 '(magit-commit-reword-override-date t)
 '(magit-diff-arguments (quote ("--ignore-space-change")))
 '(magit-diff-options (quote ("--ignore-space-change" "--ignore-all-space")))
 '(magit-diff-refine-hunk t)
 '(magit-process-popup-time 3)
 '(magit-refs-sections-hook
   (quote
    (magit-insert-branch-description magit-insert-local-branches magit-insert-remote-branches)))
 '(magit-repo-dirs
   (quote
    ("/scratch/apel/new_arch" "/scratch2/apel/SpckTest" "/scratch2/apel/documentation")))
 '(magit-repository-directories
   (quote
    ("/scratch/apel/new_arch" "/scratch/apel/SpckTest" "/scratch/apel/documentation")))
 '(magit-restore-window-configuration t)
 '(magit-rewrite-inclusive nil)
 '(magit-show-child-count t)
 '(make-backup-files nil)
 '(minibuffer-message-timeout 2 t)
 '(mo-git-blame-blame-window-width 30)
 '(mouse-yank-at-point t)
 '(nxml-child-indent 3)
 '(package-archives
   (quote
    (("gnu" . "http://elpa.gnu.org/packages/")
     ("marmalade" . "http://marmalade-repo.org/packages/"))))
 '(password-cache-expiry 36000)
 '(perl-indent-level 3)
 '(remote-file-name-inhibit-cache nil)
 '(require-final-newline t)
 '(rtags-enable-unsaved-reparsing nil)
 '(rtags-reparse-timeout 1000)
 '(rtags-timeout 1000)
 '(safe-local-variable-values
   (quote
    ((tags-table-list "/scratch/apel/new_arch/.tags")
     (after-revert-hook . ma-sync-toodledo-after-revert)
     (auto-revert-mode . t))))
 '(save-abbrevs nil)
 '(scroll-bar-mode (quote right))
 '(send-mail-function nil)
 '(show-paren-mode t nil (paren))
 '(show-paren-style (quote parenthesis))
 '(split-height-threshold 40)
 '(split-width-threshold 200)
 '(standard-indent 3)
 '(stash-repos
   (quote
    (("spckxxxx" . "/scratch/apel/new_arch/")
     ("spcktest" . "/scratch/apel/SpckTest/")
     ("documentation" . "/scratch/apel/documentation/"))))
 '(stash-reviewer-shortcuts
   (quote
    (("autotest-linux" . "linux")
     ("autotest-windows" . "win")
     ("autotest-fortran" . "fort")
     ("PKR3" . "PKl")
     ("MSN5" . "MSi")
     ("BBR1" . "BB")
     ("WTG1" . "WT")
     ("HKP1" . "PK")
     ("MAL1" . "MA")
     ("MFH1" . "MF")
     ("MDE7" . "MD")
     ("GHN1" . "GH")
     ("FMK1" . "FM")
     ("MDL2" . "DM")
     ("CWN1" . "ChW")
     ("TBN1" . "TB")
     ("PMK2" . "PM"))))
 '(stash-target-branch-regex "^origin/master\\|origin/release/.*$")
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
 '(user-mail-address "martin.apel@3ds.com")
 '(vc-command-messages t)
 '(vc-consult-headers nil)
 '(vc-display-status t)
 '(vc-git-diff-switches "-w")
 '(vc-handled-backends (quote (Git)))
 '(w3m-pop-up-windows t)
 '(which-function-mode t nil (which-func)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#ffffff" :foreground "#141312" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 88 :width normal :foundry "unknown" :family "DejaVu LGC Sans Mono"))))
 '(ace-jump-face-foreground ((((class color)) (:foreground "blue" :inverse-video t))))
 '(aw-leading-char-face ((t (:background "blue" :foreground "white"))))
 '(ma-magit-highlight-remote-face ((t (:inherit magit-branch-remote :background "light sea green" :foreground "black" :underline t :slant italic))))
 '(stash-section-title ((t (:background "light gray" :slant italic :height 1.5))))
 '(tempo-snippets-editable-face ((((background light)) (:background "light cyan" :underline t)))))

;; Avoid version-control checks for tramp buffers
(setq vc-ignore-dir-regexp
      (format "\\(%s\\)\\|\\(%s\\)"
              vc-ignore-dir-regexp
              tramp-file-name-regexp))

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

(add-hook 'c-mode-common-hook
       (lambda ()
            (imenu-add-to-menubar "Functions")
            (local-set-key (kbd "C-c C-o") 'ff-find-other-file)
            (local-set-key (kbd "C-c C-s") 'hs-show-block)
            (local-set-key (kbd "C-M-a") 'beginning-of-defun)
            (local-set-key (kbd "C-M-e") 'end-of-defun)
            (local-set-key (kbd "<delete>") 'c-electric-delete-forward)
            (local-set-key (kbd "C-c =") 'align-regexp)
            (local-set-key (kbd "C-M-u") 'ma-insert-random-uuid)
            (local-unset-key (kbd "C-c C-a"))                       ;; Free keybinding for multiple-cursors
            (local-unset-key (kbd "C-c C-n"))
            (local-unset-key (kbd "C-c C-p"))

            (add-hook 'before-save-hook 'ma-create-or-update-copyright)
            (c-toggle-hungry-state 1)
            (flyspell-prog-mode)
            (cwarn-mode)
            (hs-minor-mode)
            (idle-highlight-mode)
            (smartscan-mode)
            (hs-hide-initial-comment-block)))


(add-hook 'python-mode-hook
          (lambda ()
            (local-unset-key [?\C-C ?\C-r])
            (idle-highlight-mode)
            (which-function-mode)
            (smartscan-mode)
            (imenu-add-to-menubar "Functions")))

(add-hook 'shell-mode-hook
          'dirtrack-mode)

(add-hook 'before-save-hook
          'delete-trailing-whitespace)

(add-hook 'after-save-hook
  'executable-make-buffer-file-executable-if-script-p)

(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (smartscan-mode)
            (local-set-key (kbd "M-.") 'find-function-other-window)))

;; Workaround for a bug in compilation mode
(add-hook 'grep-mode-hook
          (lambda()
            (kill-local-variable 'compilation-auto-jump-to-next))
          )

(add-hook 'cmake-mode-hook
          (lambda ()
            (local-set-key [?\C-c ?\C-d] 'cmake-help)
            (smartscan-mode)
            (flyspell-prog-mode)
            (setq indent-line-function 'indent-relative)
            (subword-mode t)))

(add-hook 'sh-set-shell-hook
          (lambda()
            (when (string-equal sh-shell "tcsh")
              (progn
                (require 'csh-mode)
                (setq-local indent-line-function 'csh-indent-line)
                (setq-local indent-region-function 'csh-indent-region)))))

(server-start)

(global-font-lock-mode 1)

(global-set-key [f2] 'customize-group)

(setq-default ediff-ignore-similar-regions t)

(add-to-list 'auto-mode-alist '("\\.sjs$" . javascript-mode))
(add-to-list 'auto-mode-alist '("\\.h$" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(electric-pair-mode)

;; (if work-linux
;;     (progn
;;       (add-to-list 'load-path "~/.emacs.d/excorporate-0.6.0")
;;       (require 'excorporate)
;;       (require 'excorporate-calendar)
;;       (excorporate)))

(if work-linux
   (progn
     (require 'atl-stash)
     (stash-update-stash-info)
     (add-to-list 'mode-line-misc-info '(" " stash-mode-line-string " ") t)
     (run-with-timer 60 60 'stash-update-stash-info)
     (global-set-key (kbd "C-c p") 'stash-show-pull-requests)
     ))
