;;; -*- lexical-binding: t -*-

;; This code is generated from init.org.
;; Do not modify, modify the source instead

(setq home (and (string-match "^martin$" (user-login-name)) (string-equal (system-name) "merlin")))
(setq work-linux-local (and (string-match "^MAL1$" (user-login-name)) (string-equal system-type "gnu/linux")))
(setq work-linux-remote (and (string-match "^martin$" (user-login-name)) (string-equal system-type "gnu/linux") (string-equal (system-name) "LP15-MAL1-CEM")))
(setq work-linux (or work-linux-local work-linux-remote))
(setq work-win (and (string-match "^mal1$" (user-login-name)) (or (string-equal system-type "windows-nt") (string-equal system-type "cygwin"))))
(setq work (or work-linux work-win))
(setq work-vnc (and work-linux-local (string-equal (getenv "DISPLAY") ":1.0")))

(if work
    (setq browse-url-firefox-program "/home/home_dev/MAL1/tools/firefox/firefox"))

(straight-use-package 'use-package)

(use-package straight
:custom
(straight-use-package-by-default t)
(straight-recipe-overrides '((nil . ((scad-mode :type git :flavor melpa :files ("scad-mode.el" "ob-scad.el") :host github :repo "openscad/emacs-scad-mode"))))))

(setq custom-file (concat user-emacs-directory "custom.el"))

(when (file-exists-p custom-file)
  (load custom-file nil t))

(use-package desktop
  :straight (:type built-in)
  :config (desktop-save-mode t))

(global-set-key (kbd "<delete>") 'c-electric-delete-forward)
(global-set-key (kbd "C-c C-g") 'goto-line)
(global-set-key (kbd "C-x C-b") 'ibuffer)

(global-unset-key (kbd "C-x C-c"))
(global-set-key (kbd "C-x C-c C-x") 'save-buffers-kill-terminal)
(global-unset-key (kbd "M-SPC"))     ;; Originally just-one-space
(global-set-key (kbd "M-SPC") 'dabbrev-expand)
(global-set-key (kbd "<f2>") 'customize-group)
(global-unset-key (kbd "C-z"))       ;; Who needs suspend-frame?

(server-start)

(defun ma-make-display-buffer-matcher-function (major-modes)
  (lambda (buffer-name action)
    (with-current-buffer buffer-name (apply #'derived-mode-p major-modes))))

(use-package avy
  :bind ("C-M-j" . 'avy-goto-char-timer))

(use-package expand-region
	     :bind ("M-o" . er/expand-region))

(use-package flycheck)
(global-flycheck-mode)

(defun ma-after-language-guess (lang beginning end)
  "Perform multiple settings after the language of a buffer has been guessed:
- Switch the input method depending on the guessed language.
   Argument LANG: Language code."
  (message (format "Switching input language to %s" lang))
  (if (string-equal lang "de")
      (progn
        (activate-input-method "german-postfix")
        (ispell-change-dictionary "german"))
    (deactivate-input-method)
    (ispell-change-dictionary "american")))

(use-package guess-language
  :custom (guess-language-languages '(en de))
  :config
  (add-hook 'guess-language-after-detection-functions #'ma-after-language-guess))

(use-package multiple-cursors
	     :bind (("C-c C-n" . mc/mark-next-like-this)
		    ("C-c C-p" . mc/mark-previous-like-this)
		    ("C-c C-a" . mc/mark-all-like-this-in-defun)
		    ("C-c C-|" . mc/edit-lines)))

(use-package swiper
  :bind ("C-s" . swiper-isearch))

(use-package smartscan)

(use-package browse-kill-ring)

(use-package visual-regexp
  :custom
  (vr/command-python (concat "python3 " user-emacs-directory "straight/build/visual-regexp-steroids/regexp.py"))
  :bind ("M-%" . 'vr/query-replace)
        ("C-M-%" . 'vr/replace))

(use-package visual-regexp-steroids)

(use-package yasnippet
  :diminish yas-minor-mode
  :hook
  (prog-mode . yas-minor-mode)
  (org-mode . yas-minor-mode))
(use-package yasnippet-snippets)

(add-hook 'before-save-hook
          'delete-trailing-whitespace)

(defface ma-magit-highlight-remote-face
  '((t :inherit magit-branch-remote
       :underline t))
  "Face for highlighting remote branches with specific text in them."
  :group 'ma)

(use-package magit
  :bind ("C-c C-z" . magit-status)
  :config
  (add-hook 'magit-refs-mode-hook
            (lambda ()
              (add-to-list 'magit-ref-namespaces '("\\`refs/remotes/origin/\\(SPCK-[0-9]+-MAL1-.*\\)" . ma-magit-highlight-remote-face)))))

(use-package git-timemachine
  :straight (:repo "https://codeberg.org/pidu/git-timemachine"))

(use-package git-gutter
  :diminish git-gutter-mode
  :config
  (add-hook 'text-mode-hook
            (lambda ()
              (unless (and (buffer-file-name) (file-remote-p (buffer-file-name)))
                (git-gutter-mode)))))

(if work-linux-remote
    (progn
      (setq work-remote-machine "dell1254cem")
      (setq work-remote-url "/ssh:MAL1@dell1254cem:")
      (setq enable-remote-dir-locals nil)
      (setq remote-file-name-inhibit-locks t)
      ;; Avoid version-control checks for tramp buffers
      (setq vc-ignore-dir-regexp
            (format "\\(%s\\)\\|\\(%s\\)"
                    vc-ignore-dir-regexp
                    tramp-file-name-regexp)))
  (setq work-remote-url "")
  (setq work-remote-machine nil))

(use-package password-cache
  :straight (:type built-in)
  :custom (password-cache-expiry 36000)
  :after flyspell
  )

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

  (use-package link-hint
    :config
    (link-hint-define-type 'spck-url
                           :next 'ma-spck-next-link
                           :at-point-p 'ma-spck-link-at-point-p
                           :open #'browse-url)
    (push 'link-hint-spck-url link-hint-types)
    :bind ("C-c o" . 'link-hint-open-link))

(cond
 (work-linux-local
  (progn (setq projectile-project-search-path '("/scratch/apel"))
         (setq projectile-git-command (concat (getenv "HOME") "/bin/projectile_ls.sh"))))
 (work-linux-remote
  (progn (setq projectile-project-search-path '("/scratch/apel"))
         (setq projectile-git-command (concat (getenv "HOME") "/bin/projectile_ls.sh"))
         (setq projectile-enable-caching t)))
 (work-win (setq projectile-project-search-path '("D:/users/apel")))
 (home (setq projectile-project-search-path '("/home/martin"))))

(defun ma-projectile-mode-line()
  "Generates a projectile mode line"
  (format " Proj[%s]" (projectile-project-name)))

(use-package projectile
  :init
  (projectile-mode 1)
  ;; This is needed to avoid slowdown when working with remote files.
  (defadvice projectile-project-root (around ignore-remote first activate)
    (unless (file-remote-p default-directory) ad-do-it))

  :bind
  ("C-c C-f" . projectile-find-file)
  :bind-keymap
  ("C-S-p" . projectile-command-map)
  :custom
  (projectile-sort-order 'recently-active)
  (projectile-git-submodule-command nil)
  (projectile-mode-line-prefix "")
  (projectile-mode-line-function 'ma-projectile-mode-line))

(defun ma-deadgrep-root-function()
  "Determine root directory for current buffer."
    (if (and (buffer-file-name) (file-in-directory-p (buffer-file-name) "/scratch/apel/new_arch/develop/src/ooa"))
        "/scratch/apel/new_arch/develop/src/ooa"
      (if (and (buffer-file-name) (file-in-directory-p (buffer-file-name) "/scratch/apel/new_arch/develop/src"))
          "/scratch/apel/new_arch/develop/src"
        (deadgrep--project-root))))
(use-package deadgrep
  :bind ("C-c C-r" . deadgrep)
  :custom (deadgrep-max-buffers  1)
  (deadgrep-project-root-function 'ma-deadgrep-root-function))

(use-package hydra
  :straight (:host github :repo "abo-abo/hydra"))

(use-package all-the-icons)

(use-package diminish)

(use-package uniquify
  :straight (:type built-in)
  :custom (uniquify-buffer-name-style 'post-forward-angle-brackets))

(use-package ace-window
  :bind ("C-x o" . 'ace-window)
  :custom (aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)))

(use-package which-key
  :diminish which-key-mode
  :config (which-key-mode)
  :custom (which-key-max-description-length 35))

(use-package doom-modeline
  :custom
  (doom-modeline-modal-icon nil)
  (doom-modeline-persp-icon nil)
  (doom-modeline-persp-name nil)
  (doom-modeline-buffer-file-name-style 'buffer-name)
  (doom-modeline-vcs-max-length 25)
  :config
  (progn
    (doom-modeline-mode 1)
    (if home
        (display-battery-mode t))))

(use-package modus-themes
  :custom
    (modus-themes-deuteranopia t)
    (modus-themes-bold-constructs t)
    (modus-themes-italic-constructs t)
    (modus-themes-paren-match '(bold))
    (modus-themes-mode-line '(3d))
    (modus-themes-hl-line '(intense))
    (modus-themes-headings '((t variable-pitch)))
  :config
  (progn
    (load-theme 'modus-vivendi :no-confirm)))

(use-package unicode-fonts
  :config (unicode-fonts-setup))

(global-font-lock-mode 1)

(use-package fontaine
  :custom (fontaine-presets
           '((home
              :default-family "DejaVu Sans Mono"
              :default-height 80
              :fixed-pitch-family "DejaVu Sans Mono"
              :fixed-pitch-height 100
              :variable-pitch-family "Nimbus Roman"
              :variable-pitch-height 100)
             (work
              :inherit home)
             (screen-sharing
              :inherit home
              :default-height 100
              :fixed-pitch-family "DejaVu Sans Mono"
              :fixed-pitch-height 120
              :variable-pitch-family "Nimbus Roman"
              :variable-pitch-height 120))))
(if (or home work-linux-remote)
    (fontaine-set-preset 'home)
  (fontaine-set-preset 'work))

(use-package whitespace
  :straight (:type built-in)
  :custom (whitespace-line-column 150)
  (whitespace-style '(face lines-tail))
  :hook (prog-mode . whitespace-mode))

(defalias 'yes-or-no-p 'y-or-n-p)
(setq frame-inhibit-implied-resize t)

(defun ma-devdocs-lookup-at-point()
  (interactive)
  (devdocs-lookup nil (thing-at-point 'symbol)))

(use-package devdocs
  :bind
  ("C-c C-S-d" . 'ma-devdocs-lookup-at-point)
  ("C-c C-d" . devdocs-lookup)
  :init
  (add-hook 'c-mode-common-hook
            (lambda()
              (setq-local devdocs-current-docs '("cpp" "qt~5.12"))
              (local-unset-key (kbd "C-c C-d"))))
  (add-hook 'cmake-mode-hook
            (lambda()
              (setq-local devdocs-current-docs '("cmake~3.23"))
              (local-unset-key (kbd "C-c C-d"))))
  (add-hook 'dockerfile-mode-hook
            (lambda()
              (setq-local devdocs-current-docs '("docker"))))
  (add-hook 'js-mode-hook
            (lambda()
              (setq-local devdocs-current-docs '("node~18_lts" "javascript"))))
  (add-hook 'python-mode-hook
            (lambda()
              (setq-local devdocs-current-docs '("python~3.10"))))
  (add-hook 'perl-mode-hook
            (lambda()
              (setq-local devdocs-current-docs '("perl~5.34"))))
  (add-hook 'yaml-mode-hook
            (lambda()
              (setq-local devdocs-current-docs '("ansible")))))

(setq Info-directory-list '("/usr/local/share/info/" "/usr/share/info/"))

(use-package helpful
:bind
("C-h f" . helpful-callable)
("C-h v" . helpful-variable)
("C-h k" . helpful-key)
("C-c C-d" . helpful-at-point))
(add-to-list 'display-buffer-alist
             `(,(ma-make-display-buffer-matcher-function '(helpful-mode))
               (display-buffer-reuse-window display-buffer-in-direction)
               (direction . bottom)
               (window-height . 0.5)))

(defun ma-cmake-upcase-completion-list (candidates)
  "Converts all incoming completion candidates to upper case"
  (if (string-equal major-mode "cmake-mode")
 (mapcar 'upcase candidates)
    candidates))

(use-package company
 :diminish company-mode
 :config
 (global-company-mode)
 :custom
   (company-dabbrev-downcase nil)
   (company-transformers '(ma-cmake-upcase-completion-list company-sort-by-occurrence))
   (company-cmake-executable "/scratch/apel/new_arch/develop/extern/linux64/cmake-3.23/bin/cmake")
   (company-backends '(company-cmake company-capf company-files
                                     (company-dabbrev-code company-keywords)
                                     company-dabbrev))
   (company-idle-delay 2.0)
   :bind ("C-M-S-s-c" . company-complete))

;; (use-package company-box
;;   :after company
;;   :diminish company-box-mode
;;   :hook company-mode)

(use-package vertico
  :custom
    (vertico-sort-function #'vertico-sort-history-alpha)
  :config
  (progn
    (vertico-mode)
    (define-key vertico-map (kbd "TAB") 'minibuffer-complete)
    (savehist-mode)))

(use-package orderless
  :custom (completion-styles '(substring orderless basic)))

(use-package marginalia
  :init
  (marginalia-mode))

(when work-linux-remote
  (defun ma-switch-to-mu4e ()
    "Switch to unread mail in mu4e"
    (interactive)
    (unless (mu4e-running-p)
      (mu4e t))
    (mu4e-search-bookmark (mu4e-get-bookmark-query ?i))
    (mu4e-headers-change-sorting :date 'ascending))

  (defun ma-view-previous-next-advice(orig &rest args)
    (let ((switch-to-buffer-obey-display-actions nil))
      (apply orig args)))

  (use-package mu4e
    :straight (:branch "release/1.10")
    :load-path "straight/repos/mu/build/mu4e"
    :commands mu4e-running-p mu4e
    :custom
    (mu4e-mu-binary (concat user-emacs-directory "straight/repos/mu/build/mu/mu"))
    (mu4e-bookmarks
     (quote
      (("(maildir:/INBOX OR maildir:/AutoNotifications) AND NOT flag:trashed" "INBOX" 105)
       ("flag:unread AND NOT flag:trashed AND NOT maildir:Trash" "Unread messages" 117)
       ("date:today..now AND NOT flag:trashed AND NOT maildir:Trash AND NOT maildir:/Junk" "Today's messages" 116)
       ("date:7d..now AND NOT flag:trashed AND NOT maildir:Trash AND NOT maildir:/Junk" "Last 7 days" 119))))
    (mu4e-headers-fields
     '( (:human-date . 12)
        (:flags . 6)
        (:from-or-to . 30)
        (:subject)))
    (mu4e-compose-signature-auto-include nil)
    (mu4e-compose-dont-reply-to-self t)
    (mu4e-compose-complete-only-after "2020-01-01")
    (mu4e-drafts-folder "/Drafts")
    (mu4e-get-mail-command "~/bin/Linux/call_mbsync.sh")
    (mu4e-completing-read-function 'completing-read)
    (mu4e-headers-include-related nil)
    (mu4e-index-update-error-warning nil)
    (mu4e-hide-index-messages t)
    (mu4e-sent-folder "/Sent")
    (mu4e-trash-folder "/Trash")
    (mu4e-update-interval 120)
    (mu4e-use-fancy-chars t)
    (mu4e-attachment-dir "/tmp")
    (mu4e-change-filenames-when-moving t)
    (mu4e-headers-visible-lines 20)
    (mu4e-org-link-query-in-headers-mode t)
    (mu4e-modeline-support nil)
    (message-send-mail-function (quote smtpmail-send-it))

    (smtpmail-debug-info nil)
    (smtpmail-local-domain "3ds.com")
    (smtpmail-smtp-server "smtps.emea.3ds.com")
    (smtpmail-smtp-service 587)
    (smtpmail-stream-type (quote starttls))

    (mail-user-agent 'mu4e-user-agent)
    (shr-color-visible-luminance-min 80)
    :config
    (set-variable 'read-mail-command 'mu4e)
    (advice-add 'mu4e-view-headers-next :around #'ma-view-previous-next-advice)
    (advice-add 'mu4e-view-headers-prev :around #'ma-view-previous-next-advice)
    (advice-add 'mu4e-headers-mark-and-next :around #'ma-view-previous-next-advice)

    (add-to-list 'display-buffer-alist
                 `("^\\*mu4e-headers\\*$"
                   (display-buffer-reuse-window)
                   (window-min-height . 0.25)))

    (add-to-list 'display-buffer-alist
                 `("^\\*mu4e"
                   (display-buffer-reuse-window)))

    (add-to-list 'display-buffer-alist
                 `("^\\*Article\\*"
                   (display-buffer-reuse-window)))

    :bind ("<f4>" . ma-switch-to-mu4e)))

(use-package mu4e-alert
  :after (mu4e)
  :custom
  (mu4e-alert-email-notification-types '(count))
  (mu4e-alert-style 'notifications)
  (mu4e-alert-interesting-mail-query "maildir:/INBOX AND NOT flag:trashed AND flag:unread")
  :init
  (mu4e-alert-enable-notifications)
  :config
  (mu4e-alert-enable-mode-line-display))

(defun ma-define-snippets-for-mail ()
  "Define snippets to be used in org-msg-edit-mode."

  (yas-define-snippets 'org-msg-edit-mode
                       '(("ger"
                          "\nHi `(org-msg-get-to-name)`,\n\n$0\n\n#+begin_signature\n--\nViele Grüße,\n\nMartin\n#+end_signature\n"
                          "MailDeutsch")
                         ("eng"
                          "\nHi `(org-msg-get-to-name)`,\n\n$0\n\n#+begin_signature\n--\nBest Regards,\n\nMartin\n#+end_signature\n"
                          "MailEnglisch"))))

(defun ma-make-display-buffer-matcher-function-org-msg()
  (lambda (buffer-name action)
    (with-current-buffer buffer-name (derived-mode-p org-msg-mode))))

(use-package org-msg
  :after (mu4e)
  :custom
  (org-msg-options "html-postamble:nil H:5 num:nil ^:{} toc:nil author:nil email:nil \\n:t")
  (org-msg-startup "hidestars indent inlineimages")
  (org-msg-greeting-fmt nil)
  (org-msg-recipient-names '(("martin.apel@3ds.com" . "Martin")
                             ("Magdalena.NIEDHAMMER@3ds.com" . "Lena")
                             ("Rajanagaprasad.KODALI@3ds.com" . "Prasad")
                             ("David.BLUMENTHAL@3ds.com" . "Dave")
                             ("Edward.WATRAS@3ds.com" . "Ed")))
  (org-msg-greeting-name-limit 3)
  (org-msg-default-alternatives '((new		. (html))
                                  (reply-to-html	. (html))
                                  (reply-to-text	. (html))))
  (org-msg-convert-citation t)
  (org-msg-signature nil)

  :config
  (add-to-list 'display-buffer-alist
               `(,(ma-make-display-buffer-matcher-function '(org-mode))
                 (display-buffer-reuse-window)))
  (ma-define-snippets-for-mail))

(defun ma-org-msg-get-to-name-advice(orig &rest args)
  "Return first name of addressee or defer to org-msg-get-to-name."
  (save-excursion
    (let ((to (org-msg-message-fetch-field "to")))
      (if (string-match "^\\([[:upper:]]+\\) \\([[:alpha:]]+\\) <\\([[:alpha:]]+\.[[:alpha:]]+@3ds\.com\\)>$" to)
          (let ((mail-addr (match-string 3 to)))
            (or (assoc-default mail-addr org-msg-recipient-names)
                (match-string 2 to)))
        (apply orig args)))))

(advice-add 'org-msg-get-to-name :around #'ma-org-msg-get-to-name-advice)

(org-msg-mode)

(add-hook 'org-msg-edit-mode-hook
          (lambda ()
            (define-key org-msg-edit-mode-map (kbd "C-c C-f C-s") 'message-goto-subject)
            (define-key org-msg-edit-mode-map (kbd "C-c C-f C-t") 'message-goto-to)
            (define-key org-msg-edit-mode-map (kbd "C-c C-f C-c") 'message-goto-cc)
            (define-key org-msg-edit-mode-map (kbd "C-c C-f C-b") 'message-goto-bcc)
            (flyspell-mode 1)
            (setq flyspell-generic-check-word-predicate 'mail-mode-flyspell-verify)
            (guess-language-mode 1)))

(use-package german-holidays
  :custom calendar-holidays holiday-german-BY-holidays)

(setq diary-file "~/.emacs.d/diary")
(setq calendar-url "http://localhost:1080/users/Martin.APEL@3ds.com/calendar/")
(setq calendar-view-diary-initially-flag t)
(setq diary-number-of-entries 3)
(setq calendar-time-display-form '(24-hours ":" minutes))
(setq calendar-week-start-day 1)
(setq appt-display-diary t)
(setq appt-display-format 'window)
(setq org-agenda-include-diary t)

(add-hook 'diary-list-entries-hook #'diary-sort-entries t)

(defvar ma--getcal-last-update nil "Last time the calendar has been updated.")

(defun ma--getcal-do (url file)
  "Download ics file and add it to file"
  (let ((tmpfile (url-file-local-copy url)))
    (icalendar-import-file tmpfile file)
    (let ((tmp-buffer (find-buffer-visiting tmpfile)))
      (when tmp-buffer
        (kill-buffer tmp-buffer)))
    (delete-file tmpfile)))

(defun ma-getcal ()
  "Load an ICS calendar into the Emacs diary"
  (interactive)
  (message (concat "Loading " calendar-url " into " diary-file))
  (let ((diary-buffer (find-file-noselect diary-file)))
    (with-current-buffer diary-buffer
      (erase-buffer)
      (ma--getcal-do calendar-url diary-file)
      (save-buffer)))
  (setq ma--getcal-last-update (float-time)))

(defun ma--getcal-if-necessary ()
  "Reload the calendar if it hasn't been updated for an hour."
  (when (or (not (and (floatp ma--getcal-last-update) (< (- (float-time) ma--getcal-last-update) 3600))))
    (ma-getcal)))

(when work
  (appt-activate 1)
  (run-with-idle-timer 60 t 'ma--getcal-if-necessary))

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

(use-package org
  :straight (:type built-in)
  :custom
  (org-agenda-files '("~/org" "~/org/jira" "~/org-roam"))
  (org-agenda-custom-commands
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
  (org-agenda-repeating-timestamp-show-all nil)
  (org-agenda-skip-deadline-prewarning-if-scheduled t)
  (org-agenda-skip-scheduled-if-deadline-is-shown t)
  (org-agenda-start-on-weekday nil)
  (org-babel-load-languages (quote ((emacs-lisp . t) (dot . t) (ditaa . t) (shell . t))))
  (org-export-backends (quote (ascii html icalendar latex md pandoc jira)))
  (org-capture-templates
   (quote
    (
     ("g" "General" entry
      (file+olp "~/org/na.org" "Unsorted")
      "** TODO %?")
     ("t" "Test" entry (file "~/org/test.org") nil)
     ("m" "TODO from Mail" entry
      (file+headline "~/org/na.org" "Mail")
      "** TODO [#A] %?Mail: %a\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n" :immediate-finish t :jump-to-captured t))))
  (sorg-scheduled-past-days 5)
  :bind
  ("C-c a" . 'org-agenda)
  ("C-c C" . 'org-capture)
  :hook (org . hl-line-mode)
  :config
  (define-key org-mode-map (kbd "C-c C-z") nil))      ;; Free up for global magit-status binding

(use-package ox-pandoc
  :straight t)

(use-package org-jira
  :if work
  :custom
  (jiralib-url "https://spck-jira.ux.dsone.3ds.com:8443")
  (org-jira-working-dir "~/org/jira")
  ;;                            other         dev 2023               dev 2023x    in progress       testing             ready
  (org-jira-default-jql "filter = 33100 OR filter = 62300 OR filter = 33400 OR filter = 10903 OR filter = 14101 ORDER BY status asc")
  (org-jira-use-status-as-todo t)
  :config
  (add-hook 'org-mode-hook
            (lambda()
              (if (and (buffer-file-name) (file-in-directory-p (buffer-file-name) "~/org/jira"))
                  (org-jira-mode 1)))))

(use-package ox-jira
  :if work)

(use-package org-bullets
  :hook (org-mode . org-bullets-mode))

(use-package emacsql
  :if work)
(use-package org-roam
  :if work
  :custom
  (org-roam-directory "~/org-roam")
  (org-roam-capture-templates
   '(("d" "default" plain "%?" :target
      (file+head "%<%Y-%m-%d_%H:%M:%S>-${slug}.org" "#+title: ${title}")
      :unnarrowed t)
     ("s" "spck" plain (file "~/org-roam/templates/spck-template.org")
      :target (file "%<%Y-%m-%d_%H:%M:%S>-SPCK-${slug}.org")
      :unnarrowed t)
     ))
  (org-roam-database-connector 'sqlite-builtin)
  :bind
  ("C-c n l" . 'org-roam-buffer-toggle)
  ("C-c n f" . 'org-roam-node-find)
  ("C-c n i" . 'org-roam-node-insert)
  :after emacsql
  :config
  (org-roam-db-autosync-mode))

(use-package org-auto-tangle
  :diminish org-auto-tangle-mode
  :hook (org-mode . org-auto-tangle-mode))

(when work-linux-local
  (defun ma-bitlbee-identify ()
    "Auto-identify for Bitlbee channels using authinfo"
    (interactive)
    (when (string= (buffer-name) "&bitlbee")
      (let* ((entry (nth 0 (auth-source-search :max 1
                                               :host "dell1254cem"
                                               :user "MAL1"
                                               :port 6667)))
             (secret (plist-get entry :secret))
             (user (plist-get entry :user))
             (password (if (functionp secret)
                           (funcall secret)
                         secret)))
        (erc-message "PRIVMSG" (concat (erc-default-target) " account add sipe martin.apel@3ds.com,dsone\\\\" user " " password))
        (erc-message "PRIVMSG" (concat (erc-default-target) " account sipe set useragent \"UCCAPI/16.0.6001.1073 OC/16.0.6001.1073 (Skype for Business)\""))
        (erc-message "PRIVMSG" (concat (erc-default-target) " account sipe on"))
        (erc-log-mode 1)
        )
      ))

  (defun ma-bitlbee-ignore-unimportant (msg)
    "less noise from bitlbee"
    (if (string-match "localhost has changed mode for " msg)
        (setq erc-insert-this nil)))

  (defun ma-erc-format-nick (&optional user _channel-data)
    "Format the nick name."
    (when user
      (progn
        (message "User is %s" user)
        (message "Nickname is %s" (erc-server-user-nickname user))
        (erc-server-user-nickname user))))
  )

(use-package erc
  :if work-linux-local
;;  :custom
;;   (erc-autoaway-idle-seconds 1800)
;;   (erc-autoaway-message "Away")
;;   (erc-notifications-mode t)
;;   (erc-track-showcount t)
;;   (erc-hide-list '("JOIN" "PART" "QUIT" "MODE" "MODE-nick"))
;;   (erc-nick "martin")
;;   (erc-notifications-icon "/usr/share/icons/Adwaita/48x48/actions/call-start.png")
;;   (erc-server "dell1254cem")
;;   (erc-track-exclude-types '("JOIN" "NICK" "PART" "333" "353"))
;;   (erc-user-full-name "Martin Apel")
;;  :config
;;   (add-to-list 'erc-modules 'autoaway)
;;   (add-to-list 'erc-modules 'dcc)
;;   (add-to-list 'erc-modules 'notifications)
;;   (add-to-list 'erc-modules 'smiley)
;;   (add-to-list 'erc-modules 'spelling)
;;   (erc-update-modules)
  :requires 'auth-source)

(when work-linux-local
  (progn
    (add-hook 'erc-insert-pre-hook 'ma-bitlbee-ignore-unimportant)
    (add-hook 'erc-join-hook 'ma-bitlbee-identify)
    (erc :server "localhost" :nick "martin" :password "")))

(use-package subword
  :straight (:type built-in)
  :config
  (add-hook 'prog-mode-hook
            (lambda()
              (local-set-key (kbd "M-<left>") 'subword-backward)
              (local-set-key (kbd "M-<right>") 'subword-forward)
              (subword-mode t))))

(use-package idle-highlight-mode
  :hook prog-mode)

(add-hook 'prog-mode-hook 'hl-line-mode)

(add-hook 'prog-mode-hook
          (lambda()
            (lock-file-mode nil)
            (smartscan-mode 1)))

(use-package lsp-mode
  :custom
  (read-process-output-max (* 1024 1024)) ;; 1mb
  (gc-cons-threshold 100000000)

  (lsp-completion-provider :capf)
  (lsp-eldoc-enable-hover nil)
  (lsp-client-packages '(lsp-bash lsp-clangd lsp-clients lsp-cmake lsp-dockerfile lsp-groovy lsp-javascript lsp-json lsp-perl lsp-php lsp-pyls lsp-xml lsp-yaml))
  (lsp-clients-clangd-args '("--background-index" "--log=info" "-j=8" "--clang-tidy"))
  (lsp-completion-no-cache t)
  (lsp-enable-indentation nil)
  (lsp-enable-folding nil)
  (lsp-enable-on-type-formatting nil)
  (lsp-keymap-prefix "C-r")
  (lsp-modeline-code-actions-enable nil)
  (lsp-modeline-diagnostics-scope :file)
  (lsp-response-timeout 2)
  (lsp-restart 'auto-restart)
  :hook (prog-mode . #'lsp-deferred)
        (lsp-mode . lsp-enable-which-key-integration))

(use-package lsp-ui
  :after (lsp)
  :hook (c++-mode . yas-minor-mode)
        (c++ts-mode . yas-minor-mode))

(use-package modern-cpp-font-lock
  :config (modern-c++-font-lock-global-mode t))

(add-hook 'c-mode-common-hook 'smerge-start-session)

(add-hook 'c-mode-common-hook
           (lambda ()
             (local-set-key (kbd "C-c C-o") 'ff-find-other-file)
             (local-set-key (kbd "C-c C-s") 'hs-show-block)
             (local-set-key (kbd "C-M-a") 'beginning-of-defun)
             (local-set-key (kbd "C-M-e") 'end-of-defun)
             (local-set-key (kbd "<delete>") 'c-electric-delete-forward)
             (local-set-key (kbd "C-c =") 'align-regexp)
             (local-set-key (kbd "C-c *") 'ma-insert-separator)
             (local-unset-key (kbd "C-c C-a"))                       ;; Free keybinding for multiple-cursors
             (local-unset-key (kbd "C-c C-n"))
             (local-unset-key (kbd "C-c C-p"))
             (local-unset-key (kbd "C-c C-z"))))                     ;; Free keybinding for magit-status
;; (add-hook 'c-ts-base-mode-hook
;;            (lambda ()
;;              (local-set-key (kbd "C-c C-o") 'ff-find-other-file)
;;              (local-set-key (kbd "C-c C-s") 'hs-show-block)
;;              (local-set-key (kbd "C-M-a") 'beginning-of-defun)
;;              (local-set-key (kbd "C-M-e") 'end-of-defun)
;;              (local-set-key (kbd "<delete>") 'c-electric-delete-forward)
;;              (local-set-key (kbd "C-c =") 'align-regexp)
;;              (local-set-key (kbd "C-c *") 'ma-insert-separator)
;;              (local-unset-key (kbd "C-c C-a"))                       ;; Free keybinding for multiple-cursors
;;              (local-unset-key (kbd "C-c C-n"))
;;              (local-unset-key (kbd "C-c C-p"))
;;              (local-unset-key (kbd "C-c C-z"))))                     ;; Free keybinding for magit-status

(defun ma-indent-style()
  "Override the built-in BSD indentation style with some additional rules"
  `(;; Here are your custom rules
;;     ((node-is ")") parent-bol 0)
;;     ((match nil "argument_list" nil 1 1) parent-bol c-ts-mode-indent-offset)
;;     ((parent-is "argument_list") prev-sibling 0)
;;     ((match nil "parameter_list" nil 1 1) parent-bol c-ts-mode-indent-offset)
;;     ((parent-is "parameter_list") prev-sibling 0)
    ((and (parent-is "if_statement") (not (node-is "compound_statement"))) parent-bol 3)

    ;; Append here the indent style you want as base
    ,@(alist-get 'bsd (c-ts-mode--indent-styles 'cpp))))

(use-package c-ts-mode
  :if (treesit-language-available-p 'c)
  :disabled t
  :custom
  (c-ts-mode-indent-offset 3)
  (c-ts-mode-indent-style #'ma-indent-style)
  :init
  ;; Remap the standard C/C++ modes
  (add-to-list 'major-mode-remap-alist '(c-mode . c-ts-mode))
  (add-to-list 'major-mode-remap-alist '(c++-mode . c++-ts-mode))
  (add-to-list 'major-mode-remap-alist '(c-or-c++-mode . c-or-c++-ts-mode)))

(add-hook 'c-mode-common-hook
          (lambda ()
            (imenu-add-to-menubar "Functions")
            (local-set-key (kbd "C-c C-i") 'imenu)
            (if work
                (add-hook 'before-save-hook 'ma-create-or-update-copyright))
            (c-toggle-hungry-state 1)
            (cwarn-mode)
            (hs-minor-mode)
            (hs-hide-initial-comment-block)))
(add-to-list 'auto-mode-alist '("\\.h" . c++-mode))

(use-package cmake-mode
  :custom (cmake-tab-width 3)
  :init
  (add-hook 'cmake-mode-hook
            (lambda ()
              (local-set-key (kbd "C-c C-d") 'cmake-help)
              (flyspell-prog-mode)
              (setq indent-line-function 'indent-relative))))

(use-package dockerfile-mode)

(use-package docker-compose-mode)

(use-package js2-mode
:mode ("\\.js$" "\\.sjs$" "\\.qs$")
:custom
(js2-include-node-externs t)
(js2-mode-assume-strict t)
(js2-include-browser-externs nil))

(use-package jenkinsfile-mode)

(use-package auto-compile
  :custom (load-prefer-newer t)
  :config (auto-compile-on-load-mode 1)
  (auto-compile-on-save-mode 1))

(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (local-set-key (kbd "M-.") 'find-function-other-window)))

(add-hook 'sh-set-shell-hook
          (lambda()
            (when (string-equal sh-shell "tcsh")
              (progn
                (require 'csh-mode)
                (setq-local indent-line-function 'csh-indent-line)
                (setq-local indent-region-function 'csh-indent-region)))))
(add-hook 'shell-mode-hook
          'dirtrack-mode)
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

(use-package restclient)

(use-package generic
  :straight (:type built-in)
  :if work
  :config
  (define-generic-mode
      'spck-mode
    '("!")
    '("body"
      "constr"
      "control"
      "ens"
      "express"
      "force"
      "joint"
      "marker"
      "poly"
      "prim"
      "road"
      "refsys"
      "sensor"
      "slv"
      "substr"
      "subvar"
      "track"
      "timex"
      "view"
      "yout")
    '(
      ("\\(\\$[A-Za-z0-9_]+\\)" 1 font-lock-variable-name-face)
      ("\\([+-]?[0-9]\\.[0-9]+E[+-][0-9]+\\)" 1 font-lock-constant-face)
      ("'\\([^']+\\)'" 1 font-lock-string-face)
      )
    '("\\.sys$" "\\.ani$" "\\.spck$")
    (list
     (function
      (lambda ()
        (setq imenu-generic-expression
              '((nil "(.*\\(\\$[A-Za-z0-9_]+\\).*) *=" 1)))
        (imenu-add-menubar-index)
        (local-set-key [?\C-c ?\C-j] 'imenu))))
    "A mode for SIMPACK model files"))

(use-package skeleton
  :straight (:type built-in)
  :if work
  :config
  (define-skeleton header-skeleton
    "Define a C++ header file skeleton"
    ""
    "// Copyright Dassault Systemes Simulia Corp.\n\n"
    "#pragma once\n\n"
    "#include \"base/WinExportDefs.h\"\n\n"
    "namespace " (skeleton-read "Namespace name?") "\n"
    "{\n\n"
    "class SPCK_XXX_EXPORT " (file-name-sans-extension (file-name-nondirectory buffer-file-name)) "\n"
    "{\n"
    "public:\n\n"
    "   " (file-name-sans-extension (file-name-nondirectory buffer-file-name)) "(const " (file-name-sans-extension (file-name-nondirectory buffer-file-name)) "&) = delete;\n"
    "   " (file-name-sans-extension (file-name-nondirectory buffer-file-name)) "& operator=(const " (file-name-sans-extension (file-name-nondirectory buffer-file-name)) "&) = delete;\n"
    "};\n"
    "}\n"
    ))

(use-package auto-insert
  :straight (:type built-in)
  :after (skeleton)
  :hook (find-file-hook . auto-insert)
  :config (define-auto-insert "\\.h\\'" 'header-skeleton))

(use-package scad-mode
  :if home)
(use-package scad-dbus
  :straight (:type git :flavor melpa :files ("scad-dbus.el") :host github :repo "Lenbok/scad-dbus" :depends "hydra")
  :if home)

(add-to-list 'load-path "~/.emacs.d/ma-funcs")
(require 'ma-funcs)
(require 'ma-simpack-js-mode)
(add-hook 'js2-mode-hook 'ma-simpack-js-mode)

(use-package atl-stash
  :straight (:type built-in)
  :if work
  :commands (stash-update-stash-info
             stash-create-branch
             stash-show-pull-requests)
  :config (add-to-list 'mode-line-misc-info '(" " stash-mode-line-string " ") t)
  :bind ("C-c p" . stash-show-pull-requests))
(when work
  (run-with-idle-timer 60 60 'stash-update-stash-info))

(run-with-idle-timer 1800 t 'ma-kill-old-buffers)

(use-package marginalia-jira
  :straight (:type built-in)
  :defer 10
  :if work)

(use-package vterm
  :if work
  :bind (:map vterm-mode-map
  ("C-g" . vterm--self-insert)
  ("<f4>" . ma-switch-to-mu4e)
  ("<f3>" . ma-ssh-connect-with-tmux-support))
  :custom (vterm-copy-exclude-prompt  t)
  :config
  (add-to-list 'display-buffer-alist
               `("^\\*vterm\\*$"
                 (display-buffer-reuse-window))))
(use-package vterm-toggle
  :if work
  :after vterm
  :bind (:map vterm-mode-map ("<f5>" . vterm-toggle))
  :init
  (global-set-key (kbd "<f5>") 'vterm-toggle)
  (global-set-key (kbd "C-<f5>") 'vterm-toggle-cd))
