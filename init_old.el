        (:name request)
        (:name files
               :type builtin)
        (:name json-snatcher)
        (:name json-reformat)
        (:name json-mode
               :depends (json-snatcher json-reformat))
                        (add-to-list 'auto-mode-alist '("\\.json$" . js2-mode))
        (:name json-navigator
               :type github
               :pkgname "DamienCassou/json-navigator")
        (:name markdown-mode)
        (:name graphviz-dot-mode)
        (:name "dap-mode")
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
               (:name platformio-mode
                :type github
                :pkgname "ZachMassia/platformio-mode"
                :depends (projectile async))))))

;; Avoid version-control checks for tramp buffers
(setq vc-ignore-dir-regexp
      (format "\\(%s\\)\\|\\(%s\\)"
              vc-ignore-dir-regexp
              tramp-file-name-regexp))

(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)

(add-hook 'python-mode-hook
          (lambda ()
            (local-unset-key [?\C-C ?\C-r])
            (which-function-mode)
            (imenu-add-to-menubar "Functions")))

(setq-default ediff-ignore-similar-regions t)

(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
