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

(setq ma-na-org "~/org/na.org")
(setq ma-private-org "~/Nextcloud/private.org")
(if work-linux-remote
    (progn
      (setq ma-na-org (concat work-remote-url ma-na-org))
      (setq ma-private-org (concat work-remote-url ma-private-org))))

(setq org-agenda-files nil)
(if (file-exists-p ma-na-org)
   (push ma-na-org org-agenda-files))
(if (file-exists-p ma-private-org)
   (push ma-private-org org-agenda-files))

(setq org-agenda-custom-commands
   (quote
    (("w" "Work agenda only" alltodo ""
      ((org-agenda-files (list ma-na-org))))
     ("h" "Home agenda only" agenda ""
      ((org-agenda-files (list ma-private-org))))
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

(global-set-key [?\C-c ?a]    'org-agenda)
(global-set-key [?\C-c ?C]    'org-capture)
