;; clangd
(add-hook 'c++-mode-hook
          (lambda()
            (local-set-key (kbd "C-c i") '(lambda()
                                            (interactive)
                                            (require 'lsp-ui)
                                            (lsp-ui-imenu)))
            ))
(add-hook 'c++-mode-hook #'yas-minor-mode)

;; dockerfile
(add-hook 'dockerfile-mode-hook #'lsp)

;; cmake
(add-hook 'cmake-mode-hook #'lsp)

;; Javascript
(add-hook 'js2-mode-hook #'lsp)
