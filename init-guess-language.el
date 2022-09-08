(setq guess-language-languages '(en de))

(defun ma-after-language-guess (lang beginning end)
  "Perform multiple settings after the language of a buffer has been guessed:
- Switch the input method depending on the guessed language.
   - Change the signature of the mail buffer
   Argument LANG: Language code."
  (message (format "Switching input language to %s" lang))
  (if (string-equal lang "de")
      (activate-input-method "german-postfix")
    (deactivate-input-method))

  (when (featurep 'org-msg)
    (save-excursion
      (let ((old-signature org-msg-signature)
            (new-signature     (if (string-equal lang "de") ma-org-msg-signature-de ma-org-msg-signature-en))
            (new-greeting-fmt  (if (string-equal lang "de") ma-org-msg-greeting-fmt-de ma-org-msg-greeting-fmt-en)))
        (replace-string-in-region old-signature new-signature)
        (setq org-msg-signature new-signature)
        (setq org-msg-greeting-fmt new-greeting-fmt))))
  )

(eval-after-load "guess-language"
  '(add-hook 'guess-language-after-detection-functions #'ma-after-language-guess))
