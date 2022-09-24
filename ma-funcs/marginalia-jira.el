(require 'jiralib)
(require 'org-jira)
(require 'ma-jira-cache)

(defun ma-marginalia-jira--annotator (cand)
  (let ((summary (ma-jira-cache-summary-for-key cand)))
    (if summary
        (marginalia--fields (summary :truncate 1.0 :face 'marginalia-value))
      (marginalia--fields ("Unknown" :truncate 1.0 :face 'marginalia-value)))))

;; (defun ma-marginalia-jira--completing-read-advice(prompt collection &optional predicate
;;                                                          require-match initial-input
;;                                                          hist def inherit-input-method)
;;   (message "Advice called")
;;   (when (arrayp collection)
;;     (mapcar (lambda(entry)
;;               (when (stringp entry)
;;                 (message (concat "Found entry " entry))))
;;             collection))
;;   )



(eval-after-load 'marginalia
  (lambda ()
;;    (advice-add #'completing-read-default :before #'ma-marginalia-jira--completing-read-advice)
    (add-to-list 'marginalia-prompt-categories '("JIRA" . jira))
    (add-to-list 'marginalia-command-categories '(org-roam-node-find . jira))
    (add-to-list 'marginalia-annotator-registry
                 '(jira ma-marginalia-jira--annotator))))

(provide 'marginalia-jira)
