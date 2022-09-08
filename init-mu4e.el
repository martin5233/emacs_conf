(setq mu4e-bookmarks
   (quote
    (("flag:unread AND NOT flag:trashed AND NOT maildir:Trash" "Unread messages" 117)
     ("(maildir:/INBOX OR maildir:/AutoNotifications) AND NOT flag:trashed" "INBOX" 105)
     ("date:today..now AND NOT flag:trashed AND NOT maildir:Trash AND NOT maildir:/Junk" "Today's messages" 116)
     ("date:7d..now AND NOT flag:trashed AND NOT maildir:Trash AND NOT maildir:/Junk" "Last 7 days" 119))))
(setq mu4e-headers-fields
      '( (:human-date . 12)
         (:flags . 6)
         (:from-or-to . 30)
         (:subject)))
(setq mu4e-compose-signature-auto-include nil)
(setq mu4e-compose-dont-reply-to-self t)
(setq mu4e-compose-complete-only-after "2020-01-01")
(setq mu4e-drafts-folder "/Drafts")
(setq mu4e-get-mail-command "~/bin/Linux/call_mbsync.sh")
(setq mu4e-completing-read-function 'completing-read)
(setq mu4e-headers-include-related nil)
(setq mu4e-index-update-error-warning nil)
(setq mu4e-hide-index-messages t)
(setq mu4e-sent-folder "/Sent")
(setq mu4e-trash-folder "/Trash")
(setq mu4e-update-interval 120)
(setq mu4e-use-fancy-chars t)
(setq mu4e-attachment-dir "/tmp")
(setq mu4e-change-filenames-when-moving t)

(setq message-send-mail-function (quote smtpmail-send-it))

(setq smtpmail-debug-info nil)
(setq smtpmail-local-domain "3ds.com")
(setq smtpmail-smtp-server "smtps.emea.3ds.com")
(setq smtpmail-smtp-service 587)
(setq smtpmail-stream-type (quote starttls))

(setq mail-user-agent 'mu4e-user-agent)
(set-variable 'read-mail-command 'mu4e)

(defun ma-switch-to-mu4e ()
  "Switch to unread mail in mu4e"
  (interactive)
  (unless (mu4e-running-p)
    (mu4e t))
  (mu4e-search-bookmark (mu4e-get-bookmark-query ?i))
  (mu4e-headers-change-sorting :date 'ascending))

(global-set-key [f4] 'ma-switch-to-mu4e)

(setq mu4e-alert-email-notification-types '(count))
(setq mu4e-alert-style 'notifications)
(setq mu4e-alert-interesting-mail-query "maildir:/INBOX AND NOT flag:trashed AND flag:unread")
(setq shr-color-visible-luminance-min 80)

(with-eval-after-load 'message-mode
  (setq message-cite-style message-cite-style-outlook
        message-cite-reply-position 'above))

(add-hook 'after-init-hook #'mu4e-alert-enable-mode-line-display)
(add-hook 'after-init-hook #'mu4e-alert-enable-notifications)

(defun ma-compose-hook()
  "Hook function for compose mode."
  (guess-language-mode 1)
  (flyspell-mode 1)
  (setq flyspell-generic-check-word-predicate 'mail-mode-flyspell-verify)
  (setq message-cite-style message-cite-style-outlook)
  (set-fill-column 120))

(add-hook 'mu4e-compose-mode-hook 'ma-compose-hook)

(add-hook 'mu4e-compose-pre-hook
          (lambda()
            (setq message-cite-style message-cite-style-outlook
                  message-cite-reply-position 'above)
            (guess-language-mode 1)
            (flyspell-mode 1)
            (setq flyspell-generic-check-word-predicate 'mail-mode-flyspell-verify)))

(when (fboundp 'imagemagick-register-types)
   (imagemagick-register-types))
