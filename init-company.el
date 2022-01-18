(global-company-mode)

(setq company-dabbrev-downcase nil)


(defun ma-cmake-upcase-completion-list (candidates)
  "Converts all incoming completion candidates to upper case"
  (if (string-equal major-mode "cmake-mode")
      (mapcar 'upcase candidates)
    candidates))

(setq company-transformers '(ma-cmake-upcase-completion-list company-sort-by-occurrence))
