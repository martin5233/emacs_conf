(with-eval-after-load 'message-mode
  (setq message-cite-style message-cite-style-outlook
        message-cite-reply-position 'above))

(defun ma-compose-hook()
  "Hook function for compose mode."
  (setq message-cite-style message-cite-style-outlook)
  (set-fill-column 120))

(add-hook 'mu4e-compose-mode-hook 'ma-compose-hook)

(add-hook 'mu4e-compose-pre-hook
          (lambda()
            (setq message-cite-style message-cite-style-outlook
                  message-cite-reply-position 'above)

(when (fboundp 'imagemagick-register-types)
   (imagemagick-register-types))
