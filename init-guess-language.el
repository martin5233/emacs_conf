(setq guess-language-languages '(en de))

(defun ma-switch-input-method-after-language-guess (lang beginning end)
  "Switch the input method depending on the guessed language"
  (message (format "Switching input language to %s" lang))
  (if (string-equal lang "de")
      (activate-input-method "german-postfix")
    (deactivate-input-method)))

(add-hook 'guess-language-after-detection-functions #'ma-switch-input-method-after-language-guess)
