(setq jiralib-url "https://spck-jira.ux.dsone.3ds.com:8443")
(setq org-jira-working-dir "~/org/jira")

(setq org-jira-custom-jqls
'(
(:jql " project = SPCK AND issuetype in (Development) AND issueFunction in subtasksOf('type = Specification AND fixVersion = 2023') AND status in (Assigned) AND assignee in (currentUser()) ORDER BY summary ASC, priority, issuekey"
:limit 50
:filename "issues-for-development-2023")
(:jql " status = 'In Progress' AND assignee in (currentUser()) ORDER BY fixVersion"
:limit 50
:filename "issues-inprogress")
(:jql " issuetype = Development AND status = Ready AND resolution = Unresolved AND assignee in (currentUser()) ORDER BY priority"
:limit 50
:filename "issues-ready")
(:jql " issuetype = Development AND status = 'Integration Test' AND resolution = Unresolved AND assignee in (currentUser()) ORDER BY priority"
:limit 50
:filename "issues-for-testing")
(:jql " issuekey = SPCK-62159"
:limit 50
:filename "other-issues")))

;;                               other         dev 2023               in progress       testing             ready
(setq org-jira-default-jql "filter = 33100 OR filter = 60000 OR filter = 33400 OR filter = 10903 OR filter = 14101 ORDER BY status asc")
(setq org-jira-use-status-as-todo t)

(add-hook 'org-mode-hook
          (lambda()
             (if (and (buffer-file-name) (file-in-directory-p (buffer-file-name) "~/org/jira"))
                 (org-jira-mode 1))))
