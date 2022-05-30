(setq diary-file "~/.emacs.d/diary")
(setq calendar-url "http://localhost:1080/users/Martin.APEL@3ds.com/calendar/")
(setq calendar-view-diary-initially-flag t)
(setq diary-number-of-entries 3)
(setq calendar-time-display-form '(24-hours ":" minutes))
(setq calendar-week-start-day 1)
(setq appt-display-diary t)
(setq org-agenda-include-diary t)

(defvar ma--getcal-last-update nil "Last time the calendar has been updated.")

(defun ma--getcal-do (url file)
  "Download ics file and add it to file"
  (let ((tmpfile (url-file-local-copy url)))
    (icalendar-import-file tmpfile file)
    (kill-buffer (car (last (split-string tmpfile "/"))))))

(defun ma-getcal ()
  "Load an ICS calendar into the Emacs diary"
  (interactive)
  (message (concat "Loading " calendar-url " into " diary-file))
  (with-current-buffer (find-file-noselect diary-file)
    (erase-buffer) ;; to avoid duplicating events
    (ma--getcal-do calendar-url diary-file)
    (basic-save-buffer)))

(defun ma--getcal-if-necessary ()
  "Reload the calendar if it hasn't been updated for an hour."
  (when (or (not (and (floatp ma--getcal-last-update) (< (- (float-time) ma--getcal-last-update) 3600))))
    (ma-getcal)))

(appt-activate 1)

(ma-getcal)
(run-with-idle-timer 60 t 'ma--getcal-if-necessary)
