(package-initialize)

(setq home (and (string-match "^martin$" (user-login-name)) (string-equal (system-name) "merlin")))
(setq work-linux-local (and (string-match "^MAL1$" (user-login-name)) (string-equal system-type "gnu/linux")))
(setq work-linux-remote (and (string-match "^martin$" (user-login-name)) (string-equal system-type "gnu/linux") (string-equal (system-name) "LP5-MAL1-CEM")))
(setq work-linux (or work-linux-local work-linux-remote))
(setq work-win (and (string-match "^mal1$" (user-login-name)) (or (string-equal system-type "windows-nt") (string-equal system-type "cygwin"))))
(setq work (or work-linux work-win))
(setq work-vnc (and work-linux-local (string-equal (getenv "DISPLAY") ":1.0")))

(if work-linux-remote
    (progn
      (setq work-remote-url "/ssh:MAL1@dell1254cem:")
      (setq enable-remote-dir-locals nil)
      (setq tramp-use-ssh-controlmaster-options nil)
  ;; Avoid version-control checks for tramp buffers
  (setq vc-ignore-dir-regexp
        (format "\\(%s\\)\\|\\(%s\\)"
                vc-ignore-dir-regexp
                tramp-file-name-regexp)))
  (setq work-remote-url ""))

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(setq el-get-user-package-directory "~/.emacs.d")
(setq Info-directory-list '("/usr/local/share/info/" "/usr/share/info/"))

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
        (:name org-mode
               :type builtin)
        (:name ox-pandoc
               :depends org-mode)
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
        (:name transient)
        (:name magit
               :depends (dash ghub graphql magit-popup treepy with-editor transient)
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
        (:name hydra)
        (:name gdb-mi
               :type github
               :pkgname "weirdNox/emacs-gdb"
               :depends hydra
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
        (:name smartscan)
        (:name git-timemachine)
        (:name git-gutter
               :after (if (not work-linux-remote)
                          (global-git-gutter-mode 1)))
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
        (:name json-reformat)
        (:name json-mode
               :depends (json-snatcher json-reformat))
        (:name hierarchy
               :type github
               :pkgname "DamienCassou/hierarchy")  ;; To be removed after 27.1, as integrated into Emacs core
        (:name json-navigator
               :type github
               :pkgname "DamienCassou/json-navigator"
               :depends hierarchy)
        (:name markdown-mode)
        (:name visual-regexp
               :after (progn
                        (global-set-key (kbd "M-%") 'vr/query-replace)
                        (global-set-key (kbd "C-M-%") 'vr/replace)))
        (:name visual-regexp-steroids)
        (:name which-key
               :after (which-key-mode))
        (:name yasnippet)
        (:name ace-window
               :after
               (progn
                 (global-set-key (kbd "C-x o") 'ace-window)
                 (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))))
        (:name auto-compile
               :after (progn
                        (setq load-prefer-newer t)
                        (require 'auto-compile)
                        (auto-compile-on-load-mode 1)
                        (auto-compile-on-save-mode 1)))
        (:name graphviz-dot-mode)
        (:name modern-cpp-font-lock
               :type github
               :pkgname "ludwigpacifici/modern-cpp-font-lock"
               :after (modern-c++-font-lock-global-mode t))
        (:name diminish
               :after (progn
                        (eval-after-load "cwarn" '(diminish 'cwarn-mode))
                        (eval-after-load "hideshow" '(diminish 'hs-minor-mode))
                        (eval-after-load "git-gutter" '(diminish 'git-gutter-mode))
                        (eval-after-load "flymake" '(diminish 'flymake-mode))
                        (eval-after-load "flycheck" '(diminish 'flycheck-mode))
                        (eval-after-load "company" '(diminish 'company-mode))
                        (eval-after-load "company-box" '(diminish 'company-box-mode))
                        (eval-after-load "yasnippet" '(diminish 'yas-minor-mode))
                        (eval-after-load "which-key" '(diminish 'which-key-mode))
                        (eval-after-load "abbrev" '(diminish 'abbrev-mode))))
        (:name projectile)
        (:name counsel-projectile
               :depends projectile
               :after (counsel-projectile-mode 1))
        (:name company-mode)
        (:name company-box-mode
		         :type github
		         :pkgname "sebastiencs/company-box"
               :after (add-hook 'company-mode-hook 'company-box-mode)
               :depends (company-mode frame-local))
        (:name frame-local
	       :type github
	       :pkgname "sebastiencs/frame-local")
        (:name flycheck)
        (:name doom-modeline)
;;         (:name doom-themes
        ;;                :after (load-theme 'doom-solarized-light t))
        (:name modus-themes
               :type github
               :pkgname "protesilaos/modus-themes"
               :after (progn
                        (modus-themes-load-themes)
                        (setq modus-themes-deuteranopia t)
                        (setq modus-themes-bold-constructs t)
                        (setq modus-themes-italic-constructs t)
                        (setq modus-themes-paren-match '(bold))
                        (setq modus-themes-mode-line '(3d))
                        (setq modus-themes-hl-line '(intense))
                        (modus-themes-load-vivendi)))
        (:name avy
         :type github
         :pkgname "abo-abo/avy")
        (:name engine-mode
         :type github
         :pkgname "hrs/engine-mode")
        (:name "devdocs"
         :type github
         :pkgname "astoff/devdocs.el")
        (:name "prescient"
         :type github
         :pkgname "raxod502/prescient.el"
         :depends (swiper company-mode)
         :after (progn
                  (ivy-prescient-mode)
                  (company-prescient-mode)
                  (prescient-persist-mode)))
        (:name keyfreq
               :type github
               :pkgname "dacap/keyfreq"
               :after (progn
                        (setq keyfreq-excluded-commands
                              '(lsp-ui-doc--handle-mouse-movement
                                gud-tooltip-mouse-motion))
                        (keyfreq-mode 1)
                        (keyfreq-autosave-mode 1)))
        ))

(if work
    (setq el-get-sources
     (append el-get-sources
        '((:name restclient
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
               (:name popup)
               (:name erc
                      :type builtin)
               (:name lsp-mode)
               (:name lsp-ui
                      :depends (lsp-mode))
               (:name lsp-ivy
                      :type github
                      :pkgname "emacs-lsp/lsp-ivy"
                      :depends lsp-mode)
               (:name uuid
                      :type http
                      :url "http://www.emacswiki.org/emacs/download/uuid.el")
               ))))

(if home
    (setq el-get-sources
     (append el-get-sources
          '(
            (:name eaf
                   :type github
                   :pkgname "emacs-eaf/emacs-application-framework")
            (:name platformio-mode
                   :type github
                   :pkgname "ZachMassia/platformio-mode"
                   :depends projectile)))))

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
 '(auth-source-save-behavior nil)
 '(auth-sources '("~/.authinfo.gpg"))
 '(auto-revert-check-vc-info nil)
 '(auto-revert-remote-files nil)
 '(auto-revert-verbose nil)
 '(blink-matching-paren-on-screen nil)
 '(browse-kill-ring-no-duplicates t)
 '(browse-url-browser-function '((".*" . browse-url-firefox)))
 '(browse-url-firefox-program "/home/home_dev/MAL1/tools/firefox/firefox")
 '(c-basic-offset 3)
 '(c-cleanup-list '(scope-operator compact-empty-funcall))
 '(c-default-style
   '((c-mode . "cc-mode")
     (c++-mode . "cc-mode")
     (java-mode . "java")
     (other . "gnu")))
 '(c-offsets-alist
   '((incomposition . +)
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
     (inline-open . 0)))
 '(c-style-variables-are-local-p nil)
 '(calendar-holidays
   '((holiday-fixed 1 1 "New Year's Day")
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
                            calendar-daylight-time-zone-name)))))
 '(calendar-mark-holidays-flag t)
 '(calendar-view-diary-initially-flag t)
 '(cc-other-file-alist
   '(("\\.cc\\'"
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
      (".cxx"))))
 '(cc-search-directories
   '("." "/usr/include" "/usr/local/include/*" "/scratch/apel/new_arch/develop/src/ooa" "../LocalInterfaces" "../../ProtectedInterfaces" "../src" "../../src" "/scratch/apel/new_arch/develop/src/postproc/include" "/scratch/apel/new_arch/develop/src/postproc/include/*"))
 '(comment-style 'plain)
 '(compilation-ask-about-save nil)
 '(compilation-auto-jump-to-first-error t)
 '(compilation-error-regexp-alist '(bash cmake cmake-info gcc-include gnu perl))
 '(compilation-read-command nil)
 '(compilation-scroll-output 'first-error)
 '(compilation-search-path '("/scratch/apel/new_arch"))
 '(compilation-skip-threshold 2)
 '(compilation-skip-visited t)
 '(completion-category-overrides '((file (styles emacs22))))
 '(confirm-kill-emacs 'yes-or-no-p)
 '(cperl-continued-statement-offset 0)
 '(cperl-indent-level 3)
 '(dabbrev-case-fold-search nil)
 '(default-input-method "german-postfix")
 '(desktop-globals-to-save
   '(desktop-missing-file-warning search-ring regexp-search-ring register-alist file-name-history))
 '(desktop-restore-eager 20)
 '(desktop-save 'ask-if-new)
 '(diary-file "~/.diary")
 '(dired-auto-revert-buffer 'dired-directory-changed-p)
 '(dired-dwim-target t)
 '(dired-omit-files "^\\.?#\\|^\\.")
 '(dirtrack-list '("^MAL1@[a-zA-Z0-9]+ \\[\\(.*\\)\\]" 1))
 '(ediff-keep-variants nil)
 '(ediff-split-window-function 'split-window-horizontally)
 '(ediff-window-setup-function 'ediff-setup-windows-plain)
 '(el-get-byte-compile-at-init t)
 '(eldoc-minor-mode-string nil)
 '(electric-indent-mode t)
 '(emacs-lisp-mode-hook '(eldoc-mode imenu-add-menubar-index checkdoc-minor-mode))
 '(erc-hide-list '("JOIN" "PART" "QUIT" "MODE" "MODE-nick"))
 '(erc-modules
   '(autoaway autojoin button completion dcc fill irccontrols list match menu move-to-prompt netsplit networks noncommands notifications readonly ring smiley stamp spelling track))
 '(erc-nick "martin")
 '(erc-notifications-icon "/usr/share/icons/Adwaita/48x48/actions/call-start.png")
 '(erc-server "localhost")
 '(erc-track-exclude-types '("JOIN" "NICK" "PART" "333" "353"))
 '(erc-track-showcount nil t)
 '(erc-user-full-name "Martin Apel")
 '(eudc-protocol 'ldap)
 '(eudc-query-form-attributes '(name firstname email phone Uid))
 '(eudc-server "10.29.111.1")
 '(european-calendar-style nil)
 '(ff-always-in-other-window t)
 '(ff-always-try-to-create nil)
 '(ff-ignore-include t)
 '(file-cache-filter-regexps
   '("~$" "\\.o$" "\\.rpo$" "\\.exe$" "\\.a$" "\\.elc$" ",v$" "\\.output$" "\\.$" "#$" "\\.class$" "\\.bak$" "\\.svn-base$" "\\.html$" "\\.svn" "\\.so$" "\\.dll$" "CMakeFiles" "extern/share" "extern/linux" "extern/win" "partners" "/obj/" "^project\\.pj$" "\\.sbr$" "\\.tes$" "\\.intinfo$" "\\.dim$"))
 '(fill-column 120)
 '(focus-follows-mouse t)
 '(gdb-find-source-frame t)
 '(gdb-many-windows t)
 '(gdb-show-main t)
 '(git-commit-summary-max-length 72)
 '(global-auto-revert-mode t)
 '(gnutls-trustfiles
   '("/etc/ssl/certs/ca-certificates.crt" "/etc/pki/tls/certs/ca-bundle.crt" "/etc/ssl/ca-bundle.pem" "/usr/ssl/certs/ca-bundle.crt" "/usr/local/share/certs/ca-root-nss.crt" "/home/home_dev/MAL1/SIMPACK_CA.cer"))
 '(grep-command "grep --color -nH -e ")
 '(grep-find-command
   '("find . -type f -exec grep --color -nH -e  \\{\\} +" . 49))
 '(grep-find-template
   "find <D> <X> -type f <F> -exec grep <C> -nH -e <R> \\{\\} +")
 '(grep-template "grep <X> <C> -nH -e <R> <F>")
 '(grep-use-null-filename-separator nil)
 '(groovy-indent-offset 3)
 '(gud-tooltip-mode t)
 '(imenu-sort-function 'imenu--sort-by-name)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(js-indent-level 3)
 '(large-file-warning-threshold 20000000)
 '(latex-run-command "pdflatex")
 '(ldap-default-base "ou=dsone,dc=dsone,dc=3ds,dc=com")
 '(ldap-default-host "10.29.111.1")
 '(ldap-host-parameters-alist
   '(("10.29.111.1" base "ou=dsone,dc=dsone,dc=3ds,dc=com" binddn "cn=SVC_SP_LDAPAUTH,ou=Managed Accounts,ou=DSDEU057,OU=EU,ou=dsone,dc=dsone,dc=3ds,dc=com" passwd "p@wist0psecret!")))
 '(log-edit-hook '(log-edit-insert-cvs-template log-edit-show-files))
 '(lsp-ui-doc-border "deep sky blue")
 '(lsp-ui-doc-enable t)
 '(lsp-ui-doc-include-signature t)
 '(lsp-ui-doc-max-height 10)
 '(lsp-ui-doc-position 'bottom)
 '(lsp-ui-sideline-diagnostic-max-line-length 70)
 '(lsp-ui-sideline-show-code-actions t)
 '(lsp-ui-sideline-show-diagnostics t)
 '(lsp-ui-sideline-show-hover nil)
 '(magit-auto-revert-mode nil)
 '(magit-cherry-pick-arguments '("-x"))
 '(magit-commit-extend-override-date t)
 '(magit-commit-reword-override-date t)
 '(magit-completing-read-function 'ivy-completing-read)
 '(magit-diff-refine-hunk t)
 '(magit-log-arguments '("-n20"))
 '(magit-log-section-arguments '("-n256" "--decorate"))
 '(magit-process-popup-time 3)
 '(magit-pull-arguments '("--rebase"))
 '(magit-qdiff-options '("--ignore-space-change" "--ignore-all-space"))
 '(magit-refs-primary-column-width '(16 . 60))
 '(magit-refs-sections-hook
   '(magit-insert-error-header magit-insert-branch-description magit-insert-local-branches magit-insert-remote-branches))
 '(magit-repo-dirs
   '("/scratch/apel/new_arch" "/scratch2/apel/SpckTest" "/scratch2/apel/documentation"))
 '(magit-repository-directories '(("/scratch/apel" . 1) ("~/.emacs.d" . 2)))
 '(magit-restore-window-configuration t)
 '(magit-rewrite-inclusive nil)
 '(magit-show-child-count t)
 '(make-backup-files nil)
 '(minibuffer-message-timeout 2 t)
 '(mo-git-blame-blame-window-width 30)
 '(mouse-yank-at-point t)
 '(nxml-child-indent 3)
 '(org-agenda-files nil)
 '(package-archives '(("gnu" . "http://elpa.gnu.org/packages/")))
 '(package-selected-packages '(nil))
 '(password-cache-expiry 36000)
 '(perl-indent-level 3)
 '(remote-file-name-inhibit-cache nil)
 '(require-final-newline t)
 '(safe-local-variable-values
   '((ma-make-target . "all")
     (ma-build-dir . "/scratch/apel/embed_nodejs/obj")
     (ma-make-target . "")
     (ma-build-dir . "")
     (ma-build-target)
     (ma-compile-command . "~/bin/ds/my_mkmk")
     (ma-compile-command . "~/bin/my_compile")
     (ma-compile-command . "~/bin/my_remote_compile.sh")))
 '(save-abbrevs nil)
 '(scroll-bar-mode 'right)
 '(send-mail-function nil)
 '(show-paren-mode t nil (paren))
 '(show-paren-style 'expression)
 '(smartscan-symbol-selector "symbol")
 '(split-height-threshold 40)
 '(split-width-threshold 200)
 '(standard-indent 3)
 '(stash-repos
   '(("spckxxxx" . "/scratch/apel/new_arch/")
     ("spcktest" . "/scratch/apel/SpckTest/")
     ("devscripts" . "/scratch/apel/devscripts/")))
 '(stash-reviewer-shortcuts
   '(("autotest-linux" . "linux")
     ("autotest-windows" . "win")
     ("autotest-fortran" . "fort")
     ("PKR3" . "PKl")
     ("BBR1" . "BB")
     ("WTG1" . "WT")
     ("HKP1" . "PK")
     ("MAL1" . "MA")
     ("MFH1" . "MF")
     ("MDE7" . "MD")
     ("FMK1" . "FM")
     ("MDL2" . "DM")))
 '(stash-target-branch-regex "^origin/master\\|origin/release/.*$")
 '(svn-log-edit-show-diff-for-commit t)
 '(tab-width 3)
 '(tex-close-quote "\"")
 '(tex-command nil t)
 '(tex-open-quote "\"")
 '(texinfo-close-quote "''")
 '(texinfo-open-quote "``")
 '(tool-bar-mode nil)
 '(tramp-default-method "scp")
 '(tramp-default-proxies-alist nil)
 '(tramp-smb-conf nil)
 '(truncate-lines t)
 '(use-file-dialog nil)
 '(user-full-name "Martin Apel")
 '(user-mail-address "martin.apel@3ds.com")
 '(vc-command-messages t)
 '(vc-consult-headers nil)
 '(vc-display-status t)
 '(vc-git-diff-switches "-w")
 '(vc-handled-backends '(Git))
 '(w3m-pop-up-windows t)
 '(warning-suppress-log-types '((comp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-char-face ((t (:background "deep sky blue" :foreground "white" :height 3.0))))
 '(git-gutter:added ((t (:inherit default :foreground "deep sky blue" :weight bold))))
 '(ma-magit-highlight-remote-face ((t (:inherit magit-branch-remote :background "light sea green" :foreground "black" :underline t :slant italic))))
 '(stash-section-title ((t (:background "blue" :slant italic :height 1.5)))))

;; Avoid version-control checks for tramp buffers
(setq vc-ignore-dir-regexp
      (format "\\(%s\\)\\|\\(%s\\)"
              vc-ignore-dir-regexp
              tramp-file-name-regexp))

(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)

(if (> (display-pixel-height) 1200)
    (add-to-list 'default-frame-alist
                 '(font . "DejaVu Sans Mono-8"))
    (add-to-list 'default-frame-alist
                 '(font . "DejaVu Sans Mono-10")))

(defalias 'yes-or-no-p 'y-or-n-p)

(global-set-key [delete] 'delete-char)
(global-set-key [?\C-c ?\C-g] 'goto-line)
(global-set-key [?\C-x ?\C-b] 'ibuffer)
(global-set-key [?\C-c ?\C-r] 'rgrep)
(global-set-key (kbd "C-M-j") 'avy-goto-char-timer)

(global-unset-key [?\C-x ?\C-c])
(global-set-key [?\C-x ?\C-c ?\C-x] 'save-buffers-kill-terminal)
(global-set-key "\M- " 'dabbrev-expand)
(global-set-key (kbd "C-.") 'goto-last-change)
(global-set-key (kbd "<kp-end>") 'shell)
(global-set-key (kbd "<kp-next>") '(lambda () "Open init.el" (interactive) (find-file "~/.emacs.d/init.el")))
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-s") 'swiper-isearch)
(global-set-key (kbd "C-x r b") 'counsel-bookmark)
(global-set-key (kbd "C-h b") 'counsel-descbinds)
(global-set-key (kbd "C-h f") 'counsel-describe-function)
(global-set-key (kbd "C-h v") 'counsel-describe-variable)
(global-set-key (kbd "M-y") 'counsel-yank-pop)
(global-set-key (kbd "C-x b") 'counsel-ibuffer)
;; (global-set-key (kbd "SPC") 'just-one-space)

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
            (local-unset-key (kbd "C-c C-a"))                       ;; Free keybinding for multiple-cursors
            (local-unset-key (kbd "C-c C-n"))
            (local-unset-key (kbd "C-c C-p"))
            (local-unset-key (kbd "C-c C-z"))                       ;; Free keybinding for magit-status

            (if work
                (add-hook 'before-save-hook 'ma-create-or-update-copyright))
            (c-toggle-hungry-state 1)
            (flyspell-prog-mode)
            (cwarn-mode)
            (hs-minor-mode)
            (idle-highlight-mode)
            (hs-hide-initial-comment-block)))

(add-hook 'python-mode-hook
          (lambda ()
            (local-unset-key [?\C-C ?\C-r])
            (idle-highlight-mode)
            (which-function-mode)
            (imenu-add-to-menubar "Functions")))

(add-hook 'prog-mode-hook
          (lambda()
            (smartscan-mode 1)))

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

(server-start)

(global-font-lock-mode 1)
(global-hl-line-mode)

(global-set-key [f2] 'customize-group)

(setq-default ediff-ignore-similar-regions t)

(add-to-list 'auto-mode-alist '("\\.sjs$" . javascript-mode))
(add-to-list 'auto-mode-alist '("\\.h$" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . js-mode))

(if work-linux
   (progn
     (require 'atl-stash)
     (stash-update-stash-info)
     (add-to-list 'mode-line-misc-info '(" " stash-mode-line-string " ") t)
     (run-with-timer 60 60 'stash-update-stash-info)
     (global-set-key (kbd "C-c p") 'stash-show-pull-requests)
     ))
