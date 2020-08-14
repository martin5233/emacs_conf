(package-initialize)

(setq home (string-match "^martin$" (user-login-name)))
(setq work-linux (and (string-match "^MAL1$" (user-login-name)) (string-equal system-type "gnu/linux")))
(setq work-win (and (string-match "^mal1$" (user-login-name)) (or (string-equal system-type "windows-nt") (string-equal system-type "cygwin"))))
(setq work (or work-linux work-win))
(setq home-office (and work-linux (string-equal (getenv "DISPLAY") ":1.0")))

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
      '((:name expand-region
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
        (:name uniquify
               :type builtin
               :features uniquify
               :after (setq uniquify-buffer-name-style 'post-forward-angle-brackets))
        (:name dash)
        (:name ghub)
        (:name graphql)
        (:name magit-popup)
        (:name treepy)
        (:name with-editor)
        (:name magit
               :depends (dash ghub graphql magit-popup treepy with-editor)
               :after
               (progn
                 (when work-win (setq magit-git-executable "C:/Program Files (x86)/SmartGit/git/bin/git.exe"))
                 (global-set-key (kbd "C-c C-z") 'magit-status)))
        (:name swiper
               :after (progn
                        (ivy-mode 1)
                        (setq ivy-set-virtual-buffers t)
                        (setq ivy-count-format "(%d/%d)")
                        (setq ivy-re-builders-alist '((t . ivy--regex-ignore-order)))
                        (add-to-list 'ivy-completing-read-handlers-alist '(find-file . completing-read-default))
                        (add-to-list 'ivy-completing-read-handlers-alist '(grep-read-files . completing-read-default))
                        ))
        (:name mo-git-blame
               :after (global-set-key (kbd "C-x v g") 'mo-git-blame-current))
        (:name hydra)
        (:name emacs-gdb
               :type github
               :pkgname "weirdNox/emacs-gdb"
               :depends hydra
               :autoloads gdb-mi.el
               :after (progn
                        (fmakunbound 'gdb)
                        (fmakunbound 'gdb-enable-debug)
                        (setq gdb-ignore-gdbinit nil)
                        (defhydra hydra-gdb ()
                          "gdb"
                          ("g"  (gdb-executable "/scratch/apel/new_arch/obj/dbg64/run/bin/linux64/simpack-gui") "simpack-gui")
                          ("s"  (gdb-executable "/scratch/apel/new_arch/obj/dbg64/run/bin/linux64/simpack-slv") "simpack-slv"))
                        (global-set-key (kbd "<f4>") 'hydra-gdb/body)
                        ))
        (:name smartscan
               :after (global-smartscan-mode 1))
        (:name git-timemachine)
        (:name git-gutter
               :after (global-git-gutter-mode 1))
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
               :after (add-hook 'prog-mode-hook
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
        (:name json-snatcher)
        (:name json-mode
               :depends json-snatcher)
        (:name markdown-mode)
        (:name levenshtein
               :type http
               :url "http://www.emacswiki.org/emacs/download/levenshtein.el"
               )
        (:name visual-regexp
               :after (progn
                        (global-set-key (kbd "M-%") 'vr/query-replace)
                        (global-set-key (kbd "C-M-%") 'vr/replace)))
        (:name visual-regexp-steroids)
        (:name guide-key)
        (:name ace-window
               :after
               (global-set-key (kbd "C-x o") 'ace-window))
        (:name auto-compile
               :after (progn
                        (setq load-prefer-newer t)
                        (require 'auto-compile)
                        (auto-compile-on-load-mode 1)
                        (auto-compile-on-save-mode 1)))
        (:name graphviz-dot-mode)
        (:name diminish
               :after (progn
                        (eval-after-load "cwarn" '(diminish 'cwarn-mode))
                        (eval-after-load "hideshow" '(diminish 'hs-minor-mode))
                        (eval-after-load "git-gutter" '(diminish 'git-gutter-mode))
                        (eval-after-load "abbrev" '(diminish 'abbrev-mode))))
        ))

(if work
    (setq el-get-sources
     (append el-get-sources
        '((:name filecache
           :type builtin)
          (:name restclient
           :type github
           :pkgname "pashky/restclient.el")
          (:name language-detection
                 :type github
                 :pkgname "andreasjansson/language-detection.el")
          (:name dockerfile-mode
                 :type github
                 :pkgname "spotify/dockerfile-mode"
                 :after
                 (add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode)))
          (:name groovy-emacs-mode)
          ))))

(if work-linux
    (setq el-get-sources
     (append el-get-sources
             '(
               (:name mu4e
                      :checkout "v1.0"
                      :depends (alert ht))
               (:name mu4e-alert
                      :depends (mu4e alert ht s))
               (:name rtags
                      :after (progn
                               (setq rtags-autostart-diagnostics t)
                               (setq rtags-enable-unsaved-reparsing nil)
                               (setq rtags-jump-to-first-match nil)
                               (setq rtags-path "/usr/local/bin")
                               (setq rtags-process-flags "--rp-daemon 1")
                               (setq rtags-rc-log-enabled t)
                               (setq rtags-reparse-timeout 1000)
                               (setq rtags-timeout 2000)
                               (rtags-diagnostics)
                               (setq rtags-completions-enabled t)
                               (setq rtags-suspend-during-compilation t)
                               (rtags-start-process-unless-running)
                               (add-hook 'kill-emacs-hook
                                         'rtags-quit-rdm)))
               (:name popup)
               (:name auto-complete
                      :depends popup)
               (:name ac-python
                      :depends auto-complete)
               (:name doxymacs)
               (:name erc
                      :type builtin)
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
 '(appt-audible nil)
 '(auth-source-debug nil)
 '(auth-sources (quote ("~/.authinfo.gpg")))
 '(auto-revert-check-vc-info nil)
 '(auto-revert-remote-files nil)
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
    ("." "/usr/include" "/usr/local/include/*" "/scratch/apel/new_arch/develop/src/ooa" "../LocalInterfaces" "../../ProtectedInterfaces" "../src" "../../src" "/scratch/apel/new_arch/develop/src/postproc/include" "/scratch/apel/new_arch/develop/src/postproc/include/*")))
 '(cmake-ide-rc-executable "/usr/local/bin/rc")
 '(cmake-ide-rdm-executable "/usr/local/bin/rdm")
 '(comment-style (quote plain))
 '(compilation-ask-about-save nil)
 '(compilation-auto-jump-to-first-error t)
 '(compilation-error-regexp-alist (quote (bash cmake cmake-info gcc-include gnu perl)))
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
 '(dired-dwim-target t)
 '(dired-omit-files "^\\.?#\\|^\\.")
 '(dirtrack-list (quote ("^MAL1@[a-zA-Z0-9]+ \\[\\(.*\\)\\]" 1)))
 '(ediff-keep-variants nil)
 '(ediff-split-window-function (quote split-window-horizontally))
 '(ediff-window-setup-function (quote ediff-setup-windows-plain))
 '(el-get-byte-compile-at-init t)
 '(emacs-lisp-mode-hook
   (quote
    (eldoc-mode imenu-add-menubar-index checkdoc-minor-mode)))
 '(erc-hide-list (quote ("JOIN" "PART" "QUIT" "MODE" "MODE-nick")))
 '(erc-modules
   (quote
    (autoaway autojoin button completion dcc fill irccontrols list match menu move-to-prompt netsplit networks noncommands notifications readonly ring smiley stamp spelling track)))
 '(erc-nick "martin")
 '(erc-notifications-icon "/usr/share/icons/Adwaita/48x48/actions/call-start.png")
 '(erc-server "localhost")
 '(erc-track-exclude-types (quote ("JOIN" "NICK" "PART" "333" "353")))
 '(erc-track-showcount nil)
 '(erc-user-full-name "Martin Apel")
 '(eudc-protocol (quote ldap))
 '(eudc-query-form-attributes (quote (name firstname email phone Uid)))
 '(eudc-server "10.29.111.1")
 '(european-calendar-style nil)
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
 '(gnutls-trustfiles
   (quote
    ("/etc/ssl/certs/ca-certificates.crt" "/etc/pki/tls/certs/ca-bundle.crt" "/etc/ssl/ca-bundle.pem" "/usr/ssl/certs/ca-bundle.crt" "/usr/local/share/certs/ca-root-nss.crt" "/home/home_dev/MAL1/SIMPACK_CA.cer")))
 '(grep-command "grep --color -nH -e ")
 '(grep-find-command
   (quote
    ("find . -type f -exec grep --color -nH -e  \\{\\} +" . 49)))
 '(grep-find-template
   "find <D> <X> -type f <F> -exec grep <C> -nH -e <R> \\{\\} +")
 '(grep-template "grep <X> <C> -nH -e <R> <F>")
 '(grep-use-null-filename-separator nil)
 '(gud-tooltip-mode t)
 '(guide-key-mode t)
 '(guide-key/guide-key-sequence (quote ("C-x r" "C-c r")))
 '(guide-key/idle-delay 0.0)
 '(guide-key/popup-window-position (quote bottom))
 '(imenu-sort-function (quote imenu--sort-by-name))
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(js-indent-level 3)
 '(large-file-warning-threshold 20000000)
 '(latex-run-command "pdflatex")
 '(ldap-default-base "ou=dsone,dc=dsone,dc=3ds,dc=com")
 '(ldap-default-host "10.29.111.1")
 '(ldap-host-parameters-alist
   (quote
    (("10.29.111.1" base "ou=dsone,dc=dsone,dc=3ds,dc=com" binddn "cn=SVC_SP_LDAPAUTH,ou=Managed Accounts,ou=DSDEU057,OU=EU,ou=dsone,dc=dsone,dc=3ds,dc=com" passwd "p@wist0psecret!"))))
 '(log-edit-hook (quote (log-edit-insert-cvs-template log-edit-show-files)))
 '(magit-auto-revert-mode nil)
 '(magit-cherry-pick-arguments (quote ("-x")))
 '(magit-commit-extend-override-date t)
 '(magit-commit-reword-override-date t)
 '(magit-completing-read-function (quote ivy-completing-read))
 '(magit-diff-refine-hunk t)
 '(magit-log-arguments (quote ("-n20")))
 '(magit-log-section-arguments (quote ("-n256" "--decorate")))
 '(magit-process-popup-time 3)
 '(magit-pull-arguments (quote ("--rebase")))
 '(magit-qdiff-options (quote ("--ignore-space-change" "--ignore-all-space")))
 '(magit-refs-primary-column-width (quote (16 . 60)))
 '(magit-refs-sections-hook
   (quote
    (magit-insert-error-header magit-insert-branch-description magit-insert-local-branches magit-insert-remote-branches)))
 '(magit-repo-dirs
   (quote
    ("/scratch/apel/new_arch" "/scratch2/apel/SpckTest" "/scratch2/apel/documentation")))
 '(magit-repository-directories (quote (("/scratch/apel" . 1) ("~/.emacs.d" . 2))))
 '(magit-restore-window-configuration t)
 '(magit-rewrite-inclusive nil)
 '(magit-show-child-count t)
 '(make-backup-files nil)
 '(minibuffer-message-timeout 2 t)
 '(mo-git-blame-blame-window-width 30)
 '(mouse-yank-at-point t)
 '(nxml-child-indent 3)
 '(org-agenda-files (quote ("~/org/na.org")))
 '(package-archives
   (quote
    (("gnu" . "http://elpa.gnu.org/packages/")
     ("marmalade" . "http://marmalade-repo.org/packages/"))))
 '(package-selected-packages (quote (nil)))
 '(password-cache-expiry 36000)
 '(perl-indent-level 3)
 '(remote-file-name-inhibit-cache nil)
 '(require-final-newline t)
 '(safe-local-variable-values
   (quote
    ((c-file-offsets
      (block-close . 0)
      (brace-list-close . 0)
      (brace-list-entry . 0)
      (brace-list-intro . +)
      (case-label . 0)
      (class-close . 0)
      (defun-block-intro . +)
      (defun-close . 0)
      (defun-open . 0)
      (else-clause . 0)
      (inclass . +)
      (label . 0)
      (statement . 0)
      (statement-block-intro . +)
      (statement-case-intro . +)
      (statement-cont . +)
      (substatement . +)
      (topmost-intro . 0))
     (dockerfile-image-name . "test")
     (ma-make-target . "")
     (ma-build-dir . "")
     (ma-build-target)
     (ma-compile-command . "~/bin/ds/my_mkmk")
     (tags-table-list "/scratch/apel/new_arch/.tags")
     (tags-table-list "/scratch/apel/MotionPlatform/TAGS")
     (tags-table-list "/scratch/apel/SpckTest/SquishTestSuites/TAGS")
     (eval ignore-errors "Write-contents-functions is a buffer-local alternative to before-save-hook"
           (add-hook
            (quote write-contents-functions)
            (lambda nil
              (delete-trailing-whitespace)
              nil))
           (require
            (quote whitespace))
           "Sometimes the mode needs to be toggled off and on."
           (whitespace-mode 0)
           (whitespace-mode 1))
     (whitespace-line-column . 80)
     (whitespace-style face tabs trailing lines-tail)
     (ma-build-dir)
     (ma-make-target)
     (ma-make-target . undef)
     (crontab-host . build-linux)
     (crontab-host . redhat64)
     (crontab-apply-after-save . t)
     (ma-compile-command . "~/bin/my_compile")
     (ma-compile-command . "/home/home_dev/MAL1/bin/ds/my_mkmk"))))
 '(save-abbrevs nil)
 '(scroll-bar-mode (quote right))
 '(send-mail-function nil)
 '(show-paren-mode t nil (paren))
 '(show-paren-style (quote parenthesis))
 '(smartscan-symbol-selector "symbol")
 '(split-height-threshold 40)
 '(split-width-threshold 200)
 '(standard-indent 3)
 '(stash-repos
   (quote
    (("spckxxxx" . "/scratch/apel/new_arch/")
     ("spcktest" . "/scratch/apel/SpckTest/")
     ("motionplatformloader" . "/scratch/apel/MotionPlatform/")
     ("devscripts" . "/scratch/apel/devscripts/"))))
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
 '(tramp-default-method "ssh" nil (tramp))
 '(tramp-default-proxies-alist nil nil (tramp))
 '(tramp-smb-conf "/home/home_dev/MAL1/.smbclient.conf" nil (tramp))
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
 '(git-gutter:added ((t (:inherit default :foreground "deep sky blue" :weight bold))))
 '(ma-magit-highlight-remote-face ((t (:inherit magit-branch-remote :background "light sea green" :foreground "black" :underline t :slant italic))))
 '(rtags-errline ((t (:background "dark orange"))))
 '(rtags-fixitline ((t (:background "goldenrod4
"))))
 '(rtags-skippedline ((t (:background "white smoke"))))
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
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "C-x r b") 'counsel-bookmark)
(global-set-key (kbd "C-h b") 'counsel-descbinds)
(global-set-key (kbd "C-h f") 'counsel-describe-function)
(global-set-key (kbd "C-h v") 'counsel-describe-variable)
(global-set-key (kbd "M-y") 'counsel-yank-pop)
(global-set-key (kbd "C-x b") 'counsel-ibuffer)
;; (global-set-key (kbd "SPC") 'just-one-space)
;; (global-set-key (kbd "S-SPC") '(lambda () (interactive) (insert-char #x20)))

(windmove-default-keybindings)

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
            (local-set-key (kbd "C-c i") 'imenu)
            (local-unset-key (kbd "C-c C-a"))                       ;; Free keybinding for multiple-cursors
            (local-unset-key (kbd "C-c C-n"))
            (local-unset-key (kbd "C-c C-p"))
            (local-unset-key (kbd "C-c C-z"))                       ;; Free keybinding for magit-status

            (add-hook 'before-save-hook 'ma-create-or-update-copyright)
            (c-toggle-hungry-state 1)
            (flyspell-prog-mode)
            (cwarn-mode)
            (hs-minor-mode)
            (idle-highlight-mode)
            (rtags-enable-standard-keybindings)
            (hs-hide-initial-comment-block)))


(add-hook 'python-mode-hook
          (lambda ()
            (local-unset-key [?\C-C ?\C-r])
            (idle-highlight-mode)
            (which-function-mode)
            (imenu-add-to-menubar "Functions")))

(add-hook 'shell-mode-hook
          'dirtrack-mode)

(add-hook 'before-save-hook
          'delete-trailing-whitespace)

(add-hook 'after-save-hook
  'executable-make-buffer-file-executable-if-script-p)

(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (local-set-key (kbd "M-.") 'find-function-other-window)))

(add-hook 'cmake-mode-hook
          (lambda ()
            (local-set-key [?\C-c ?\C-d] 'cmake-help)
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

(add-hook 'prog-mode-hook
          (lambda()
            (if (tramp-tramp-file-p (buffer-file-name (current-buffer)))
                (set (make-local-variable 'rtags-enabled) nil))))

(server-start)

(global-font-lock-mode 1)

(global-set-key [f2] 'customize-group)

(setq-default ediff-ignore-similar-regions t)

(add-to-list 'auto-mode-alist '("\\.sjs$" . javascript-mode))
(add-to-list 'auto-mode-alist '("\\.h$" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(electric-pair-mode)

(if work-linux
   (progn
     (require 'atl-stash)
     (stash-update-stash-info)
     (add-to-list 'mode-line-misc-info '(" " stash-mode-line-string " ") t)
     (run-with-timer 60 60 'stash-update-stash-info)
     (global-set-key (kbd "C-c p") 'stash-show-pull-requests)
     ))
