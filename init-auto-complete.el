;;; init-auto-complete.el --- Initialization for auto-complete  -*- lexical-binding: t; -*-

;; Copyright (C) 2018  Martin Apel

;; Author: Martin Apel <martin.apel@3ds.com>

(setq ac-modes '(emacs-lisp-mode lisp-mode lisp-interaction-mode
                                 perl-mode cperl-mode
                                 c++-mode c-mode
                                 python-mode ruby-mode lua-mode
                                 ecmascript-mode javascript-mode js-mode js2-mode
                                 php-mode
                                 css-mode
                                 makefile-mode sh-mode
                                 fortran-mode f90-mode
                                 xml-mode sgml-mode))
(global-auto-complete-mode)
(global-set-key (kbd "<f5>") 'auto-complete)
(setq ac-use-menu-map t)

(eval-after-load "rtags"
  '(progn
     ;; Due to some strange interaction with auto-compile-on-load, this doesn't work, when using
     ;; require or load-library. This way it works
     (load-file "~/.emacs.d/el-get/rtags/src/ac-rtags.el")))

(add-hook 'c-mode-common-hook
          (lambda()
            (make-variable-buffer-local ac-auto-start)
            (setq ac-auto-start nil)
            (setq ac-sources '(ac-source-rtags))))

(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (setq ac-sources '(ac-source-functions ac-source-symbols ac-source-features))))

(add-hook 'cmake-mode-hook
          (lambda ()
            (setq ac-sources '(ac-source-words-in-same-mode-buffers))))

(add-hook 'python-mode-hook
          (lambda ()
            (require 'ac-python)
            (setq ac-sources '(ac-python ac-source-words-in-same-mode-buffers))))
