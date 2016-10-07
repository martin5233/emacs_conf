(require 'mu4e)
(require 'org-mu4e)

(setq mu4e-bookmarks
   (quote
    (("flag:unread AND NOT flag:trashed AND NOT maildir:\"/Deleted Items\"" "Unread messages" 117)
     ("maildir:/INBOX AND NOT flag:trashed" "INBOX" 105)
     ("date:today..now AND NOT flag:trashed AND NOT maildir:\"/Deleted Items\" AND NOT \"maildir:/Junk\"" "Today's messages" 116)
     ("date:7d..now AND NOT flag:trashed AND NOT maildir:\"/Deleted Items\" AND NOT \"maildir:/Junk\"" "Last 7 days" 119)
     ("mime:image/*" "Messages with images" 112))))
(setq mu4e-headers-fields
      '( (:human-date . 12)
         (:flags . 6)
         (:from-or-to . 30)
         (:subject)))
(setq mu4e-compose-signature-auto-include nil)
(setq mu4e-compose-dont-reply-to-self t)
(setq mu4e-drafts-folder "/Drafts")
(setq mu4e-get-mail-command "offlineimap")
(setq mu4e-headers-include-related nil)
(setq mu4e-hide-index-messages t)
(setq mu4e-html2text-command "w3m -T text/html -O UTF8")
(setq mu4e-maildir "/mail")
(setq mu4e-sent-folder "/Sent")
(setq mu4e-trash-folder
      (lambda (msg)
        (if (and msg
                 (string-prefix-p "[JIRA]" (mu4e-message-field msg :subject)))
            "/Devel.JIRA"
          "/Deleted Items")))
(setq mu4e-update-interval 120)
(setq mu4e-use-fancy-chars t)
(setq mu4e-view-prefer-html t)
(setq mu4e-view-show-images t)
(setq mu4e-user-mail-address-list '("martin.apel@3ds.com"))
(setq mu4e-attachment-dir "/tmp")
(add-to-list 'mu4e-view-actions
             '("ViewInBrowser" . mu4e-action-view-in-browser) t)

(setq message-send-mail-function (quote smtpmail-send-it))

(setq smtpmail-debug-info nil)
(setq smtpmail-local-domain "3ds.com")
(setq smtpmail-smtp-server "smtps.emea.3ds.com")
(setq smtpmail-smtp-service 587)
(setq smtpmail-stream-type (quote starttls))

(defun ma-switch-to-mu4e ()
  "Switch to unread mail in mu4e"
  (interactive)
  (unless (mu4e-running-p)
    (mu4e t))
  (mu4e-headers-search-bookmark (mu4e-get-bookmark-query ?i))
  (mu4e-headers-change-sorting :date 'ascending))

(global-set-key [f3] 'ma-switch-to-mu4e)

(setq mu4e-alert-email-notification-types '(count))
(setq mu4e-alert-style 'notifications)
(setq mu4e-alert-interesting-mail-query "flag:unread AND NOT flag:trashed AND NOT maildir:/Devel.cron AND NOT maildir:\"/Deleted Items\"")
(add-hook 'after-init-hook #'mu4e-alert-enable-mode-line-display)
(add-hook 'after-init-hook #'mu4e-alert-enable-notifications)

(defun ma-mu4e-set-spell-language()
  "Run from mu4e-compose-mode-hook to set the language dictionary based on the addressee."
  (require 'eudc)
  (let ((msg (mu4e-message-at-point 'noerror)))
  (if mu4e-compose-parent-message
      (let ((to (mapcar 'cdr (mu4e-message-field mu4e-compose-parent-message :to)))
            (countries nil))
        (dolist (i to)
          (let* ((query-result (eudc-query (list (cons 'email i))))
                 (country (assoc-default 'c (car query-result))))
            (setq countries (append countries (list country)))))
        (delete-dups countries)
;; If the country could not be determined for one recipient or the list is empty, the user has to manually set the language
        (if (or (memq nil countries) (null countries) (> (length countries) 1))
            (ispell-change-dictionary (mu4e-read-option "Choose dictionary: "
                                                        '(("German" . "de-neu") ("English" . "en_US"))))
          (if (string-equal (car countries) "DE")
              (ispell-change-dictionary "de-neu")
            (ispell-change-dictionary "en_US")))
        )
    (ispell-change-dictionary (mu4e-read-option "Choose dictionary: "
                                                '(("German" . "de-neu") ("English" . "en_US")))))))

(add-hook 'mu4e-compose-mode-hook
          (lambda()
            (flyspell-mode 1)
            (ma-mu4e-set-spell-language)))

(when (fboundp 'imagemagick-register-types)
   (imagemagick-register-types))
