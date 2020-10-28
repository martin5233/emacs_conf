(projectile-mode 1)
(define-key projectile-mode-map (kbd "C-c C-p") 'projectile-command-map)
(setq projectile-completion-system 'ivy)
(setq projectile-project-search-path '("/scratch/apel"))
(setq projectile-sort-order 'recently-active)
(setq projectile-git-command "/home/home_dev/MAL1/bin/projectile_ls.sh")
(setq projectile-git-submodule-command nil)
(setq projectile-mode-line-prefix "")

(defun ma-projectile-mode-line()
  "Generates a projectile mode line"
  (format " Proj[%s]" (projectile-project-name)))
(setq projectile-mode-line-function 'ma-projectile-mode-line)
