;;; init-company.el --- Company completion framework initialization  -*- lexical-binding: t; -*-

;; Copyright (C) 2016  Martin Apel

;; Author: Martin Apel <martin.apel@3ds.com>
;; Keywords: convenience, abbrev

(eval-after-load "rtags" '(push 'company-rtags company-backends))
(global-company-mode)
(global-set-key (kbd "<f5>") 'company-complete)
(setq company-show-numbers t)
(setq company-dabbrev-ignore-case 'keep-prefix)
(setq company-dabbrev-downcase nil)
(setq company-auto-complete t)
(setq company-transformers '(company-sort-prefer-same-case-prefix))
(setq company-idle-delay nil)

(add-hook 'c-mode-common-hook
          (lambda()
            (set (make-local-variable 'company-backends) '((company-rtags company-capf company-dabbrev-code company-dabbrev)))))

(add-hook 'cmake-mode-hook
          (lambda()
            (set (make-local-variable 'company-backends) '((company-cmake company-capf company-dabbrev-code company-dabbrev)))))

(add-hook 'fundamental-mode
          (lambda()
            (set (make-local-variable 'company-backends) '((company-capf company-dabbrev-code company-dabbrev)))))
