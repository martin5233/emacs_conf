(defun ma-spck-next-link (end)
  "Return position of next SPCK-{ID} link or nil if there is none."
  (save-excursion
    (when (looking-at "\\(SPCK-[0-9.]+\\)")
      (progn
        (skip-chars-forward "SPCK-")
        (skip-chars-forward "[:digit:]")))
    (when (re-search-forward "\\(SPCK-[[:digit:]]+\\)" end t)
      (progn
        (skip-chars-backward "[SPCK\\-][:digit:]")
        (point)))))


(defun ma-spck-link-at-point-p ()
  "Return SPCK-{ID} link at point or nil if there is none."
  (save-excursion
    (skip-chars-backward "[SPCK\\-][:digit:]")
    (and
     (looking-at "\\(SPCK-[0-9.]+\\)")
     (concat "https://spck-jira.ux.dsone.3ds.com:8443/browse/" (match-string 1)))))

(link-hint-define-type 'spck-url
  :next 'ma-spck-next-link
  :at-point-p 'ma-spck-link-at-point-p
  :open #'browse-url)
(push 'link-hint-spck-url link-hint-types)

(global-set-key (kbd "C-c o") 'link-hint-open-link)
