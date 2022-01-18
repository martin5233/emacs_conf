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
(add-hook 'js-mode-hook
          (lambda()
            (setq-local devdocs-current-docs '("node" "javascript"))))
(add-hook 'python-mode-hook
          (lambda()
            (setq-local devdocs-current-docs '("python~3.10"))))
(add-hook 'perl-mode-hook
          (lambda()
            (setq-local devdocs-current-docs '("perl~5.34"))))

(defun ma-devdocs-lookup-at-point()
  (interactive)
  (devdocs-lookup nil (thing-at-point 'symbol)))

(global-set-key (kbd "C-c C-S-d") 'ma-devdocs-lookup-at-point)
