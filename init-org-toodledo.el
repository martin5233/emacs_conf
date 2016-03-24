(defun ma-sync-toodledo-after-revert ()
  "Sync private.org to Toodledo"
  (with-current-buffer (find-file-noselect "~/ownCloud/private.org")
    (org-toodledo-sync)))

(setq org-toodledo-inhibit-https t)
(setq org-toodledo-password "uENfYn30UIzJZs5f1h4s")
(setq org-toodledo-sync-on-save "yes")
(setq org-toodledo-userid "td50effa7ae84c9")
(setq safe-local-variable-values (list (cons 'after-revert-hook 'ma-sync-toodledo-after-revert)
                                       (cons 'auto-revert-mode t)))
(find-file-noselect "~/ownCloud/private.org")
(org-toodledo-make-lookup-function "context")
