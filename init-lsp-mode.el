(setq read-process-output-max (* 1024 1024)) ;; 1mb
(setq gc-cons-threshold 100000000)

(setq lsp-completion-provider :capf)
(setq lsp-eldoc-enable-hover nil)
(setq lsp-client-packages '(lsp-bash lsp-clangd lsp-clients lsp-cmake lsp-dockerfile lsp-groovy lsp-javascript lsp-json lsp-perl lsp-php lsp-pyls lsp-xml lsp-yaml))
(setq lsp-enabled-clients '(dockerfile-ls cmakels clangd))
(setq lsp-clients-clangd-args '("--background-index" "--log=info" "-j=8" "--clang-tidy"))
(setq lsp-completion-no-cache t)
(setq lsp-enable-indentation nil)
(setq lsp-enable-folding nil)
(setq lsp-enable-on-type-formatting nil)
(setq lsp-keymap-prefix "C-r")
(setq lsp-modeline-code-actions-enable nil)
(setq lsp-modeline-diagnostics-scope :file)
(setq lsp-response-timeout 2)
(setq lsp-restart 'auto-restart)

(with-eval-after-load 'lsp-mode
  (progn
    (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)))

;; clangd
(add-hook 'c++-mode-hook
          (lambda()
            (lsp)
            (yas-minor-mode)
            (local-set-key (kbd "C-c i") '(lambda()
                                            (interactive)
                                            (require 'lsp-ui)
                                            (lsp-ui-imenu)))
            (local-set-key (kbd "C-c j") 'lsp-ivy-workspace-symbol)
            ))
(add-hook 'c++-mode-hook #'yas-minor-mode)

;; dockerfile
(add-hook 'dockerfile-mode-hook #'lsp)

;; cmake
(add-hook 'cmake-mode-hook #'lsp)
