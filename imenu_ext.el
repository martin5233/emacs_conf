(defun find-matching-entry-in-alist (alist entry)
  "Return the value of the first entry where the 'entry' is a substring
   of the key. If no substring is found nil is returned"
  (let ((head (car alist))
	(tail (cdr alist)))
  (cond ((null head)
	 nil)
	 ((string-match entry (car head))
	  (cdr head))
	 (t
	  (find-matching-entry-in-alist tail entry))
	 ))
)

(defun find-str-in-imenu-lists-of-all-buffers (remaining-buffers str)
  "Tries to find 'str' as a substring in the imenu alist of the
   remaining buffers. If it finds it, it jumps to the location
   given in that list."
(cond ((null remaining-buffers)
       nil)
      (t
       (set-buffer (car remaining-buffers))
       (let ((location (find-matching-entry-in-alist imenu--index-alist str)))
       (cond ((null location)
	      (find-str-in-imenu-lists-of-all-buffers (cdr remaining-buffers) str))
	     (t
              (push-mark)
	      (switch-to-buffer-other-window (current-buffer))
	      (goto-char (marker-position location)))))))
)

;;;###autoload
(defun imenu-jump-to-func-at-point ()
  "Jump to the function definition of the function called at point"
(interactive)
(let* ((str (buffer-substring
	     (save-excursion
	       (progn   
		 (backward-word 1)
		 (point)))
	     (save-excursion
	       (progn
		 (forward-word 1)
		 (point)))
	     ))
       (res (find-str-in-imenu-lists-of-all-buffers (buffer-list) str)))
  (cond ((null res)
	 (message "Function '%s' not found in any buffer" str))))
)

(provide 'imenu_ext)
