(setq company-cmake-executable "/scratch/apel/new_arch/develop/extern/linux64/cmake-3.17/bin/cmake")

(defun ma-cmake-upcase-completion-list (candidates)
  "Converts all incoming completion candidates to upper case"
  (if (string-equal major-mode "cmake-mode")
      (mapcar 'upcase candidates)
    candidates))

(setq company-transformers '(ma-cmake-upcase-completion-list))

(global-company-mode)

(setq company-backends '(company-cmake company-capf company-files
                                       (company-dabbrev-code company-keywords)
                                       company-dabbrev))
(setq company-idle-delay 2.0)
(global-set-key (kbd "<f3>") 'company-complete)
