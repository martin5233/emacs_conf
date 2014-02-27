(defun ma-sync-toodledo ()
  "Sync private.org to Toodledo"
  (find-file "~/ownCloud/private.org")
  (org-toodledo-sync)
  (org-agenda "a" "a")
)

(setq org-toodledo-inhibit-https t)
(setq org-toodledo-password "uENfYn30UIzJZs5f1h4s")
(setq org-toodledo-sync-on-save "yes")
(setq org-toodledo-userid "td50effa7ae84c9")

(run-with-idle-timer 60 nil 'ma-sync-toodledo)

