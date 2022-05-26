(setq diary-file "~/.emacs.d/diary")
(setq calendar-url "https://nextcloud.apel-boecker.de:32671/nextcloud/remote.php/dav/calendars/martin/familie?export")
(setq calendar-view-diary-initially-flag t)
(setq diary-number-of-entries 3)
(setq calendar-time-display-form '(24-hours ":" minutes))
(setq calendar-week-start-day 1)
(setq appt-display-diary t)
(setq org-agenda-include-diary t)

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
    (ma--getcal-do calendar-url diary-file)))


(appt-activate 1)

(ma-getcal)
(run-with-timer 3600 t 'ma-getcal)
