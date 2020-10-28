(setq read-process-output-max (* 1024 1024)) ;; 1mb
(setq gc-cons-threshold 100000000)

(setq lsp-completion-provider :capf)
(setq lsp-eldoc-enable-hover nil)
(setq lsp-enabled-clients '(clangd-ma dockerfile-ls cmakels clangd))
(setq lsp-clients-clangd-args '("--background-index" "--log=info" "-j=8" "--clang-tidy"))
(setq lsp-response-timeout 2)
(setq lsp-keymap-prefix "C-r")
(setq lsp-enable-indentation nil)
(setq lsp-enable-folding nil)
(setq lsp-enable-on-type-formatting nil)

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
(setq lsp-dockerfile-language-server-command '("docker" "run" "-i" "--rm" "lsp-dockerfile:latest"))
(add-hook 'dockerfile-mode-hook #'lsp)

;; cmake
(setq company-cmake-executable "/scratch/apel/new_arch/develop/extern/linux64/cmake-3.17/bin/cmake")
(add-hook 'cmake-mode-hook #'lsp)

(defun ma-cmake-upcase-completion-list (candidates)
  "Converts all incoming completion candidates to upper case"
  (if (string-equal major-mode "cmake-mode")
      (mapcar 'upcase candidates)
    candidates))

(setq company-transformers '(ma-cmake-upcase-completion-list))
