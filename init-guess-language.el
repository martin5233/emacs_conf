(setq guess-language-languages '(en de))

(defun ma-switch-input-method-after-language-guess (lang beginning end)
  "Switch the input method depending on the guessed language.
Argument LANG: Language code."
  (message (format "Switching input language to %s" lang))
  (if (string-equal lang "de")
      (activate-input-method "german-postfix")
    (deactivate-input-method))

  (when (featurep 'org-msg)
    (if (string-equal lang "de")
        (setq org-msg-greeting-fmt ma-org-msg-greeting-fmt-de
              org-msg-signature    ma-org-msg-signature-de)
      (setq org-msg-greeting-fmt ma-org-msg-greeting-fmt-en
            org-msg-signature    ma-org-msg-signature-en)))
  )

(eval-after-load "guess-language"
  '(add-hook 'guess-language-after-detection-functions #'ma-switch-input-method-after-language-guess))

;; (remove-hook 'guess-language-after-detection-functions #'ma-switch-input-method-after-language-guess)
