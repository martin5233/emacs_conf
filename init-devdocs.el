(global-set-key (kbd "C-c C-d") 'devdocs-lookup)
(add-hook 'c-mode-common-hook
          (lambda()
            (setq-local devdocs-current-docs '("cpp" "qt~5.12"))
            (local-unset-key (kbd "C-c C-d"))))
(add-hook 'cmake-mode-hook
          (lambda()
            (setq-local devdocs-current-docs '("cmake~3.17"))
            (local-unset-key (kbd "C-c C-d"))))
(add-hook 'dockerfile-mode-hook
          (lambda()
            (setq-local devdocs-current-docs '("docker~19"))))

(defun ma-devdocs-lookup-at-point()
  (interactive)
  (devdocs-lookup nil (thing-at-point 'symbol)))

(global-set-key (kbd "C-c C-S-d") 'ma-devdocs-lookup-at-point)
