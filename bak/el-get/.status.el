((ace-window status "installed" recipe
             (:name ace-window :after
                    (global-set-key
                     (kbd "C-x o")
                     'ace-window)
                    :description "Quickly switch windows using `avy'" :type github :pkgname "abo-abo/ace-window" :depends
                    (avy)))
 (alert status "installed" recipe
        (:name alert :description "Growl-style notification system for Emacs" :website "https://github.com/jwiegley/alert" :type github :pkgname "jwiegley/alert" :prepare
               (progn
                 (autoload 'alert "alert" "Alert the user that something has happened.")
                 (autoload 'alert-add-rule "alert" "Programmatically add an alert configuration rule."))))
 (ascii-table status "installed" recipe
              (:name ascii-table :auto-generated t :type emacswiki :description "simple ASCII table" :website "https://raw.github.com/emacsmirror/emacswiki.org/master/ascii-table.el"))
 (auto-compile status "installed" recipe
               (:name auto-compile :after
                      (progn
                        (setq load-prefer-newer t)
                        (require 'auto-compile)
                        (auto-compile-on-load-mode 1)
                        (auto-compile-on-save-mode 1))
                      :type github :pkgname "tarsius/auto-compile" :description "Automatically compile Emacs Lisp libraries." :depends
                      (packed)))
 (auto-insert status "installed" recipe
              (:name auto-insert :type builtin :depends skeleton :after
                     (progn
                       (add-hook 'find-file-hook 'auto-insert)
                       (define-auto-insert "\\.h\\'" 'header-skeleton))))
 (browse-kill-ring status "installed" recipe
                   (:name browse-kill-ring :description "Interactively insert items from kill-ring" :type github :pkgname "browse-kill-ring/browse-kill-ring" :prepare
                          (progn
                            (autoload 'browse-kill-ring-default-keybindings "browse-kill-ring"))))
 (cl-lib status "installed" recipe
         (:name cl-lib :builtin "24.3" :type elpa :description "Properly prefixed CL functions and macros" :website "http://elpa.gnu.org/packages/cl-lib.html"))
 (cmake-mode status "installed" recipe
             (:name cmake-mode :after
                    (setq cmake-tab-width 3)
                    :website "http://www.itk.org/Wiki/CMake/Editors/Emacs" :description "Provides syntax highlighting and indentation for CMakeLists.txt and *.cmake source files." :type http :url "http://cmake.org/gitweb?p=cmake.git;a=blob_plain;hb=master;f=Auxiliary/cmake-mode.el"))
 (company-mode status "installed" recipe
               (:name company-mode :after
                      (global-company-mode)
                      :website "http://company-mode.github.io/" :description "Modular in-buffer completion framework for Emacs" :type github :pkgname "company-mode/company-mode"))
 (crontab-mode status "installed" recipe
               (:name crontab-mode :description "Mode for editing crontab files" :type http :url "http://web.archive.org/web/20080716014153/http://www.mahalito.net/~harley/elisp/crontab-mode.el"))
 (dash status "installed" recipe
       (:name dash :description "A modern list api for Emacs. No 'cl required." :type github :pkgname "magnars/dash.el"))
 (deferred status "installed" recipe
   (:name deferred :description "Simple asynchronous functions for emacs lisp." :type github :pkgname "kiwanami/emacs-deferred"))
 (desktop status "installed" recipe
          (:name desktop :type builtin :after
                 (progn
                   (desktop-save-mode t)
                   (add-hook 'kill-emacs-hook 'ma-kill-old-buffers))))
 (diminish status "installed" recipe
           (:name diminish :after
                  (progn
                    (eval-after-load "cwarn"
                      '(diminish 'cwarn-mode))
                    (eval-after-load "hideshow"
                      '(diminish 'hs-minor-mode))
                    (eval-after-load "git-gutter"
                      '(diminish 'git-gutter-mode))
                    (eval-after-load "abbrev"
                      '(diminish 'abbrev-mode)))
                  :description "An Emacs package that diminishes the amount of space taken on the mode line by the names of minor modes." :type http :url "http://www.eskimo.com/~seldon/diminish.el" :features diminish))
 (dockerfile-mode status "installed" recipe
                  (:name dockerfile-mode :type github :pkgname "spotify/dockerfile-mode" :after
                         (add-to-list 'auto-mode-alist
                                      '("Dockerfile\\'" . dockerfile-mode))))
 (el-get status "installed" recipe
         (:name el-get :website "https://github.com/dimitri/el-get#readme" :description "Manage the external elisp bits and pieces you depend upon." :type github :branch "master" :pkgname "dimitri/el-get" :info "." :compile
                ("el-get.*\\.el$" "methods/")
                :features el-get :post-init
                (when
                    (memq 'el-get
                          (bound-and-true-p package-activated-list))
                  (message "Deleting melpa bootstrap el-get")
                  (unless package--initialized
                    (package-initialize t))
                  (when
                      (package-installed-p 'el-get)
                    (let
                        ((feats
                          (delete-dups
                           (el-get-package-features
                            (el-get-elpa-package-directory 'el-get)))))
                      (el-get-elpa-delete-package 'el-get)
                      (dolist
                          (feat feats)
                        (unload-feature feat t))))
                  (require 'el-get))))
 (emacs-async status "installed" recipe
              (:name emacs-async :description "Simple library for asynchronous processing in Emacs" :type github :pkgname "jwiegley/emacs-async"))
 (emacs-gdb status "installed" recipe
            (:name emacs-gdb :type github :pkgname "weirdNox/emacs-gdb" :depends hydra :after
                   (progn
                     (fmakunbound 'gdb)
                     (fmakunbound 'gdb-enable-debug))))
 (emacs-w3m status "installed" recipe
            (:name emacs-w3m :description "A simple Emacs interface to w3m" :type cvs :website "http://emacs-w3m.namazu.org/" :module "emacs-w3m" :url ":pserver:anonymous@cvs.namazu.org:/storage/cvsroot" :build
                   `(("autoconf")
                     ("./configure" ,(format "--with-emacs=%s" el-get-emacs))
                     ("make"))
                   :build/windows-nt
                   (("sh" "./autogen.sh")
                    ("sh" "./configure")
                    ("make"))
                   :info "doc"))
 (epl status "installed" recipe
      (:name epl :description "EPL provides a convenient high-level API for various package.el versions, and aims to overcome its most striking idiocies." :type github :pkgname "cask/epl"))
 (erc status "installed" recipe
      (:name erc :type builtin))
 (erc-nick-notify status "installed" recipe
                  (:name erc-nick-notify :auto-generated t :type emacswiki :description "Notify popup for ERC" :website "https://raw.github.com/emacsmirror/emacswiki.org/master/erc-nick-notify.el"))
 (etags-select status "installed" recipe
               (:name etags-select :description "Select from multiple tags" :type http :url "http://www.emacswiki.org/cgi-bin/wiki/download/etags-select.el" :features etags-select :after
                      (progn
                        (add-hook 'c-mode-common-hook
                                  (lambda nil
                                    (local-set-key
                                     (kbd "M-.")
                                     'etags-select-find-tag-at-point)))
                        (setq etags-select-go-if-unambiguous t)
                        (setq etags-select-use-short-name-completion t))))
 (expand-region status "installed" recipe
                (:name expand-region :after
                       (global-set-key "\357" 'er/expand-region)
                       :type github :pkgname "magnars/expand-region.el" :description "Expand region increases the selected region by semantic units. Just keep pressing the key until it selects what you want." :website "https://github.com/magnars/expand-region.el#readme"))
 (f status "installed" recipe
    (:name f :website "https://github.com/rejeep/f.el" :description "Modern API for working with files and directories in Emacs" :depends
           (s dash)
           :type github :pkgname "rejeep/f.el"))
 (filecache status "installed" recipe
            (:name filecache :type builtin))
 (files status "installed" recipe
        (:name files :type builtin))
 (flycheck status "installed" recipe
           (:name flycheck :type github :pkgname "flycheck/flycheck" :description "On-the-fly syntax checking extension" :build
                  '(("makeinfo" "-o" "doc/flycheck.info" "doc/flycheck.texi"))
                  :info "./doc" :depends
                  (dash pkg-info let-alist cl-lib)))
 (fuzzy status "installed" recipe
        (:name fuzzy :website "https://github.com/auto-complete/fuzzy-el" :description "Fuzzy matching utilities for GNU Emacs" :type github :pkgname "auto-complete/fuzzy-el"))
 (generic status "installed" recipe
          (:name generic :type builtin))
 (ghub status "installed" recipe
       (:name ghub :type github :description "Minuscule client for the Github API" :pkgname "magit/ghub" :depends
              (graphql treepy)))
 (git-gutter status "installed" recipe
             (:name git-gutter :after
                    (global-git-gutter-mode 1)
                    :description "Emacs port of GitGutter Sublime Text 2 Plugin" :website "https://github.com/syohex/emacs-git-gutter" :type github :pkgname "syohex/emacs-git-gutter"))
 (git-modes status "installed" recipe
            (:name git-modes :description "GNU Emacs modes for various Git-related files" :type github :pkgname "magit/git-modes"))
 (git-timemachine status "installed" recipe
                  (:name git-timemachine :description "Step through historic versions of git controlled file using everyone's favourite editor" :type github :minimum-emacs-version "24.3" :pkgname "pidu/git-timemachine"))
 (graphql status "installed" recipe
          (:name graphql :description "GraphQL.el provides a set of generic functions for interacting with GraphQL web services." :type github :pkgname "vermiculus/graphql.el"))
 (graphviz-dot-mode status "installed" recipe
                    (:name graphviz-dot-mode :description "graphviz dot language mode" :type github :pkgname "ppareit/graphviz-dot-mode"))
 (groovy-emacs-mode status "installed" recipe
                    (:name groovy-emacs-mode :description "A groovy major mode, grails minor mode, and a groovy inferior mode." :type github :pkgname "Groovy-Emacs-Modes/groovy-emacs-modes" :depends
                           (s)))
 (guide-key status "installed" recipe
            (:name guide-key :description "Guide the following key bindings automatically and dynamically." :type github :pkgname "kbkbkbkb1/guide-key" :depends
                   (popwin)))
 (ht status "installed" recipe
     (:name ht :website "https://github.com/Wilfred/ht.el" :description "The missing hash table utility library for Emacs." :type github :pkgname "Wilfred/ht.el"))
 (http-post-simple status "installed" recipe
                   (:name http-post-simple :type http :url "http://www.emacswiki.org/emacs/download/http-post-simple.el" :features http-post-simple))
 (hydra status "installed" recipe
        (:name hydra :description "make Emacs bindings that stick around" :type github :depends
               (cl-lib)
               :pkgname "abo-abo/hydra"))
 (idle-highlight-mode status "installed" recipe
                      (:name idle-highlight-mode :description "Idle Highlight Mode." :website "https://github.com/nonsequitur/idle-highlight-mode" :type github :pkgname "nonsequitur/idle-highlight-mode"))
 (json-mode status "installed" recipe
            (:name json-mode :description "Major mode for editing JSON files, extends the builtin js-mode to add better syntax highlighting for JSON." :type github :pkgname "joshwnj/json-mode"))
 (json-snatcher status "installed" recipe
                (:name json-snatcher :description "Find the path to a value in JSON" :type github :pkgname "Sterlingg/json-snatcher"))
 (language-detection status "installed" recipe
                     (:name language-detection :type github :pkgname "andreasjansson/language-detection.el"))
 (let-alist status "installed" recipe
            (:name let-alist :description "Easily let-bind values of an assoc-list by their names." :builtin "25.1" :type http :url "http://git.savannah.gnu.org/cgit/emacs.git/plain/lisp/emacs-lisp/let-alist.el"))
 (levenshtein status "installed" recipe
              (:name levenshtein :type http :url "http://www.emacswiki.org/emacs/download/levenshtein.el"))
 (llvm-mode status "installed" recipe
            (:name llvm-mode :description "Major mode for the LLVM assembler language." :website "http://llvm.org/" :type http :url "http://llvm.org/viewvc/llvm-project/llvm/trunk/utils/emacs/llvm-mode.el?view=co" :build
                   (("mv" "llvm-mode.el_view_co" "llvm-mode.el"))
                   :prepare
                   (progn
                     (autoload 'llvm-mode "llvm-mode" "LLVM assembler language editing mode." t)
                     (add-to-list 'auto-mode-alist
                                  '("\\.ll\\'" . llvm-mode)))))
 (lsp-ivy status "installed" recipe
          (:name lsp-ivy :type github :pkgname "emacs-lsp/lsp-ivy" :depends lsp-mode))
 (lsp-mode status "installed" recipe
           (:name lsp-mode :website "https://github.com/emacs-lsp/lsp-mode" :description "Emacs client/library for the Language Server Protocol" :depends
                  (dash f ht spinner)
                  :type github :pkgname "emacs-lsp/lsp-mode"))
 (lsp-ui status "installed" recipe
         (:name lsp-ui :depends
                (lsp-mode)
                :description "Contains all the higher level UI modules of lsp-mode, like flycheck support and code lenses." :type github :pkgname "emacs-lsp/lsp-ui"))
 (macrostep status "installed" recipe
            (:name macrostep :website "https://github.com/joddie/macrostep" :description "Interactive macro stepper for Emacs Lisp" :type github :pkgname "joddie/macrostep"))
 (magit status "installed" recipe
        (:name magit :depends
               (dash ghub graphql magit-popup treepy with-editor)
               :after
               (progn
                 (when work-win
                   (setq magit-git-executable "C:/Program Files (x86)/SmartGit/git/bin/git.exe"))
                 (global-set-key
                  (kbd "C-c C-z")
                  'magit-status))
               :website "https://github.com/magit/magit#readme" :description "It's Magit! An Emacs mode for Git." :type github :pkgname "magit/magit" :branch "master" :minimum-emacs-version "24.4" :info "Documentation" :load-path "lisp/" :compile "lisp/" :build
               `(("make" ,(format "EMACSBIN=%s" el-get-emacs)
                  "docs")
                 ("touch" "lisp/magit-autoloads.el"))
               :build/berkeley-unix
               `(("gmake" ,(format "EMACSBIN=%s" el-get-emacs)
                  "docs")
                 ("touch" "lisp/magit-autoloads.el"))
               :build/windows-nt
               (with-temp-file "lisp/magit-autoloads.el" nil)))
 (magit-popup status "installed" recipe
              (:name magit-popup :website "https://github.com/magit/magit-popup" :description "Define prefix-infix-suffix command combos" :type github :pkgname "magit/magit-popup" :depends
                     (emacs-async dash)))
 (markdown-mode status "installed" recipe
                (:name markdown-mode :description "Major mode to edit Markdown files in Emacs" :website "http://jblevins.org/projects/markdown-mode/" :type git :url "git://jblevins.org/git/markdown-mode.git" :prepare
                       (add-to-list 'auto-mode-alist
                                    '("\\.\\(md\\|mdown\\|markdown\\)\\'" . markdown-mode))))
 (mo-git-blame status "installed" recipe
               (:name mo-git-blame :after
                      (global-set-key
                       (kbd "C-x v g")
                       'mo-git-blame-current)
                      :description "An interactive, iterative 'git blame' mode for Emacs" :type github :pkgname "mbunkus/mo-git-blame" :features "mo-git-blame"))
 (mu4e status "installed" recipe
       (:name mu4e :depends
              (alert ht)
              :website "http://www.djcbsoftware.nl/code/mu/mu4e.html" :description "An emacs-based e-mail client which uses mu (http://www.djcbsoftware.nl/code/mu/) as its back-end: mu4e." :type github :pkgname "djcb/mu" :post-init
              (setq mu4e-mu-binary
                    (expand-file-name "mu"
                                      (expand-file-name "mu"
                                                        (el-get-package-directory 'mu4e))))
              :build
              `(("autoreconf" "-i")
                ("./configure")
                ("make"))
              :load-path "mu4e" :info "mu4e/mu4e.info"))
 (mu4e-alert status "installed" recipe
             (:name mu4e-alert :description "Desktop notification and mode-line display for mu4e." :type github :depends
                    (mu4e alert s)
                    :pkgname "iqbalansari/mu4e-alert"))
 (multiple-cursors status "installed" recipe
                   (:name multiple-cursors :after
                          (progn
                            (global-set-key
                             (kbd "C-c C-n")
                             'mc/mark-next-like-this)
                            (global-set-key
                             (kbd "C-c C-p")
                             'mc/mark-previous-like-this)
                            (global-set-key
                             (kbd "C-c C-a")
                             'mc/mark-all-like-this-in-defun)
                            (global-set-key
                             (kbd "C-c C-|")
                             'mc/edit-lines))
                          :description "An experiment in adding multiple cursors to emacs" :type github :pkgname "magnars/multiple-cursors.el"))
 (org-mode status "installed" recipe
           (:name org-mode :branch "maint" :website "http://orgmode.org/" :description "Org-mode is for keeping notes, maintaining ToDo lists, doing project planning, and authoring with a fast and effective plain-text system." :type git :url "git://orgmode.org/org-mode.git" :info "doc" :build/berkeley-unix `,(mapcar
                                                                                                                                                                                                                                                                                                                       (lambda
                                                                                                                                                                                                                                                                                                                         (target)
                                                                                                                                                                                                                                                                                                                         (list "gmake" target
                                                                                                                                                                                                                                                                                                                               (concat "EMACS="
                                                                                                                                                                                                                                                                                                                                       (shell-quote-argument el-get-emacs))))
                                                                                                                                                                                                                                                                                                                       '("oldorg"))
                  :build `,(mapcar
                            (lambda
                              (target)
                              (list "make" target
                                    (concat "EMACS="
                                            (shell-quote-argument el-get-emacs))))
                            '("oldorg"))
                  :load-path
                  ("." "contrib/lisp" "lisp")
                  :load
                  ("lisp/org-loaddefs.el")))
 (org-toodledo status "installed" recipe
               (:name org-toodledo :type github :pkgname "christopherjwhite/org-toodledo" :features org-toodledo :depends
                      (org-mode http-post-simple)))
 (ox-jira status "installed" recipe
          (:name ox-jira :type github :pkgname "stig/ox-jira.el"))
 (ox-pandoc status "installed" recipe
            (:name ox-pandoc :description "Another org-mode exporter via pandoc." :website "https://github.com/kawabata/ox-pandoc/" :type github :minimum-emacs-version "24.3" :pkgname "kawabata/ox-pandoc"))
 (package status "installed" recipe
          (:name package :description "ELPA implementation (\"package.el\") from Emacs 24" :builtin "24" :type http :url "http://repo.or.cz/w/emacs.git/blob_plain/1a0a666f941c99882093d7bd08ced15033bc3f0c:/lisp/emacs-lisp/package.el" :shallow nil :features package :post-init
                 (progn
                   (let
                       ((old-package-user-dir
                         (expand-file-name
                          (convert-standard-filename
                           (concat
                            (file-name-as-directory default-directory)
                            "elpa")))))
                     (when
                         (file-directory-p old-package-user-dir)
                       (add-to-list 'package-directory-list old-package-user-dir)))
                   (setq package-archives
                         (bound-and-true-p package-archives))
                   (mapc
                    (lambda
                      (pa)
                      (add-to-list 'package-archives pa 'append))
                    '(("ELPA" . "http://tromey.com/elpa/")
                      ("melpa" . "https://melpa.org/packages/")
                      ("gnu" . "http://elpa.gnu.org/packages/")
                      ("SC" . "http://joseito.republika.pl/sunrise-commander/"))))))
 (packed status "installed" recipe
         (:name packed :type github :pkgname "tarsius/packed" :description "Package manager agnostic Emacs Lisp package utilities"))
 (password-cache status "installed" recipe
                 (:name password-cache :type builtin))
 (php-mode-improved status "installed" recipe
                    (:name php-mode-improved :type http :url "http://www.emacswiki.org/cgi-bin/wiki/download/php-mode-improved.el" :after
                           (add-to-list 'auto-mode-alist
                                        '("\\.php$" . php-mode))))
 (pkg-info status "installed" recipe
           (:name pkg-info :description "Provide information about Emacs packages." :type github :pkgname "lunaryorn/pkg-info.el" :depends
                  (dash epl)))
 (popup status "installed" recipe
        (:name popup :website "https://github.com/auto-complete/popup-el" :description "Visual Popup Interface Library for Emacs" :type github :submodule nil :depends cl-lib :pkgname "auto-complete/popup-el"))
 (popwin status "installed" recipe
         (:name popwin :description "Popup Window Manager." :website "https://github.com/m2ym/popwin-el" :type github :pkgname "m2ym/popwin-el" :load-path
                ("." "misc")))
 (rainbow-delimiters status "installed" recipe
                     (:name rainbow-delimiters :website "https://github.com/Fanael/rainbow-delimiters#readme" :description "Color nested parentheses, brackets, and braces according to their depth." :type github :pkgname "Fanael/rainbow-delimiters"))
 (request status "installed" recipe
          (:name request :description "Easy HTTP request for Emacs Lisp" :type github :submodule nil :pkgname "tkf/emacs-request"))
 (restclient status "installed" recipe
             (:name restclient :type github :pkgname "pashky/restclient.el"))
 (rtags status "installed" recipe
        (:name rtags :after
               (progn
                 (setq rtags-autostart-diagnostics t)
                 (setq rtags-enable-unsaved-reparsing nil)
                 (setq rtags-jump-to-first-match nil)
                 (setq rtags-path "/usr/local/bin")
                 (setq rtags-process-flags "--rp-daemon 1")
                 (setq rtags-rc-log-enabled t)
                 (setq rtags-reparse-timeout 1000)
                 (setq rtags-timeout 2000)
                 (rtags-diagnostics)
                 (setq rtags-completions-enabled t)
                 (setq rtags-suspend-during-compilation t)
                 (rtags-start-process-unless-running)
                 (add-hook 'kill-emacs-hook 'rtags-quit-rdm))
               :description "Client/server application that indexes C/C++ code and keeps a persistent in-memory database of references, declarations, definitions, symbolnames\n\nSet `el-get-rtags-no-build-clang' to non-nil before\ninstall/update in order to avoid building clang.\n" :type github :website "https://github.com/Andersbakken/rtags" :pkgname "Andersbakken/rtags" :build
               `(("cmake" ,@(if
                                (bound-and-true-p el-get-rtags-no-build-clang)
                                '("-DRTAGS_NO_BUILD_CLANG=1"))
                  ".")
                 ("make" ,@el-get-parallel-make-args))
               :compile "src" :load-path "src" :post-init
               (setq rtags-path
                     (concat default-directory "/bin/"))))
 (s status "installed" recipe
    (:name s :description "The long lost Emacs string manipulation library." :type github :pkgname "magnars/s.el"))
 (seq status "installed" recipe
      (:name seq :description "Sequence manipulation library for Emacs" :builtin "25" :type github :pkgname "NicolasPetton/seq.el"))
 (skeleton status "installed" recipe
           (:name skeleton :type builtin))
 (smartscan status "installed" recipe
            (:name smartscan :after
                   (global-smartscan-mode 1)
                   :description "Jumps between other symbols found at point in Emacs" :type github :pkgname "mickeynp/smart-scan"))
 (smerge-mode status "installed" recipe
              (:name smerge-mode :type builtin :after
                     (add-hook 'c-mode-common-hook 'smerge-start-session)))
 (smex status "installed" recipe
       (:name smex :description "M-x interface with Ido-style fuzzy matching." :type github :pkgname "nonsequitur/smex" :features smex :post-init
              (smex-initialize)
              :after
              (global-set-key
               (kbd "M-x")
               'smex)))
 (soap-client status "installed" recipe
              (:name soap-client :description "Access SOAP web services." :type github :pkgname "alex-hhh/emacs-soap-client"))
 (spinner status "installed" recipe
          (:name spinner :description "Emacs mode-line spinner for operations in progress." :type github :pkgname "Bruce-Connor/spinner.el"))
 (subword status "installed" recipe
          (:name subword :type builtin :after
                 (add-hook 'prog-mode-hook
                           (lambda nil
                             (local-set-key
                              (kbd "M-<left>")
                              'subword-backward)
                             (local-set-key
                              (kbd "M-<right>")
                              'subword-forward)
                             (subword-mode t)))))
 (swiper status "installed" recipe
         (:name swiper :after
                (progn
                  (ivy-mode 1)
                  (setq ivy-set-virtual-buffers t)
                  (setq ivy-count-format "(%d/%d)")
                  (setq ivy-re-builders-alist
                        '((t . ivy--regex-ignore-order)))
                  (add-to-list 'ivy-completing-read-handlers-alist
                               '(find-file . completing-read-default))
                  (add-to-list 'ivy-completing-read-handlers-alist
                               '(grep-read-files . completing-read-default)))
                :description "Gives you an overview as you search for a regex." :type github :depends
                (cl-lib)
                :pkgname "abo-abo/swiper" :build
                `(("make" ,(format "emacs=%s" el-get-emacs)
                   "compile")
                  ("makeinfo" "-o" "doc/ivy.info" "doc/ivy.texi"))
                :build/berkeley-unix
                `(("gmake" ,(format "emacs=%s" el-get-emacs)
                   "compile")
                  ("gmakeinfo" "-o" "doc/ivy.info" "doc/ivy.texi"))
                :info "doc/ivy.info"))
 (tempo status "installed" recipe
        (:name tempo :type builtin :features tempo))
 (tempo-snippets status "installed" recipe
                 (:name tempo-snippets :type http :url "http://nschum.de/src/emacs/tempo-snippets/tempo-snippets.el"))
 (treepy status "installed" recipe
         (:name treepy :description "A set of generic functions for traversing tree-like data structures recursively and/or iteratively." :type github :pkgname "volrath/treepy.el"))
 (uniquify status "installed" recipe
           (:name uniquify :type builtin :features uniquify :after
                  (setq uniquify-buffer-name-style 'post-forward-angle-brackets)))
 (url-http-ntlm status "installed" recipe
                (:name url-http-ntlm :description "NTLM authentication for the url library." :type elpa))
 (uuid status "installed" recipe
       (:name uuid :type http :url "http://www.emacswiki.org/cgi-bin/wiki/download/uuid.el"))
 (visual-regexp status "installed" recipe
                (:name visual-regexp :after
                       (progn
                         (global-set-key
                          (kbd "M-%")
                          'vr/query-replace)
                         (global-set-key
                          (kbd "C-M-%")
                          'vr/replace))
                       :description "A regexp/replace command for Emacs with\n       interactive visual feedback" :type github :depends cl-lib :pkgname "benma/visual-regexp.el"))
 (visual-regexp-steroids status "installed" recipe
                         (:name visual-regexp-steroids :description "An extension to visual-regexp-steroids which enables\nthe use of modern regexp engines" :type github :depends visual-regexp :pkgname "benma/visual-regexp-steroids.el"))
 (wgrep status "installed" recipe
        (:name wgrep :description "Writable grep buffer and apply the changes to files" :type github :pkgname "mhayashi1120/Emacs-wgrep"))
 (with-editor status "installed" recipe
   (:name with-editor :description "Use the Emacsclient as $EDITOR" :type github :pkgname "magit/with-editor"))
 (yaml-mode status "installed" recipe
            (:name yaml-mode :description "Simple major mode to edit YAML file for emacs" :type github :pkgname "yoshiki/yaml-mode")))
