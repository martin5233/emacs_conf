(projectile-mode 1)
(define-key projectile-mode-map (kbd "C-M-S-p") 'projectile-command-map)
(global-set-key (kbd "C-c C-f") 'projectile--find-file)

(setq projectile-completion-system 'ivy)
(setq projectile-sort-order 'recently-active)

(cond
 (work-linux-local
  (progn (setq projectile-project-search-path '("/scratch/apel"))
         (setq projectile-git-command "/home/home_dev/MAL1/bin/projectile_ls.sh")))
 (work-linux-remote
  (progn (setq projectile-project-search-path nil)
         (setq projectile-git-command "/home/home_dev/MAL1/bin/projectile_ls.sh")
         (setq projectile-enable-caching t)))
 (work-win (setq projectile-project-search-path '("D:/users/apel")))
 (home (setq projectile-project-search-path '("/home/martin"))))

(setq projectile-git-submodule-command nil)
(setq projectile-mode-line-prefix "")

(defun ma-projectile-mode-line()
  "Generates a projectile mode line"
  (format " Proj[%s]" (projectile-project-name)))
(setq projectile-mode-line-function 'ma-projectile-mode-line)
