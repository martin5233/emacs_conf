(setq org-msg-options "html-postamble:nil H:5 num:nil ^:{} toc:nil author:nil email:nil \\n:t")
(setq org-msg-startup "hidestars indent inlineimages")
(setq	org-msg-greeting-fmt "\nHallo%s,\n\n")
(setq	org-msg-recipient-names '(("martin.apel@3ds.com" . "Martin")))
(setq org-msg-greeting-name-limit 3)
(setq org-msg-default-alternatives '((new		. (text html))
				                         (reply-to-html	. (text html))
				                         (reply-to-text	. (text))))
(setq org-msg-convert-citation t)
(setq org-msg-signature "

#+begin_signature
Viele Grüße,

Martin
#+end_signature")

;; (defun ma-org-msg-get-to-name-advice(orig &rest args)
;;   "Return first name of addressee or defer to org-msg-get-to-name."
;;   (save-excursion
;;     (let ((to (org-msg-message-fetch-field "to")))
;;       (if (string-match "\([:upper:]+\) \([:upper:][:lower:]+\) <[:print:]+@3ds\.com>" to)
;;           (match-string 2)
;;         (apply orig args)))))

;; (advice-add 'org-msg-get-to-name :around #'ma-org-msg-get-to-name-advice)


(org-msg-mode)
