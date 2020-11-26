(defun ma-show-agenda-if-hidden ()
  "Show Org agenda of today if it is currently hidden. Returns t, if it already was visible, otherwise nil"
  (interactive)
  (let* ((buf (get-buffer "*Org Agenda*")))
    (if (not buf)
      (progn
        (org-agenda-list 1)
        nil)
      (if (not (get-buffer-window buf))
          (progn
            (switch-to-buffer buf)
            nil)
        t)
      )
    )
)

(if work-linux-local
    (setq org-agenda-files (quote ("~/ownCloud/geburtstage.org" "~/org/na.org" "~/ownCloud/private.org")))
  (when home
      (setq org-agenda-files (quote ("~/ownCloud/geburtstage.org" "~/ownCloud/private.org")))))

(setq org-agenda-custom-commands
   (quote
    (("w" "Work agenda only" alltodo ""
      ((org-agenda-files
        (quote
         ("~/org/na.org")))))
     ("h" "Home agenda only" agenda ""
      ((org-agenda-files
        (quote
         ("~/ownCloud/private.org" "~/ownCloud/geburtstage.org")))))
     ("s" "Unscheduled items" alltodo ""
      ((org-agenda-skip-function
        (quote
         (org-agenda-skip-entry-if
          (quote scheduled)
          (quote nottodo)
          (quote todo))))))
     )))

(setq org-agenda-repeating-timestamp-show-all nil)
(setq org-agenda-skip-deadline-prewarning-if-scheduled t)
(setq org-agenda-skip-scheduled-if-deadline-is-shown t)
(setq org-agenda-start-on-weekday nil)
(setq org-babel-load-languages (quote ((emacs-lisp . t) (dot . t) (ditaa . t))))
(setq org-export-backends (quote (ascii html icalendar latex md pandoc)))
(setq org-capture-templates
   (quote
    (("g" "General" entry
      (file+olp "~/org/na.org" "Unsorted")
      "** TODO %?")
     ("m" "TODO from Mail" entry
      (file+headline "~/org/na.org" "Mail")
      "** TODO [#A] %?Mail: %a\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n" :immediate-finish t :jump-to-captured t))))
(setq org-ditaa-jar-path "/usr/share/ditaa/ditaa.jar")
(setq sorg-scheduled-past-days 5)
(setq org-sort-agenda-notime-is-late nil)

(global-set-key [?\C-c ?a]    'org-agenda)
(global-set-key [?\C-c ?C]    'org-capture)
