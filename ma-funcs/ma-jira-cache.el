(require 'jiralib)
(require 'org-jira)

(defvar ma-jira-key-to-summary-alist nil)
(defvar ma-jira-key-to-fix-version-alist nil)

(defun ma-jira-cache--extract-fix-version (issue)
  "Extract the fix version from a given issue. If no fix version is found, 'None' is returned."
  (let ((fix-versions (org-jira-find-value issue  'fields 'fixVersions)))
    (if (length> fix-versions 0)
        (alist-get 'name (aref fix-versions 0))
      "None")))

(defun ma-jira-cache--fill-cache()
  "Transform the response from the JIRA server to fill the cache."
  (message "Filling cache with JIRA issue ids and summaries...")
  (let* ((issues (jiralib-do-jql-search "updated >= -60d" 1000))
         (keys (cl-mapcar 'org-jira-get-issue-key issues))
         (summaries (cl-mapcar 'org-jira-get-issue-summary issues))
         (fix-versions (cl-mapcar 'ma-jira-cache--extract-fix-version issues)))
    (setq ma-jira-key-to-summary-alist (cl-pairlis keys summaries))
    (setq ma-jira-key-to-fix-version-alist (cl-pairlis keys fix-versions))
    (message "Done.")))

(run-with-idle-timer 30 nil 'ma-jira-cache--fill-cache)

(defun ma-jira-cache-keys()
  "Returns a list of all Jira issue keys stored in the cache."
  (unless ma-jira-key-to-summary-alist
    (ma-jira-cache--fill-cache))
  (mapcar 'car ma-jira-key-to-summary-alist))

(defun ma-jira-cache-summary-for-key (key)
  "Returns the summary for the given issue key. Returns string 'Unknown', if key is not found."
  (let
      ((cached-result (cdr (assoc key ma-jira-key-to-summary-alist))))
    (if (not cached-result)
      (let* ((issues (jiralib-do-jql-search (concat "key = " key) 1))
             (summary (car (cl-mapcar 'org-jira-get-issue-summary issues))))
        (add-to-list 'ma-jira-key-to-summary-alist (cons key summary))
        summary)
      cached-result)))

(defun ma-jira-cache-fix-version-for-key (key)
  "Returns the fix-version for the given issue KEY. Returns string 'Unknown', if key is not found."
  (let
      ((cached-result (cdr (assoc key ma-jira-key-to-fix-version-alist))))
    (if (not cached-result)
      (let* ((issues (jiralib-do-jql-search (concat "key = " key) 1))
             (fix-version (ma-jira-cache--extract-fix-version (car issues))))
        (add-to-list 'ma-jira-key-to-fix-version-alist (cons key fix-version))
        fix-version)
      cached-result)))


(provide 'ma-jira-cache)
