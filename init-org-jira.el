(setq jiralib-url "https://spck-jira.ux.dsone.3ds.com:8443")
(setq org-jira-working-dir "~/org/jira")

;;                               other         dev 2023               dev 2023x    in progress       testing             ready
(setq org-jira-default-jql "filter = 33100 OR filter = 62300 OR filter = 33400 OR filter = 10903 OR filter = 14101 ORDER BY status asc")
(setq org-jira-use-status-as-todo t)

(add-hook 'org-mode-hook
          (lambda()
             (if (and (buffer-file-name) (file-in-directory-p (buffer-file-name) "~/org/jira"))
                 (org-jira-mode 1))))
