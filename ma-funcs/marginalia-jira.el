(require 'jiralib)
(require 'org-jira)

(defvar ma-jira-key-to-summary-alist nil)

(defun ma-marginalia-jira--fill-cache()
  "Transform the response from the JIRA server to fill the cache."
  (message "Filling cache with JIRA issue ids and summaries")
  (let* ((issues (jiralib-do-jql-search "assignee in (currentUser())"))
         (keys (cl-mapcar 'org-jira-get-issue-key issues))
         (summaries (cl-mapcar 'org-jira-get-issue-summary issues)))

    (setq ma-jira-key-to-summary-alist (cl-pairlis keys summaries))))

(defun ma-marginalia-jira--annotator (cand)
  (message "ma-jira-annotator called with " cand)
  (let ((summary (cdr (assoc cand ma-jira-key-to-summary-alist))))
    (if summary
        (marginalia--fields (summary :truncate 1.0 :face 'marginalia-value))
      (marginalia--fields ("Unknown" :truncate 1.0 :face 'marginalia-value)))))

(eval-after-load 'marginalia
  (lambda ()
    (add-to-list 'marginalia-prompt-categories '("JIRA" . jira))
    (add-to-list 'marginalia-annotator-registry
                 '(jira ma-marginalia-jira--annotator))))

(run-with-idle-timer 30 nil 'ma-marginalia-jira--fill-cache)
