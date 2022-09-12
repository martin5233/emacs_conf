(require 'jiralib)
(require 'org-jira)

(defvar ma-jira-key-to-summary-alist nil)

(defun ma-jira-cache--fill-cache()
  "Transform the response from the JIRA server to fill the cache."
  (message "Filling cache with JIRA issue ids and summaries...")
  (let* ((issues (jiralib-do-jql-search "updated >= -60d" 1000))
         (keys (cl-mapcar 'org-jira-get-issue-key issues))
         (summaries (cl-mapcar 'org-jira-get-issue-summary issues)))

    (setq ma-jira-key-to-summary-alist (cl-pairlis keys summaries))
    (message "Done.")))

(run-with-idle-timer 30 nil 'ma-jira-cache--fill-cache)

(defun ma-jira-cache-keys()
  "Returns a list of all Jira issue keys stored in the cache."
  (mapcar 'car ma-jira-key-to-summary-alist))

(defun ma-jira-cache-summary-for-key (key)
  "Returns the summary for the given issue key. Returns string 'Unknown', if key is not found."
  (let
      ((cached-result (cdr (assoc key ma-jira-key-to-summary-alist))))
    (if (not cached-result)
      (let* ((issues (jiralib-do-jql-search (concat "key = " key) 1))
             (summary (cl-mapcar 'org-jira-get-issue-summary issues)))
        (add-to-list 'ma-jira-key-to-summary-alist (cons key (car summary)))
        summary)
      cached-result)))


(provide 'ma-jira-cache)
