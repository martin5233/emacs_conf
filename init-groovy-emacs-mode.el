;;; init-groovy-emacs-mode.el --- Initialization for Groovy mode  -*- lexical-binding: t; -*-

;; Copyright (C) 2018  Martin Apel

;; Author: Martin Apel <martin.apel@3ds.com>
;; Keywords: convenience

(defun ma-lint-Jenkinsfile ()
  "Pass the current buffer, which is assumed to be a Jenkinsfile, to the linter of Jenkins for syntax checking"
  (interactive)
  (shell-command-on-region (point-min) (point-max)  "ssh -p 9002 spck-simdev declarative-linter" (get-buffer-create "*Jenkins Lint Output*"))
  )

(add-hook 'groovy-mode-hook
          (lambda()
            (local-set-key (kbd "C-c C-c") 'ma-lint-Jenkinsfile)
            (local-unset-key (kbd "C-c C-z"))                       ;; Free keybinding for magit-status
            ))
