(setq Info-directory-list '("/usr/local/share/info/" "/usr/share/info/"))

        (:name request)
        (:name files
               :type builtin)
        (:name json-snatcher)
        (:name json-reformat)
        (:name json-mode
               :depends (json-snatcher json-reformat))
        (:name js2-mode
               :type github
               :pkgname "mooz/js2-mode"
               :after (progn
                        (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
                        (add-to-list 'auto-mode-alist '("\\.sjs$" . js2-mode))
                        (add-to-list 'auto-mode-alist '("\\.json$" . js2-mode))
                        (setq js2-include-node-externs t)
                        (setq js2-mode-assume-strict t)))

        (:name json-navigator
               :type github
               :pkgname "DamienCassou/json-navigator")
        (:name markdown-mode)
        (:name yasnippet)
        (:name graphviz-dot-mode)
        (:name diminish
               :after (progn
                        (eval-after-load "cwarn" '(diminish 'cwarn-mode))
                        (eval-after-load "hideshow" '(diminish 'hs-minor-mode))
                        (eval-after-load "flymake" '(diminish 'flymake-mode))
                        (eval-after-load "flycheck" '(diminish 'flycheck-mode))
                        (eval-after-load "yasnippet" '(diminish 'yas-minor-mode))
                        (eval-after-load "abbrev" '(diminish 'abbrev-mode))))
        (:name "dap-mode")
        (:name keyfreq
               :type github
               :pkgname "dacap/keyfreq"
               :after (progn
                        (setq keyfreq-excluded-commands
                              '(lsp-ui-doc--handle-mouse-movement
                                gud-tooltip-mouse-motion))
                        (keyfreq-mode 1)
                        (keyfreq-autosave-mode 1)))
        (:name mu4e
               :branch "release/1.8"
               :post-init (setq mu4e-mu-binary (expand-file-name "mu" (expand-file-name "mu" (expand-file-name "build" (el-get-package-directory 'mu4e)))))
               :load-path "build/mu4e"
               :info nil)
        (:name mu4e-alert)
        (:name emacs-htmlize
               :type github
               :pkgname "hniksic/emacs-htmlize")
        (:name org-msg
               :type github
               :pkgname "jeremy-compostella/org-msg"
               :depends (emacs-htmlize mu4e))
        (:name guess-language
               :type github
               :pkgname "tmalsburg/guess-language.el")
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
               (:name erc
                      :type builtin)
               ))))

(if home
    (setq el-get-sources
     (append el-get-sources
             '(
               (:name async
                :type github
                :pkgname "jwiegley/emacs-async")
               (:name platformio-mode
                :type github
                :pkgname "ZachMassia/platformio-mode"
                :depends (projectile async))))))

(setq my-packages (mapcar 'el-get-source-name el-get-sources))

(el-get 'sync my-packages)

(add-to-list 'load-path "~/.emacs.d/ma-funcs")
(require 'ma-funcs)


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

(add-hook 'python-mode-hook
          (lambda ()
            (local-unset-key [?\C-C ?\C-r])
            (which-function-mode)
            (imenu-add-to-menubar "Functions")))







(server-start)

(global-font-lock-mode 1)
(global-hl-line-mode)

(global-set-key [f2] 'customize-group)

(setq-default ediff-ignore-similar-regions t)

(add-to-list 'auto-mode-alist '("\\.h$" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))

(if work-linux
   (progn
     (require 'atl-stash)
     (stash-update-stash-info)
     (add-to-list 'mode-line-misc-info '(" " stash-mode-line-string " ") t)
     (run-with-timer 60 60 'stash-update-stash-info)
     (global-set-key (kbd "C-c p") 'stash-show-pull-requests)
     (run-with-idle-timer 1800 t 'ma-kill-old-buffers)
     (load "marginalia-jira")
     ))
