(require 'jiralib)
(require 'org-jira)
(require 'ma-jira-cache)

(defun ma-marginalia-jira--annotator (cand)
  (let ((summary (ma-jira-cache-summary-for-key cand)))
    (if summary
        (marginalia--fields (summary :truncate 1.0 :face 'marginalia-value))
      (marginalia--fields ("Unknown" :truncate 1.0 :face 'marginalia-value)))))

(eval-after-load 'marginalia
  (lambda ()
    (add-to-list 'marginalia-prompt-categories '("JIRA" . jira))
;;    (add-to-list 'marginalia-command-categories '(org-roam-node-find . jira))
    (add-to-list 'marginalia-annotator-registry
                 '(jira ma-marginalia-jira--annotator))))

(provide 'marginalia-jira)
