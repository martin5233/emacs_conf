(setq org-roam-directory "~/org-roam")
(global-set-key (kbd "C-c n l") 'org-roam-buffer-toggle)
(global-set-key (kbd "C-c n f") 'org-roam-node-find)
(global-set-key (kbd "C-c n i") 'org-roam-node-insert)

(setq org-roam-capture-templates
      '(("d" "default" plain "%?" :target
         (file+head "%<%Y-%m-%d_%H:%M:%S>-${slug}.org" "#+title: ${title}")
         :unnarrowed t)
        ("s" "spck" plain (file "~/org-roam/templates/spck-template.org")
         :target (file "%<%Y-%m-%d_%H:%M:%S>-SPCK-${slug}.org")
         :unnarrowed t)
        )
      )


(org-roam-db-autosync-mode)
