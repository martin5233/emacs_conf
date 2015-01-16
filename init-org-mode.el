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

(defun ma-org-get-attachments ()
  "Retrieve the attachments of the current entry into a directory named ~/devs/<DevIssue-Id>
   and insert a link to this directory for the current entry"
  (interactive)
  (let* ((headline (nth 4 (org-heading-components)))
         (matched (string-match "^\\(\\[#[A-C]\\]\\)?\\([0-9]+\\):" headline))
         (dev-id (match-string 2 headline))
         (dir (concat "~/devs/" dev-id))
         (link (format "[[file:%s][%s]]" dir dev-id))
         )
    (progn
      ;; delete directory if it already exists
      (if (file-directory-p dir)
          (delete-directory dir t))
      (shell-command (concat "~/perl/download_mks_attachments.pl " dev-id))
      (save-excursion
        (while (not (org-at-heading-p))
          (forward-line -1))
        (beginning-of-line)
        (replace-string dev-id link nil (line-beginning-position) (line-end-position))
        )
      )
    )
)


(if work-linux
    (setq org-agenda-files (quote ("~/ownCloud/geburtstage.org" "~/org/na.org" "~/ownCloud/private.org")))
  (when home
      (setq org-agenda-files (quote ("~/ownCloud/geburtstage.org" "~/ownCloud/private.org")))))

(setq org-agenda-custom-commands
   (quote
    (("w" "Work agenda only" agenda ""
      ((org-agenda-files
        (quote
         ("~/org/na.org" "~/org/devs.org")))))
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
     ("r" "Activities to report" tags "REPORT"
      ((org-agenda-remove-tags t)
       (org-agenda-prefix-format "")
       (org-agenda-todo-keyword-format "%-17s")
       (ps-landscape-mode t)
       (ps-number-of-columns 1))
      ("~/org/Activities.pdf")))))

(setq org-agenda-repeating-timestamp-show-all nil)
(setq org-agenda-skip-deadline-prewarning-if-scheduled t)
(setq org-agenda-skip-scheduled-if-deadline-is-shown t)
(setq org-agenda-start-on-weekday nil)
(setq org-babel-load-languages (quote ((emacs-lisp . t) (dot . t) (ditaa . t))))
(setq org-capture-templates
   (quote
    (("d" "DevIssue from MKS" entry
      (file "~/org/devs.org")
      "* ASSIGNED %:description  :REPORT:
%:initial
" :immediate-finish t)
     ("g" "General" entry
      (file+olp "~/org/na.org" "Unsorted")
      "** TODO %?")
     ("m" "TODO from Mail" entry
      (file+olp "~/org/na.org" "Unsorted")
      "** TODO %a" :immediate-finish t))))
(setq org-ditaa-jar-path "/usr/share/ditaa/ditaa.jar")
(setq sorg-scheduled-past-days 5)
(setq org-sort-agenda-notime-is-late nil)

(global-set-key [?\C-c ?a]    'org-agenda)
