(defconst ma-org-msg-greeting-fmt-de "\nHallo%s,\n\n")
(defconst ma-org-msg-signature-de "\n\n#+begin_signature\n--\nViele Grüße,\n\nMartin\n#+end_signature")
(defconst ma-org-msg-greeting-fmt-en "\nHi%s,\n\n")
(defconst ma-org-msg-signature-en "\n\n#+begin_signature\n--\nThanks,\n\nMartin\n#+end_signature")


(setq org-msg-options "html-postamble:nil H:5 num:nil ^:{} toc:nil author:nil email:nil \\n:t")
(setq org-msg-startup "hidestars indent inlineimages")
(setq	org-msg-greeting-fmt ma-org-msg-greeting-fmt-de)
(setq	org-msg-recipient-names '(("martin.apel@3ds.com" . "Martin")))
(setq org-msg-greeting-name-limit 3)
(setq org-msg-default-alternatives '((new		. (text html))
				                         (reply-to-html	. (text html))
				                         (reply-to-text	. (text))))
(setq org-msg-convert-citation t)
(setq org-msg-signature ma-org-msg-signature-de)

(defun ma-org-msg-get-to-name-advice(orig &rest args)
  "Return first name of addressee or defer to org-msg-get-to-name."
  (save-excursion
    (let ((to (org-msg-message-fetch-field "to")))
      (if (string-match "^\\([[:upper:]]+\\) \\([[:alpha:]]+\\) <[[:alpha:]]+\.[[:alpha:]]+@3ds\.com>$" to)
          (match-string 2 to)
        (apply orig args)))))

(advice-add 'org-msg-get-to-name :around #'ma-org-msg-get-to-name-advice)


(org-msg-mode)

(add-hook 'org-msg-edit-mode-hook
          (lambda ()
            (define-key org-msg-edit-mode-map (kbd "C-c C-f C-s") 'message-goto-subject)
            (define-key org-msg-edit-mode-map (kbd "C-c C-f C-t") 'message-goto-to)
            (define-key org-msg-edit-mode-map (kbd "C-c C-f C-c") 'message-goto-cc)
            (define-key org-msg-edit-mode-map (kbd "C-c C-f C-b") 'message-goto-bcc)))
