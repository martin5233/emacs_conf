(setq read-process-output-max (* 1024 1024)) ;; 1mb
(setq gc-cons-threshold 100000000)

(setq lsp-completion-provider :capf)
(setq lsp-eldoc-enable-hover nil)
(setq lsp-enabled-clients '(clangd-ma dockerfile-ls cmakels clangd))
(setq lsp-clients-clangd-args '("--background-index" "--log=info" "-j=8" "--clang-tidy"))
(setq lsp-response-timeout 2)
(setq lsp-keymap-prefix "C-r")
(with-eval-after-load 'lsp-mode
  (progn
    (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)))

;; clangd
(add-hook 'c++-mode-hook #'lsp)
(add-hook 'c++-mode-hook #'yas-minor-mode)

;; dockerfile
(setq lsp-dockerfile-language-server-command '("docker" "run" "-i" "--rm" "lsp-dockerfile:latest"))
(add-hook 'dockerfile-mode-hook #'lsp)

;; cmake
(setq company-cmake-executable "/scratch/apel/new_arch/develop/extern/linux64/cmake-3.17/bin/cmake")
(add-hook 'cmake-mode-hook #'lsp)
