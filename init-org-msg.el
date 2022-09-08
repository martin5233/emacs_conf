(defconst ma-org-msg-greeting-fmt-de "\nHallo%s,\n\n")
(defconst ma-org-msg-signature-de "\n\n#+begin_signature\n--\nViele Grüße,\n\nMartin\n\n#+end_signature")
(defconst ma-org-msg-greeting-fmt-en "\nHi%s,\n\n")
(defconst ma-org-msg-signature-en "\n\n#+begin_signature\n--\nBest Regards,\n\nMartin\n\n#+end_signature")


(setq org-msg-options "html-postamble:nil H:5 num:nil ^:{} toc:nil author:nil email:nil \\n:t")
(setq org-msg-startup "hidestars indent inlineimages")
(setq	org-msg-greeting-fmt ma-org-msg-greeting-fmt-de)
(setq	org-msg-recipient-names '(("martin.apel@3ds.com" . "Martin")))
(setq org-msg-greeting-name-limit 3)
(setq org-msg-default-alternatives '((new		. (html))
				                         (reply-to-html	. (html))
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

(defun ma-toggle-greeting-and-signature()
  "Switch the greeting and signature from German to English or vice versa."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (if (search-forward ma-org-msg-signature-de nil t)
        (replace-match ma-org-msg-signature-en)
      (if (search-forward ma-org-msg-signature-en nil t)
          (replace-match ma-org-msg-signature-de)))
    (goto-char (point-min))
    (let ((greeting-regex-de (string-replace "%s" " \\([[:alpha:]]+\\)" ma-org-msg-greeting-fmt-de))
          (greeting-regex-en (string-replace "%s" " \\([[:alpha:]]+\\)" ma-org-msg-greeting-fmt-en)))
      (if (re-search-forward greeting-regex-en nil t)
          (replace-match (format ma-org-msg-greeting-fmt-de (concat " " (match-string 1))))
        (if (re-search-forward greeting-regex-de nil t)
          (replace-match (format ma-org-msg-greeting-fmt-en (concat " " (match-string 1)))))))))


(org-msg-mode)

(add-hook 'org-msg-edit-mode-hook
          (lambda ()
            (define-key org-msg-edit-mode-map (kbd "C-c C-f C-s") 'message-goto-subject)
            (define-key org-msg-edit-mode-map (kbd "C-c C-f C-t") 'message-goto-to)
            (define-key org-msg-edit-mode-map (kbd "C-c C-f C-c") 'message-goto-cc)
            (define-key org-msg-edit-mode-map (kbd "C-c C-f C-b") 'message-goto-bcc)
            (local-set-key (kbd "C-c C-s") 'ma-toggle-greeting-and-signature)))
