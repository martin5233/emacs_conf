;;; .loaddefs.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads nil "ace-window/ace-window" "ace-window/ace-window.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ace-window/ace-window.el

(autoload 'ace-select-window "ace-window/ace-window" "\
Ace select window." t nil)

(autoload 'ace-delete-window "ace-window/ace-window" "\
Ace delete window." t nil)

(autoload 'ace-swap-window "ace-window/ace-window" "\
Ace swap window." t nil)

(autoload 'ace-delete-other-windows "ace-window/ace-window" "\
Ace delete other windows." t nil)

(autoload 'ace-display-buffer "ace-window/ace-window" "\
Make `display-buffer' and `pop-to-buffer' select using `ace-window'.
See sample config for `display-buffer-base-action' and `display-buffer-alist':
https://github.com/abo-abo/ace-window/wiki/display-buffer.

\(fn BUFFER ALIST)" nil nil)

(autoload 'ace-window "ace-window/ace-window" "\
Select a window.
Perform an action based on ARG described below.

By default, behaves like extended `other-window'.
See `aw-scope' which extends it to work with frames.

Prefixed with one \\[universal-argument], does a swap between the
selected window and the current window, so that the selected
buffer moves to current window (and current buffer moves to
selected window).

Prefixed with two \\[universal-argument]'s, deletes the selected
window.

\(fn ARG)" t nil)

(defvar ace-window-display-mode nil "\
Non-nil if Ace-Window-Display mode is enabled.
See the `ace-window-display-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `ace-window-display-mode'.")

(custom-autoload 'ace-window-display-mode "ace-window/ace-window" nil)

(autoload 'ace-window-display-mode "ace-window/ace-window" "\
Minor mode for showing the ace window key in the mode line.

If called interactively, enable Ace-Window-Display mode if ARG is
positive, and disable it if ARG is zero or negative.  If called
from Lisp, also enable the mode if ARG is omitted or nil, and
toggle it if ARG is `toggle'; disable the mode otherwise.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "ace-window/ace-window" '("ace-window-mode" "aw-")))

;;;***

;;;### (autoloads nil "alert/alert" "alert/alert.el" (0 0 0 0))
;;; Generated autoloads from alert/alert.el

(autoload 'alert-add-rule "alert/alert" "\
Programmatically add an alert configuration rule.

Normally, users should custoimze `alert-user-configuration'.
This facility is for module writers and users that need to do
things the Lisp way.

Here is a rule the author currently uses with ERC, so that the
fringe gets colored whenever people chat on BitlBee:

\(alert-add-rule :status   \\='(buried visible idle)
                :severity \\='(moderate high urgent)
                :mode     \\='erc-mode
                :predicate
                #\\='(lambda (info)
                    (string-match (concat \"\\\\`[^&].*@BitlBee\\\\\\='\")
                                  (erc-format-target-and/or-network)))
                :persistent
                #\\='(lambda (info)
                    ;; If the buffer is buried, or the user has been
                    ;; idle for `alert-reveal-idle-time' seconds,
                    ;; make this alert persistent.  Normally, alerts
                    ;; become persistent after
                    ;; `alert-persist-idle-time' seconds.
                    (memq (plist-get info :status) \\='(buried idle)))
                :style \\='fringe
                :continue t)

\(fn &key SEVERITY STATUS MODE CATEGORY TITLE MESSAGE PREDICATE ICON (STYLE alert-default-style) PERSISTENT CONTINUE NEVER-PERSIST APPEND)" nil nil)

(autoload 'alert "alert/alert" "\
Alert the user that something has happened.
MESSAGE is what the user will see.  You may also use keyword
arguments to specify additional details.  Here is a full example:

\(alert \"This is a message\"
       :severity \\='high          ;; The default severity is `normal'
       :title \"Title\"           ;; An optional title
       :category \\='example       ;; A symbol to identify the message
       :mode \\='text-mode         ;; Normally determined automatically
       :buffer (current-buffer) ;; This is the default
       :data nil                ;; Unused by alert.el itself
       :persistent nil          ;; Force the alert to be persistent;
                                ;; it is best not to use this
       :never-persist nil       ;; Force this alert to never persist
       :id \\='my-id)              ;; Used to replace previous message of
                                ;; the same id in styles that support it
       :style \\='fringe)          ;; Force a given style to be used;
                                ;; this is only for debugging!

If no :title is given, the buffer-name of :buffer is used.  If
:buffer is nil, it is the current buffer at the point of call.

:data is an opaque value which modules can pass through to their
own styles if they wish.

Here are some more typical examples of usage:

  ;; This is the most basic form usage
  (alert \"This is an alert\")

  ;; You can adjust the severity for more important messages
  (alert \"This is an alert\" :severity \\='high)

  ;; Or decrease it for purely informative ones
  (alert \"This is an alert\" :severity \\='trivial)

  ;; Alerts can have optional titles.  Otherwise, the title is the
  ;; buffer-name of the (current-buffer) where the alert originated.
  (alert \"This is an alert\" :title \"My Alert\")

  ;; Further, alerts can have categories.  This allows users to
  ;; selectively filter on them.
  (alert \"This is an alert\" :title \"My Alert\"
         :category \\='some-category-or-other)

\(fn MESSAGE &key (SEVERITY \\='normal) TITLE ICON CATEGORY BUFFER MODE DATA STYLE PERSISTENT NEVER-PERSIST ID)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "alert/alert" '("alert-" "x-urgen")))

;;;***

;;;### (autoloads nil "ascii-table/ascii-table" "ascii-table/ascii-table.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ascii-table/ascii-table.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "ascii-table/ascii-table" '("ascii-table")))

;;;***

;;;### (autoloads nil "auto-compile/auto-compile" "auto-compile/auto-compile.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from auto-compile/auto-compile.el

(autoload 'auto-compile-mode "auto-compile/auto-compile" "\
Compile Emacs Lisp source files after the visiting buffers are saved.

If called interactively, enable Auto-Compile mode if ARG is
positive, and disable it if ARG is zero or negative.  If called
from Lisp, also enable the mode if ARG is omitted or nil, and
toggle it if ARG is `toggle'; disable the mode otherwise.

After a buffer containing Emacs Lisp code is saved to its source
file update the respective byte code file.  If the latter does
not exist do nothing.  Therefore to disable automatic compilation
remove the byte code file.  See command `toggle-auto-compile' for
a convenient way to do so.

This mode should be enabled globally, using it's globalized
variant `auto-compile-on-save-mode'.  Also see the related
`auto-compile-on-load-mode'.

\(fn &optional ARG)" t nil)

(put 'auto-compile-on-save-mode 'globalized-minor-mode t)

(defvar auto-compile-on-save-mode nil "\
Non-nil if Auto-Compile-On-Save mode is enabled.
See the `auto-compile-on-save-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `auto-compile-on-save-mode'.")

(custom-autoload 'auto-compile-on-save-mode "auto-compile/auto-compile" nil)

(autoload 'auto-compile-on-save-mode "auto-compile/auto-compile" "\
Toggle Auto-Compile mode in all buffers.
With prefix ARG, enable Auto-Compile-On-Save mode if ARG is positive;
otherwise, disable it.  If called from Lisp, enable the mode if
ARG is omitted or nil.

Auto-Compile mode is enabled in all buffers where
`turn-on-auto-compile-mode' would do it.
See `auto-compile-mode' for more information on Auto-Compile mode.

\(fn &optional ARG)" t nil)

(autoload 'toggle-auto-compile "auto-compile/auto-compile" "\
Toggle automatic compilation of an Emacs Lisp source file or files.

Read a file or directory name from the minibuffer defaulting to
the visited Emacs Lisp source file or `default-directory' if no
such file is being visited in the current buffer.

If the user selects a file then automatic compilation of only
that file is toggled.  Since both `auto-compile-on-save' and
`auto-compile-on-save' only ever _recompile_ byte code files,
toggling automatic compilation is done simply by creating or
removing the respective byte code file.

If the user selects a directory then automatic compilation for
multiple files is toggled as follows:

* With a positive prefix argument always compile source files;
  with a negative prefix argument always remove byte code files.

* Otherwise the existence or absence of the byte code file of
  the source file that was current when this command was invoked
  determines whether byte code files should be created or removed.

* If no Emacs Lisp source file is being visited in the buffer
  that was current when the command was invoked ask the user what
  to do.

* When _removing_ byte code files then all byte code files are
  removed.  If `auto-compile-deletes-stray-dest' is non-nil this
  even includes byte code files for which no source file exists.

* When _creating_ byte code files only do so for source files
  that are actual libraries.  Source files that provide the
  correct feature are considered to be libraries; see
  `packed-library-p'.

* Note that non-libraries can still be automatically compiled,
  you just cannot _recursively_ turn on automatic compilation
  using this command.

* When `auto-compile-toggle-recompiles' is non-nil recompile all
  affected source files even when the respective source files are
  up-to-date.  Do so even for non-library source files.

* Only enter subdirectories for which `packed-ignore-directory-p'
  returns nil; i.e. don't enter hidden directories or directories
  containing a file named \".nosearch\".

\(fn FILE ACTION)" t nil)

(defvar auto-compile-on-load-mode nil "\
Non-nil if Auto-Compile-On-Load mode is enabled.
See the `auto-compile-on-load-mode' command
for a description of this minor mode.")

(custom-autoload 'auto-compile-on-load-mode "auto-compile/auto-compile" nil)

(autoload 'auto-compile-on-load-mode "auto-compile/auto-compile" "\
Before loading a library recompile it if it needs recompilation.

If called interactively, enable Auto-Compile-On-Load mode if ARG
is positive, and disable it if ARG is zero or negative.  If
called from Lisp, also enable the mode if ARG is omitted or nil,
and toggle it if ARG is `toggle'; disable the mode otherwise.

A library needs to be recompiled if the source file is newer than
it's byte-compile destination.  Without this advice the outdated
byte code file would be loaded instead.

Also see the related `auto-compile-on-save-mode'.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "auto-compile/auto-compile" '("auto-compile-" "byte-compile-log-warning" "load" "mode-line-" "require" "save-buffers-kill-" "turn-on-auto-compile-mode")))

;;;***

;;;### (autoloads nil "browse-kill-ring/browse-kill-ring" "browse-kill-ring/browse-kill-ring.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from browse-kill-ring/browse-kill-ring.el

(autoload 'browse-kill-ring-default-keybindings "browse-kill-ring/browse-kill-ring" "\
Set up M-y (`yank-pop') so that it can invoke `browse-kill-ring'.
Normally, if M-y was not preceeded by C-y, then it has no useful
behavior.  This function sets things up so that M-y will invoke
`browse-kill-ring'." t nil)

(autoload 'browse-kill-ring "browse-kill-ring/browse-kill-ring" "\
Display items in the `kill-ring' in another buffer." t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "browse-kill-ring/browse-kill-ring" '("browse-kill-ring-")))

;;;***

;;;### (autoloads nil "cmake-mode/cmake-mode" "cmake-mode/cmake-mode.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from cmake-mode/cmake-mode.el

(autoload 'cmake-mode "cmake-mode/cmake-mode" "\
Major mode for editing CMake source files.

\(fn)" t nil)

(autoload 'cmake-command-run "cmake-mode/cmake-mode" "\
Runs the command cmake with the arguments specified.  The
optional argument topic will be appended to the argument list.

\(fn TYPE &optional TOPIC BUFFER)" t nil)

(autoload 'cmake-help-list-commands "cmake-mode/cmake-mode" "\
Prints out a list of the cmake commands." t nil)

(autoload 'cmake-help-command "cmake-mode/cmake-mode" "\
Prints out the help message for the command the cursor is on." t nil)

(autoload 'cmake-help-module "cmake-mode/cmake-mode" "\
Prints out the help message for the module the cursor is on." t nil)

(autoload 'cmake-help-variable "cmake-mode/cmake-mode" "\
Prints out the help message for the variable the cursor is on." t nil)

(autoload 'cmake-help-property "cmake-mode/cmake-mode" "\
Prints out the help message for the property the cursor is on." t nil)

(autoload 'cmake-help "cmake-mode/cmake-mode" "\
Queries for any of the four available help topics and prints out the appropriate page." t nil)

(add-to-list 'auto-mode-alist '("CMakeLists\\.txt\\'" . cmake-mode))

(add-to-list 'auto-mode-alist '("\\.cmake\\'" . cmake-mode))

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "cmake-mode/cmake-mode" '("cmake-")))

;;;***

;;;### (autoloads nil "company-mode/company" "company-mode/company.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from company-mode/company.el

(autoload 'company-mode "company-mode/company" "\
\"complete anything\"; is an in-buffer completion framework.
Completion starts automatically, depending on the values
`company-idle-delay' and `company-minimum-prefix-length'.

Completion can be controlled with the commands:
`company-complete-common', `company-complete-selection', `company-complete',
`company-select-next', `company-select-previous'.  If these commands are
called before `company-idle-delay', completion will also start.

Completions can be searched with `company-search-candidates' or
`company-filter-candidates'.  These can be used while completion is
inactive, as well.

The completion data is retrieved using `company-backends' and displayed
using `company-frontends'.  If you want to start a specific backend, call
it interactively or use `company-begin-backend'.

By default, the completions list is sorted alphabetically, unless the
backend chooses otherwise, or `company-transformers' changes it later.

regular keymap (`company-mode-map'):

\\{company-mode-map}
keymap during active completions (`company-active-map'):

\\{company-active-map}

\(fn &optional ARG)" t nil)

(defvar global-company-mode nil "\
Non-nil if Global Company mode is enabled.
See the `global-company-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `global-company-mode'.")

(custom-autoload 'global-company-mode "company-mode/company" nil)

(autoload 'global-company-mode "company-mode/company" "\
Toggle Company mode in all buffers.
With prefix ARG, enable Global Company mode if ARG is positive;
otherwise, disable it.  If called from Lisp, enable the mode if
ARG is omitted or nil.

Company mode is enabled in all buffers where
`company-mode-on' would do it.
See `company-mode' for more information on Company mode.

\(fn &optional ARG)" t nil)

(autoload 'company-manual-begin "company-mode/company" "\


\(fn)" t nil)

(autoload 'company-complete "company-mode/company" "\
Insert the common part of all candidates or the current selection.
The first time this is called, the common part is inserted, the second
time, or when the selection has been changed, the selected candidate is
inserted.

\(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "company-mode/company" '("company-")))

;;;***

;;;### (autoloads nil "company-mode/company-abbrev" "company-mode/company-abbrev.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from company-mode/company-abbrev.el

(autoload 'company-abbrev "company-mode/company-abbrev" "\
`company-mode' completion backend for abbrev.

\(fn COMMAND &optional ARG &rest IGNORED)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "company-mode/company-abbrev" '("company-abbrev-insert")))

;;;***

;;;### (autoloads nil "company-mode/company-bbdb" "company-mode/company-bbdb.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from company-mode/company-bbdb.el

(autoload 'company-bbdb "company-mode/company-bbdb" "\
`company-mode' completion backend for BBDB.

\(fn COMMAND &optional ARG &rest IGNORE)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "company-mode/company-bbdb" '("company-bbdb-")))

;;;***

;;;### (autoloads nil "company-mode/company-capf" "company-mode/company-capf.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from company-mode/company-capf.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "company-mode/company-capf" '("company-")))

;;;***

;;;### (autoloads nil "company-mode/company-clang" "company-mode/company-clang.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from company-mode/company-clang.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "company-mode/company-clang" '("company-clang")))

;;;***

;;;### (autoloads nil "company-mode/company-cmake" "company-mode/company-cmake.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from company-mode/company-cmake.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "company-mode/company-cmake" '("company-cmake")))

;;;***

;;;### (autoloads nil "company-mode/company-css" "company-mode/company-css.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from company-mode/company-css.el

(autoload 'company-css "company-mode/company-css" "\
`company-mode' completion backend for `css-mode'.

\(fn COMMAND &optional ARG &rest IGNORED)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "company-mode/company-css" '("company-css-")))

;;;***

;;;### (autoloads nil "company-mode/company-dabbrev" "company-mode/company-dabbrev.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from company-mode/company-dabbrev.el

(autoload 'company-dabbrev "company-mode/company-dabbrev" "\
dabbrev-like `company-mode' completion backend.

\(fn COMMAND &optional ARG &rest IGNORED)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "company-mode/company-dabbrev" '("company-dabbrev-")))

;;;***

;;;### (autoloads nil "company-mode/company-dabbrev-code" "company-mode/company-dabbrev-code.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from company-mode/company-dabbrev-code.el

(autoload 'company-dabbrev-code "company-mode/company-dabbrev-code" "\
dabbrev-like `company-mode' backend for code.
The backend looks for all symbols in the current buffer that aren't in
comments or strings.

\(fn COMMAND &optional ARG &rest IGNORED)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "company-mode/company-dabbrev-code" '("company-dabbrev-code-")))

;;;***

;;;### (autoloads nil "company-mode/company-elisp" "company-mode/company-elisp.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from company-mode/company-elisp.el

(autoload 'company-elisp "company-mode/company-elisp" "\
`company-mode' completion backend for Emacs Lisp.

\(fn COMMAND &optional ARG &rest IGNORED)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "company-mode/company-elisp" '("company-elisp-")))

;;;***

;;;### (autoloads nil "company-mode/company-etags" "company-mode/company-etags.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from company-mode/company-etags.el

(autoload 'company-etags "company-mode/company-etags" "\
`company-mode' completion backend for etags.

\(fn COMMAND &optional ARG &rest IGNORED)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "company-mode/company-etags" '("company-etags-")))

;;;***

;;;### (autoloads nil "company-mode/company-files" "company-mode/company-files.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from company-mode/company-files.el

(autoload 'company-files "company-mode/company-files" "\
`company-mode' completion backend existing file names.
Completions works for proper absolute and relative files paths.
File paths with spaces are only supported inside strings.

\(fn COMMAND &optional ARG &rest IGNORED)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "company-mode/company-files" '("company-file")))

;;;***

;;;### (autoloads nil "company-mode/company-gtags" "company-mode/company-gtags.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from company-mode/company-gtags.el

(autoload 'company-gtags "company-mode/company-gtags" "\
`company-mode' completion backend for GNU Global.

\(fn COMMAND &optional ARG &rest IGNORED)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "company-mode/company-gtags" '("company-gtags-")))

;;;***

;;;### (autoloads nil "company-mode/company-ispell" "company-mode/company-ispell.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from company-mode/company-ispell.el

(autoload 'company-ispell "company-mode/company-ispell" "\
`company-mode' completion backend using Ispell.

\(fn COMMAND &optional ARG &rest IGNORED)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "company-mode/company-ispell" '("company-ispell-")))

;;;***

;;;### (autoloads nil "company-mode/company-keywords" "company-mode/company-keywords.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from company-mode/company-keywords.el

(autoload 'company-keywords "company-mode/company-keywords" "\
`company-mode' backend for programming language keywords.

\(fn COMMAND &optional ARG &rest IGNORED)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "company-mode/company-keywords" '("company-keywords-")))

;;;***

;;;### (autoloads nil "company-mode/company-nxml" "company-mode/company-nxml.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from company-mode/company-nxml.el

(autoload 'company-nxml "company-mode/company-nxml" "\
`company-mode' completion backend for `nxml-mode'.

\(fn COMMAND &optional ARG &rest IGNORED)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "company-mode/company-nxml" '("company-nxml-")))

;;;***

;;;### (autoloads nil "company-mode/company-oddmuse" "company-mode/company-oddmuse.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from company-mode/company-oddmuse.el

(autoload 'company-oddmuse "company-mode/company-oddmuse" "\
`company-mode' completion backend for `oddmuse-mode'.

\(fn COMMAND &optional ARG &rest IGNORED)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "company-mode/company-oddmuse" '("company-oddmuse-")))

;;;***

;;;### (autoloads nil "company-mode/company-semantic" "company-mode/company-semantic.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from company-mode/company-semantic.el

(autoload 'company-semantic "company-mode/company-semantic" "\
`company-mode' completion backend using CEDET Semantic.

\(fn COMMAND &optional ARG &rest IGNORED)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "company-mode/company-semantic" '("company-semantic-")))

;;;***

;;;### (autoloads nil "company-mode/company-template" "company-mode/company-template.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from company-mode/company-template.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "company-mode/company-template" '("company-template-")))

;;;***

;;;### (autoloads nil "company-mode/company-tempo" "company-mode/company-tempo.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from company-mode/company-tempo.el

(autoload 'company-tempo "company-mode/company-tempo" "\
`company-mode' completion backend for tempo.

\(fn COMMAND &optional ARG &rest IGNORED)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "company-mode/company-tempo" '("company-tempo-")))

;;;***

;;;### (autoloads nil "company-mode/company-tests" "company-mode/company-tests.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from company-mode/company-tests.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "company-mode/company-tests" '("company-")))

;;;***

;;;### (autoloads nil "company-mode/company-tng" "company-mode/company-tng.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from company-mode/company-tng.el

(autoload 'company-tng-frontend "company-mode/company-tng" "\
When the user changes the selection at least once, this
frontend will display the candidate in the buffer as if it's
already there and any key outside of `company-active-map' will
confirm the selection and finish the completion.

\(fn COMMAND)" nil nil)

(autoload 'company-tng-configure-default "company-mode/company-tng" "\
Applies the default configuration to enable company-tng.

\(fn)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "company-mode/company-tng" '("company-tng--")))

;;;***

;;;### (autoloads nil "company-mode/company-yasnippet" "company-mode/company-yasnippet.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from company-mode/company-yasnippet.el

(autoload 'company-yasnippet "company-mode/company-yasnippet" "\
`company-mode' backend for `yasnippet'.

This backend should be used with care, because as long as there are
snippets defined for the current major mode, this backend will always
shadow backends that come after it.  Recommended usages:

* In a buffer-local value of `company-backends', grouped with a backend or
  several that provide actual text completions.

  (add-hook 'js-mode-hook
            (lambda ()
              (set (make-local-variable 'company-backends)
                   '((company-dabbrev-code company-yasnippet)))))

* After keyword `:with', grouped with other backends.

  (push '(company-semantic :with company-yasnippet) company-backends)

* Not in `company-backends', just bound to a key.

  (global-set-key (kbd \"C-c y\") 'company-yasnippet)

\(fn COMMAND &optional ARG &rest IGNORE)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "company-mode/company-yasnippet" '("company-yasnippet-")))

;;;***

;;;### (autoloads nil "crontab-mode/crontab-mode" "crontab-mode/crontab-mode.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from crontab-mode/crontab-mode.el

(autoload 'crontab-mode "crontab-mode/crontab-mode" "\
Major mode for editing crontabs.
Defines commands for getting and applying crontabs for hosts.
Sets up command `font-lock-mode'.

\\{crontab-mode-map}" t nil)

(autoload 'crontab-get "crontab-mode/crontab-mode" "\
Get the crontab for the HOST into a buffer.

\(fn HOST)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "crontab-mode/crontab-mode" '("crontab-")))

;;;***

;;;### (autoloads nil "dash/dash" "dash/dash.el" (0 0 0 0))
;;; Generated autoloads from dash/dash.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "dash/dash" '("dash-" "-keep" "-butlast" "-non" "-only-some" "-zip" "-e" "->" "-a" "-gr" "-when-let" "-d" "-l" "-s" "-p" "-r" "-m" "-i" "-f" "-u" "-value-to-list" "-t" "--" "-c" "!cons" "!cdr")))

;;;***

;;;### (autoloads nil "dash/dash-functional" "dash/dash-functional.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from dash/dash-functional.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "dash/dash-functional" '("-rpartial" "-juxt" "-not" "-o" "-a" "-iteratefn" "-c" "-f" "-prodfn")))

;;;***

;;;### (autoloads nil "deferred/concurrent" "deferred/concurrent.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from deferred/concurrent.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "deferred/concurrent" '("cc:")))

;;;***

;;;### (autoloads nil "deferred/deferred" "deferred/deferred.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from deferred/deferred.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "deferred/deferred" '("deferred:")))

;;;***

;;;### (autoloads nil "diminish/diminish" "diminish/diminish.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from diminish/diminish.el

(autoload 'diminish "diminish/diminish" "\
Diminish mode-line display of minor mode MODE to TO-WHAT (default \"\").

Interactively, enter (with completion) the name of any minor mode, followed
on the next line by what you want it diminished to (default empty string).
The response to neither prompt should be quoted.  However, in Lisp code,
both args must be quoted, the first as a symbol, the second as a string,
as in (diminish 'jiggle-mode \" Jgl\").

The mode-line displays of minor modes usually begin with a space, so
the modes' names appear as separate words on the mode line.  However, if
you're having problems with a cramped mode line, you may choose to use single
letters for some modes, without leading spaces.  Capitalizing them works
best; if you then diminish some mode to \"X\" but have abbrev-mode enabled as
well, you'll get a display like \"AbbrevX\".  This function prepends a space
to TO-WHAT if it's > 1 char long & doesn't already begin with a space.

\(fn MODE &optional TO-WHAT)" t nil)

(autoload 'diminish-undo "diminish/diminish" "\
Restore mode-line display of diminished mode MODE to its minor-mode value.
Do nothing if the arg is a minor mode that hasn't been diminished.

Interactively, enter (with completion) the name of any diminished mode (a
mode that was formerly a minor mode on which you invoked M-x diminish).
To restore all diminished modes to minor status, answer `diminished-modes'.
The response to the prompt shouldn't be quoted.  However, in Lisp code,
the arg must be quoted as a symbol, as in (diminish-undo 'diminished-modes).

\(fn MODE)" t nil)

(autoload 'diminished-modes "diminish/diminish" "\
Echo all active diminished or minor modes as if they were minor.
The display goes in the echo area; if it's too long even for that,
you can see the whole thing in the *Messages* buffer.
This doesn't change the status of any modes; it just lets you see
what diminished modes would be on the mode-line if they were still minor." t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "diminish/diminish" '("diminish")))

;;;***

;;;### (autoloads nil "dockerfile-mode/dockerfile-mode" "dockerfile-mode/dockerfile-mode.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from dockerfile-mode/dockerfile-mode.el

(autoload 'dockerfile-build-buffer "dockerfile-mode/dockerfile-mode" "\
Build an image called IMAGE-NAME based upon the buffer.

If prefix arg NO-CACHE is set, don't cache the image.
The build string will be of the format:
`sudo docker build --no-cache --tag IMAGE-NAME --build-args arg1.. -f filename directory`

\(fn IMAGE-NAME &optional NO-CACHE)" t nil)

(autoload 'dockerfile-build-no-cache-buffer "dockerfile-mode/dockerfile-mode" "\
Build an image called IMAGE-NAME based upon the buffer without cache.

\(fn IMAGE-NAME)" t nil)

(autoload 'dockerfile-mode "dockerfile-mode/dockerfile-mode" "\
A major mode to edit Dockerfiles.
\\{dockerfile-mode-map}

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("Dockerfile\\(?:\\..*\\)?\\'" . dockerfile-mode))

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "dockerfile-mode/dockerfile-mode" '("dockerfile-")))

;;;***

;;;### (autoloads nil "el-get/el-get" "el-get/el-get.el" (0 0 0 0))
;;; Generated autoloads from el-get/el-get.el

(autoload 'el-get-version "el-get/el-get" "\
Message the current el-get version

\(fn)" t nil)

(autoload 'el-get-install "el-get/el-get" "\
Cause the named PACKAGE to be installed after all of its
dependencies (if any).

PACKAGE may be either a string or the corresponding symbol.

\(fn PACKAGE)" t nil)

(autoload 'el-get-update "el-get/el-get" "\
Update PACKAGE.

\(fn PACKAGE)" t nil)

(autoload 'el-get-update-all "el-get/el-get" "\
Performs update of all installed packages.

\(fn &optional NO-PROMPT)" t nil)

(autoload 'el-get-update-packages-of-type "el-get/el-get" "\
Update all installed packages of type TYPE.

\(fn TYPE)" t nil)

(autoload 'el-get-self-update "el-get/el-get" "\
Update el-get itself.  The standard recipe takes care of reloading the code.

\(fn)" t nil)

(autoload 'el-get-remove "el-get/el-get" "\
Remove any PACKAGE that is know to be installed or required.

\(fn PACKAGE)" t nil)

(autoload 'el-get-reinstall "el-get/el-get" "\
Remove PACKAGE and then install it again.

\(fn PACKAGE)" t nil)

(autoload 'el-get-cd "el-get/el-get" "\
Open dired in the package directory.

\(fn PACKAGE)" t nil)

(autoload 'el-get-make-recipes "el-get/el-get" "\
Loop over `el-get-sources' and write a recipe file for each
entry which is not a symbol and is not already a known recipe.

\(fn &optional DIR)" t nil)

(autoload 'el-get-checksum "el-get/el-get" "\
Compute the checksum of the given package, and put it in the kill-ring

\(fn PACKAGE)" t nil)

(autoload 'el-get-self-checksum "el-get/el-get" "\
Compute the checksum of the running version of el-get itself.

Also put the checksum in the kill-ring.

\(fn)" t nil)

(autoload 'el-get "el-get/el-get" "\
Ensure that packages have been downloaded once and init them as needed.

This will not update the sources by using `apt-get install' or
`git pull', but it will ensure that:

* the packages have been installed
* load-path is set so their elisp files can be found
* Info-directory-list is set so their info files can be found
* Autoloads have been prepared and evaluated for each package
* Any post-installation setup (e.g. `(require 'feature)') happens

When SYNC is nil (the default), all installations run
concurrently, in the background.

When SYNC is 'sync, each package will be installed synchronously,
and any error will stop it all.

Please note that the `el-get-init' part of `el-get' is always
done synchronously. There's `byte-compile' support though, and
the packages you use are welcome to use `autoload' too.

PACKAGES is expected to be a list of packages you want to install
or init.  When PACKAGES is omited (the default), the list of
already installed packages is considered.

\(fn &optional SYNC &rest PACKAGES)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "el-get/el-get" '("el-get-")))

;;;***

;;;### (autoloads nil "el-get/el-get-autoloading" "el-get/el-get-autoloading.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from el-get/el-get-autoloading.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "el-get/el-get-autoloading" '("el-get-")))

;;;***

;;;### (autoloads nil "el-get/el-get-build" "el-get/el-get-build.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from el-get/el-get-build.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "el-get/el-get-build" '("el-get-")))

;;;***

;;;### (autoloads nil "el-get/el-get-bundle" "el-get/el-get-bundle.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from el-get/el-get-bundle.el

(autoload 'el-get-bundle-el-get "el-get/el-get-bundle" "\


\(fn SRC SYNC)" nil nil)

(autoload 'el-get-bundle "el-get/el-get-bundle" "\
Install PACKAGE and run initialization FORM.

PACKAGE can be either a simple package name or a package name
with a modifier before the name to specify local recipe source
information:

* `<owner>/' : specifies a Github owner name
* `gist:<id>' : specifies a Gist ID
* `<type>:' : specifies a type of the package source

If `FEATURE in PACKAGE' form is used instead of PACKAGE, then
that FEATURE is `require'd after installing PACKAGE.  You can
also use `el-get-bundle!' macro if FEATURE and PACKAGE are the
same.  If you wish to `require' more than one feature, then use
`:features' property in FORM.

The initialization FORM may start with a property list that
describes a local recipe.  The property list may include the keyword
`:bundle-sync' with a value of either `t' or `nil' to request that
`el-get-bundle' invoke `el-get' synchronously (respectively asynchronously).
The keyword `:bundle-async' is the inverse of `:bundle-sync'.
\(Note that the request to run el-get synchronously may not be respected in all
circumstances: see the definition of `el-get-bundle-el-get' for details.)
The FORM after the property list is treated as initialization code,
which is actually an `:after' property of the local recipe.

A copy of the initialization code is stored in a directory
specified by `el-get-bundle-init-directory' and its byte-compiled
version is used if `el-get-bundle-byte-compile' is non-nil.

\(fn PACKAGE &rest FORM)" nil t)

(function-put 'el-get-bundle 'lisp-indent-function 'defun)

(autoload 'el-get-bundle! "el-get/el-get-bundle" "\
Install PACKAGE and run initialization form.
It is the same as `el-get-bundle' except that PACKAGE is explicitly
required.

\(fn PACKAGE &rest ARGS)" nil t)

(function-put 'el-get-bundle! 'lisp-indent-function 'defun)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "el-get/el-get-bundle" '("el-get-bundle-")))

;;;***

;;;### (autoloads nil "el-get/el-get-byte-compile" "el-get/el-get-byte-compile.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from el-get/el-get-byte-compile.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "el-get/el-get-byte-compile" '("el-get-")))

;;;***

;;;### (autoloads nil "el-get/el-get-check" "el-get/el-get-check.el"
;;;;;;  (22159 45202 0 0))
;;; Generated autoloads from el-get/el-get-check.el

(autoload 'el-get-check-recipe "el-get/el-get-check" "\
Check the format of the recipe.
Please run this command before sending a pull request.
Usage: M-x el-get-check-recipe RET

You can run this function from checker script like this:
    test/check-recipe.el PATH/TO/RECIPE.rcp

When used as a lisp function, FILE-OR-BUFFER must be a buffer
object or a file path.

\(fn FILE-OR-BUFFER)" t nil)

;;;***

;;;### (autoloads nil "el-get/el-get-core" "el-get/el-get-core.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from el-get/el-get-core.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "el-get/el-get-core" '("el-get-")))

;;;***

;;;### (autoloads nil "el-get/el-get-custom" "el-get/el-get-custom.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from el-get/el-get-custom.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "el-get/el-get-custom" '("el-get-")))

;;;***

;;;### (autoloads nil "el-get/el-get-dependencies" "el-get/el-get-dependencies.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from el-get/el-get-dependencies.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "el-get/el-get-dependencies" '("el-get-" "topological-sort")))

;;;***

;;;### (autoloads nil "el-get/el-get-list-packages" "el-get/el-get-list-packages.el"
;;;;;;  (22480 4233 0 0))
;;; Generated autoloads from el-get/el-get-list-packages.el

(autoload 'el-get-list-packages "el-get/el-get-list-packages" "\
Display a list of packages.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "el-get/el-get-methods" "el-get/el-get-methods.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from el-get/el-get-methods.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "el-get/el-get-methods" '("el-get-insecure-check")))

;;;***

;;;### (autoloads nil "el-get/el-get-notify" "el-get/el-get-notify.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from el-get/el-get-notify.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "el-get/el-get-notify" '("el-get-")))

;;;***

;;;### (autoloads nil "el-get/el-get-recipes" "el-get/el-get-recipes.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from el-get/el-get-recipes.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "el-get/el-get-recipes" '("el-get-")))

;;;***

;;;### (autoloads nil "el-get/el-get-status" "el-get/el-get-status.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from el-get/el-get-status.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "el-get/el-get-status" '("el-get-")))

;;;***

;;;### (autoloads nil "emacs-async/async" "emacs-async/async.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-async/async.el

(autoload 'async-start-process "emacs-async/async" "\
Start the executable PROGRAM asynchronously.  See `async-start'.
PROGRAM is passed PROGRAM-ARGS, calling FINISH-FUNC with the
process object when done.  If FINISH-FUNC is nil, the future
object will return the process object when the program is
finished.  Set DEFAULT-DIRECTORY to change PROGRAM's current
working directory.

\(fn NAME PROGRAM FINISH-FUNC &rest PROGRAM-ARGS)" nil nil)

(autoload 'async-start "emacs-async/async" "\
Execute START-FUNC (often a lambda) in a subordinate Emacs process.
When done, the return value is passed to FINISH-FUNC.  Example:

    (async-start
       ;; What to do in the child process
       (lambda ()
         (message \"This is a test\")
         (sleep-for 3)
         222)

       ;; What to do when it finishes
       (lambda (result)
         (message \"Async process done, result should be 222: %s\"
                  result)))

If FINISH-FUNC is nil or missing, a future is returned that can
be inspected using `async-get', blocking until the value is
ready.  Example:

    (let ((proc (async-start
                   ;; What to do in the child process
                   (lambda ()
                     (message \"This is a test\")
                     (sleep-for 3)
                     222))))

        (message \"I'm going to do some work here\") ;; ....

        (message \"Waiting on async process, result should be 222: %s\"
                 (async-get proc)))

If you don't want to use a callback, and you don't care about any
return value from the child process, pass the `ignore' symbol as
the second argument (if you don't, and never call `async-get', it
will leave *emacs* process buffers hanging around):

    (async-start
     (lambda ()
       (delete-file \"a remote file on a slow link\" nil))
     'ignore)

Note: Even when FINISH-FUNC is present, a future is still
returned except that it yields no value (since the value is
passed to FINISH-FUNC).  Call `async-get' on such a future always
returns nil.  It can still be useful, however, as an argument to
`async-ready' or `async-wait'.

\(fn START-FUNC &optional FINISH-FUNC)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-async/async" '("async-")))

;;;***

;;;### (autoloads nil "emacs-async/async-bytecomp" "emacs-async/async-bytecomp.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-async/async-bytecomp.el

(autoload 'async-byte-recompile-directory "emacs-async/async-bytecomp" "\
Compile all *.el files in DIRECTORY asynchronously.
All *.elc files are systematically deleted before proceeding.

\(fn DIRECTORY &optional QUIET)" nil nil)

(defvar async-bytecomp-package-mode nil "\
Non-nil if Async-Bytecomp-Package mode is enabled.
See the `async-bytecomp-package-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `async-bytecomp-package-mode'.")

(custom-autoload 'async-bytecomp-package-mode "emacs-async/async-bytecomp" nil)

(autoload 'async-bytecomp-package-mode "emacs-async/async-bytecomp" "\
Byte compile asynchronously packages installed with package.el.
Async compilation of packages can be controlled by
`async-bytecomp-allowed-packages'.

\(fn &optional ARG)" t nil)

(autoload 'async-byte-compile-file "emacs-async/async-bytecomp" "\
Byte compile Lisp code FILE asynchronously.

Same as `byte-compile-file' but asynchronous.

\(fn FILE)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-async/async-bytecomp" '("async-byte")))

;;;***

;;;### (autoloads nil "emacs-async/async-test" "emacs-async/async-test.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-async/async-test.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-async/async-test" '("async-test-")))

;;;***

;;;### (autoloads nil "emacs-async/dired-async" "emacs-async/dired-async.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-async/dired-async.el

(defvar dired-async-mode nil "\
Non-nil if Dired-Async mode is enabled.
See the `dired-async-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `dired-async-mode'.")

(custom-autoload 'dired-async-mode "emacs-async/dired-async" nil)

(autoload 'dired-async-mode "emacs-async/dired-async" "\
Do dired actions asynchronously.

\(fn &optional ARG)" t nil)

(autoload 'dired-async-do-copy "emacs-async/dired-async" "\
Run ‘dired-do-copy’ asynchronously.

\(fn &optional ARG)" t nil)

(autoload 'dired-async-do-symlink "emacs-async/dired-async" "\
Run ‘dired-do-symlink’ asynchronously.

\(fn &optional ARG)" t nil)

(autoload 'dired-async-do-hardlink "emacs-async/dired-async" "\
Run ‘dired-do-hardlink’ asynchronously.

\(fn &optional ARG)" t nil)

(autoload 'dired-async-do-rename "emacs-async/dired-async" "\
Run ‘dired-do-rename’ asynchronously.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-async/dired-async" '("dired-async-")))

;;;***

;;;### (autoloads nil "emacs-async/smtpmail-async" "emacs-async/smtpmail-async.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-async/smtpmail-async.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-async/smtpmail-async" '("async-smtpmail-")))

;;;***

;;;### (autoloads nil "emacs-gdb/gdb-mi" "emacs-gdb/gdb-mi.el" (0
;;;;;;  0 0 0))
;;; Generated autoloads from emacs-gdb/gdb-mi.el

(autoload 'gdb-create-session "emacs-gdb/gdb-mi" "\
Create GDB session. This will not associate any target with it.

\(fn)" t nil)

(autoload 'gdb-executable "emacs-gdb/gdb-mi" "\
Start debugging an executable in the current session.
If no session is available, one is automatically created.

\(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-gdb/gdb-mi" '(#("gdb-" 0 4 (fontified nil face font-lock-function-name-face)))))

;;;***

;;;### (autoloads nil "emacs-w3m/bookmark-w3m" "emacs-w3m/bookmark-w3m.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/bookmark-w3m.el

(autoload 'bookmark-w3m-bookmark-jump "emacs-w3m/bookmark-w3m" "\
Default bookmark handler for w3m buffers.

\(fn BOOKMARK)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/bookmark-w3m" '("bookmark-w3m-")))

;;;***

;;;### (autoloads nil "emacs-w3m/mew-w3m" "emacs-w3m/mew-w3m.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/mew-w3m.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/mew-w3m" '("w3m-m" "mew-")))

;;;***

;;;### (autoloads nil "emacs-w3m/mime-w3m" "emacs-w3m/mime-w3m.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/mime-w3m.el

(autoload 'mime-w3m-preview-text/html "emacs-w3m/mime-w3m" "\


\(fn ENTITY SITUATION)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/mime-w3m" '("mime-w3m-")))

;;;***

;;;### (autoloads nil "emacs-w3m/octet" "emacs-w3m/octet.el" (0 0
;;;;;;  0 0))
;;; Generated autoloads from emacs-w3m/octet.el

(autoload 'octet-buffer "emacs-w3m/octet" "\
View octet-stream content according to `octet-type-filter-alist'.
Optional NAME is the filename.
If optional CONTENT-TYPE is specified, it is used for type guess.

\(fn &optional NAME CONTENT-TYPE)" t nil)

(autoload 'octet-find-file "emacs-w3m/octet" "\
Find FILE with octet-stream decoding.

\(fn FILE)" t nil)

(autoload 'mime-preview-octet "emacs-w3m/octet" "\
A method for mime-view to preview octet message.

\(fn ENTITY SITUATION)" nil nil)

(autoload 'mime-view-octet "emacs-w3m/octet" "\
A method for mime-view to display octet message.

\(fn ENTITY SITUATION)" nil nil)

(autoload 'octet-mime-setup "emacs-w3m/octet" "\
Octet setting for MIME module.

\(fn)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/octet" '("mime-" "octet-" "w3m-about-octet-attachments")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m" "emacs-w3m/w3m.el" (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m.el

(autoload 'w3m-retrieve "emacs-w3m/w3m" "\
Retrieve web contents pointed to by URL.
It will put the retrieved contents into the current buffer.

If HANDLER is nil, this function will retrieve web contents, return
the content type of the retrieved data, and then come to an end.  This
behavior is what is called a synchronous operation.  You have to
specify HANDLER in order to make this function show its real ability,
which is called an asynchronous operation.

If HANDLER is a function, this function will come to an end in no time.
In this case, contents will be retrieved by the asynchronous process
after a while.  And after finishing retrieving contents successfully,
HANDLER will be called on the buffer where this function starts.  The
content type of the retrieved data will be passed to HANDLER as a
string argument.

NO-UNCOMPRESS specifies whether this function should not uncompress contents.
NO-CACHE specifies whether this function should not use cached contents.
POST-DATA and REFERER will be sent to the web server with a request.

\(fn URL &optional NO-UNCOMPRESS NO-CACHE POST-DATA REFERER HANDLER)" nil nil)

(autoload 'w3m-download "emacs-w3m/w3m" "\
Download contents of URL to a file named FILENAME.
NO-CACHE (which the prefix argument gives when called interactively)
specifies not using the cached data.

\(fn &optional URL FILENAME NO-CACHE HANDLER POST-DATA)" t nil)

(autoload 'w3m-goto-url "emacs-w3m/w3m" "\
Visit World Wide Web pages in the current buffer.

This is the primitive function of `w3m'.

If the second argument RELOAD is non-nil, reload a content of URL.
Except that if it is 'redisplay, re-display the page without reloading.
The third argument CHARSET specifies a charset to be used for decoding
a content.
The fourth argument POST-DATA should be a string or a cons cell.
If it is a string, it makes this function request a body as if
the content-type is \"x-www-form-urlencoded\".  If it is a cons cell,
the car of a cell is used as the content-type and the cdr of a cell is
used as the body.
If the fifth argument REFERER is specified, it is used for a Referer:
field for this request.
The remaining HANDLER, ELEMENT[1], NO-POPUP, and SAVE-POS[2] are for
the internal operations of emacs-w3m.
You can also use \"quicksearch\" url schemes such as \"gg:emacs\" which
would search for the term \"emacs\" with the Google search engine.
See the `w3m-search' function and the variable `w3m-uri-replace-alist'.

Notes for the developers:
\[1] ELEMENT is a history element which has already been registered in
the `w3m-history-flat' variable.  It is corresponding to URL to be
retrieved at this time, not for the url of the current page.

\[2] SAVE-POS leads this function to save the current emacs-w3m window
configuration; i.e. to run `w3m-history-store-position'.
`w3m-history-store-position' should be called in a w3m-mode buffer, so
this will be convenient if a command that calls this function may be
invoked in other than a w3m-mode buffer.

\(fn URL &optional RELOAD CHARSET POST-DATA REFERER HANDLER ELEMENT NO-POPUP SAVE-POS)" t nil)

(autoload 'w3m-goto-url-new-session "emacs-w3m/w3m" "\
Visit World Wide Web pages in a new buffer.

If you invoke this command in the emacs-w3m buffer, the new buffer
will be created by copying the current buffer.  Otherwise, the new
buffer will start afresh.

\(fn URL &optional RELOAD CHARSET POST-DATA REFERER)" t nil)

(autoload 'w3m-gohome "emacs-w3m/w3m" "\
Go to the Home page.

\(fn)" t nil)

(autoload 'w3m-create-empty-session "emacs-w3m/w3m" "\
Create an empty page as a new session and visit it.

\(fn)" t nil)

(autoload 'w3m "emacs-w3m/w3m" "\
Visit World Wide Web pages using the external w3m command.

If no emacs-w3m session already exists: If POINT is at a url
string, visit that. Otherwise, if `w3m-home-page' is defined,
visit that. Otherwise, present a blank page. This behavior can be
over-ridden by setting variable `w3m-quick-start' to nil, in
which case you will always be prompted for a URL.

If an emacs-w3m session already exists: Pop to one of its windows
or frames. You can over-ride this behavior by setting
`w3m-quick-start' to nil, in order to always be prompted for a
URL.

In you have set `w3m-quick-start' to nil, but wish to over-ride
default behavior from the command line, either run this command
with a prefix argument or enter the empty string for the prompt.
In such cases, this command will visit a url at the point or,
lacking that, the URL set in variable `w3m-home-page' or, lacking
that, the \"about:\" page.

Any of five display styles are possible. See `w3m-display-mode'
for a description of those options.

You can also run this command in the batch mode as follows:

  emacs -f w3m http://emacs-w3m.namazu.org/ &

In that case, or if this command is called non-interactively, the
variables `w3m-pop-up-windows' and `w3m-pop-up-frames' will be ignored
\(treated as nil) and it will run emacs-w3m at the current (or the
initial) window.

If the optional NEW-SESSION is non-nil, this function creates a new
emacs-w3m buffer.  Besides that, it also makes a new emacs-w3m buffer
if `w3m-make-new-session' is non-nil and a user specifies a url string.

The optional INTERACTIVE-P is for the internal use; it is mainly used
to check whether Emacs 22 or later calls this function as an
interactive command in the batch mode.

\(fn &optional URL NEW-SESSION INTERACTIVE-P)" t nil)

(autoload 'w3m-browse-url "emacs-w3m/w3m" "\
Ask emacs-w3m to browse URL.
NEW-SESSION specifies whether to create a new emacs-w3m session.  URL
defaults to the string looking like a url around the cursor position.

\(fn URL &optional NEW-SESSION)" t nil)

(autoload 'w3m-find-file "emacs-w3m/w3m" "\
Function used to open FILE whose name is expressed in ordinary format.
The file name will be converted into the file: scheme.

\(fn FILE)" t nil)

(autoload 'w3m-region "emacs-w3m/w3m" "\
Render the region of the current buffer between START and END.
URL specifies the address where the contents come from.  It can be
omitted or nil when the address is not identified.  CHARSET is used
for decoding the contents.  If it is nil, this function attempts to
parse the meta tag to extract the charset.

\(fn START END &optional URL CHARSET)" t nil)

(autoload 'w3m-buffer "emacs-w3m/w3m" "\
Render the current buffer.
See `w3m-region' for the optional arguments.

\(fn &optional URL CHARSET)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m" '("w3m-" "emacs-w3m-version")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-antenna" "emacs-w3m/w3m-antenna.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-antenna.el

(autoload 'w3m-about-antenna "emacs-w3m/w3m-antenna" "\


\(fn URL &optional NO-DECODE NO-CACHE POST-DATA REFERER HANDLER)" nil nil)

(autoload 'w3m-antenna "emacs-w3m/w3m-antenna" "\
Report changes of WEB sites, which is specified in `w3m-antenna-sites'.

\(fn &optional NO-CACHE)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-antenna" '("w3m-antenna-")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-bookmark" "emacs-w3m/w3m-bookmark.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-bookmark.el

(autoload 'w3m-bookmark-add-this-url "emacs-w3m/w3m-bookmark" "\
Add link under cursor to bookmark.

\(fn)" t nil)

(autoload 'w3m-bookmark-add-current-url "emacs-w3m/w3m-bookmark" "\
Add a url of the current page to the bookmark.
With prefix, ask for a new url instead of the present one.

\(fn &optional ARG)" t nil)

(autoload 'w3m-bookmark-add-all-urls "emacs-w3m/w3m-bookmark" "\
Add urls of all pages being visited to the bookmark.

\(fn)" t nil)

(autoload 'w3m-bookmark-add-current-url-group "emacs-w3m/w3m-bookmark" "\
Add link of the group of current urls to the bookmark.

\(fn)" t nil)

(autoload 'w3m-bookmark-view "emacs-w3m/w3m-bookmark" "\
Display the bookmark list in the current buffer.

\(fn &optional RELOAD)" t nil)

(autoload 'w3m-bookmark-view-new-session "emacs-w3m/w3m-bookmark" "\
Display the bookmark list in a new buffer.

\(fn &optional RELOAD)" t nil)

(autoload 'w3m-about-bookmark "emacs-w3m/w3m-bookmark" "\


\(fn &rest ARGS)" nil nil)

(autoload 'w3m-setup-bookmark-menu "emacs-w3m/w3m-bookmark" "\
Setup w3m bookmark items in menubar.

\(fn)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-bookmark" '("w3m-bookmark-")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-bug" "emacs-w3m/w3m-bug.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-bug.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-bug" '("report-emacs-w3m-bug")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-ccl" "emacs-w3m/w3m-ccl.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-ccl.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-ccl" '("w3m-")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-cookie" "emacs-w3m/w3m-cookie.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-cookie.el

(autoload 'w3m-cookie-shutdown "emacs-w3m/w3m-cookie" "\
Save cookies, and reset cookies' data.

\(fn &optional INTERACTIVE-P)" t nil)

(autoload 'w3m-cookie-set "emacs-w3m/w3m-cookie" "\
Register cookies which correspond to URL.
BEG and END should be an HTTP response header region on current buffer.

\(fn URL BEG END)" nil nil)

(autoload 'w3m-cookie-get "emacs-w3m/w3m-cookie" "\
Get a cookie field string which corresponds to the URL.

\(fn URL)" nil nil)

(autoload 'w3m-cookie "emacs-w3m/w3m-cookie" "\
Display cookies and enable you to manage them.

\(fn &optional NO-CACHE)" t nil)

(autoload 'w3m-about-cookie "emacs-w3m/w3m-cookie" "\
Make the html contents to display and to enable you to manage cookies.
To delete all cookies associated with amazon.com for example, do it in
the following two steps:

1. Mark them `unused' (type `C-c C-c' or press any OK button).

Limit to [amazon.com          ] <= [ ]regexp  [OK]
\( )Noop  ( )Use all  (*)Unuse all  ( )Delete unused all  [OK]

2. Delete cookies that are marked `unused'.

Limit to [amazon.com          ] <= [ ]regexp  [OK]
\( )Noop  ( )Use all  ( )Unuse all  (*)Delete unused all  [OK]

You can mark cookies on the one-by-one basis of course.  The `Limit-to'
string is case insensitive and allows a regular expression.

\(fn URL &optional NO-DECODE NO-CACHE POST-DATA &rest ARGS)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-cookie" '("w3m-")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-dtree" "emacs-w3m/w3m-dtree.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-dtree.el

(autoload 'w3m-about-dtree "emacs-w3m/w3m-dtree" "\


\(fn URL &optional NODECODE ALLFILES &rest ARGS)" nil nil)

(autoload 'w3m-dtree "emacs-w3m/w3m-dtree" "\
Display directory tree on local file system.
If called with 'prefix argument', display all directorys and files.

\(fn ALLFILES PATH)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-dtree" '("w3m-dtree-")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-ems" "emacs-w3m/w3m-ems.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-ems.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-ems" '("w3m-")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-favicon" "emacs-w3m/w3m-favicon.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-favicon.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-favicon" '("w3m-")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-fb" "emacs-w3m/w3m-fb.el" (0
;;;;;;  0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-fb.el

(defvar w3m-fb-mode nil "\
Non-nil if W3m-Fb mode is enabled.
See the `w3m-fb-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `w3m-fb-mode'.")

(custom-autoload 'w3m-fb-mode "emacs-w3m/w3m-fb" nil)

(autoload 'w3m-fb-mode "emacs-w3m/w3m-fb" "\
Toggle W3M Frame Buffer mode.
This allows frame-local lists of buffers (tabs).

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-fb" '("w3m-fb-")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-filter" "emacs-w3m/w3m-filter.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-filter.el

(autoload 'w3m-filter "emacs-w3m/w3m-filter" "\
Apply filtering rule of URL against a content in this buffer.

\(fn URL)" nil nil)

(autoload 'w3m-toggle-filtering "emacs-w3m/w3m-filter" "\
Toggle whether web pages will have their html modified by w3m's filters before being rendered.
When called with a prefix argument, prompt for a single filter to
toggle with completion (a function toggled last will first appear).

\(fn ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-filter" '("w3m-filter-")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-form" "emacs-w3m/w3m-form.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-form.el

(autoload 'w3m-fontify-forms "emacs-w3m/w3m-form" "\
Process half-dumped data and fontify forms in this buffer.

\(fn)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-form" '("w3m-fo")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-hist" "emacs-w3m/w3m-hist.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-hist.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-hist" '("w3m-history")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-image" "emacs-w3m/w3m-image.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-image.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-image" '("w3m-")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-lnum" "emacs-w3m/w3m-lnum.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-lnum.el

(autoload 'w3m-lnum-mode "emacs-w3m/w3m-lnum" "\
Minor mode to extend point commands by using Conkeror style number selection.
With prefix ARG 0 disable battery included point functions, otherwise
enable them.  With no prefix ARG - toggle.

\(fn &optional ARG)" t nil)

(autoload 'w3m-lnum-goto "emacs-w3m/w3m-lnum" "\
Turn on link, image and form numbers and ask for one to go to.
0 corresponds to location url.

\(fn)" t nil)

(autoload 'w3m-lnum-follow "emacs-w3m/w3m-lnum" "\
Turn on link numbers, ask for one and execute appropriate action on it.
If link - visit it, when button - press, when input - activate it,
If image - toggle it.
With prefix ARG visit link in new session or don't move over
field/button/image on activation/push/toggle.
With `-' ARG, for link image - go to it and toggle it, if link,
visit in background.  With -4 ARG, for link image - toggle it.
With double prefix ARG, prompt for url to visit.
With triple prefix ARG, prompt for url to visit in new session.

\(fn ARG)" t nil)

(autoload 'w3m-lnum-universal "emacs-w3m/w3m-lnum" "\
Turn on link numbers, ask for one and offer actions over it depending on selection type.
Actions may be selected either by hitting corresponding key,
pressing <return> over the action line or left clicking.

\(fn)" t nil)

(autoload 'w3m-lnum-toggle-inline-image "emacs-w3m/w3m-lnum" "\
If image at point, toggle it.
Otherwise turn on link numbers and toggle selected image.
With prefix ARG open url under image in new session.
If no such url, move over image and toggle it.

\(fn &optional ARG)" t nil)

(autoload 'w3m-lnum-view-image "emacs-w3m/w3m-lnum" "\
Display the image under point in the external viewer.
If no image at poing, turn on image numbers and display selected.
The viewer is defined in `w3m-content-type-alist' for every type of an
image.

\(fn)" t nil)

(autoload 'w3m-lnum-save-image "emacs-w3m/w3m-lnum" "\
Save the image under point to a file.
If no image at point, turn on image numbers and save selected.
The default name will be the original name of the image.

\(fn)" t nil)

(autoload 'w3m-lnum-external-view-this-url "emacs-w3m/w3m-lnum" "\
Launch the external browser and display the link at point.
If no link at point, turn on link numbers and open selected externally.

\(fn)" t nil)

(autoload 'w3m-lnum-edit-this-url "emacs-w3m/w3m-lnum" "\
Edit the page linked from the anchor under the cursor.
If no such, turn on link numbers and edit selected.

\(fn)" t nil)

(autoload 'w3m-lnum-print-this-url "emacs-w3m/w3m-lnum" "\
Display the url under point in the echo area and put it into `kill-ring'.
If no url under point, activate numbering and select one.

\(fn)" t nil)

(autoload 'w3m-lnum-download-this-url "emacs-w3m/w3m-lnum" "\
Download the file or the page pointed to by the link under point.
If no point, activate numbering and select andchor to download.

\(fn)" t nil)

(autoload 'w3m-lnum-bookmark-add-this-url "emacs-w3m/w3m-lnum" "\
Add link under cursor to bookmarks.
If no link under point, activate numbering and ask for one.

\(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-lnum" '("w3m-")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-load" "emacs-w3m/w3m-load.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-load.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-load" '("w3m-fb-mode")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-mail" "emacs-w3m/w3m-mail.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-mail.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-mail" '("w3m-mail")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-namazu" "emacs-w3m/w3m-namazu.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-namazu.el

(autoload 'w3m-about-namazu "emacs-w3m/w3m-namazu" "\


\(fn URL &optional NO-DECODE NO-CACHE &rest ARGS)" nil nil)

(autoload 'w3m-namazu "emacs-w3m/w3m-namazu" "\
Search indexed files with Namazu.

\(fn INDEX QUERY &optional RELOAD)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-namazu" '("w3m-namazu-")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-perldoc" "emacs-w3m/w3m-perldoc.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-perldoc.el

(autoload 'w3m-about-perldoc "emacs-w3m/w3m-perldoc" "\


\(fn URL &optional NO-DECODE NO-CACHE &rest ARGS)" nil nil)

(autoload 'w3m-perldoc "emacs-w3m/w3m-perldoc" "\
View Perl documents.

\(fn DOCNAME)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-perldoc" '("w3m-perldoc-")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-proc" "emacs-w3m/w3m-proc.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-proc.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-proc" '("w3m-process-")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-rss" "emacs-w3m/w3m-rss.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-rss.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-rss" '("w3m-rss-")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-save" "emacs-w3m/w3m-save.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-save.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-save" '("w3m-save-buffer")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-search" "emacs-w3m/w3m-search.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-search.el

(autoload 'w3m-search "emacs-w3m/w3m-search" "\
Search QUERY using SEARCH-ENGINE.

Search results will appear in the current buffer.

When called interactively with a prefix argument, you can choose one of
the search engines defined in `w3m-search-engine-alist'.  Otherwise use
`w3m-search-default-engine'.
If Transient Mark mode, use the region as an initial string of query
and deactivate the mark.

\(fn SEARCH-ENGINE QUERY)" t nil)

(autoload 'w3m-search-new-session "emacs-w3m/w3m-search" "\
Like `w3m-search', but do the search in a new buffer.

\(fn SEARCH-ENGINE QUERY)" t nil)

(autoload 'w3m-search-uri-replace "emacs-w3m/w3m-search" "\
Generate query string for ENGINE from URI matched by last search.

\(fn URI ENGINE)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-search" '("w3m-search-")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-session" "emacs-w3m/w3m-session.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-session.el

(autoload 'w3m-session-save "emacs-w3m/w3m-session" "\
Save the current session (all currently open emacs-w3m buffers).

The user will be prompted for a name for the saved session.  The
saved session information will include, for each currently open
emacs-w3m buffer: the current url and page title, and the
buffer's url history.

\(fn)" t nil)

(autoload 'w3m-session-crash-recovery-remove "emacs-w3m/w3m-session" "\
Remove crash recovery session set.

\(fn)" nil nil)

(autoload 'w3m-session-select "emacs-w3m/w3m-session" "\
Select session from session list.
Position point at N-th session if N is given.  With the
prefix-argument, toggles the position of the popup window between
being below or beside the main window.

\(fn &optional N TOGGLE NOMSG)" t nil)

(autoload 'w3m-setup-session-menu "emacs-w3m/w3m-session" "\
Setup w3m session items in menubar.

\(fn)" nil nil)

(autoload 'w3m-session-last-autosave-session "emacs-w3m/w3m-session" "\


\(fn)" nil nil)

(autoload 'w3m-session-last-crashed-session "emacs-w3m/w3m-session" "\


\(fn)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-session" '("w3m-")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-symbol" "emacs-w3m/w3m-symbol.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-symbol.el

(autoload 'w3m-replace-symbol "emacs-w3m/w3m-symbol" "\


\(fn)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-symbol" '("w3m-")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-tabmenu" "emacs-w3m/w3m-tabmenu.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-tabmenu.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-tabmenu" '("w3m-")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-ucs" "emacs-w3m/w3m-ucs.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-ucs.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-ucs" '("w3m-")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-util" "emacs-w3m/w3m-util.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-util.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-util" '("w3m-")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-weather" "emacs-w3m/w3m-weather.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-weather.el

(autoload 'w3m-weather "emacs-w3m/w3m-weather" "\
Display weather report.

\(fn AREA)" t nil)

(autoload 'w3m-about-weather "emacs-w3m/w3m-weather" "\


\(fn URL NO-DECODE NO-CACHE POST-DATA REFERER HANDLER)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-weather" '("w3m-weather-")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3m-xmas" "emacs-w3m/w3m-xmas.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3m-xmas.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3m-xmas" '("w3m-")))

;;;***

;;;### (autoloads nil "emacs-w3m/w3mhack" "emacs-w3m/w3mhack.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from emacs-w3m/w3mhack.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "emacs-w3m/w3mhack" '("w3mhack-" "shimbun-module-directory")))

;;;***

;;;### (autoloads nil "erc-nick-notify/erc-nick-notify" "erc-nick-notify/erc-nick-notify.el"
;;;;;;  (22500 56913 0 0))
;;; Generated autoloads from erc-nick-notify/erc-nick-notify.el

(defvar erc-nick-notify-mode nil "\
Non-nil if Erc-Nick-Notify mode is enabled.
See the `erc-nick-notify-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `erc-nick-notify-mode'.")

(custom-autoload 'erc-nick-notify-mode "erc-nick-notify/erc-nick-notify" nil)

(autoload 'erc-nick-notify-mode "erc-nick-notify/erc-nick-notify" "\
Minor mode that calls `erc-nick-notify-cmd' when your nick gets
mentioned in an erc channel.

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads nil "etags-select/etags-select" "etags-select/etags-select.el"
;;;;;;  (21704 62845 0 0))
;;; Generated autoloads from etags-select/etags-select.el

(let ((loads (get 'etags-select-mode 'custom-loads))) (if (member '"etags-select/etags-select" loads) nil (put 'etags-select-mode 'custom-loads (cons '"etags-select/etags-select" loads))))

(defvar etags-select-no-select-for-one-match t "\
*If non-nil, don't open the selection window if there is only one
matching tag.")

(custom-autoload 'etags-select-no-select-for-one-match "etags-select/etags-select" t)

(defvar etags-select-mode-hook nil "\
*List of functions to call on entry to etags-select-mode mode.")

(custom-autoload 'etags-select-mode-hook "etags-select/etags-select" t)

(defvar etags-select-highlight-tag-after-jump t "\
*If non-nil, temporarily highlight the tag after you jump to it.")

(custom-autoload 'etags-select-highlight-tag-after-jump "etags-select/etags-select" t)

(defvar etags-select-highlight-delay 1.0 "\
*How long to highlight the tag.")

(custom-autoload 'etags-select-highlight-delay "etags-select/etags-select" t)

(defface etags-select-highlight-tag-face '((t (:foreground "white" :background "cadetblue4" :bold t))) "\
Font Lock mode face used to highlight tags." :group (quote etags-select-mode))

(defvar etags-select-use-short-name-completion nil "\
*Use short tag names during completion.  For example, say you
have a function named foobar in several classes and you invoke
`etags-select-find-tag'.  If this variable is nil, you would have
to type ClassA::foo<TAB> to start completion.  Since avoiding
knowing which class a function is in is the basic idea of this
package, if you set this to t you can just type foo<TAB>.

Only works with GNU Emacs.")

(custom-autoload 'etags-select-use-short-name-completion "etags-select/etags-select" t)

(defvar etags-select-go-if-unambiguous nil "\
*If non-nil, jump by tag number if it is unambiguous.")

(custom-autoload 'etags-select-go-if-unambiguous "etags-select/etags-select" t)

(autoload 'etags-select-find-tag-at-point "etags-select/etags-select" "\
Do a find-tag-at-point, and display all exact matches.  If only one match is
found, see the `etags-select-no-select-for-one-match' variable to decide what
to do.

\(fn)" t nil)

(autoload 'etags-select-find-tag "etags-select/etags-select" "\
Do a find-tag, and display all exact matches.  If only one match is
found, see the `etags-select-no-select-for-one-match' variable to decide what
to do.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "expand-region/expand-region" "expand-region/expand-region.el"
;;;;;;  (21704 62826 0 0))
;;; Generated autoloads from expand-region/expand-region.el

(autoload 'er/expand-region "expand-region/expand-region" "\
Increase selected region by semantic units.

With prefix argument expands the region that many times.
If prefix argument is negative calls `er/contract-region'.
If prefix argument is 0 it resets point and mark to their state
before calling `er/expand-region' for the first time.

\(fn ARG)" t nil)

;;;***

;;;### (autoloads nil "expand-region/expand-region-custom" "expand-region/expand-region-custom.el"
;;;;;;  (21268 30206 0 0))
;;; Generated autoloads from expand-region/expand-region-custom.el

(let ((loads (get 'expand-region 'custom-loads))) (if (member '"expand-region/expand-region-custom" loads) nil (put 'expand-region 'custom-loads (cons '"expand-region/expand-region-custom" loads))))

(defvar expand-region-preferred-python-mode 'python "\
The name of your preferred python mode")

(custom-autoload 'expand-region-preferred-python-mode "expand-region/expand-region-custom" t)

(defvar expand-region-guess-python-mode t "\
If expand-region should attempt to guess your preferred python mode")

(custom-autoload 'expand-region-guess-python-mode "expand-region/expand-region-custom" t)

(defvar expand-region-autocopy-register "" "\
If set to a string of a single character (try \"e\"), then the
contents of the most recent expand or contract command will
always be copied to the register named after that character.")

(custom-autoload 'expand-region-autocopy-register "expand-region/expand-region-custom" t)

(defvar expand-region-skip-whitespace t "\
If expand-region should skip past whitespace on initial expansion")

(custom-autoload 'expand-region-skip-whitespace "expand-region/expand-region-custom" t)

(defvar expand-region-fast-keys-enabled t "\
If expand-region should bind fast keys after initial expand/contract")

(custom-autoload 'expand-region-fast-keys-enabled "expand-region/expand-region-custom" t)

(defvar expand-region-contract-fast-key "-" "\
Key to use after an initial expand/contract to contract once more.")

(custom-autoload 'expand-region-contract-fast-key "expand-region/expand-region-custom" t)

(defvar expand-region-reset-fast-key "0" "\
Key to use after an initial expand/contract to undo.")

(custom-autoload 'expand-region-reset-fast-key "expand-region/expand-region-custom" t)

(defvar expand-region-exclude-text-mode-expansions '(html-mode nxml-mode) "\
List of modes which derive from `text-mode' for which text mode expansions are not appropriate.")

(custom-autoload 'expand-region-exclude-text-mode-expansions "expand-region/expand-region-custom" t)

;;;***

;;;### (autoloads nil "f/f" "f/f.el" (0 0 0 0))
;;; Generated autoloads from f/f.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "f/f" '("f-")))

;;;***

;;;### (autoloads nil "flycheck/flycheck" "flycheck/flycheck.el"
;;;;;;  (22061 64740 0 0))
;;; Generated autoloads from flycheck/flycheck.el

(autoload 'flycheck-info "flycheck/flycheck" "\
Open the Flycheck manual.

\(fn)" t nil)

(autoload 'flycheck-mode "flycheck/flycheck" "\
Minor mode for on-the-fly syntax checking.

When called interactively, toggle `flycheck-mode'.  With prefix
ARG, enable `flycheck-mode' if ARG is positive, otherwise disable
it.

When called from Lisp, enable `flycheck-mode' if ARG is omitted,
nil or positive.  If ARG is `toggle', toggle `flycheck-mode'.
Otherwise behave as if called interactively.

In `flycheck-mode' the buffer is automatically syntax-checked
using the first suitable syntax checker from `flycheck-checkers'.
Use `flycheck-select-checker' to select a checker for the current
buffer manually.

\\{flycheck-mode-map}

\(fn &optional ARG)" t nil)

(defvar global-flycheck-mode nil "\
Non-nil if Global-Flycheck mode is enabled.
See the command `global-flycheck-mode' for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `global-flycheck-mode'.")

(custom-autoload 'global-flycheck-mode "flycheck/flycheck" nil)

(autoload 'global-flycheck-mode "flycheck/flycheck" "\
Toggle Flycheck mode in all buffers.
With prefix ARG, enable Global-Flycheck mode if ARG is positive;
otherwise, disable it.  If called from Lisp, enable the mode if
ARG is omitted or nil.

Flycheck mode is enabled in all buffers where
`flycheck-mode-on-safe' would do it.
See `flycheck-mode' for more information on Flycheck mode.

\(fn &optional ARG)" t nil)

(autoload 'flycheck-define-error-level "flycheck/flycheck" "\
Define a new error LEVEL with PROPERTIES.

The following PROPERTIES constitute an error level:

`:severity SEVERITY'
     A number denoting the severity of this level.  The higher
     the number, the more severe is this level compared to other
     levels.  Defaults to 0.

     The severity is used by `flycheck-error-level-<' to
     determine the ordering of errors according to their levels.

`:compilation-level LEVEL'

     A number indicating the broad class of messages that errors
     at this level belong to: one of 0 (info), 1 (warning), or
     2 or nil (error).  Defaults to nil.

     This is used by `flycheck-checker-pattern-to-error-regexp'
     to map error levels into `compilation-mode''s hierarchy and
     to get proper highlighting of errors in `compilation-mode'.

`:overlay-category CATEGORY'
     A symbol denoting the overlay category to use for error
     highlight overlays for this level.  See Info
     node `(elisp)Overlay Properties' for more information about
     overlay categories.

     A category for an error level overlay should at least define
     the `face' property, for error highlighting.  Another useful
     property for error level categories is `priority', to
     influence the stacking of multiple error level overlays.

`:fringe-bitmap BITMAP'
     A fringe bitmap symbol denoting the bitmap to use for fringe
     indicators for this level.  See Info node `(elisp)Fringe
     Bitmaps' for more information about fringe bitmaps,
     including a list of built-in fringe bitmaps.

`:fringe-face FACE'
     A face symbol denoting the face to use for fringe indicators
     for this level.

`:error-list-face FACE'
     A face symbol denoting the face to use for messages of this
     level in the error list.  See `flycheck-list-errors'.

\(fn LEVEL &rest PROPERTIES)" nil nil)

(put 'flycheck-define-error-level 'lisp-indent-function '1)

(autoload 'flycheck-define-command-checker "flycheck/flycheck" "\
Define SYMBOL as syntax checker which runs a command.

Define SYMBOL as generic syntax checker via
`flycheck-define-generic-checker', which uses an external command
to check the buffer.  SYMBOL and DOCSTRING are the same as for
`flycheck-define-generic-checker'.

In addition to the properties understood by
`flycheck-define-generic-checker', the following PROPERTIES
constitute a command syntax checker.  Unless otherwise noted, all
properties are mandatory.  Note that the default `:error-filter'
of command checkers is `flycheck-sanitize-errors'.

`:command COMMAND'
     The command to run for syntax checking.

     COMMAND is a list of the form `(EXECUTABLE [ARG ...])'.

     EXECUTABLE is a string with the executable of this syntax
     checker.  It can be overridden with the variable
     `flycheck-SYMBOL-executable'.  Note that this variable is
     NOT implicitly defined by this function.  Use
     `flycheck-def-executable-var' to define this variable.

     Each ARG is an argument to the executable, either as string,
     or as special symbol or form for
     `flycheck-substitute-argument', which see.

`:error-patterns PATTERNS'
     A list of patterns to parse the output of the `:command'.

     Each ITEM in PATTERNS is a list `(LEVEL SEXP ...)', where
     LEVEL is a Flycheck error level (see
     `flycheck-define-error-level'), followed by one or more RX
     `SEXP's which parse an error of that level and extract line,
     column, file name and the message.

     See `rx' for general information about RX, and
     `flycheck-rx-to-string' for some special RX forms provided
     by Flycheck.

     All patterns are applied in the order of declaration to the
     whole output of the syntax checker.  Output already matched
     by a pattern will not be matched by subsequent patterns.  In
     other words, the first pattern wins.

     This property is optional.  If omitted, however, an
     `:error-parser' is mandatory.

`:error-parser FUNCTION'
     A function to parse errors with.

     The function shall accept three arguments OUTPUT CHECKER
     BUFFER.  OUTPUT is the syntax checker output as string,
     CHECKER the syntax checker that was used, and BUFFER a
     buffer object representing the checked buffer.  The function
     must return a list of `flycheck-error' objects parsed from
     OUTPUT.

     This property is optional.  If omitted, it defaults to
     `flycheck-parse-with-patterns'.  In this case,
     `:error-patterns' is mandatory.

`:standard-input t'
     Whether to send the buffer contents on standard input.

     If this property is given and has a non-nil value, send the
     contents of the buffer on standard input.

     Defaults to nil.

Note that you may not give `:start', `:interrupt', and
`:print-doc' for a command checker.  You can give a custom
`:verify' function, though, whose results will be appended to the
default `:verify' function of command checkers.

\(fn SYMBOL DOCSTRING &rest PROPERTIES)" nil nil)

(put 'flycheck-define-command-checker 'lisp-indent-function '1)

(put 'flycheck-define-command-checker 'doc-string-elt '2)

(autoload 'flycheck-def-config-file-var "flycheck/flycheck" "\
Define SYMBOL as config file variable for CHECKER, with default FILE-NAME.

SYMBOL is declared as customizable variable using `defcustom', to
provide a configuration file for the given syntax CHECKER.
CUSTOM-ARGS are forwarded to `defcustom'.

FILE-NAME is the initial value of the new variable.  If omitted,
the default value is nil.

Use this together with the `config-file' form in the `:command'
argument to `flycheck-define-checker'.

\(fn SYMBOL CHECKER &optional FILE-NAME &rest CUSTOM-ARGS)" nil t)

(put 'flycheck-def-config-file-var 'lisp-indent-function '3)

(autoload 'flycheck-def-option-var "flycheck/flycheck" "\
Define SYMBOL as option variable with INIT-VALUE for CHECKER.

SYMBOL is declared as customizable variable using `defcustom', to
provide an option for the given syntax CHECKER.  INIT-VALUE is
the initial value of the variable, and DOCSTRING is its
docstring.  CUSTOM-ARGS are forwarded to `defcustom'.

Use this together with the `option', `option-list' and
`option-flag' forms in the `:command' argument to
`flycheck-define-checker'.

\(fn SYMBOL INIT-VALUE CHECKER DOCSTRING &rest CUSTOM-ARGS)" nil t)

(put 'flycheck-def-option-var 'lisp-indent-function '3)

(put 'flycheck-def-option-var 'doc-string-elt '4)

;;;***

;;;### (autoloads nil "ghub/buck" "ghub/buck.el" (0 0 0 0))
;;; Generated autoloads from ghub/buck.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "ghub/buck" '("buck-default-host")))

;;;***

;;;### (autoloads nil "ghub/ghub" "ghub/ghub.el" (0 0 0 0))
;;; Generated autoloads from ghub/ghub.el

(autoload 'ghub-create-token "ghub/ghub" "\
Create, store and return a new token.

HOST is the Github instance, usually \"api.github.com\".
USERNAME is the name of a user on that instance.
PACKAGE is the package that will use the token.
SCOPES are the scopes the token is given access to.

\(fn HOST USERNAME PACKAGE SCOPES)" t nil)

(autoload 'ghub-token-scopes "ghub/ghub" "\
Return and echo the scopes of the specified token.
This is intended for debugging purposes only.  The user
has to provide several values including their password.

\(fn HOST USERNAME PACKAGE)" t nil)

(autoload 'ghub-clear-caches "ghub/ghub" "\
Clear all caches that might negatively affect Ghub.

If a library that is used by Ghub caches incorrect information
such as a mistyped password, then that can prevent Ghub from
asking the user for the correct information again.

Set `url-http-real-basic-auth-storage' to nil
and call `auth-source-forget+'.

\(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "ghub/ghub" '("auth-source-netrc-parse-next-interesting@save-match-data" "ghub-")))

;;;***

;;;### (autoloads nil "ghub/ghub-graphql" "ghub/ghub-graphql.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ghub/ghub-graphql.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "ghub/ghub-graphql" '("ghub-")))

;;;***

;;;### (autoloads nil "ghub/glab" "ghub/glab.el" (0 0 0 0))
;;; Generated autoloads from ghub/glab.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "ghub/glab" '("glab-default-host")))

;;;***

;;;### (autoloads nil "ghub/gogs" "ghub/gogs.el" (0 0 0 0))
;;; Generated autoloads from ghub/gogs.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "ghub/gogs" '("gogs-default-host")))

;;;***

;;;### (autoloads nil "ghub/gtea" "ghub/gtea.el" (0 0 0 0))
;;; Generated autoloads from ghub/gtea.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "ghub/gtea" '("gtea-default-host")))

;;;***

;;;### (autoloads nil "git-gutter/git-gutter" "git-gutter/git-gutter.el"
;;;;;;  (23183 60963 0 0))
;;; Generated autoloads from git-gutter/git-gutter.el

(autoload 'git-gutter:linum-setup "git-gutter/git-gutter" "\
Setup for linum-mode.

\(fn)" nil nil)

(autoload 'git-gutter-mode "git-gutter/git-gutter" "\
Git-Gutter mode

\(fn &optional ARG)" t nil)

(defvar global-git-gutter-mode nil "\
Non-nil if Global Git-Gutter mode is enabled.
See the `global-git-gutter-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `global-git-gutter-mode'.")

(custom-autoload 'global-git-gutter-mode "git-gutter/git-gutter" nil)

(autoload 'global-git-gutter-mode "git-gutter/git-gutter" "\
Toggle Git-Gutter mode in all buffers.
With prefix ARG, enable Global Git-Gutter mode if ARG is positive;
otherwise, disable it.  If called from Lisp, enable the mode if
ARG is omitted or nil.

Git-Gutter mode is enabled in all buffers where
`git-gutter--turn-on' would do it.
See `git-gutter-mode' for more information on Git-Gutter mode.

\(fn &optional ARG)" t nil)

(autoload 'git-gutter "git-gutter/git-gutter" "\
Show diff information in gutter

\(fn)" t nil)

(autoload 'git-gutter:toggle "git-gutter/git-gutter" "\
Toggle to show diff information.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "git-modes/git-commit-mode" "git-modes/git-commit-mode.el"
;;;;;;  (21704 62826 0 0))
;;; Generated autoloads from git-modes/git-commit-mode.el

(autoload 'git-commit-mode "git-modes/git-commit-mode" "\
Major mode for editing git commit messages.

This mode helps with editing git commit messages both by
providing commands to do common tasks, and by highlighting the
basic structure of and errors in git commit messages.

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("/MERGE_MSG\\'" . git-commit-mode))

(add-to-list 'auto-mode-alist '("/\\(?:COMMIT\\|NOTES\\|TAG\\|PULLREQ\\)_EDITMSG\\'" . git-commit-mode))

;;;***

;;;### (autoloads nil "git-modes/git-rebase-mode" "git-modes/git-rebase-mode.el"
;;;;;;  (21704 62826 0 0))
;;; Generated autoloads from git-modes/git-rebase-mode.el

(autoload 'git-rebase-mode "git-modes/git-rebase-mode" "\
Major mode for editing of a Git rebase file.

Rebase files are generated when you run 'git rebase -i' or run
`magit-interactive-rebase'.  They describe how Git should perform
the rebase.  See the documentation for git-rebase (e.g., by
running 'man git-rebase' at the command line) for details.

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("/git-rebase-todo\\'" . git-rebase-mode))

;;;***

;;;### (autoloads nil "git-modes/gitattributes-mode" "git-modes/gitattributes-mode.el"
;;;;;;  (21704 62826 0 0))
;;; Generated autoloads from git-modes/gitattributes-mode.el

(autoload 'gitattributes-mode "git-modes/gitattributes-mode" "\
A major mode for editing .gitattributes files.
\\{gitattributes-mode-map}

\(fn)" t nil)

(dolist (pattern '("/\\.gitattributes\\'" "/\\.git/info/attributes\\'" "/git/attributes\\'")) (add-to-list 'auto-mode-alist (cons pattern #'gitattributes-mode)))

;;;***

;;;### (autoloads nil "git-modes/gitconfig-mode" "git-modes/gitconfig-mode.el"
;;;;;;  (21704 62826 0 0))
;;; Generated autoloads from git-modes/gitconfig-mode.el

(autoload 'gitconfig-mode "git-modes/gitconfig-mode" "\
A major mode for editing .gitconfig files.

\(fn)" t nil)

(dolist (pattern '("/\\.gitconfig\\'" "/\\.git/config\\'" "/git/config\\'" "/\\.gitmodules\\'")) (add-to-list 'auto-mode-alist (cons pattern 'gitconfig-mode)))

;;;***

;;;### (autoloads nil "git-modes/gitignore-mode" "git-modes/gitignore-mode.el"
;;;;;;  (21704 62826 0 0))
;;; Generated autoloads from git-modes/gitignore-mode.el

(autoload 'gitignore-mode "git-modes/gitignore-mode" "\
A major mode for editing .gitignore files.

\(fn)" t nil)

(dolist (pattern (list "/\\.gitignore\\'" "/\\.git/info/exclude\\'" "/git/ignore\\'")) (add-to-list 'auto-mode-alist (cons pattern 'gitignore-mode)))

;;;***

;;;### (autoloads nil "git-timemachine/git-timemachine" "git-timemachine/git-timemachine.el"
;;;;;;  (23183 60631 0 0))
;;; Generated autoloads from git-timemachine/git-timemachine.el

(autoload 'git-timemachine-toggle "git-timemachine/git-timemachine" "\
Toggle git timemachine mode.

\(fn)" t nil)

(autoload 'git-timemachine "git-timemachine/git-timemachine" "\
Enable git timemachine for file of current buffer.

\(fn)" t nil)

(autoload 'git-timemachine-switch-branch "git-timemachine/git-timemachine" "\
Enable git timemachine for current buffer, switching to GIT-BRANCH.

\(fn GIT-BRANCH)" t nil)

;;;***

;;;### (autoloads nil "graphql/graphql" "graphql/graphql.el" (0 0
;;;;;;  0 0))
;;; Generated autoloads from graphql/graphql.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "graphql/graphql" '("graphql-")))

;;;***

;;;### (autoloads nil "graphviz-dot-mode/graphviz-dot-mode" "graphviz-dot-mode/graphviz-dot-mode.el"
;;;;;;  (21914 14008 0 0))
;;; Generated autoloads from graphviz-dot-mode/graphviz-dot-mode.el

(autoload 'graphviz-dot-mode "graphviz-dot-mode/graphviz-dot-mode" "\
Major mode for the dot language. \\<graphviz-dot-mode-map>
TAB indents for graph lines.

\\[graphviz-dot-indent-graph]	- Indentation function.
\\[graphviz-dot-preview]	- Previews graph in a buffer.
\\[graphviz-dot-view]	- Views graph in an external viewer.
\\[graphviz-dot-indent-line]	- Indents current line of code.
\\[graphviz-dot-complete-word]	- Completes the current word.
\\[electric-graphviz-dot-terminate-line]	- Electric newline.
\\[electric-graphviz-dot-open-brace]	- Electric open braces.
\\[electric-graphviz-dot-close-brace]	- Electric close braces.
\\[electric-graphviz-dot-semi]	- Electric semi colons.

Variables specific to this mode:

  graphviz-dot-dot-program            (default `dot')
       Location of the dot program.
  graphviz-dot-view-command           (default `doted %s')
       Command to run when `graphviz-dot-view' is executed.
  graphviz-dot-view-edit-command      (default nil)
       If the user should be asked to edit the view command.
  graphviz-dot-save-before-view       (default t)
       Automatically save current buffer berore `graphviz-dot-view'.
  graphviz-dot-preview-extension      (default `png')
       File type to use for `graphviz-dot-preview'.
  graphviz-dot-auto-indent-on-newline (default t)
       Whether to run `electric-graphviz-dot-terminate-line' when
       newline is entered.
  graphviz-dot-auto-indent-on-braces (default t)
       Whether to run `electric-graphviz-dot-open-brace' and
       `electric-graphviz-dot-close-brace' when braces are
       entered.
  graphviz-dot-auto-indent-on-semi (default t)
       Whether to run `electric-graphviz-dot-semi' when semi colon
       is typed.
  graphviz-dot-toggle-completions  (default nil)
       If completions should be displayed in the buffer instead of a
       completion buffer when \\[graphviz-dot-complete-word] is
       pressed repeatedly.

This mode can be customized by running \\[graphviz-dot-customize].

Turning on Graphviz Dot mode calls the value of the variable
`graphviz-dot-mode-hook' with no args, if that value is non-nil.

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("\\.dot\\'" . graphviz-dot-mode))

(add-to-list 'auto-mode-alist '("\\.gv\\'" . graphviz-dot-mode))

;;;***

;;;### (autoloads nil "groovy-emacs-mode/grails-mode" "groovy-emacs-mode/grails-mode.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from groovy-emacs-mode/grails-mode.el

(autoload 'grails-mode "groovy-emacs-mode/grails-mode" "\
Grails Minor Mode.
     With no argument, this command toggles the mode.
     Non-null prefix argument turns on the mode.
     Null prefix argument turns off the mode.

     When Grails mode is enabled, several keys are enabled that
     will allow navigation around a typical grails project.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "groovy-emacs-mode/grails-mode" '("grails-" "anything-grails-project-files")))

;;;***

;;;### (autoloads nil "groovy-emacs-mode/groovy-electric" "groovy-emacs-mode/groovy-electric.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from groovy-emacs-mode/groovy-electric.el

(autoload 'groovy-electric-mode "groovy-emacs-mode/groovy-electric" "\
Toggle Groovy Electric minor mode.
With no argument, this command toggles the mode.  Non-null prefix
argument turns on the mode.  Null prefix argument turns off the
mode.

When Groovy Electric mode is enabled, simple, double and back
quotes as well as braces are paired auto-magically. Expansion
does not occur inside comments and strings. Note that you must
have Font Lock enabled. ${ } is expanded when in a GString

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "groovy-emacs-mode/groovy-electric" '("groovy-electric-")))

;;;***

;;;### (autoloads nil "groovy-emacs-mode/groovy-mode" "groovy-emacs-mode/groovy-mode.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from groovy-emacs-mode/groovy-mode.el

(add-to-list 'auto-mode-alist '("\\.g\\(?:ant\\|roovy\\|radle\\)\\'" . groovy-mode))

(add-to-list 'auto-mode-alist '("Jenkinsfile" . groovy-mode))

(add-to-list 'interpreter-mode-alist '("groovy" . groovy-mode))

(autoload 'groovy-mode "groovy-emacs-mode/groovy-mode" "\
Major mode for editing Groovy code.

The hook `groovy-mode-hook' is run with no args at mode
initialization.

Key bindings:
\\{groovy-mode-map}

\(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "groovy-emacs-mode/groovy-mode" '("groovy-")))

;;;***

;;;### (autoloads nil "groovy-emacs-mode/inf-groovy" "groovy-emacs-mode/inf-groovy.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from groovy-emacs-mode/inf-groovy.el

(autoload 'inf-groovy-keys "groovy-emacs-mode/inf-groovy" "\
Set local key defs for inf-groovy in groovy-mode

\(fn)" nil nil)

(autoload 'inferior-groovy-mode "groovy-emacs-mode/inf-groovy" "\
Major mode for interacting with an inferior groovy (groovysh) process.

The following commands are available:
\\{inferior-groovy-mode-map}

A groovy process can be fired up with M-x run-groovy.

Customisation: Entry to this mode runs the hooks on comint-mode-hook and
inferior-groovy-mode-hook (in that order).

You can send text to the inferior groovy process from other buffers containing
Groovy source.
    switch-to-groovy switches the current buffer to the groovy process buffer.
    groovy-send-definition sends the current definition to the groovy process.
    groovy-send-region sends the current region to the groovy process.

    groovy-send-definition-and-go, groovy-send-region-and-go,
        switch to the groovy process buffer after sending their text.
For information on running multiple processes in multiple buffers, see
documentation for variable groovy-buffer.

Commands:
Return after the end of the process' output sends the text from the
    end of process to point.
Return before the end of the process' output copies the sexp ending at point
    to the end of the process' output, and sends it.
Delete converts tabs to spaces as it moves back.
Tab indents for groovy; with argument, shifts rest
    of expression rigidly with the current line.
C-M-q does Tab on each line starting within following expression.
Paragraphs are separated only by blank lines.  # start comments.
If you accidentally suspend your process, use \\[comint-continue-subjob]
to continue it.

\(fn)" t nil)

(autoload 'run-groovy "groovy-emacs-mode/inf-groovy" "\
Run an inferior Groovy process, input and output via buffer *groovy*.
If there is a process already running in *groovy*, switch to that buffer.
With a prefix argument, prompt for the groovysh path and arguments
\(see variables `groovysh' and `groovysh-args' for the defaults).

Runs the hook `inferior-groovy-mode-hook' (after the
`comint-mode-hook' is run).  Type \\[describe-mode] in the
process buffer for a list of commands.

\(fn CMD)" t nil)

(eval-after-load 'groovy-mode (lambda nil (add-hook 'groovy-mode-hook 'inf-groovy-keys)))

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "groovy-emacs-mode/inf-groovy" '("inf" "groovy" "switch-to-groovy" "remove-in-string")))

;;;***

;;;### (autoloads nil "guide-key/guide-key" "guide-key/guide-key.el"
;;;;;;  (21704 62826 0 0))
;;; Generated autoloads from guide-key/guide-key.el

(defvar guide-key-mode nil "\
Non-nil if Guide-Key mode is enabled.
See the command `guide-key-mode' for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `guide-key-mode'.")

(custom-autoload 'guide-key-mode "guide-key/guide-key" nil)

(autoload 'guide-key-mode "guide-key/guide-key" "\
Toggle guide key mode.

In guide key mode, Guide following keys to an input key sequence
automatically and dynamically.
With a prefix argument ARG, enable guide key mode if ARG is
positive, otherwise disable.

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads nil "hydra/hydra" "hydra/hydra.el" (0 0 0 0))
;;; Generated autoloads from hydra/hydra.el

(autoload 'defhydra "hydra/hydra" "\
Create a Hydra - a family of functions with prefix NAME.

NAME should be a symbol, it will be the prefix of all functions
defined here.

BODY has the format:

    (BODY-MAP BODY-KEY &rest BODY-PLIST)

DOCSTRING will be displayed in the echo area to identify the
Hydra.  When DOCSTRING starts with a newline, special Ruby-style
substitution will be performed by `hydra--format'.

Functions are created on basis of HEADS, each of which has the
format:

    (KEY CMD &optional HINT &rest PLIST)

BODY-MAP is a keymap; `global-map' is used quite often.  Each
function generated from HEADS will be bound in BODY-MAP to
BODY-KEY + KEY (both are strings passed to `kbd'), and will set
the transient map so that all following heads can be called
though KEY only.  BODY-KEY can be an empty string.

CMD is a callable expression: either an interactive function
name, or an interactive lambda, or a single sexp (it will be
wrapped in an interactive lambda).

HINT is a short string that identifies its head.  It will be
printed beside KEY in the echo erea if `hydra-is-helpful' is not
nil.  If you don't even want the KEY to be printed, set HINT
explicitly to nil.

The heads inherit their PLIST from BODY-PLIST and are allowed to
override some keys.  The keys recognized are :exit and :bind.
:exit can be:

- nil (default): this head will continue the Hydra state.
- t: this head will stop the Hydra state.

:bind can be:
- nil: this head will not be bound in BODY-MAP.
- a lambda taking KEY and CMD used to bind a head.

It is possible to omit both BODY-MAP and BODY-KEY if you don't
want to bind anything.  In that case, typically you will bind the
generated NAME/body command.  This command is also the return
result of `defhydra'.

\(fn NAME BODY &optional DOCSTRING &rest HEADS)" nil t)

(function-put 'defhydra 'lisp-indent-function 'defun)

(function-put 'defhydra 'doc-string-elt '3)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "hydra/hydra" '("hydra-" "defhydradio")))

;;;***

;;;### (autoloads nil "hydra/hydra-examples" "hydra/hydra-examples.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from hydra/hydra-examples.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "hydra/hydra-examples" '("hydra-" "org-agenda-cts" "whitespace-mode")))

;;;***

;;;### (autoloads nil "hydra/hydra-ox" "hydra/hydra-ox.el" (0 0 0
;;;;;;  0))
;;; Generated autoloads from hydra/hydra-ox.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "hydra/hydra-ox" '("hydra-ox")))

;;;***

;;;### (autoloads nil "hydra/hydra-test" "hydra/hydra-test.el" (0
;;;;;;  0 0 0))
;;; Generated autoloads from hydra/hydra-test.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "hydra/hydra-test" '("hydra-" "remap")))

;;;***

;;;### (autoloads nil "hydra/lv" "hydra/lv.el" (0 0 0 0))
;;; Generated autoloads from hydra/lv.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "hydra/lv" '("lv-")))

;;;***

;;;### (autoloads nil "idle-highlight-mode/idle-highlight-mode" "idle-highlight-mode/idle-highlight-mode.el"
;;;;;;  (21268 30412 0 0))
;;; Generated autoloads from idle-highlight-mode/idle-highlight-mode.el

(autoload 'idle-highlight-mode "idle-highlight-mode/idle-highlight-mode" "\
Idle-Highlight Minor Mode

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads nil "json-mode/json-mode" "json-mode/json-mode.el"
;;;;;;  (21704 62826 0 0))
;;; Generated autoloads from json-mode/json-mode.el

(autoload 'json-mode "json-mode/json-mode" "\
Major mode for editing JSON files

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("\\.json$" . json-mode))

(autoload 'json-mode-show-path "json-mode/json-mode" "\


\(fn)" t nil)

(autoload 'json-mode-beautify "json-mode/json-mode" "\
Beautify / pretty-print the active region (or the entire buffer if no active region).

\(fn)" t nil)

;;;***

;;;### (autoloads nil "json-snatcher/json-snatcher" "json-snatcher/json-snatcher.el"
;;;;;;  (21389 57836 0 0))
;;; Generated autoloads from json-snatcher/json-snatcher.el

(autoload 'jsons-print-path "json-snatcher/json-snatcher" "\
Print the path to the JSON value under point, and save it in the kill ring.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "language-detection/language-detection" "language-detection/language-detection.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from language-detection/language-detection.el

(autoload 'language-detection-buffer "language-detection/language-detection" "\
Predict the programming language of the current buffer and output it to messages.

\(fn &optional PRINT-MESSAGE)" t nil)

(autoload 'language-detection-string "language-detection/language-detection" "\
Return the predicted programming language of STRING as a symbol.

\(fn STRING)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "language-detection/language-detection" '("language-detection-")))

;;;***

;;;### (autoloads nil "let-alist/let-alist" "let-alist/let-alist.el"
;;;;;;  (22061 64466 0 0))
;;; Generated autoloads from let-alist/let-alist.el

(autoload 'let-alist "let-alist/let-alist" "\
Let-bind dotted symbols to their cdrs in ALIST and execute BODY.
Dotted symbol is any symbol starting with a `.'.  Only those present
in BODY are let-bound and this search is done at compile time.

For instance, the following code

  (let-alist alist
    (if (and .title .body)
        .body
      .site
      .site.contents))

essentially expands to

  (let ((.title (cdr (assq 'title alist)))
        (.body  (cdr (assq 'body alist)))
        (.site  (cdr (assq 'site alist)))
        (.site.contents (cdr (assq 'contents (cdr (assq 'site alist))))))
    (if (and .title .body)
        .body
      .site
      .site.contents))

If you nest `let-alist' invocations, the inner one can't access
the variables of the outer one. You can, however, access alists
inside the original alist by using dots inside the symbol, as
displayed in the example above.

\(fn ALIST &rest BODY)" nil t)

(put 'let-alist 'lisp-indent-function '1)

;;;***

;;;### (autoloads nil "llvm-mode/llvm-mode" "llvm-mode/llvm-mode.el"
;;;;;;  (21704 62845 0 0))
;;; Generated autoloads from llvm-mode/llvm-mode.el

(autoload 'llvm-mode "llvm-mode/llvm-mode" "\
Major mode for editing LLVM source files.
\\{llvm-mode-map}
  Runs `llvm-mode-hook' on startup.

\(fn)" t nil)

(add-to-list 'auto-mode-alist (cons (purecopy "\\.ll\\'") 'llvm-mode))

;;;***

;;;### (autoloads nil "lsp-ivy/lsp-ivy" "lsp-ivy/lsp-ivy.el" (0 0
;;;;;;  0 0))
;;; Generated autoloads from lsp-ivy/lsp-ivy.el

(autoload 'lsp-ivy-workspace-symbol "lsp-ivy/lsp-ivy" "\
`ivy' for lsp workspace/symbol.
When called with prefix ARG the default selection will be symbol at point.

\(fn ARG)" t nil)

(autoload 'lsp-ivy-global-workspace-symbol "lsp-ivy/lsp-ivy" "\
`ivy' for lsp workspace/symbol for all of the current workspaces.
When called with prefix ARG the default selection will be symbol at point.

\(fn ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-ivy/lsp-ivy" '("lsp-ivy-")))

;;;***

;;;### (autoloads nil "lsp-mode/lsp-ada" "lsp-mode/lsp-ada.el" (0
;;;;;;  0 0 0))
;;; Generated autoloads from lsp-mode/lsp-ada.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-mode/lsp-ada" '("lsp-ada-")))

;;;***

;;;### (autoloads nil "lsp-mode/lsp-bash" "lsp-mode/lsp-bash.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from lsp-mode/lsp-bash.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-mode/lsp-bash" '("lsp-bash-")))

;;;***

;;;### (autoloads nil "lsp-mode/lsp-clients" "lsp-mode/lsp-clients.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from lsp-mode/lsp-clients.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-mode/lsp-clients" '("parse-rf-language-server-" "expand-start-command" "lsp-")))

;;;***

;;;### (autoloads nil "lsp-mode/lsp-clojure" "lsp-mode/lsp-clojure.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from lsp-mode/lsp-clojure.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-mode/lsp-clojure" '("lsp-clojure-")))

;;;***

;;;### (autoloads nil "lsp-mode/lsp-completion" "lsp-mode/lsp-completion.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from lsp-mode/lsp-completion.el

(define-obsolete-variable-alias 'lsp-prefer-capf 'lsp-completion-provider "lsp-mode 7.0.1")

(autoload 'lsp-completion-at-point "lsp-mode/lsp-completion" "\
Get lsp completions.

\(fn)" nil nil)

(autoload 'lsp-completion--enable "lsp-mode/lsp-completion" "\
Enable LSP completion support.

\(fn)" nil nil)

(autoload 'lsp-completion-mode "lsp-mode/lsp-completion" "\
Toggle LSP completion support.

\(fn &optional ARG)" t nil)

(add-hook 'lsp-configure-hook (lambda nil (when (and lsp-auto-configure lsp-completion-enable) (lsp-completion--enable))))

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-mode/lsp-completion" '("lsp-completion-")))

;;;***

;;;### (autoloads nil "lsp-mode/lsp-cpp" "lsp-mode/lsp-cpp.el" (0
;;;;;;  0 0 0))
;;; Generated autoloads from lsp-mode/lsp-cpp.el

(autoload 'lsp-cpp-flycheck-clang-tidy-error-explainer "lsp-mode/lsp-cpp" "\
Explain a clang-tidy ERROR by scraping documentation from llvm.org.

\(fn ERROR)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-mode/lsp-cpp" '("lsp-cpp-flycheck-clang-tidy--")))

;;;***

;;;### (autoloads nil "lsp-mode/lsp-crystal" "lsp-mode/lsp-crystal.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from lsp-mode/lsp-crystal.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-mode/lsp-crystal" '("lsp-clients-crystal-executable")))

;;;***

;;;### (autoloads nil "lsp-mode/lsp-csharp" "lsp-mode/lsp-csharp.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from lsp-mode/lsp-csharp.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-mode/lsp-csharp" '("lsp-csharp-")))

;;;***

;;;### (autoloads nil "lsp-mode/lsp-css" "lsp-mode/lsp-css.el" (0
;;;;;;  0 0 0))
;;; Generated autoloads from lsp-mode/lsp-css.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-mode/lsp-css" '("lsp-css-")))

;;;***

;;;### (autoloads nil "lsp-mode/lsp-diagnostics" "lsp-mode/lsp-diagnostics.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from lsp-mode/lsp-diagnostics.el

(define-obsolete-variable-alias 'lsp-diagnostic-package 'lsp-diagnostics-provider "lsp-mode 7.0.1")

(define-obsolete-variable-alias 'lsp-flycheck-default-level 'lsp-diagnostics-flycheck-default-level "lsp-mode 7.0.1")

(autoload 'lsp-diagnostics--enable "lsp-mode/lsp-diagnostics" "\
Enable LSP checker support.

\(fn)" nil nil)

(autoload 'lsp-diagnostics-mode "lsp-mode/lsp-diagnostics" "\
Toggle LSP diagnostics integration.

\(fn &optional ARG)" t nil)

(add-hook 'lsp-configure-hook (lambda nil (when lsp-auto-configure (lsp-diagnostics--enable))))

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-mode/lsp-diagnostics" '("lsp-diagnostics-")))

;;;***

;;;### (autoloads nil "lsp-mode/lsp-dockerfile" "lsp-mode/lsp-dockerfile.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from lsp-mode/lsp-dockerfile.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-mode/lsp-dockerfile" '("lsp-dockerfile-language-server-command")))

;;;***

;;;### (autoloads nil "lsp-mode/lsp-elm" "lsp-mode/lsp-elm.el" (0
;;;;;;  0 0 0))
;;; Generated autoloads from lsp-mode/lsp-elm.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-mode/lsp-elm" '("lsp-")))

;;;***

;;;### (autoloads nil "lsp-mode/lsp-erlang" "lsp-mode/lsp-erlang.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from lsp-mode/lsp-erlang.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-mode/lsp-erlang" '("lsp-erlang-server-")))

;;;***

;;;### (autoloads nil "lsp-mode/lsp-eslint" "lsp-mode/lsp-eslint.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from lsp-mode/lsp-eslint.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-mode/lsp-eslint" '("lsp-")))

;;;***

;;;### (autoloads nil "lsp-mode/lsp-fsharp" "lsp-mode/lsp-fsharp.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from lsp-mode/lsp-fsharp.el

(autoload 'lsp-fsharp--workspace-load "lsp-mode/lsp-fsharp" "\
Load all of the provided PROJECTS.

\(fn PROJECTS)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-mode/lsp-fsharp" '("lsp-fsharp-")))

;;;***

;;;### (autoloads nil "lsp-mode/lsp-gdscript" "lsp-mode/lsp-gdscript.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from lsp-mode/lsp-gdscript.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-mode/lsp-gdscript" '("lsp-gdscript-")))

;;;***

;;;### (autoloads nil "lsp-mode/lsp-go" "lsp-mode/lsp-go.el" (0 0
;;;;;;  0 0))
;;; Generated autoloads from lsp-mode/lsp-go.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-mode/lsp-go" '("lsp-go-")))

;;;***

;;;### (autoloads nil "lsp-mode/lsp-haxe" "lsp-mode/lsp-haxe.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from lsp-mode/lsp-haxe.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-mode/lsp-haxe" '("lsp-")))

;;;***

;;;### (autoloads nil "lsp-mode/lsp-headerline" "lsp-mode/lsp-headerline.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from lsp-mode/lsp-headerline.el

(autoload 'lsp-headerline-breadcrumb-mode "lsp-mode/lsp-headerline" "\
Toggle breadcrumb on headerline.

\(fn &optional ARG)" t nil)

(autoload 'lsp-breadcrumb-go-to-symbol "lsp-mode/lsp-headerline" "\
Go to the symbol on breadcrumb at SYMBOL-POSITION.

\(fn SYMBOL-POSITION)" t nil)

(autoload 'lsp-breadcrumb-narrow-to-symbol "lsp-mode/lsp-headerline" "\
Narrow to the symbol range on breadcrumb at SYMBOL-POSITION.

\(fn SYMBOL-POSITION)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-mode/lsp-headerline" '("lsp-headerline-")))

;;;***

;;;### (autoloads nil "lsp-mode/lsp-html" "lsp-mode/lsp-html.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from lsp-mode/lsp-html.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-mode/lsp-html" '("lsp-html-")))

;;;***

;;;### (autoloads nil "lsp-mode/lsp-intelephense" "lsp-mode/lsp-intelephense.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from lsp-mode/lsp-intelephense.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-mode/lsp-intelephense" '("lsp-intelephense-")))

;;;***

;;;### (autoloads nil "lsp-mode/lsp-json" "lsp-mode/lsp-json.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from lsp-mode/lsp-json.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-mode/lsp-json" '("lsp-")))

;;;***

;;;### (autoloads nil "lsp-mode/lsp-lens" "lsp-mode/lsp-lens.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from lsp-mode/lsp-lens.el

(autoload 'lsp-lens-show "lsp-mode/lsp-lens" "\
Display lenses in the buffer.

\(fn)" t nil)

(autoload 'lsp-lens-hide "lsp-mode/lsp-lens" "\
Delete all lenses.

\(fn)" t nil)

(autoload 'lsp-lens-mode "lsp-mode/lsp-lens" "\
Toggle code-lens overlays.

\(fn &optional ARG)" t nil)

(autoload 'lsp-avy-lens "lsp-mode/lsp-lens" "\
Click lsp lens using `avy' package.

\(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-mode/lsp-lens" '("lsp-lens-")))

;;;***

;;;### (autoloads nil "lsp-mode/lsp-lua" "lsp-mode/lsp-lua.el" (0
;;;;;;  0 0 0))
;;; Generated autoloads from lsp-mode/lsp-lua.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-mode/lsp-lua" '("lsp-clients-")))

;;;***

;;;### (autoloads nil "lsp-mode/lsp-mode" "lsp-mode/lsp-mode.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from lsp-mode/lsp-mode.el
(put 'lsp-enable-file-watchers 'safe-local-variable #'booleanp)
(put 'lsp-file-watch-threshold 'safe-local-variable (lambda (i) (or (numberp i) (not i))))

(autoload 'lsp "lsp-mode/lsp-mode" "\
Entry point for the server startup.
When ARG is t the lsp mode will start new language server even if
there is language server which can handle current language. When
ARG is nil current file will be opened in multi folder language
server if there is such. When `lsp' is called with prefix
argument ask the user to select which language server to start.

\(fn &optional ARG)" t nil)

(autoload 'lsp-deferred "lsp-mode/lsp-mode" "\
Entry point that defers server startup until buffer is visible.
`lsp-deferred' will wait until the buffer is visible before invoking `lsp'.
This avoids overloading the server with many files when starting Emacs.

\(fn)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-mode/lsp-mode" '("lsp-" "make-lsp-client" "with-lsp-workspace" "when-lsp-workspace")))

;;;***

;;;### (autoloads nil "lsp-mode/lsp-modeline" "lsp-mode/lsp-modeline.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from lsp-mode/lsp-modeline.el

(define-obsolete-variable-alias 'lsp-diagnostics-modeline-scope 'lsp-modeline-diagnostics-scope "lsp-mode 7.0.1")

(autoload 'lsp-modeline-code-actions-mode "lsp-mode/lsp-modeline" "\
Toggle code actions on modeline.

\(fn &optional ARG)" t nil)

(define-obsolete-function-alias 'lsp-diagnostics-modeline-mode 'lsp-modeline-diagnostics-mode "lsp-mode 7.0.1")

(autoload 'lsp-modeline-diagnostics-mode "lsp-mode/lsp-modeline" "\
Toggle diagnostics modeline.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-mode/lsp-modeline" '("lsp-")))

;;;***

;;;### (autoloads nil "lsp-mode/lsp-perl" "lsp-mode/lsp-perl.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from lsp-mode/lsp-perl.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-mode/lsp-perl" '("lsp-perl-")))

;;;***

;;;### (autoloads nil "lsp-mode/lsp-protocol" "lsp-mode/lsp-protocol.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from lsp-mode/lsp-protocol.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-mode/lsp-protocol" '("lsp" "dash-expand:&RangeToPoint")))

;;;***

;;;### (autoloads nil "lsp-mode/lsp-pwsh" "lsp-mode/lsp-pwsh.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from lsp-mode/lsp-pwsh.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-mode/lsp-pwsh" '("lsp-pwsh-")))

;;;***

;;;### (autoloads nil "lsp-mode/lsp-pyls" "lsp-mode/lsp-pyls.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from lsp-mode/lsp-pyls.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-mode/lsp-pyls" '("lsp-")))

;;;***

;;;### (autoloads nil "lsp-mode/lsp-r" "lsp-mode/lsp-r.el" (0 0 0
;;;;;;  0))
;;; Generated autoloads from lsp-mode/lsp-r.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-mode/lsp-r" '("lsp-clients-r-server-command")))

;;;***

;;;### (autoloads nil "lsp-mode/lsp-rust" "lsp-mode/lsp-rust.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from lsp-mode/lsp-rust.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-mode/lsp-rust" '("lsp-")))

;;;***

;;;### (autoloads nil "lsp-mode/lsp-serenata" "lsp-mode/lsp-serenata.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from lsp-mode/lsp-serenata.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-mode/lsp-serenata" '("lsp-serenata-")))

;;;***

;;;### (autoloads nil "lsp-mode/lsp-solargraph" "lsp-mode/lsp-solargraph.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from lsp-mode/lsp-solargraph.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-mode/lsp-solargraph" '("lsp-solargraph-")))

;;;***

;;;### (autoloads nil "lsp-mode/lsp-sqls" "lsp-mode/lsp-sqls.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from lsp-mode/lsp-sqls.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-mode/lsp-sqls" '("lsp-sqls-")))

;;;***

;;;### (autoloads nil "lsp-mode/lsp-terraform" "lsp-mode/lsp-terraform.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from lsp-mode/lsp-terraform.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-mode/lsp-terraform" '("lsp-terraform-")))

;;;***

;;;### (autoloads nil "lsp-mode/lsp-verilog" "lsp-mode/lsp-verilog.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from lsp-mode/lsp-verilog.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-mode/lsp-verilog" '("lsp-clients-verilog-executable")))

;;;***

;;;### (autoloads nil "lsp-mode/lsp-vetur" "lsp-mode/lsp-vetur.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from lsp-mode/lsp-vetur.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-mode/lsp-vetur" '("lsp-")))

;;;***

;;;### (autoloads nil "lsp-mode/lsp-vhdl" "lsp-mode/lsp-vhdl.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from lsp-mode/lsp-vhdl.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-mode/lsp-vhdl" '("lsp-vhdl-" "ghdl-ls-bin-name" "vhdl-" "hdl-checker-bin-name")))

;;;***

;;;### (autoloads nil "lsp-mode/lsp-xml" "lsp-mode/lsp-xml.el" (0
;;;;;;  0 0 0))
;;; Generated autoloads from lsp-mode/lsp-xml.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-mode/lsp-xml" '("lsp-xml-")))

;;;***

;;;### (autoloads nil "lsp-mode/lsp-yaml" "lsp-mode/lsp-yaml.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from lsp-mode/lsp-yaml.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-mode/lsp-yaml" '("lsp-yaml-")))

;;;***

;;;### (autoloads nil "lsp-ui/lsp-ui" "lsp-ui/lsp-ui.el" (0 0 0 0))
;;; Generated autoloads from lsp-ui/lsp-ui.el

(autoload 'lsp-ui-mode "lsp-ui/lsp-ui" "\
Toggle language server UI mode on or off.
‘lsp-ui-mode’ is a minor mode that contains a series of useful UI
integrations for ‘lsp-mode’.  With a prefix argument ARG, enable
language server UI mode if ARG is positive, and disable it
otherwise.  If called from Lisp, enable the mode if ARG is
omitted or nil, and toggle it if ARG is ‘toggle’.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-ui/lsp-ui" '("lsp-ui-")))

;;;***

;;;### (autoloads nil "lsp-ui/lsp-ui-doc" "lsp-ui/lsp-ui-doc.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from lsp-ui/lsp-ui-doc.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-ui/lsp-ui-doc" '("lsp-ui-doc-")))

;;;***

;;;### (autoloads nil "lsp-ui/lsp-ui-flycheck" "lsp-ui/lsp-ui-flycheck.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from lsp-ui/lsp-ui-flycheck.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-ui/lsp-ui-flycheck" '("lsp-ui-flycheck-")))

;;;***

;;;### (autoloads nil "lsp-ui/lsp-ui-imenu" "lsp-ui/lsp-ui-imenu.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from lsp-ui/lsp-ui-imenu.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-ui/lsp-ui-imenu" '("lsp-ui-imenu")))

;;;***

;;;### (autoloads nil "lsp-ui/lsp-ui-peek" "lsp-ui/lsp-ui-peek.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from lsp-ui/lsp-ui-peek.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-ui/lsp-ui-peek" '("lsp-ui-peek-")))

;;;***

;;;### (autoloads nil "lsp-ui/lsp-ui-sideline" "lsp-ui/lsp-ui-sideline.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from lsp-ui/lsp-ui-sideline.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-ui/lsp-ui-sideline" '("lsp-ui-sideline")))

;;;***

;;;### (autoloads nil "macrostep/macrostep" "macrostep/macrostep.el"
;;;;;;  (21610 63980 0 0))
;;; Generated autoloads from macrostep/macrostep.el

(autoload 'macrostep-mode "macrostep/macrostep" "\
Minor mode for inline expansion of macros in Emacs Lisp source buffers.

\\<macrostep-keymap>Progressively expand macro forms with \\[macrostep-expand], collapse them with \\[macrostep-collapse],
and move back and forth with \\[macrostep-next-macro] and \\[macrostep-prev-macro].
Use \\[macrostep-collapse-all] or collapse all visible expansions to
quit and return to normal editing.

\\{macrostep-keymap}

\(fn &optional ARG)" t nil)

(autoload 'macrostep-expand "macrostep/macrostep" "\
Expand the Elisp macro form following point by one step.

Enters `macrostep-mode' if it is not already active, making the
buffer temporarily read-only. If macrostep-mode is active and the
form following point is not a macro form, search forward in the
buffer and expand the next macro form found, if any.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "magit-popup/magit-popup" "magit-popup/magit-popup.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit-popup/magit-popup.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit-popup/magit-popup" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/git-commit" "magit/lisp/git-commit.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/git-commit.el

(defvar global-git-commit-mode t "\
Non-nil if Global Git-Commit mode is enabled.
See the `global-git-commit-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `global-git-commit-mode'.")

(custom-autoload 'global-git-commit-mode "magit/lisp/git-commit" nil)

(autoload 'global-git-commit-mode "magit/lisp/git-commit" "\
Edit Git commit messages.
This global mode arranges for `git-commit-setup' to be called
when a Git commit message file is opened.  That usually happens
when Git uses the Emacsclient as $GIT_EDITOR to have the user
provide such a commit message.

\(fn &optional ARG)" t nil)

(defconst git-commit-filename-regexp "/\\(\\(\\(COMMIT\\|NOTES\\|PULLREQ\\|TAG\\)_EDIT\\|MERGE_\\|\\)MSG\\|\\(BRANCH\\|EDIT\\)_DESCRIPTION\\)\\'")

(autoload 'git-commit-setup-check-buffer "magit/lisp/git-commit" "\


\(fn)" nil nil)

(autoload 'git-commit-setup "magit/lisp/git-commit" "\


\(fn)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/git-commit" '("git-commit-")))

;;;***

;;;### (autoloads nil "magit/lisp/git-rebase" "magit/lisp/git-rebase.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/git-rebase.el

(autoload 'git-rebase-mode "magit/lisp/git-rebase" "\
Major mode for editing of a Git rebase file.

Rebase files are generated when you run 'git rebase -i' or run
`magit-interactive-rebase'.  They describe how Git should perform
the rebase.  See the documentation for git-rebase (e.g., by
running 'man git-rebase' at the command line) for details.

\(fn)" t nil)

(defconst git-rebase-filename-regexp "/git-rebase-todo\\'")

(add-to-list 'auto-mode-alist (cons git-rebase-filename-regexp 'git-rebase-mode))

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/git-rebase" '("git-rebase-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit" "magit/lisp/magit.el" (0
;;;;;;  0 0 0))
;;; Generated autoloads from magit/lisp/magit.el
 (autoload 'magit-dispatch-popup "magit" nil t)
 (autoload 'magit-run-popup "magit" nil t)

(autoload 'magit-git-command "magit/lisp/magit" "\
Execute COMMAND asynchronously; display output.

Interactively, prompt for COMMAND in the minibuffer. \"git \" is
used as initial input, but can be deleted to run another command.

With a prefix argument COMMAND is run in the top-level directory
of the current working tree, otherwise in `default-directory'.

\(fn COMMAND)" t nil)

(autoload 'magit-git-command-topdir "magit/lisp/magit" "\
Execute COMMAND asynchronously; display output.

Interactively, prompt for COMMAND in the minibuffer. \"git \" is
used as initial input, but can be deleted to run another command.

COMMAND is run in the top-level directory of the current
working tree.

\(fn COMMAND)" t nil)

(autoload 'magit-shell-command "magit/lisp/magit" "\
Execute COMMAND asynchronously; display output.

Interactively, prompt for COMMAND in the minibuffer.  With a
prefix argument COMMAND is run in the top-level directory of
the current working tree, otherwise in `default-directory'.

\(fn COMMAND)" t nil)

(autoload 'magit-shell-command-topdir "magit/lisp/magit" "\
Execute COMMAND asynchronously; display output.

Interactively, prompt for COMMAND in the minibuffer.  COMMAND
is run in the top-level directory of the current working tree.

\(fn COMMAND)" t nil)

(autoload 'magit-version "magit/lisp/magit" "\
Return the version of Magit currently in use.
If optional argument PRINT-DEST is non-nil, output
stream (interactively, the echo area, or the current buffer with
a prefix argument), also print the used versions of Magit, Git,
and Emacs to it.

\(fn &optional PRINT-DEST)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-apply" "magit/lisp/magit-apply.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-apply.el

(autoload 'magit-stage-file "magit/lisp/magit-apply" "\
Stage all changes to FILE.
With a prefix argument or when there is no file at point ask for
the file to be staged.  Otherwise stage the file at point without
requiring confirmation.

\(fn FILE)" t nil)

(autoload 'magit-stage-modified "magit/lisp/magit-apply" "\
Stage all changes to files modified in the worktree.
Stage all new content of tracked files and remove tracked files
that no longer exist in the working tree from the index also.
With a prefix argument also stage previously untracked (but not
ignored) files.

\(fn &optional ALL)" t nil)

(autoload 'magit-unstage-file "magit/lisp/magit-apply" "\
Unstage all changes to FILE.
With a prefix argument or when there is no file at point ask for
the file to be unstaged.  Otherwise unstage the file at point
without requiring confirmation.

\(fn FILE)" t nil)

(autoload 'magit-unstage-all "magit/lisp/magit-apply" "\
Remove all changes from the staging area.

\(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-apply" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-autorevert" "magit/lisp/magit-autorevert.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-autorevert.el

(defvar magit-auto-revert-mode (and (not global-auto-revert-mode) (not noninteractive)) "\
Non-nil if Magit-Auto-Revert mode is enabled.
See the `magit-auto-revert-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `magit-auto-revert-mode'.")

(custom-autoload 'magit-auto-revert-mode "magit/lisp/magit-autorevert" nil)

(autoload 'magit-auto-revert-mode "magit/lisp/magit-autorevert" "\
Toggle Auto-Revert mode in all buffers.
With prefix ARG, enable Magit-Auto-Revert mode if ARG is positive;
otherwise, disable it.  If called from Lisp, enable the mode if
ARG is omitted or nil.

Auto-Revert mode is enabled in all buffers where
`magit-turn-on-auto-revert-mode-if-desired' would do it.
See `auto-revert-mode' for more information on Auto-Revert mode.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-autorevert" '("auto-revert-buffer" "magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-bisect" "magit/lisp/magit-bisect.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-bisect.el
 (autoload 'magit-bisect-popup "magit-bisect" nil t)

(autoload 'magit-bisect-start "magit/lisp/magit-bisect" "\
Start a bisect session.

Bisecting a bug means to find the commit that introduced it.
This command starts such a bisect session by asking for a know
good and a bad commit.  To move the session forward use the
other actions from the bisect popup (\\<magit-status-mode-map>\\[magit-bisect-popup]).

\(fn BAD GOOD)" t nil)

(autoload 'magit-bisect-reset "magit/lisp/magit-bisect" "\
After bisecting, cleanup bisection state and return to original `HEAD'.

\(fn)" t nil)

(autoload 'magit-bisect-good "magit/lisp/magit-bisect" "\
While bisecting, mark the current commit as good.
Use this after you have asserted that the commit does not contain
the bug in question.

\(fn)" t nil)

(autoload 'magit-bisect-bad "magit/lisp/magit-bisect" "\
While bisecting, mark the current commit as bad.
Use this after you have asserted that the commit does contain the
bug in question.

\(fn)" t nil)

(autoload 'magit-bisect-skip "magit/lisp/magit-bisect" "\
While bisecting, skip the current commit.
Use this if for some reason the current commit is not a good one
to test.  This command lets Git choose a different one.

\(fn)" t nil)

(autoload 'magit-bisect-run "magit/lisp/magit-bisect" "\
Bisect automatically by running commands after each step.

Unlike `git bisect run' this can be used before bisecting has
begun.  In that case it behaves like `git bisect start; git
bisect run'.

\(fn CMDLINE &optional BAD GOOD)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-bisect" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-blame" "magit/lisp/magit-blame.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-blame.el

(autoload 'magit-blame-echo "magit/lisp/magit-blame" "\
For each line show the revision in which it was added.
Show the information about the chunk at point in the echo area
when moving between chunks.  Unlike other blaming commands, do
not turn on `read-only-mode'.

\(fn)" t nil)

(autoload 'magit-blame-addition "magit/lisp/magit-blame" "\
For each line show the revision in which it was added.

\(fn)" t nil)

(autoload 'magit-blame-removal "magit/lisp/magit-blame" "\
For each line show the revision in which it was removed.

\(fn)" t nil)

(autoload 'magit-blame-reverse "magit/lisp/magit-blame" "\
For each line show the last revision in which it still exists.

\(fn)" t nil)
 (autoload 'magit-blame-popup "magit-blame" nil t)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-blame" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-bookmark" "magit/lisp/magit-bookmark.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-bookmark.el

(autoload 'magit-bookmark--status-jump "magit/lisp/magit-bookmark" "\
Handle a Magit status BOOKMARK.

\(fn BOOKMARK)" nil nil)

(autoload 'magit-bookmark--status-make-record "magit/lisp/magit-bookmark" "\
Create a Magit status bookmark.

\(fn)" nil nil)

(autoload 'magit-bookmark--refs-jump "magit/lisp/magit-bookmark" "\
Handle a Magit refs BOOKMARK.

\(fn BOOKMARK)" nil nil)

(autoload 'magit-bookmark--refs-make-record "magit/lisp/magit-bookmark" "\
Create a Magit refs bookmark.

\(fn)" nil nil)

(autoload 'magit-bookmark--log-jump "magit/lisp/magit-bookmark" "\
Handle a Magit log BOOKMARK.

\(fn BOOKMARK)" nil nil)

(autoload 'magit-bookmark--log-make-record "magit/lisp/magit-bookmark" "\
Create a Magit log bookmark.

\(fn)" nil nil)

(autoload 'magit-bookmark--reflog-jump "magit/lisp/magit-bookmark" "\
Handle a Magit reflog BOOKMARK.

\(fn BOOKMARK)" nil nil)

(autoload 'magit-bookmark--reflog-make-record "magit/lisp/magit-bookmark" "\
Create a Magit reflog bookmark.

\(fn)" nil nil)

(autoload 'magit-bookmark--stashes-jump "magit/lisp/magit-bookmark" "\
Handle a Magit stash list BOOKMARK.

\(fn BOOKMARK)" nil nil)

(autoload 'magit-bookmark--stashes-make-record "magit/lisp/magit-bookmark" "\
Create a Magit stash list bookmark.

\(fn)" nil nil)

(autoload 'magit-bookmark--cherry-jump "magit/lisp/magit-bookmark" "\
Handle a Magit cherry BOOKMARK.

\(fn BOOKMARK)" nil nil)

(autoload 'magit-bookmark--cherry-make-record "magit/lisp/magit-bookmark" "\
Create a Magit cherry bookmark.

\(fn)" nil nil)

(autoload 'magit-bookmark--diff-jump "magit/lisp/magit-bookmark" "\
Handle a Magit diff BOOKMARK.

\(fn BOOKMARK)" nil nil)

(autoload 'magit-bookmark--diff-make-record "magit/lisp/magit-bookmark" "\
Create a Magit diff bookmark.

\(fn)" nil nil)

(autoload 'magit-bookmark--revision-jump "magit/lisp/magit-bookmark" "\
Handle a Magit revision BOOKMARK.

\(fn BOOKMARK)" nil nil)

(autoload 'magit-bookmark--revision-make-record "magit/lisp/magit-bookmark" "\
Create a Magit revision bookmark.

\(fn)" nil nil)

(autoload 'magit-bookmark--stash-jump "magit/lisp/magit-bookmark" "\
Handle a Magit stash BOOKMARK.

\(fn BOOKMARK)" nil nil)

(autoload 'magit-bookmark--stash-make-record "magit/lisp/magit-bookmark" "\
Create a Magit stash bookmark.

\(fn)" nil nil)

(autoload 'magit-bookmark--submodules-jump "magit/lisp/magit-bookmark" "\
Handle a Magit submodule list BOOKMARK.

\(fn BOOKMARK)" nil nil)

(autoload 'magit-bookmark--submodules-make-record "magit/lisp/magit-bookmark" "\
Create a Magit submodule list bookmark.

\(fn)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-bookmark" '("magit-bookmark--")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-branch" "magit/lisp/magit-branch.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-branch.el
 (autoload 'magit-branch-popup "magit" nil t)

(autoload 'magit-checkout "magit/lisp/magit-branch" "\
Checkout REVISION, updating the index and the working tree.
If REVISION is a local branch, then that becomes the current
branch.  If it is something else, then `HEAD' becomes detached.
Checkout fails if the working tree or the staging area contain
changes.

\(git checkout REVISION).

\(fn REVISION)" t nil)

(autoload 'magit-branch-create "magit/lisp/magit-branch" "\
Create BRANCH at branch or revision START-POINT.

\(git branch [ARGS] BRANCH START-POINT).

\(fn BRANCH START-POINT &optional ARGS)" t nil)

(autoload 'magit-branch-and-checkout "magit/lisp/magit-branch" "\
Create and checkout BRANCH at branch or revision START-POINT.

\(git checkout [ARGS] -b BRANCH START-POINT).

\(fn BRANCH START-POINT &optional ARGS)" t nil)

(autoload 'magit-branch-or-checkout "magit/lisp/magit-branch" "\
Hybrid between `magit-checkout' and `magit-branch-and-checkout'.

Ask the user for an existing branch or revision.  If the user
input actually can be resolved as a branch or revision, then
check that out, just like `magit-checkout' would.

Otherwise create and checkout a new branch using the input as
its name.  Before doing so read the starting-point for the new
branch.  This is similar to what `magit-branch-and-checkout'
does.

\(fn ARG &optional START-POINT)" t nil)

(autoload 'magit-branch-checkout "magit/lisp/magit-branch" "\
Checkout an existing or new local branch.

Read a branch name from the user offering all local branches and
a subset of remote branches as candidates.  Omit remote branches
for which a local branch by the same name exists from the list
of candidates.  The user can also enter a completely new branch
name.

- If the user selects an existing local branch, then check that
  out.

- If the user selects a remote branch, then create and checkout
  a new local branch with the same name.  Configure the selected
  remote branch as push target.

- If the user enters a new branch name, then create and check
  that out, after also reading the starting-point from the user.

In the latter two cases the upstream is also set.  Whether it is
set to the chosen START-POINT or something else depends on the
value of `magit-branch-adjust-remote-upstream-alist', just like
when using `magit-branch-and-checkout'.

\(fn BRANCH &optional START-POINT)" t nil)

(autoload 'magit-branch-orphan "magit/lisp/magit-branch" "\
Create and checkout an orphan BRANCH with contents from revision START-POINT.

\(git checkout --orphan [ARGS] BRANCH START-POINT).

\(fn BRANCH START-POINT &optional ARGS)" t nil)

(autoload 'magit-branch-pull-request "magit/lisp/magit-branch" "\
Create and configure a new branch from a pull-request.
Please see the manual for more information.

\(fn PR)" t nil)

(autoload 'magit-branch-spinoff "magit/lisp/magit-branch" "\
Create new branch from the unpushed commits.

Create and checkout a new branch starting at and tracking the
current branch.  That branch in turn is reset to the last commit
it shares with its upstream.  If the current branch has no
upstream or no unpushed commits, then the new branch is created
anyway and the previously current branch is not touched.

This is useful to create a feature branch after work has already
began on the old branch (likely but not necessarily \"master\").

If the current branch is a member of the value of option
`magit-branch-prefer-remote-upstream' (which see), then the
current branch will be used as the starting point as usual, but
the upstream of the starting-point may be used as the upstream
of the new branch, instead of the starting-point itself.

If optional FROM is non-nil, then the source branch is reset
to `FROM~', instead of to the last commit it shares with its
upstream.  Interactively, FROM is only ever non-nil, if the
region selects some commits, and among those commits, FROM is
the commit that is the fewest commits ahead of the source
branch.

The commit at the other end of the selection actually does not
matter, all commits between FROM and `HEAD' are moved to the new
branch.  If FROM is not reachable from `HEAD' or is reachable
from the source branch's upstream, then an error is raised.

\(fn BRANCH &optional FROM &rest ARGS)" t nil)

(autoload 'magit-branch-reset "magit/lisp/magit-branch" "\
Reset a branch to the tip of another branch or any other commit.

When the branch being reset is the current branch, then do a
hard reset.  If there are any uncommitted changes, then the user
has to confirm the reset because those changes would be lost.

This is useful when you have started work on a feature branch but
realize it's all crap and want to start over.

When resetting to another branch and a prefix argument is used,
then also set the target branch as the upstream of the branch
that is being reset.

\(fn BRANCH TO &optional ARGS SET-UPSTREAM)" t nil)

(autoload 'magit-branch-delete "magit/lisp/magit-branch" "\
Delete one or multiple branches.
If the region marks multiple branches, then offer to delete
those, otherwise prompt for a single branch to be deleted,
defaulting to the branch at point.

\(fn BRANCHES &optional FORCE)" t nil)

(autoload 'magit-branch-rename "magit/lisp/magit-branch" "\
Rename the branch named OLD to NEW.

With a prefix argument FORCE, rename even if a branch named NEW
already exists.

If `branch.OLD.pushRemote' is set, then unset it.  Depending on
the value of `magit-branch-rename-push-target' (which see) maybe
set `branch.NEW.pushRemote' and maybe rename the push-target on
the remote.

\(fn OLD NEW &optional FORCE)" t nil)

(autoload 'magit-branch-shelve "magit/lisp/magit-branch" "\
Shelve a BRANCH.
Rename \"refs/heads/BRANCH\" to \"refs/shelved/BRANCH\",
and also rename the respective reflog file.

\(fn BRANCH)" t nil)

(autoload 'magit-branch-unshelve "magit/lisp/magit-branch" "\
Unshelve a BRANCH
Rename \"refs/shelved/BRANCH\" to \"refs/heads/BRANCH\",
and also rename the respective reflog file.

\(fn BRANCH)" t nil)

(autoload 'magit-branch-config-popup "magit/lisp/magit-branch" "\
Popup console for setting branch variables.

\(fn BRANCH)" t nil)

(autoload 'magit-edit-branch*description "magit/lisp/magit-branch" "\
Edit the description of the current branch.
With a prefix argument edit the description of another branch.

The description for the branch named NAME is stored in the Git
variable `branch.<name>.description'.

\(fn BRANCH)" t nil)

(autoload 'magit-set-branch*merge/remote "magit/lisp/magit-branch" "\
Set or unset the upstream of the current branch.
With a prefix argument do so for another branch.

When the branch in question already has an upstream then simply
unsets it.  Invoke this command again to set another upstream.

Together the Git variables `branch.<name>.remote' and
`branch.<name>.merge' define the upstream branch of the local
branch named NAME.  The value of `branch.<name>.remote' is the
name of the upstream remote.  The value of `branch.<name>.merge'
is the full reference of the upstream branch, on the remote.

Non-interactively, when UPSTREAM is non-nil, then always set it
as the new upstream, regardless of whether another upstream was
already set.  When nil, then always unset.

\(fn BRANCH UPSTREAM)" t nil)

(autoload 'magit-cycle-branch*rebase "magit/lisp/magit-branch" "\
Cycle the value of `branch.<name>.rebase' for the current branch.
With a prefix argument cycle the value for another branch.

The Git variables `branch.<name>.rebase' controls whether pulling
into the branch named NAME is done by rebasing that branch onto
the fetched branch or by merging that branch.

When `true' then pulling is done by rebasing.
When `false' then pulling is done by merging.

When that variable is undefined then the value of `pull.rebase'
is used instead.  It defaults to `false'.

\(fn BRANCH)" t nil)

(autoload 'magit-cycle-branch*pushRemote "magit/lisp/magit-branch" "\
Cycle the value of `branch.<name>.pushRemote' for the current branch.
With a prefix argument cycle the value for another branch.

The Git variable `branch.<name>.pushRemote' specifies the remote
that the branch named NAME is usually pushed to.  The value has
to be the name of an existing remote.

If that variable is undefined, then the value of the Git variable
`remote.pushDefault' is used instead, provided that it is defined,
which by default it is not.

\(fn BRANCH)" t nil)

(autoload 'magit-cycle-pull\.rebase "magit/lisp/magit-branch" "\
Cycle the repository-local value of `pull.rebase'.

The Git variable `pull.rebase' specifies whether pulling is done
by rebasing or by merging.  It can be overwritten using the Git
variable `branch.<name>.rebase'.

When `true' then pulling is done by rebasing.
When `false' (the default) then pulling is done by merging.

\(fn)" t nil)

(autoload 'magit-cycle-remote\.pushDefault "magit/lisp/magit-branch" "\
Cycle the repository-local value of `remote.pushDefault'.

The Git variable `remote.pushDefault' specifies the remote that
local branches are usually pushed to.  It can be overwritten
using the Git variable `branch.<name>.pushRemote'.

\(fn)" t nil)

(autoload 'magit-cycle-branch*autoSetupMerge "magit/lisp/magit-branch" "\
Cycle the repository-local value of `branch.autoSetupMerge'.

The Git variable `branch.autoSetupMerge' under what circumstances
creating a branch (named NAME) should result in the variables
`branch.<name>.merge' and `branch.<name>.remote' being set
according to the starting point used to create the branch.  If
the starting point isn't a branch, then these variables are never
set.

When `always' then the variables are set regardless of whether
the starting point is a local or a remote branch.

When `true' (the default) then the variable are set when the
starting point is a remote branch, but not when it is a local
branch.

When `false' then the variables are never set.

\(fn)" t nil)

(autoload 'magit-cycle-branch*autoSetupRebase "magit/lisp/magit-branch" "\
Cycle the repository-local value of `branch.autoSetupRebase'.

The Git variable `branch.autoSetupRebase' specifies whether
creating a branch (named NAME) should result in the variable
`branch.<name>.rebase' being set to `true'.

When `always' then the variable is set regardless of whether the
starting point is a local or a remote branch.

When `local' then the variable are set when the starting point
is a local branch, but not when it is a remote branch.

When `remote' then the variable are set when the starting point
is a remote branch, but not when it is a local branch.

When `never' (the default) then the variable is never set.

\(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-branch" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-clone" "magit/lisp/magit-clone.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-clone.el

(autoload 'magit-clone "magit/lisp/magit-clone" "\
Clone the REPOSITORY to DIRECTORY.
Then show the status buffer for the new repository.

\(fn REPOSITORY DIRECTORY)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-clone" '("magit-clone-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-collab" "magit/lisp/magit-collab.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-collab.el

(autoload 'magit-browse-pull-request "magit/lisp/magit-collab" "\
Visit pull-request PR using `browse-url'.

Currently this only supports Github, but that restriction will
be lifted eventually to support other Git forges.

\(fn PR)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-collab" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-commit" "magit/lisp/magit-commit.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-commit.el

(autoload 'magit-commit-create "magit/lisp/magit-commit" "\
Create a new commit on `HEAD'.
With a prefix argument, amend to the commit at `HEAD' instead.

\(git commit [--amend] ARGS)

\(fn &optional ARGS)" t nil)

(autoload 'magit-commit-amend "magit/lisp/magit-commit" "\
Amend the last commit.

\(git commit --amend ARGS)

\(fn &optional ARGS)" t nil)

(autoload 'magit-commit-extend "magit/lisp/magit-commit" "\
Amend the last commit, without editing the message.

With a prefix argument keep the committer date, otherwise change
it.  The option `magit-commit-extend-override-date' can be used
to inverse the meaning of the prefix argument.
\(git commit
--amend --no-edit)

\(fn &optional ARGS OVERRIDE-DATE)" t nil)

(autoload 'magit-commit-reword "magit/lisp/magit-commit" "\
Reword the last commit, ignoring staged changes.

With a prefix argument keep the committer date, otherwise change
it.  The option `magit-commit-reword-override-date' can be used
to inverse the meaning of the prefix argument.

Non-interactively respect the optional OVERRIDE-DATE argument
and ignore the option.

\(git commit --amend --only)

\(fn &optional ARGS OVERRIDE-DATE)" t nil)

(autoload 'magit-commit-fixup "magit/lisp/magit-commit" "\
Create a fixup commit.

With a prefix argument the target COMMIT has to be confirmed.
Otherwise the commit at point may be used without confirmation
depending on the value of option `magit-commit-squash-confirm'.

\(fn &optional COMMIT ARGS)" t nil)

(autoload 'magit-commit-squash "magit/lisp/magit-commit" "\
Create a squash commit, without editing the squash message.

With a prefix argument the target COMMIT has to be confirmed.
Otherwise the commit at point may be used without confirmation
depending on the value of option `magit-commit-squash-confirm'.

\(fn &optional COMMIT ARGS)" t nil)

(autoload 'magit-commit-augment "magit/lisp/magit-commit" "\
Create a squash commit, editing the squash message.

With a prefix argument the target COMMIT has to be confirmed.
Otherwise the commit at point may be used without confirmation
depending on the value of option `magit-commit-squash-confirm'.

\(fn &optional COMMIT ARGS)" t nil)

(autoload 'magit-commit-instant-fixup "magit/lisp/magit-commit" "\
Create a fixup commit targeting COMMIT and instantly rebase.

\(fn &optional COMMIT ARGS)" t nil)

(autoload 'magit-commit-instant-squash "magit/lisp/magit-commit" "\
Create a squash commit targeting COMMIT and instantly rebase.

\(fn &optional COMMIT ARGS)" t nil)

(autoload 'magit-commit-reshelve "magit/lisp/magit-commit" "\
Change the committer date and possibly the author date of `HEAD'.

If you are the author of `HEAD', then both dates are changed,
otherwise only the committer date.  The current time is used
as the initial minibuffer input and the original author (if
that is you) or committer date is available as the previous
history element.

\(fn DATE)" t nil)
 (autoload 'magit-commit-absorb-popup "magit-commit" nil t)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-commit" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-diff" "magit/lisp/magit-diff.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-diff.el

(autoload 'magit-diff-popup "magit/lisp/magit-diff" "\
Popup console for diff commands.

\(fn ARG)" t nil)

(autoload 'magit-diff-buffer-file-popup "magit/lisp/magit-diff" "\
Popup console for diff commands.

This is a variant of `magit-diff-popup' which shows the same popup
but which limits the diff to the file being visited in the current
buffer.

\(fn)" t nil)

(autoload 'magit-diff-dwim "magit/lisp/magit-diff" "\
Show changes for the thing at point.

\(fn &optional ARGS FILES)" t nil)

(autoload 'magit-diff-range "magit/lisp/magit-diff" "\
Show differences between two commits.

REV-OR-RANGE should be a range or a single revision.  If it is a
revision, then show changes in the working tree relative to that
revision.  If it is a range, but one side is omitted, then show
changes relative to `HEAD'.

If the region is active, use the revisions on the first and last
line of the region as the two sides of the range.  With a prefix
argument, instead of diffing the revisions, choose a revision to
view changes along, starting at the common ancestor of both
revisions (i.e., use a \"...\" range).

\(fn REV-OR-RANGE &optional ARGS FILES)" t nil)

(autoload 'magit-diff-working-tree "magit/lisp/magit-diff" "\
Show changes between the current working tree and the `HEAD' commit.
With a prefix argument show changes between the working tree and
a commit read from the minibuffer.

\(fn &optional REV ARGS FILES)" t nil)

(autoload 'magit-diff-staged "magit/lisp/magit-diff" "\
Show changes between the index and the `HEAD' commit.
With a prefix argument show changes between the index and
a commit read from the minibuffer.

\(fn &optional REV ARGS FILES)" t nil)

(autoload 'magit-diff-unstaged "magit/lisp/magit-diff" "\
Show changes between the working tree and the index.

\(fn &optional ARGS FILES)" t nil)

(autoload 'magit-diff-unmerged "magit/lisp/magit-diff" "\
Show changes that are being merged.

\(fn &optional ARGS FILES)" t nil)

(autoload 'magit-diff-while-committing "magit/lisp/magit-diff" "\
While committing, show the changes that are about to be committed.
While amending, invoking the command again toggles between
showing just the new changes or all the changes that will
be committed.

\(fn &optional ARGS)" t nil)

(autoload 'magit-diff-buffer-file "magit/lisp/magit-diff" "\
Show diff for the blob or file visited in the current buffer.

\(fn)" t nil)

(autoload 'magit-diff-paths "magit/lisp/magit-diff" "\
Show changes between any two files on disk.

\(fn A B)" t nil)

(autoload 'magit-show-commit "magit/lisp/magit-diff" "\
Visit the revision at point in another buffer.
If there is no revision at point or with a prefix argument prompt
for a revision.

\(fn REV &optional ARGS FILES MODULE)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-diff" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-ediff" "magit/lisp/magit-ediff.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-ediff.el
 (autoload 'magit-ediff-popup "magit-ediff" nil t)

(autoload 'magit-ediff-resolve "magit/lisp/magit-ediff" "\
Resolve outstanding conflicts in FILE using Ediff.
FILE has to be relative to the top directory of the repository.

In the rare event that you want to manually resolve all
conflicts, including those already resolved by Git, use
`ediff-merge-revisions-with-ancestor'.

\(fn FILE)" t nil)

(autoload 'magit-ediff-stage "magit/lisp/magit-ediff" "\
Stage and unstage changes to FILE using Ediff.
FILE has to be relative to the top directory of the repository.

\(fn FILE)" t nil)

(autoload 'magit-ediff-compare "magit/lisp/magit-ediff" "\
Compare REVA:FILEA with REVB:FILEB using Ediff.

FILEA and FILEB have to be relative to the top directory of the
repository.  If REVA or REVB is nil, then this stands for the
working tree state.

If the region is active, use the revisions on the first and last
line of the region.  With a prefix argument, instead of diffing
the revisions, choose a revision to view changes along, starting
at the common ancestor of both revisions (i.e., use a \"...\"
range).

\(fn REVA REVB FILEA FILEB)" t nil)

(autoload 'magit-ediff-dwim "magit/lisp/magit-ediff" "\
Compare, stage, or resolve using Ediff.
This command tries to guess what file, and what commit or range
the user wants to compare, stage, or resolve using Ediff.  It
might only be able to guess either the file, or range or commit,
in which case the user is asked about the other.  It might not
always guess right, in which case the appropriate `magit-ediff-*'
command has to be used explicitly.  If it cannot read the user's
mind at all, then it asks the user for a command to run.

\(fn)" t nil)

(autoload 'magit-ediff-show-staged "magit/lisp/magit-ediff" "\
Show staged changes using Ediff.

This only allows looking at the changes; to stage, unstage,
and discard changes using Ediff, use `magit-ediff-stage'.

FILE must be relative to the top directory of the repository.

\(fn FILE)" t nil)

(autoload 'magit-ediff-show-unstaged "magit/lisp/magit-ediff" "\
Show unstaged changes using Ediff.

This only allows looking at the changes; to stage, unstage,
and discard changes using Ediff, use `magit-ediff-stage'.

FILE must be relative to the top directory of the repository.

\(fn FILE)" t nil)

(autoload 'magit-ediff-show-working-tree "magit/lisp/magit-ediff" "\
Show changes between `HEAD' and working tree using Ediff.
FILE must be relative to the top directory of the repository.

\(fn FILE)" t nil)

(autoload 'magit-ediff-show-commit "magit/lisp/magit-ediff" "\
Show changes introduced by COMMIT using Ediff.

\(fn COMMIT)" t nil)

(autoload 'magit-ediff-show-stash "magit/lisp/magit-ediff" "\
Show changes introduced by STASH using Ediff.
`magit-ediff-show-stash-with-index' controls whether a
three-buffer Ediff is used in order to distinguish changes in the
stash that were staged.

\(fn STASH)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-ediff" '("magit-ediff-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-extras" "magit/lisp/magit-extras.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-extras.el

(autoload 'magit-run-git-gui "magit/lisp/magit-extras" "\
Run `git gui' for the current git repository.

\(fn)" t nil)

(autoload 'magit-run-git-gui-blame "magit/lisp/magit-extras" "\
Run `git gui blame' on the given FILENAME and COMMIT.
Interactively run it for the current file and the `HEAD', with a
prefix or when the current file cannot be determined let the user
choose.  When the current buffer is visiting FILENAME instruct
blame to center around the line point is on.

\(fn COMMIT FILENAME &optional LINENUM)" t nil)

(autoload 'magit-run-gitk "magit/lisp/magit-extras" "\
Run `gitk' in the current repository.

\(fn)" t nil)

(autoload 'magit-run-gitk-branches "magit/lisp/magit-extras" "\
Run `gitk --branches' in the current repository.

\(fn)" t nil)

(autoload 'magit-run-gitk-all "magit/lisp/magit-extras" "\
Run `gitk --all' in the current repository.

\(fn)" t nil)

(autoload 'ido-enter-magit-status "magit/lisp/magit-extras" "\
Drop into `magit-status' from file switching.

This command does not work in Emacs 26.  It does work in Emacs 25
and Emacs 27.  See https://github.com/magit/magit/issues/3634 and
https://debbugs.gnu.org/cgi/bugreport.cgi?bug=31707.

To make this command available use something like:

  (add-hook \\='ido-setup-hook
            (lambda ()
              (define-key ido-completion-map
                (kbd \"C-x g\") \\='ido-enter-magit-status)))

Starting with Emacs 25.1 the Ido keymaps are defined just once
instead of every time Ido is invoked, so now you can modify it
like pretty much every other keymap:

  (define-key ido-common-completion-map
    (kbd \"C-x g\") \\='ido-enter-magit-status)

\(fn)" t nil)

(autoload 'magit-dired-jump "magit/lisp/magit-extras" "\
Visit file at point using Dired.
With a prefix argument, visit in another window.  If there
is no file at point, then instead visit `default-directory'.

\(fn &optional OTHER-WINDOW)" t nil)

(autoload 'magit-dired-log "magit/lisp/magit-extras" "\
Show log for all marked files, or the current file.

\(fn &optional FOLLOW)" t nil)

(autoload 'magit-do-async-shell-command "magit/lisp/magit-extras" "\
Open FILE with `dired-do-async-shell-command'.
Interactively, open the file at point.

\(fn FILE)" t nil)

(autoload 'magit-previous-line "magit/lisp/magit-extras" "\
Like `previous-line' but with Magit-specific shift-selection.

Magit's selection mechanism is based on the region but selects an
area that is larger than the region.  This causes `previous-line'
when invoked while holding the shift key to move up one line and
thereby select two lines.  When invoked inside a hunk body this
command does not move point on the first invocation and thereby
it only selects a single line.  Which inconsistency you prefer
is a matter of preference.

\(fn &optional ARG TRY-VSCROLL)" t nil)

(function-put 'magit-previous-line 'interactive-only '"use `forward-line' with negative argument instead.")

(autoload 'magit-next-line "magit/lisp/magit-extras" "\
Like `next-line' but with Magit-specific shift-selection.

Magit's selection mechanism is based on the region but selects
an area that is larger than the region.  This causes `next-line'
when invoked while holding the shift key to move down one line
and thereby select two lines.  When invoked inside a hunk body
this command does not move point on the first invocation and
thereby it only selects a single line.  Which inconsistency you
prefer is a matter of preference.

\(fn &optional ARG TRY-VSCROLL)" t nil)

(function-put 'magit-next-line 'interactive-only 'forward-line)

(autoload 'magit-clean "magit/lisp/magit-extras" "\
Remove untracked files from the working tree.
With a prefix argument also remove ignored files,
with two prefix arguments remove ignored files only.

\(git clean -f -d [-x|-X])

\(fn &optional ARG)" t nil)

(autoload 'magit-add-change-log-entry "magit/lisp/magit-extras" "\
Find change log file and add date entry and item for current change.
This differs from `add-change-log-entry' (which see) in that
it acts on the current hunk in a Magit buffer instead of on
a position in a file-visiting buffer.

\(fn &optional WHOAMI FILE-NAME OTHER-WINDOW)" t nil)

(autoload 'magit-add-change-log-entry-other-window "magit/lisp/magit-extras" "\
Find change log file in other window and add entry and item.
This differs from `add-change-log-entry-other-window' (which see)
in that it acts on the current hunk in a Magit buffer instead of
on a position in a file-visiting buffer.

\(fn &optional WHOAMI FILE-NAME)" t nil)

(autoload 'magit-edit-line-commit "magit/lisp/magit-extras" "\
Edit the commit that added the current line.

With a prefix argument edit the commit that removes the line,
if any.  The commit is determined using `git blame' and made
editable using `git rebase --interactive' if it is reachable
from `HEAD', or by checking out the commit (or a branch that
points at it) otherwise.

\(fn &optional TYPE)" t nil)

(autoload 'magit-reshelve-since "magit/lisp/magit-extras" "\
Change the author and committer dates of the commits since REV.

Ask the user for the first reachable commit whose dates should
be changed.  The read the new date for that commit.  The initial
minibuffer input and the previous history element offer good
values.  The next commit will be created one minute later and so
on.

This command is only intended for interactive use and should only
be used on highly rearranged and unpublished history.

\(fn REV)" t nil)

(autoload 'magit-pop-revision-stack "magit/lisp/magit-extras" "\
Insert a representation of a revision into the current buffer.

Pop a revision from the `magit-revision-stack' and insert it into
the current buffer according to `magit-pop-revision-stack-format'.
Revisions can be put on the stack using `magit-copy-section-value'
and `magit-copy-buffer-revision'.

If the stack is empty or with a prefix argument, instead read a
revision in the minibuffer.  By using the minibuffer history this
allows selecting an item which was popped earlier or to insert an
arbitrary reference or revision without first pushing it onto the
stack.

When reading the revision from the minibuffer, then it might not
be possible to guess the correct repository.  When this command
is called inside a repository (e.g. while composing a commit
message), then that repository is used.  Otherwise (e.g. while
composing an email) then the repository recorded for the top
element of the stack is used (even though we insert another
revision).  If not called inside a repository and with an empty
stack, or with two prefix arguments, then read the repository in
the minibuffer too.

\(fn REV TOPLEVEL)" t nil)

(autoload 'magit-copy-section-value "magit/lisp/magit-extras" "\
Save the value of the current section for later use.

Save the section value to the `kill-ring', and, provided that
the current section is a commit, branch, or tag section, push
the (referenced) revision to the `magit-revision-stack' for use
with `magit-pop-revision-stack'.

When the current section is a branch or a tag, and a prefix
argument is used, then save the revision at its tip to the
`kill-ring' instead of the reference name.

When the region is active, then save that to the `kill-ring',
like `kill-ring-save' would, instead of behaving as described
above.

\(fn)" t nil)

(autoload 'magit-copy-buffer-revision "magit/lisp/magit-extras" "\
Save the revision of the current buffer for later use.

Save the revision shown in the current buffer to the `kill-ring'
and push it to the `magit-revision-stack'.

This command is mainly intended for use in `magit-revision-mode'
buffers, the only buffers where it is always unambiguous exactly
which revision should be saved.

Most other Magit buffers usually show more than one revision, in
some way or another, so this command has to select one of them,
and that choice might not always be the one you think would have
been the best pick.

In such buffers it is often more useful to save the value of
the current section instead, using `magit-copy-section-value'.

When the region is active, then save that to the `kill-ring',
like `kill-ring-save' would, instead of behaving as described
above.

\(fn)" t nil)

(autoload 'magit-abort-dwim "magit/lisp/magit-extras" "\
Abort current operation.
Depending on the context, this will abort a merge, a rebase, a
patch application, a cherry-pick, a revert, or a bisect.

\(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-extras" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-fetch" "magit/lisp/magit-fetch.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-fetch.el
 (autoload 'magit-fetch-popup "magit-fetch" nil t)

(autoload 'magit-fetch-from-pushremote "magit/lisp/magit-fetch" "\
Fetch from the push-remote of the current branch.

\(fn ARGS)" t nil)

(autoload 'magit-fetch-from-upstream "magit/lisp/magit-fetch" "\
Fetch from the upstream repository of the current branch.

\(fn ARGS)" t nil)

(autoload 'magit-fetch-other "magit/lisp/magit-fetch" "\
Fetch from another repository.

\(fn REMOTE ARGS)" t nil)

(autoload 'magit-fetch-branch "magit/lisp/magit-fetch" "\
Fetch a BRANCH from a REMOTE.

\(fn REMOTE BRANCH ARGS)" t nil)

(autoload 'magit-fetch-refspec "magit/lisp/magit-fetch" "\
Fetch a REFSPEC from a REMOTE.

\(fn REMOTE REFSPEC ARGS)" t nil)

(autoload 'magit-fetch-all "magit/lisp/magit-fetch" "\
Fetch from all remotes.

\(fn ARGS)" t nil)

(autoload 'magit-fetch-all-prune "magit/lisp/magit-fetch" "\
Fetch from all remotes, and prune.
Prune remote tracking branches for branches that have been
removed on the respective remote.

\(fn)" t nil)

(autoload 'magit-fetch-all-no-prune "magit/lisp/magit-fetch" "\
Fetch from all remotes.

\(fn)" t nil)

(autoload 'magit-fetch-modules "magit/lisp/magit-fetch" "\
Fetch all submodules.

Option `magit-fetch-modules-jobs' controls how many submodules
are being fetched in parallel.  Also fetch the super-repository,
because `git-fetch' does not support not doing that.  With a
prefix argument fetch all remotes.

\(fn &optional ALL)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-fetch" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-files" "magit/lisp/magit-files.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-files.el

(autoload 'magit-find-file "magit/lisp/magit-files" "\
View FILE from REV.
Switch to a buffer visiting blob REV:FILE,
creating one if none already exists.

\(fn REV FILE)" t nil)

(autoload 'magit-find-file-other-window "magit/lisp/magit-files" "\
View FILE from REV, in another window.
Like `magit-find-file', but create a new window or reuse an
existing one.

\(fn REV FILE)" t nil)
 (autoload 'magit-file-popup "magit" nil t)

(defvar global-magit-file-mode t "\
Non-nil if Global Magit-File mode is enabled.
See the `global-magit-file-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `global-magit-file-mode'.")

(custom-autoload 'global-magit-file-mode "magit/lisp/magit-files" nil)

(autoload 'global-magit-file-mode "magit/lisp/magit-files" "\
Toggle Magit-File mode in all buffers.
With prefix ARG, enable Global Magit-File mode if ARG is positive;
otherwise, disable it.  If called from Lisp, enable the mode if
ARG is omitted or nil.

Magit-File mode is enabled in all buffers where
`magit-file-mode-turn-on' would do it.
See `magit-file-mode' for more information on Magit-File mode.

\(fn &optional ARG)" t nil)

(autoload 'magit-file-checkout "magit/lisp/magit-files" "\
Checkout FILE from REV.

\(fn REV FILE)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-files" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-git" "magit/lisp/magit-git.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-git.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-git" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-gitignore" "magit/lisp/magit-gitignore.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-gitignore.el
 (autoload 'magit-gitignore-popup "magit-gitignore" nil t)

(autoload 'magit-gitignore-globally "magit/lisp/magit-gitignore" "\
Instruct Git to globally ignore FILE-OR-PATTERN.

\(fn FILE-OR-PATTERN)" t nil)

(autoload 'magit-gitignore-locally "magit/lisp/magit-gitignore" "\
Instruct Git to locally ignore FILE-OR-PATTERN.

\(fn FILE-OR-PATTERN)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-gitignore" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-imenu" "magit/lisp/magit-imenu.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-imenu.el

(autoload 'magit-imenu--log-prev-index-position-function "magit/lisp/magit-imenu" "\
Move point to previous line in current buffer.
This function is used as a value for
`imenu-prev-index-position-function'.

\(fn)" nil nil)

(autoload 'magit-imenu--log-extract-index-name-function "magit/lisp/magit-imenu" "\
Return imenu name for line at point.
This function is used as a value for
`imenu-extract-index-name-function'.  Point should be at the
beginning of the line.

\(fn)" nil nil)

(autoload 'magit-imenu--diff-prev-index-position-function "magit/lisp/magit-imenu" "\
Move point to previous file line in current buffer.
This function is used as a value for
`imenu-prev-index-position-function'.

\(fn)" nil nil)

(autoload 'magit-imenu--diff-extract-index-name-function "magit/lisp/magit-imenu" "\
Return imenu name for line at point.
This function is used as a value for
`imenu-extract-index-name-function'.  Point should be at the
beginning of the line.

\(fn)" nil nil)

(autoload 'magit-imenu--status-create-index-function "magit/lisp/magit-imenu" "\
Return an alist of all imenu entries in current buffer.
This function is used as a value for
`imenu-create-index-function'.

\(fn)" nil nil)

(autoload 'magit-imenu--refs-create-index-function "magit/lisp/magit-imenu" "\
Return an alist of all imenu entries in current buffer.
This function is used as a value for
`imenu-create-index-function'.

\(fn)" nil nil)

(autoload 'magit-imenu--cherry-create-index-function "magit/lisp/magit-imenu" "\
Return an alist of all imenu entries in current buffer.
This function is used as a value for
`imenu-create-index-function'.

\(fn)" nil nil)

(autoload 'magit-imenu--submodule-prev-index-position-function "magit/lisp/magit-imenu" "\
Move point to previous line in magit-submodule-list buffer.
This function is used as a value for
`imenu-prev-index-position-function'.

\(fn)" nil nil)

(autoload 'magit-imenu--submodule-extract-index-name-function "magit/lisp/magit-imenu" "\
Return imenu name for line at point.
This function is used as a value for
`imenu-extract-index-name-function'.  Point should be at the
beginning of the line.

\(fn)" nil nil)

(autoload 'magit-imenu--repolist-prev-index-position-function "magit/lisp/magit-imenu" "\
Move point to previous line in magit-repolist buffer.
This function is used as a value for
`imenu-prev-index-position-function'.

\(fn)" nil nil)

(autoload 'magit-imenu--repolist-extract-index-name-function "magit/lisp/magit-imenu" "\
Return imenu name for line at point.
This function is used as a value for
`imenu-extract-index-name-function'.  Point should be at the
beginning of the line.

\(fn)" nil nil)

(autoload 'magit-imenu--process-prev-index-position-function "magit/lisp/magit-imenu" "\
Move point to previous process in magit-process buffer.
This function is used as a value for
`imenu-prev-index-position-function'.

\(fn)" nil nil)

(autoload 'magit-imenu--process-extract-index-name-function "magit/lisp/magit-imenu" "\
Return imenu name for line at point.
This function is used as a value for
`imenu-extract-index-name-function'.  Point should be at the
beginning of the line.

\(fn)" nil nil)

(autoload 'magit-imenu--rebase-prev-index-position-function "magit/lisp/magit-imenu" "\
Move point to previous commit in git-rebase buffer.
This function is used as a value for
`imenu-prev-index-position-function'.

\(fn)" nil nil)

(autoload 'magit-imenu--rebase-extract-index-name-function "magit/lisp/magit-imenu" "\
Return imenu name for line at point.
This function is used as a value for
`imenu-extract-index-name-function'.  Point should be at the
beginning of the line.

\(fn)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-imenu" '("magit-imenu--index-function")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-log" "magit/lisp/magit-log.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-log.el

(autoload 'magit-log-buffer-file-popup "magit/lisp/magit-log" "\
Popup console for log commands.

This is a variant of `magit-log-popup' which shows the same popup
but which limits the log to the file being visited in the current
buffer.

\(fn)" t nil)

(autoload 'magit-log-current "magit/lisp/magit-log" "\
Show log for the current branch.
When `HEAD' is detached or with a prefix argument show log for
one or more revs read from the minibuffer.

\(fn REVS &optional ARGS FILES)" t nil)

(autoload 'magit-log-other "magit/lisp/magit-log" "\
Show log for one or more revs read from the minibuffer.
The user can input any revision or revisions separated by a
space, or even ranges, but only branches and tags, and a
representation of the commit at point, are available as
completion candidates.

\(fn REVS &optional ARGS FILES)" t nil)

(autoload 'magit-log-head "magit/lisp/magit-log" "\
Show log for `HEAD'.

\(fn &optional ARGS FILES)" t nil)

(autoload 'magit-log-branches "magit/lisp/magit-log" "\
Show log for all local branches and `HEAD'.

\(fn &optional ARGS FILES)" t nil)

(autoload 'magit-log-all-branches "magit/lisp/magit-log" "\
Show log for all local and remote branches and `HEAD'.

\(fn &optional ARGS FILES)" t nil)

(autoload 'magit-log-all "magit/lisp/magit-log" "\
Show log for all references and `HEAD'.

\(fn &optional ARGS FILES)" t nil)

(autoload 'magit-log-buffer-file "magit/lisp/magit-log" "\
Show log for the blob or file visited in the current buffer.
With a prefix argument or when `--follow' is part of
`magit-log-arguments', then follow renames.  When the region is
active, restrict the log to the lines that the region touches.

\(fn &optional FOLLOW BEG END)" t nil)

(autoload 'magit-log-trace-definition "magit/lisp/magit-log" "\
Show log for the definition at point.

\(fn FILE FN REV)" t nil)

(autoload 'magit-reflog-current "magit/lisp/magit-log" "\
Display the reflog of the current branch.

\(fn ARGS)" t nil)

(autoload 'magit-reflog-other "magit/lisp/magit-log" "\
Display the reflog of a branch or another ref.

\(fn REF ARGS)" t nil)

(autoload 'magit-reflog-head "magit/lisp/magit-log" "\
Display the `HEAD' reflog.

\(fn ARGS)" t nil)

(autoload 'magit-log-move-to-parent "magit/lisp/magit-log" "\
Move to the Nth parent of the current commit.

\(fn &optional N)" t nil)

(autoload 'magit-cherry "magit/lisp/magit-log" "\
Show commits in a branch that are not merged in the upstream branch.

\(fn HEAD UPSTREAM)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-log" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-margin" "magit/lisp/magit-margin.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-margin.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-margin" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-merge" "magit/lisp/magit-merge.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-merge.el
 (autoload 'magit-merge-popup "magit" nil t)

(autoload 'magit-merge-plain "magit/lisp/magit-merge" "\
Merge commit REV into the current branch; using default message.

Unless there are conflicts or a prefix argument is used create a
merge commit using a generic commit message and without letting
the user inspect the result.  With a prefix argument pretend the
merge failed to give the user the opportunity to inspect the
merge.

\(git merge --no-edit|--no-commit [ARGS] REV)

\(fn REV &optional ARGS NOCOMMIT)" t nil)

(autoload 'magit-merge-editmsg "magit/lisp/magit-merge" "\
Merge commit REV into the current branch; and edit message.
Perform the merge and prepare a commit message but let the user
edit it.

\(git merge --edit --no-ff [ARGS] REV)

\(fn REV &optional ARGS)" t nil)

(autoload 'magit-merge-nocommit "magit/lisp/magit-merge" "\
Merge commit REV into the current branch; pretending it failed.
Pretend the merge failed to give the user the opportunity to
inspect the merge and change the commit message.

\(git merge --no-commit --no-ff [ARGS] REV)

\(fn REV &optional ARGS)" t nil)

(autoload 'magit-merge-into "magit/lisp/magit-merge" "\
Merge the current branch into BRANCH and remove the former.

Before merging, force push the source branch to its push-remote,
provided the respective remote branch already exists, ensuring
that the respective pull-request (if any) won't get stuck on some
obsolete version of the commits that are being merged.  Finally
if `magit-branch-pull-request' was used to create the merged
branch, then also remove the respective remote branch.

\(fn BRANCH &optional ARGS)" t nil)

(autoload 'magit-merge-absorb "magit/lisp/magit-merge" "\
Merge BRANCH into the current branch and remove the former.

Before merging, force push the source branch to its push-remote,
provided the respective remote branch already exists, ensuring
that the respective pull-request (if any) won't get stuck on some
obsolete version of the commits that are being merged.  Finally
if `magit-branch-pull-request' was used to create the merged
branch, then also remove the respective remote branch.

\(fn BRANCH &optional ARGS)" t nil)

(autoload 'magit-merge-squash "magit/lisp/magit-merge" "\
Squash commit REV into the current branch; don't create a commit.

\(git merge --squash REV)

\(fn REV)" t nil)

(autoload 'magit-merge-preview "magit/lisp/magit-merge" "\
Preview result of merging REV into the current branch.

\(fn REV)" t nil)

(autoload 'magit-merge-abort "magit/lisp/magit-merge" "\
Abort the current merge operation.

\(git merge --abort)

\(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-merge" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-mode" "magit/lisp/magit-mode.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-mode.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-mode" '("magit-" "disable-magit-save-buffers" "inhibit-magit-refresh")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-notes" "magit/lisp/magit-notes.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-notes.el
 (autoload 'magit-notes-popup "magit" nil t)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-notes" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-patch" "magit/lisp/magit-patch.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-patch.el
 (autoload 'magit-patch-popup "magit-patch" nil t)

(autoload 'magit-format-patch "magit/lisp/magit-patch" "\
Create patches for the commits in RANGE.
When a single commit is given for RANGE, create a patch for the
changes introduced by that commit (unlike 'git format-patch'
which creates patches for all commits that are reachable from
`HEAD' but not from the specified commit).

\(fn RANGE ARGS FILES)" t nil)

(autoload 'magit-request-pull "magit/lisp/magit-patch" "\
Request upstream to pull from you public repository.

URL is the url of your publically accessible repository.
START is a commit that already is in the upstream repository.
END is the last commit, usually a branch name, which upstream
is asked to pull.  START has to be reachable from that commit.

\(fn URL START END)" t nil)
 (autoload 'magit-patch-apply-popup "magit-patch" nil t)

(autoload 'magit-patch-apply "magit/lisp/magit-patch" "\
Apply the patch file FILE.

\(fn FILE &rest ARGS)" t nil)

(autoload 'magit-patch-save "magit/lisp/magit-patch" "\
Write current diff into patch FILE.

What arguments are used to create the patch depends on the value
of `magit-patch-save-arguments' and whether a prefix argument is
used.

If the value is the symbol `buffer', then use the same arguments
as the buffer.  With a prefix argument use no arguments.

If the value is a list beginning with the symbol `exclude', then
use the same arguments as the buffer except for those matched by
entries in the cdr of the list.  The comparison is done using
`string-prefix-p'.  With a prefix argument use the same arguments
as the buffer.

If the value is a list of strings (including the empty list),
then use those arguments.  With a prefix argument use the same
arguments as the buffer.

Of course the arguments that are required to actually show the
same differences as those shown in the buffer are always used.

\(fn FILE &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-patch" '("magit-patch-save-arguments")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-process" "magit/lisp/magit-process.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-process.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-process" '("magit-" "tramp-sh-handle-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-pull" "magit/lisp/magit-pull.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-pull.el
 (autoload 'magit-pull-popup "magit-pull" nil t)
 (autoload 'magit-pull-and-fetch-popup "magit-pull" nil t)

(autoload 'magit-pull-from-pushremote "magit/lisp/magit-pull" "\
Pull from the push-remote of the current branch.

\(fn ARGS)" t nil)

(autoload 'magit-pull-from-upstream "magit/lisp/magit-pull" "\
Pull from the upstream of the current branch.

\(fn ARGS)" t nil)

(autoload 'magit-pull-branch "magit/lisp/magit-pull" "\
Pull from a branch read in the minibuffer.

\(fn SOURCE ARGS)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-pull" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-push" "magit/lisp/magit-push.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-push.el
 (autoload 'magit-push-popup "magit-push" nil t)

(autoload 'magit-push-current-to-pushremote "magit/lisp/magit-push" "\
Push the current branch to `branch.<name>.pushRemote'.
If that variable is unset, then push to `remote.pushDefault'.

When `magit-push-current-set-remote-if-missing' is non-nil and
the push-remote is not configured, then read the push-remote from
the user, set it, and then push to it.  With a prefix argument
the push-remote can be changed before pushed to it.

\(fn ARGS &optional PUSH-REMOTE)" t nil)

(autoload 'magit-push-current-to-upstream "magit/lisp/magit-push" "\
Push the current branch to its upstream branch.

When `magit-push-current-set-remote-if-missing' is non-nil and
the upstream is not configured, then read the upstream from the
user, set it, and then push to it.  With a prefix argument the
upstream can be changed before pushed to it.

\(fn ARGS &optional UPSTREAM)" t nil)

(autoload 'magit-push-current "magit/lisp/magit-push" "\
Push the current branch to a branch read in the minibuffer.

\(fn TARGET ARGS)" t nil)

(autoload 'magit-push-other "magit/lisp/magit-push" "\
Push an arbitrary branch or commit somewhere.
Both the source and the target are read in the minibuffer.

\(fn SOURCE TARGET ARGS)" t nil)

(autoload 'magit-push-refspecs "magit/lisp/magit-push" "\
Push one or multiple REFSPECS to a REMOTE.
Both the REMOTE and the REFSPECS are read in the minibuffer.  To
use multiple REFSPECS, separate them with commas.  Completion is
only available for the part before the colon, or when no colon
is used.

\(fn REMOTE REFSPECS ARGS)" t nil)

(autoload 'magit-push-matching "magit/lisp/magit-push" "\
Push all matching branches to another repository.
If multiple remotes exist, then read one from the user.
If just one exists, use that without requiring confirmation.

\(fn REMOTE &optional ARGS)" t nil)

(autoload 'magit-push-tags "magit/lisp/magit-push" "\
Push all tags to another repository.
If only one remote exists, then push to that.  Otherwise prompt
for a remote, offering the remote configured for the current
branch as default.

\(fn REMOTE &optional ARGS)" t nil)

(autoload 'magit-push-tag "magit/lisp/magit-push" "\
Push a tag to another repository.

\(fn TAG REMOTE &optional ARGS)" t nil)

(autoload 'magit-push-implicitly "magit/lisp/magit-push" "\
Push somewhere without using an explicit refspec.

This command simply runs \"git push -v [ARGS]\".  ARGS are the
arguments specified in the popup buffer.  No explicit refspec
arguments are used.  Instead the behavior depends on at least
these Git variables: `push.default', `remote.pushDefault',
`branch.<branch>.pushRemote', `branch.<branch>.remote',
`branch.<branch>.merge', and `remote.<remote>.push'.

To add this command to the push popup add this to your init file:

  (with-eval-after-load \\='magit-remote
    (magit-define-popup-action \\='magit-push-popup ?P
      \\='magit-push-implicitly--desc
      \\='magit-push-implicitly ?p t))

The function `magit-push-implicitly--desc' attempts to predict
what this command will do.  The value it returns is displayed in
the popup buffer.

\(fn ARGS)" t nil)

(autoload 'magit-push-to-remote "magit/lisp/magit-push" "\
Push to REMOTE without using an explicit refspec.
The REMOTE is read in the minibuffer.

This command simply runs \"git push -v [ARGS] REMOTE\".  ARGS
are the arguments specified in the popup buffer.  No refspec
arguments are used.  Instead the behavior depends on at least
these Git variables: `push.default', `remote.pushDefault',
`branch.<branch>.pushRemote', `branch.<branch>.remote',
`branch.<branch>.merge', and `remote.<remote>.push'.

To add this command to the push popup add this to your init file:

  (with-eval-after-load \\='magit-remote
    (magit-define-popup-action \\='magit-push-popup ?r
      \\='magit-push-to-remote--desc
      \\='magit-push-to-remote ?p t))

\(fn REMOTE ARGS)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-push" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-refs" "magit/lisp/magit-refs.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-refs.el

(autoload 'magit-show-refs-popup "magit/lisp/magit-refs" "\
Popup console for `magit-show-refs'.

\(fn &optional ARG)" t nil)

(autoload 'magit-show-refs-head "magit/lisp/magit-refs" "\
List and compare references in a dedicated buffer.
Refs are compared with `HEAD'.

\(fn &optional ARGS)" t nil)

(autoload 'magit-show-refs-current "magit/lisp/magit-refs" "\
List and compare references in a dedicated buffer.
Refs are compared with the current branch or `HEAD' if
it is detached.

\(fn &optional ARGS)" t nil)

(autoload 'magit-show-refs "magit/lisp/magit-refs" "\
List and compare references in a dedicated buffer.
Refs are compared with a branch read from the user.

\(fn &optional REF ARGS)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-refs" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-remote" "magit/lisp/magit-remote.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-remote.el
 (autoload 'magit-remote-popup "magit-remote" nil t)

(autoload 'magit-remote-add "magit/lisp/magit-remote" "\
Add a remote named REMOTE and fetch it.

\(fn REMOTE URL &optional ARGS)" t nil)

(autoload 'magit-remote-rename "magit/lisp/magit-remote" "\
Rename the remote named OLD to NEW.

\(fn OLD NEW)" t nil)

(autoload 'magit-remote-remove "magit/lisp/magit-remote" "\
Delete the remote named REMOTE.

\(fn REMOTE)" t nil)

(autoload 'magit-remote-prune "magit/lisp/magit-remote" "\
Remove stale remote-tracking branches for REMOTE.

\(fn REMOTE)" t nil)

(autoload 'magit-remote-prune-refspecs "magit/lisp/magit-remote" "\
Remove stale refspecs for REMOTE.

A refspec is stale if there no longer exists at least one branch
on the remote that would be fetched due to that refspec.  A stale
refspec is problematic because its existence causes Git to refuse
to fetch according to the remaining non-stale refspecs.

If only stale refspecs remain, then offer to either delete the
remote or to replace the stale refspecs with the default refspec.

Also remove the remote-tracking branches that were created due to
the now stale refspecs.  Other stale branches are not removed.

\(fn REMOTE)" t nil)

(autoload 'magit-remote-set-head "magit/lisp/magit-remote" "\
Set the local representation of REMOTE's default branch.
Query REMOTE and set the symbolic-ref refs/remotes/<remote>/HEAD
accordingly.  With a prefix argument query for the branch to be
used, which allows you to select an incorrect value if you fancy
doing that.

\(fn REMOTE &optional BRANCH)" t nil)

(autoload 'magit-remote-unset-head "magit/lisp/magit-remote" "\
Unset the local representation of REMOTE's default branch.
Delete the symbolic-ref \"refs/remotes/<remote>/HEAD\".

\(fn REMOTE)" t nil)

(autoload 'magit-remote-config-popup "magit/lisp/magit-remote" "\
Popup console for setting remote variables.

\(fn REMOTE)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-remote" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-repos" "magit/lisp/magit-repos.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-repos.el

(autoload 'magit-list-repositories "magit/lisp/magit-repos" "\
Display a list of repositories.

Use the options `magit-repository-directories' to control which
repositories are displayed.

\(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-repos" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-reset" "magit/lisp/magit-reset.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-reset.el
 (autoload 'magit-reset-popup "magit" nil t)

(autoload 'magit-reset-mixed "magit/lisp/magit-reset" "\
Reset the `HEAD' and index to COMMIT, but not the working tree.

\(git reset --mixed COMMIT)

\(fn COMMIT)" t nil)

(autoload 'magit-reset-soft "magit/lisp/magit-reset" "\
Reset the `HEAD' to COMMIT, but not the index and working tree.

\(git reset --soft REVISION)

\(fn COMMIT)" t nil)

(autoload 'magit-reset-hard "magit/lisp/magit-reset" "\
Reset the `HEAD', index, and working tree to COMMIT.

\(git reset --hard REVISION)

\(fn COMMIT)" t nil)

(autoload 'magit-reset-index "magit/lisp/magit-reset" "\
Reset the index to COMMIT.
Keep the `HEAD' and working tree as-is, so if COMMIT refers to the
head this effectively unstages all changes.

\(git reset COMMIT .)

\(fn COMMIT)" t nil)

(autoload 'magit-reset-worktree "magit/lisp/magit-reset" "\
Reset the worktree to COMMIT.
Keep the `HEAD' and index as-is.

\(fn COMMIT)" t nil)

(autoload 'magit-reset-quickly "magit/lisp/magit-reset" "\
Reset the `HEAD' and index to COMMIT, and possibly the working tree.
With a prefix argument reset the working tree otherwise don't.

\(git reset --mixed|--hard COMMIT)

\(fn COMMIT &optional HARD)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-reset" '("magit-reset-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-section" "magit/lisp/magit-section.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-section.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-section" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-sequence" "magit/lisp/magit-sequence.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-sequence.el

(autoload 'magit-sequencer-continue "magit/lisp/magit-sequence" "\
Resume the current cherry-pick or revert sequence.

\(fn)" t nil)

(autoload 'magit-sequencer-skip "magit/lisp/magit-sequence" "\
Skip the stopped at commit during a cherry-pick or revert sequence.

\(fn)" t nil)

(autoload 'magit-sequencer-abort "magit/lisp/magit-sequence" "\
Abort the current cherry-pick or revert sequence.
This discards all changes made since the sequence started.

\(fn)" t nil)
 (autoload 'magit-cherry-pick-popup "magit-sequence" nil t)

(autoload 'magit-cherry-copy "magit/lisp/magit-sequence" "\
Copy COMMITS from another branch onto the current branch.
Prompt for a commit, defaulting to the commit at point.  If
the region selects multiple commits, then pick all of them,
without prompting.

\(fn COMMITS &optional ARGS)" t nil)

(autoload 'magit-cherry-apply "magit/lisp/magit-sequence" "\
Apply the changes in COMMITS but do not commit them.
Prompt for a commit, defaulting to the commit at point.  If
the region selects multiple commits, then apply all of them,
without prompting.

\(fn COMMITS &optional ARGS)" t nil)

(autoload 'magit-cherry-harvest "magit/lisp/magit-sequence" "\
Move COMMITS from another BRANCH onto the current branch.
Remove the COMMITS from BRANCH and stay on the current branch.
If a conflict occurs, then you have to fix that and finish the
process manually.

\(fn COMMITS BRANCH &optional ARGS)" t nil)

(autoload 'magit-cherry-donate "magit/lisp/magit-sequence" "\
Move COMMITS from the current branch onto another existing BRANCH.
Remove COMMITS from the current branch and stay on that branch.
If a conflict occurs, then you have to fix that and finish the
process manually.

\(fn COMMITS BRANCH &optional ARGS)" t nil)

(autoload 'magit-cherry-spinout "magit/lisp/magit-sequence" "\
Move COMMITS from the current branch onto a new BRANCH.
Remove COMMITS from the current branch and stay on that branch.
If a conflict occurs, then you have to fix that and finish the
process manually.

\(fn COMMITS BRANCH START-POINT &optional ARGS)" t nil)

(autoload 'magit-cherry-spinoff "magit/lisp/magit-sequence" "\
Move COMMITS from the current branch onto a new BRANCH.
Remove COMMITS from the current branch and checkout BRANCH.
If a conflict occurs, then you have to fix that and finish
the process manually.

\(fn COMMITS BRANCH START-POINT &optional ARGS)" t nil)
 (autoload 'magit-revert-popup "magit-sequence" nil t)

(autoload 'magit-revert-and-commit "magit/lisp/magit-sequence" "\
Revert COMMIT by creating a new commit.
Prompt for a commit, defaulting to the commit at point.  If
the region selects multiple commits, then revert all of them,
without prompting.

\(fn COMMIT &optional ARGS)" t nil)

(autoload 'magit-revert-no-commit "magit/lisp/magit-sequence" "\
Revert COMMIT by applying it in reverse to the worktree.
Prompt for a commit, defaulting to the commit at point.  If
the region selects multiple commits, then revert all of them,
without prompting.

\(fn COMMIT &optional ARGS)" t nil)
 (autoload 'magit-am-popup "magit-sequence" nil t)

(autoload 'magit-am-apply-patches "magit/lisp/magit-sequence" "\
Apply the patches FILES.

\(fn &optional FILES ARGS)" t nil)

(autoload 'magit-am-apply-maildir "magit/lisp/magit-sequence" "\
Apply the patches from MAILDIR.

\(fn &optional MAILDIR ARGS)" t nil)

(autoload 'magit-am-continue "magit/lisp/magit-sequence" "\
Resume the current patch applying sequence.

\(fn)" t nil)

(autoload 'magit-am-skip "magit/lisp/magit-sequence" "\
Skip the stopped at patch during a patch applying sequence.

\(fn)" t nil)

(autoload 'magit-am-abort "magit/lisp/magit-sequence" "\
Abort the current patch applying sequence.
This discards all changes made since the sequence started.

\(fn)" t nil)
 (autoload 'magit-rebase-popup "magit-sequence" nil t)

(autoload 'magit-rebase-onto-pushremote "magit/lisp/magit-sequence" "\
Rebase the current branch onto `branch.<name>.pushRemote'.
If that variable is unset, then rebase onto `remote.pushDefault'.

\(fn ARGS)" t nil)

(autoload 'magit-rebase-onto-upstream "magit/lisp/magit-sequence" "\
Rebase the current branch onto its upstream branch.

\(fn ARGS)" t nil)

(autoload 'magit-rebase-branch "magit/lisp/magit-sequence" "\
Rebase the current branch onto a branch read in the minibuffer.
All commits that are reachable from `HEAD' but not from the
selected branch TARGET are being rebased.

\(fn TARGET ARGS)" t nil)

(autoload 'magit-rebase-subset "magit/lisp/magit-sequence" "\
Rebase a subset of the current branch's history onto a new base.
Rebase commits from START to `HEAD' onto NEWBASE.
START has to be selected from a list of recent commits.

\(fn NEWBASE START ARGS)" t nil)

(autoload 'magit-rebase-interactive "magit/lisp/magit-sequence" "\
Start an interactive rebase sequence.

\(fn COMMIT ARGS)" t nil)

(autoload 'magit-rebase-autosquash "magit/lisp/magit-sequence" "\
Combine squash and fixup commits with their intended targets.

\(fn ARGS)" t nil)

(autoload 'magit-rebase-edit-commit "magit/lisp/magit-sequence" "\
Edit a single older commit using rebase.

\(fn COMMIT ARGS)" t nil)

(autoload 'magit-rebase-reword-commit "magit/lisp/magit-sequence" "\
Reword a single older commit using rebase.

\(fn COMMIT ARGS)" t nil)

(autoload 'magit-rebase-remove-commit "magit/lisp/magit-sequence" "\
Remove a single older commit using rebase.

\(fn COMMIT ARGS)" t nil)

(autoload 'magit-rebase-continue "magit/lisp/magit-sequence" "\
Restart the current rebasing operation.
In some cases this pops up a commit message buffer for you do
edit.  With a prefix argument the old message is reused as-is.

\(fn &optional NOEDIT)" t nil)

(autoload 'magit-rebase-skip "magit/lisp/magit-sequence" "\
Skip the current commit and restart the current rebase operation.

\(fn)" t nil)

(autoload 'magit-rebase-edit "magit/lisp/magit-sequence" "\
Edit the todo list of the current rebase operation.

\(fn)" t nil)

(autoload 'magit-rebase-abort "magit/lisp/magit-sequence" "\
Abort the current rebase operation, restoring the original branch.

\(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-sequence" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-stash" "magit/lisp/magit-stash.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-stash.el
 (autoload 'magit-stash-popup "magit-stash" nil t)

(autoload 'magit-stash-both "magit/lisp/magit-stash" "\
Create a stash of the index and working tree.
Untracked files are included according to popup arguments.
One prefix argument is equivalent to `--include-untracked'
while two prefix arguments are equivalent to `--all'.

\(fn MESSAGE &optional INCLUDE-UNTRACKED)" t nil)

(autoload 'magit-stash-index "magit/lisp/magit-stash" "\
Create a stash of the index only.
Unstaged and untracked changes are not stashed.  The stashed
changes are applied in reverse to both the index and the
worktree.  This command can fail when the worktree is not clean.
Applying the resulting stash has the inverse effect.

\(fn MESSAGE)" t nil)

(autoload 'magit-stash-worktree "magit/lisp/magit-stash" "\
Create a stash of unstaged changes in the working tree.
Untracked files are included according to popup arguments.
One prefix argument is equivalent to `--include-untracked'
while two prefix arguments are equivalent to `--all'.

\(fn MESSAGE &optional INCLUDE-UNTRACKED)" t nil)

(autoload 'magit-stash-keep-index "magit/lisp/magit-stash" "\
Create a stash of the index and working tree, keeping index intact.
Untracked files are included according to popup arguments.
One prefix argument is equivalent to `--include-untracked'
while two prefix arguments are equivalent to `--all'.

\(fn MESSAGE &optional INCLUDE-UNTRACKED)" t nil)

(autoload 'magit-snapshot-both "magit/lisp/magit-stash" "\
Create a snapshot of the index and working tree.
Untracked files are included according to popup arguments.
One prefix argument is equivalent to `--include-untracked'
while two prefix arguments are equivalent to `--all'.

\(fn &optional INCLUDE-UNTRACKED)" t nil)

(autoload 'magit-snapshot-index "magit/lisp/magit-stash" "\
Create a snapshot of the index only.
Unstaged and untracked changes are not stashed.

\(fn)" t nil)

(autoload 'magit-snapshot-worktree "magit/lisp/magit-stash" "\
Create a snapshot of unstaged changes in the working tree.
Untracked files are included according to popup arguments.
One prefix argument is equivalent to `--include-untracked'
while two prefix arguments are equivalent to `--all'.

\(fn &optional INCLUDE-UNTRACKED)" t nil)

(autoload 'magit-stash-apply "magit/lisp/magit-stash" "\
Apply a stash to the working tree.
Try to preserve the stash index.  If that fails because there
are staged changes, apply without preserving the stash index.

\(fn STASH)" t nil)

(autoload 'magit-stash-drop "magit/lisp/magit-stash" "\
Remove a stash from the stash list.
When the region is active offer to drop all contained stashes.

\(fn STASH)" t nil)

(autoload 'magit-stash-clear "magit/lisp/magit-stash" "\
Remove all stashes saved in REF's reflog by deleting REF.

\(fn REF)" t nil)

(autoload 'magit-stash-branch "magit/lisp/magit-stash" "\
Create and checkout a new BRANCH from STASH.

\(fn STASH BRANCH)" t nil)

(autoload 'magit-stash-branch-here "magit/lisp/magit-stash" "\
Create and checkout a new BRANCH and apply STASH.
The branch is created using `magit-branch', using the current
branch or `HEAD' as the string-point.

\(fn STASH BRANCH)" t nil)

(autoload 'magit-stash-format-patch "magit/lisp/magit-stash" "\
Create a patch from STASH

\(fn STASH)" t nil)

(autoload 'magit-stash-list "magit/lisp/magit-stash" "\
List all stashes in a buffer.

\(fn)" t nil)

(autoload 'magit-stash-show "magit/lisp/magit-stash" "\
Show all diffs of a stash in a buffer.

\(fn STASH &optional ARGS FILES)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-stash" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-status" "magit/lisp/magit-status.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-status.el

(autoload 'magit-init "magit/lisp/magit-status" "\
Initialize a Git repository, then show its status.

If the directory is below an existing repository, then the user
has to confirm that a new one should be created inside.  If the
directory is the root of the existing repository, then the user
has to confirm that it should be reinitialized.

Non-interactively DIRECTORY is (re-)initialized unconditionally.

\(fn DIRECTORY)" t nil)

(autoload 'magit-status "magit/lisp/magit-status" "\
Show the status of the current Git repository in a buffer.
With a prefix argument prompt for a repository to be shown.
With two prefix arguments prompt for an arbitrary directory.
If that directory isn't the root of an existing repository,
then offer to initialize it as a new repository.

\(fn &optional DIRECTORY CACHE)" t nil)

(autoload 'magit-status-internal "magit/lisp/magit-status" "\


\(fn DIRECTORY)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-status" '("magit")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-submodule" "magit/lisp/magit-submodule.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-submodule.el
 (autoload 'magit-submodule-popup "magit-submodule" nil t)

(autoload 'magit-submodule-add "magit/lisp/magit-submodule" "\
Add the repository at URL as a module.

Optional PATH is the path to the module relative to the root of
the superproject.  If it is nil, then the path is determined
based on the URL.  Optional NAME is the name of the module.  If
it is nil, then PATH also becomes the name.

\(fn URL &optional PATH NAME ARGS)" t nil)

(autoload 'magit-submodule-read-name-for-path "magit/lisp/magit-submodule" "\


\(fn PATH &optional PREFER-SHORT)" nil nil)

(autoload 'magit-submodule-register "magit/lisp/magit-submodule" "\
Register MODULES.

With a prefix argument act on all suitable modules.  Otherwise,
if the region selects modules, then act on those.  Otherwise, if
there is a module at point, then act on that.  Otherwise read a
single module from the user.

\(fn MODULES)" t nil)

(autoload 'magit-submodule-populate "magit/lisp/magit-submodule" "\
Create MODULES working directories, checking out the recorded commits.

With a prefix argument act on all suitable modules.  Otherwise,
if the region selects modules, then act on those.  Otherwise, if
there is a module at point, then act on that.  Otherwise read a
single module from the user.

\(fn MODULES)" t nil)

(autoload 'magit-submodule-update "magit/lisp/magit-submodule" "\
Update MODULES by checking out the recorded commits.

With a prefix argument act on all suitable modules.  Otherwise,
if the region selects modules, then act on those.  Otherwise, if
there is a module at point, then act on that.  Otherwise read a
single module from the user.

\(fn MODULES ARGS)" t nil)

(autoload 'magit-submodule-synchronize "magit/lisp/magit-submodule" "\
Synchronize url configuration of MODULES.

With a prefix argument act on all suitable modules.  Otherwise,
if the region selects modules, then act on those.  Otherwise, if
there is a module at point, then act on that.  Otherwise read a
single module from the user.

\(fn MODULES ARGS)" t nil)

(autoload 'magit-submodule-unpopulate "magit/lisp/magit-submodule" "\
Remove working directories of MODULES.

With a prefix argument act on all suitable modules.  Otherwise,
if the region selects modules, then act on those.  Otherwise, if
there is a module at point, then act on that.  Otherwise read a
single module from the user.

\(fn MODULES ARGS)" t nil)

(autoload 'magit-submodule-remove "magit/lisp/magit-submodule" "\
Unregister MODULES and remove their working directories.

For safety reasons, do not remove the gitdirs and if a module has
uncomitted changes, then do not remove it at all.  If a module's
gitdir is located inside the working directory, then move it into
the gitdir of the superproject first.

With the \"--force\" argument offer to remove dirty working
directories and with a prefix argument offer to delete gitdirs.
Both actions are very dangerous and have to be confirmed.  There
are additional safety precautions in place, so you might be able
to recover from making a mistake here, but don't count on it.

\(fn MODULES ARGS TRASH-GITDIRS)" t nil)

(autoload 'magit-insert-modules "magit/lisp/magit-submodule" "\
Insert submodule sections.
Hook `magit-module-sections-hook' controls which module sections
are inserted, and option `magit-module-sections-nested' controls
whether they are wrapped in an additional section.

\(fn)" nil nil)

(autoload 'magit-insert-modules-overview "magit/lisp/magit-submodule" "\
Insert sections for all modules.
For each section insert the path and the output of `git describe --tags',
or, failing that, the abbreviated HEAD commit hash.

\(fn)" nil nil)

(autoload 'magit-insert-modules-unpulled-from-upstream "magit/lisp/magit-submodule" "\
Insert sections for modules that haven't been pulled from the upstream.
These sections can be expanded to show the respective commits.

\(fn)" nil nil)

(autoload 'magit-insert-modules-unpulled-from-pushremote "magit/lisp/magit-submodule" "\
Insert sections for modules that haven't been pulled from the push-remote.
These sections can be expanded to show the respective commits.

\(fn)" nil nil)

(autoload 'magit-insert-modules-unpushed-to-upstream "magit/lisp/magit-submodule" "\
Insert sections for modules that haven't been pushed to the upstream.
These sections can be expanded to show the respective commits.

\(fn)" nil nil)

(autoload 'magit-insert-modules-unpushed-to-pushremote "magit/lisp/magit-submodule" "\
Insert sections for modules that haven't been pushed to the push-remote.
These sections can be expanded to show the respective commits.

\(fn)" nil nil)

(autoload 'magit-list-submodules "magit/lisp/magit-submodule" "\
Display a list of the current repository's submodules.

\(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-submodule" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-subtree" "magit/lisp/magit-subtree.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-subtree.el
 (autoload 'magit-subtree-popup "magit-subtree" nil t)

(autoload 'magit-subtree-add "magit/lisp/magit-subtree" "\
Add REF from REPOSITORY as a new subtree at PREFIX.

\(fn PREFIX REPOSITORY REF ARGS)" t nil)

(autoload 'magit-subtree-add-commit "magit/lisp/magit-subtree" "\
Add COMMIT as a new subtree at PREFIX.

\(fn PREFIX COMMIT ARGS)" t nil)

(autoload 'magit-subtree-merge "magit/lisp/magit-subtree" "\
Merge COMMIT into the PREFIX subtree.

\(fn PREFIX COMMIT ARGS)" t nil)

(autoload 'magit-subtree-pull "magit/lisp/magit-subtree" "\
Pull REF from REPOSITORY into the PREFIX subtree.

\(fn PREFIX REPOSITORY REF ARGS)" t nil)

(autoload 'magit-subtree-push "magit/lisp/magit-subtree" "\
Extract the history of the subtree PREFIX and push it to REF on REPOSITORY.

\(fn PREFIX REPOSITORY REF ARGS)" t nil)

(autoload 'magit-subtree-split "magit/lisp/magit-subtree" "\
Extract the history of the subtree PREFIX.

\(fn PREFIX COMMIT ARGS)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-subtree" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-tag" "magit/lisp/magit-tag.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-tag.el
 (autoload 'magit-tag-popup "magit" nil t)

(autoload 'magit-tag-create "magit/lisp/magit-tag" "\
Create a new tag with the given NAME at REV.
With a prefix argument annotate the tag.

\(git tag [--annotate] NAME REV)

\(fn NAME REV &optional ARGS)" t nil)

(autoload 'magit-tag-delete "magit/lisp/magit-tag" "\
Delete one or more tags.
If the region marks multiple tags (and nothing else), then offer
to delete those, otherwise prompt for a single tag to be deleted,
defaulting to the tag at point.

\(git tag -d TAGS)

\(fn TAGS)" t nil)

(autoload 'magit-tag-prune "magit/lisp/magit-tag" "\
Offer to delete tags missing locally from REMOTE, and vice versa.

\(fn TAGS REMOTE-TAGS REMOTE)" t nil)

(autoload 'magit-tag-release "magit/lisp/magit-tag" "\
Create an opinionated release tag.

Assume version tags that match \"\\\\`v?[0-9]\\\\(\\\\.[0-9]\\\\)*\\\\'\".
Prompt for the name of the new tag using the highest existing tag
as initial input and call \"git tag --annotate --sign -m MSG\" TAG,
regardless of whether these arguments are enabled in the popup.
Given a TAG \"v1.2.3\" and a repository \"/path/to/foo-bar\", the
MESSAGE would be \"Foo-Bar 1.2.3\".

Because it is so opinionated, this command is not available from
the tag popup by default.

\(fn TAG)" t nil)

;;;***

;;;### (autoloads nil "magit/lisp/magit-utils" "magit/lisp/magit-utils.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-utils.el

(autoload 'magit-emacs-Q-command "magit/lisp/magit-utils" "\
Show a shell command that runs an uncustomized Emacs with only Magit loaded.
See info node `(magit)Debugging Tools' for more information.

\(fn)" t nil)

(autoload 'Info-follow-nearest-node--magit-gitman "magit/lisp/magit-utils" "\


\(fn FN &optional FORK)" nil nil)

(advice-add 'Info-follow-nearest-node :around 'Info-follow-nearest-node--magit-gitman)

(autoload 'org-man-export--magit-gitman "magit/lisp/magit-utils" "\


\(fn FN LINK DESCRIPTION FORMAT)" nil nil)

(advice-add 'org-man-export :around 'org-man-export--magit-gitman)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-utils" '("magit-" "whitespace-dont-turn-on-in-magit-mode")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-wip" "magit/lisp/magit-wip.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-wip.el

(defvar magit-wip-after-save-mode nil "\
Non-nil if Magit-Wip-After-Save mode is enabled.
See the `magit-wip-after-save-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `magit-wip-after-save-mode'.")

(custom-autoload 'magit-wip-after-save-mode "magit/lisp/magit-wip" nil)

(autoload 'magit-wip-after-save-mode "magit/lisp/magit-wip" "\
Toggle Magit-Wip-After-Save-Local mode in all buffers.
With prefix ARG, enable Magit-Wip-After-Save mode if ARG is positive;
otherwise, disable it.  If called from Lisp, enable the mode if
ARG is omitted or nil.

Magit-Wip-After-Save-Local mode is enabled in all buffers where
`magit-wip-after-save-local-mode-turn-on' would do it.
See `magit-wip-after-save-local-mode' for more information on Magit-Wip-After-Save-Local mode.

\(fn &optional ARG)" t nil)

(defvar magit-wip-after-apply-mode nil "\
Non-nil if Magit-Wip-After-Apply mode is enabled.
See the `magit-wip-after-apply-mode' command
for a description of this minor mode.")

(custom-autoload 'magit-wip-after-apply-mode "magit/lisp/magit-wip" nil)

(autoload 'magit-wip-after-apply-mode "magit/lisp/magit-wip" "\
Commit to work-in-progress refs.

After applying a change using any \"apply variant\"
command (apply, stage, unstage, discard, and reverse) commit the
affected files to the current wip refs.  For each branch there
may be two wip refs; one contains snapshots of the files as found
in the worktree and the other contains snapshots of the entries
in the index.

\(fn &optional ARG)" t nil)

(defvar magit-wip-before-change-mode nil "\
Non-nil if Magit-Wip-Before-Change mode is enabled.
See the `magit-wip-before-change-mode' command
for a description of this minor mode.")

(custom-autoload 'magit-wip-before-change-mode "magit/lisp/magit-wip" nil)

(autoload 'magit-wip-before-change-mode "magit/lisp/magit-wip" "\
Commit to work-in-progress refs before certain destructive changes.

Before invoking a revert command or an \"apply variant\"
command (apply, stage, unstage, discard, and reverse) commit the
affected tracked files to the current wip refs.  For each branch
there may be two wip refs; one contains snapshots of the files
as found in the worktree and the other contains snapshots of the
entries in the index.

Only changes to files which could potentially be affected by the
command which is about to be called are committed.

\(fn &optional ARG)" t nil)

(autoload 'magit-wip-commit-initial-backup "magit/lisp/magit-wip" "\
Before saving, commit current file to a worktree wip ref.

The user has to add this function to `before-save-hook'.

Commit the current state of the visited file before saving the
current buffer to that file.  This backs up the same version of
the file as `backup-buffer' would, but stores the backup in the
worktree wip ref, which is also used by the various Magit Wip
modes, instead of in a backup file as `backup-buffer' would.

This function ignores the variables that affect `backup-buffer'
and can be used along-side that function, which is recommended
because this function only backs up files that are tracked in
a Git repository.

\(fn)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-wip" '("magit-")))

;;;***

;;;### (autoloads nil "magit/lisp/magit-worktree" "magit/lisp/magit-worktree.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from magit/lisp/magit-worktree.el
 (autoload 'magit-worktree-popup "magit-worktree" nil t)

(autoload 'magit-worktree-checkout "magit/lisp/magit-worktree" "\
Checkout BRANCH in a new worktree at PATH.

\(fn PATH BRANCH)" t nil)

(autoload 'magit-worktree-branch "magit/lisp/magit-worktree" "\
Create a new BRANCH and check it out in a new worktree at PATH.

\(fn PATH BRANCH START-POINT &optional FORCE)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "magit/lisp/magit-worktree" '("magit-")))

;;;***

;;;### (autoloads nil "markdown-mode/markdown-mode" "markdown-mode/markdown-mode.el"
;;;;;;  (21704 62835 0 0))
;;; Generated autoloads from markdown-mode/markdown-mode.el

(autoload 'markdown-mode "markdown-mode/markdown-mode" "\
Major mode for editing Markdown files.

\(fn)" t nil)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))

(autoload 'gfm-mode "markdown-mode/markdown-mode" "\
Major mode for editing GitHub Flavored Markdown files.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "mo-git-blame/mo-git-blame" "mo-git-blame/mo-git-blame.el"
;;;;;;  (21517 40458 0 0))
;;; Generated autoloads from mo-git-blame/mo-git-blame.el

(autoload 'mo-git-blame-file "mo-git-blame/mo-git-blame" "\
Calls `git blame' for REVISION of FILE-NAME or `HEAD' if
REVISION is not given. Initializes the two windows that will show
the output of 'git blame' and the content.

If FILE-NAME is missing it will be read with `find-file' in
interactive mode.

ORIGINAL-FILE-NAME defaults to FILE-NAME if not given. This is
used for tracking renaming and moving of files during iterative
re-blaming.

With a numeric prefix argument or with NUM-LINES-TO-BLAME only
the NUM-LINES-TO-BLAME lines before and after point are blamed by
using git blame's `-L' option. Otherwise the whole file is
blamed.

\(fn &optional FILE-NAME REVISION ORIGINAL-FILE-NAME NUM-LINES-TO-BLAME)" t nil)

(autoload 'mo-git-blame-current "mo-git-blame/mo-git-blame" "\
Calls `mo-git-blame-file' for HEAD for the current buffer.

\(fn)" t nil)

(autoload 'mo-git-blame-current-for-revision "mo-git-blame/mo-git-blame" "\
Calls `mo-git-blame-file' for `revision' for the current buffer.

\(fn REVISION)" t nil)

;;;***

;;;### (autoloads nil "mu4e-alert/mu4e-alert" "mu4e-alert/mu4e-alert.el"
;;;;;;  (22163 23453 0 0))
;;; Generated autoloads from mu4e-alert/mu4e-alert.el

(autoload 'mu4e-alert-set-default-style "mu4e-alert/mu4e-alert" "\
Set the default style for unread email notifications.

VALUE is the value to be used as the default style.

\(fn VALUE)" nil nil)

(autoload 'mu4e-alert-enable-mode-line-display "mu4e-alert/mu4e-alert" "\
Enable display of unread emails in mode-line.

\(fn)" t nil)

(autoload 'mu4e-alert-enable-notifications "mu4e-alert/mu4e-alert" "\
Enable desktop notifications for unread emails.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "mu4e/mu4e/mu4e" "mu4e/mu4e/mu4e.el" (22617
;;;;;;  16833 0 0))
;;; Generated autoloads from mu4e/mu4e/mu4e.el

(autoload 'mu4e "mu4e/mu4e/mu4e" "\
If mu4e is not running yet, start it. Then, show the main
window, unless BACKGROUND (prefix-argument) is non-nil.

\(fn &optional BACKGROUND)" t nil)

;;;***

;;;### (autoloads nil "mu4e/mu4e/mu4e-compose" "mu4e/mu4e/mu4e-compose.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from mu4e/mu4e/mu4e-compose.el

(autoload 'mu4e~compose-mail "mu4e/mu4e/mu4e-compose" "\
This is mu4e's implementation of `compose-mail'.

\(fn &optional TO SUBJECT OTHER-HEADERS CONTINUE SWITCH-FUNCTION YANK-ACTION SEND-ACTIONS RETURN-ACTION)" nil nil)

(define-mail-user-agent 'mu4e-user-agent 'mu4e~compose-mail 'message-send-and-exit 'message-kill-buffer 'message-send-hook)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "mu4e/mu4e/mu4e-compose" '("mu4e")))

;;;***

;;;### (autoloads nil "mu4e/mu4e/mu4e-speedbar" "mu4e/mu4e/mu4e-speedbar.el"
;;;;;;  (22617 16833 0 0))
;;; Generated autoloads from mu4e/mu4e/mu4e-speedbar.el

(autoload 'mu4e-speedbar-buttons "mu4e/mu4e/mu4e-speedbar" "\
Create buttons for any mu4e BUFFER.

\(fn BUFFER)" t nil)

;;;***

;;;### (autoloads nil "multiple-cursors/mc-cycle-cursors" "multiple-cursors/mc-cycle-cursors.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from multiple-cursors/mc-cycle-cursors.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "multiple-cursors/mc-cycle-cursors" '("mc/")))

;;;***

;;;### (autoloads nil "multiple-cursors/mc-edit-lines" "multiple-cursors/mc-edit-lines.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from multiple-cursors/mc-edit-lines.el

(autoload 'mc/edit-lines "multiple-cursors/mc-edit-lines" "\
Add one cursor to each line of the active region.
Starts from mark and moves in straight down or up towards the
line point is on.

What is done with lines which are not long enough is governed by
`mc/edit-lines-empty-lines'.  The prefix argument ARG can be used
to override this.  If ARG is a symbol (when called from Lisp),
that symbol is used instead of `mc/edit-lines-empty-lines'.
Otherwise, if ARG negative, short lines will be ignored.  Any
other non-nil value will cause short lines to be padded.

\(fn &optional ARG)" t nil)

(autoload 'mc/edit-ends-of-lines "multiple-cursors/mc-edit-lines" "\
Add one cursor to the end of each line in the active region.

\(fn)" t nil)

(autoload 'mc/edit-beginnings-of-lines "multiple-cursors/mc-edit-lines" "\
Add one cursor to the beginning of each line in the active region.

\(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "multiple-cursors/mc-edit-lines" '("mc/edit-lines-empty-lines")))

;;;***

;;;### (autoloads nil "multiple-cursors/mc-hide-unmatched-lines-mode"
;;;;;;  "multiple-cursors/mc-hide-unmatched-lines-mode.el" (0 0 0
;;;;;;  0))
;;; Generated autoloads from multiple-cursors/mc-hide-unmatched-lines-mode.el

(autoload 'mc-hide-unmatched-lines-mode "multiple-cursors/mc-hide-unmatched-lines-mode" "\
Minor mode when enabled hides all lines where no cursors (and
also hum/lines-to-expand below and above) To make use of this
mode press \"C-'\" while multiple-cursor-mode is active. You can
still edit lines while you are in mc-hide-unmatched-lines
mode. To leave this mode press <return> or \"C-g\"

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "multiple-cursors/mc-hide-unmatched-lines-mode" '("hum/")))

;;;***

;;;### (autoloads nil "multiple-cursors/mc-mark-more" "multiple-cursors/mc-mark-more.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from multiple-cursors/mc-mark-more.el

(autoload 'mc/mark-next-like-this "multiple-cursors/mc-mark-more" "\
Find and mark the next part of the buffer matching the currently active region
If no region is active add a cursor on the next line
With negative ARG, delete the last one instead.
With zero ARG, skip the last one and mark next.

\(fn ARG)" t nil)

(autoload 'mc/mark-next-like-this-word "multiple-cursors/mc-mark-more" "\
Find and mark the next part of the buffer matching the currently active region
If no region is active, mark the word at the point and find the next match
With negative ARG, delete the last one instead.
With zero ARG, skip the last one and mark next.

\(fn ARG)" t nil)

(autoload 'mc/mark-next-word-like-this "multiple-cursors/mc-mark-more" "\
Find and mark the next word of the buffer matching the currently active region
The matching region must be a whole word to be a match
If no region is active, mark the symbol at the point and find the next match
With negative ARG, delete the last one instead.
With zero ARG, skip the last one and mark next.

\(fn ARG)" t nil)

(autoload 'mc/mark-next-symbol-like-this "multiple-cursors/mc-mark-more" "\
Find and mark the next symbol of the buffer matching the currently active region
The matching region must be a whole symbol to be a match
If no region is active, mark the symbol at the point and find the next match
With negative ARG, delete the last one instead.
With zero ARG, skip the last one and mark next.

\(fn ARG)" t nil)

(autoload 'mc/mark-previous-like-this "multiple-cursors/mc-mark-more" "\
Find and mark the previous part of the buffer matching the currently active region
If no region is active add a cursor on the previous line
With negative ARG, delete the last one instead.
With zero ARG, skip the last one and mark next.

\(fn ARG)" t nil)

(autoload 'mc/mark-previous-like-this-word "multiple-cursors/mc-mark-more" "\
Find and mark the previous part of the buffer matching the currently active region
If no region is active, mark the word at the point and find the previous match
With negative ARG, delete the last one instead.
With zero ARG, skip the last one and mark previous.

\(fn ARG)" t nil)

(autoload 'mc/mark-previous-word-like-this "multiple-cursors/mc-mark-more" "\
Find and mark the previous part of the buffer matching the currently active region
The matching region must be a whole word to be a match
If no region is active add a cursor on the previous line
With negative ARG, delete the last one instead.
With zero ARG, skip the last one and mark next.

\(fn ARG)" t nil)

(autoload 'mc/mark-previous-symbol-like-this "multiple-cursors/mc-mark-more" "\
Find and mark the previous part of the buffer matching the currently active region
The matching region must be a whole symbol to be a match
If no region is active add a cursor on the previous line
With negative ARG, delete the last one instead.
With zero ARG, skip the last one and mark next.

\(fn ARG)" t nil)

(autoload 'mc/mark-next-lines "multiple-cursors/mc-mark-more" "\


\(fn ARG)" t nil)

(autoload 'mc/mark-previous-lines "multiple-cursors/mc-mark-more" "\


\(fn ARG)" t nil)

(autoload 'mc/unmark-next-like-this "multiple-cursors/mc-mark-more" "\
Deselect next part of the buffer matching the currently active region.

\(fn)" t nil)

(autoload 'mc/unmark-previous-like-this "multiple-cursors/mc-mark-more" "\
Deselect prev part of the buffer matching the currently active region.

\(fn)" t nil)

(autoload 'mc/skip-to-next-like-this "multiple-cursors/mc-mark-more" "\
Skip the current one and select the next part of the buffer matching the currently active region.

\(fn)" t nil)

(autoload 'mc/skip-to-previous-like-this "multiple-cursors/mc-mark-more" "\
Skip the current one and select the prev part of the buffer matching the currently active region.

\(fn)" t nil)

(autoload 'mc/mark-all-like-this "multiple-cursors/mc-mark-more" "\
Find and mark all the parts of the buffer matching the currently active region

\(fn)" t nil)

(autoload 'mc/mark-all-words-like-this "multiple-cursors/mc-mark-more" "\


\(fn)" t nil)

(autoload 'mc/mark-all-symbols-like-this "multiple-cursors/mc-mark-more" "\


\(fn)" t nil)

(autoload 'mc/mark-all-in-region "multiple-cursors/mc-mark-more" "\
Find and mark all the parts in the region matching the given search

\(fn BEG END &optional SEARCH)" t nil)

(autoload 'mc/mark-all-in-region-regexp "multiple-cursors/mc-mark-more" "\
Find and mark all the parts in the region matching the given regexp.

\(fn BEG END)" t nil)

(autoload 'mc/mark-more-like-this-extended "multiple-cursors/mc-mark-more" "\
Like mark-more-like-this, but then lets you adjust with arrows key.
The adjustments work like this:

   <up>    Mark previous like this and set direction to 'up
   <down>  Mark next like this and set direction to 'down

If direction is 'up:

   <left>  Skip past the cursor furthest up
   <right> Remove the cursor furthest up

If direction is 'down:

   <left>  Remove the cursor furthest down
   <right> Skip past the cursor furthest down

The bindings for these commands can be changed. See `mc/mark-more-like-this-extended-keymap'.

\(fn)" t nil)

(autoload 'mc/mark-all-like-this-dwim "multiple-cursors/mc-mark-more" "\
Tries to guess what you want to mark all of.
Can be pressed multiple times to increase selection.

With prefix, it behaves the same as original `mc/mark-all-like-this'

\(fn ARG)" t nil)

(autoload 'mc/mark-all-dwim "multiple-cursors/mc-mark-more" "\
Tries even harder to guess what you want to mark all of.

If the region is active and spans multiple lines, it will behave
as if `mc/mark-all-in-region'. With the prefix ARG, it will call
`mc/edit-lines' instead.

If the region is inactive or on a single line, it will behave like
`mc/mark-all-like-this-dwim'.

\(fn ARG)" t nil)

(autoload 'mc/mark-all-like-this-in-defun "multiple-cursors/mc-mark-more" "\
Mark all like this in defun.

\(fn)" t nil)

(autoload 'mc/mark-all-words-like-this-in-defun "multiple-cursors/mc-mark-more" "\
Mark all words like this in defun.

\(fn)" t nil)

(autoload 'mc/mark-all-symbols-like-this-in-defun "multiple-cursors/mc-mark-more" "\
Mark all symbols like this in defun.

\(fn)" t nil)

(autoload 'mc/toggle-cursor-on-click "multiple-cursors/mc-mark-more" "\
Add a cursor where you click, or remove a fake cursor that is
already there.

\(fn EVENT)" t nil)

(defalias 'mc/add-cursor-on-click 'mc/toggle-cursor-on-click)

(autoload 'mc/mark-sgml-tag-pair "multiple-cursors/mc-mark-more" "\
Mark the tag we're in and its pair for renaming.

\(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "multiple-cursors/mc-mark-more" '("mc/" "mc--")))

;;;***

;;;### (autoloads nil "multiple-cursors/mc-mark-pop" "multiple-cursors/mc-mark-pop.el"
;;;;;;  (21268 30210 0 0))
;;; Generated autoloads from multiple-cursors/mc-mark-pop.el

(autoload 'mc/mark-pop "multiple-cursors/mc-mark-pop" "\
Add a cursor at the current point, pop off mark ring and jump
to the popped mark.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "multiple-cursors/mc-separate-operations" "multiple-cursors/mc-separate-operations.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from multiple-cursors/mc-separate-operations.el

(autoload 'mc/insert-numbers "multiple-cursors/mc-separate-operations" "\
Insert increasing numbers for each cursor, starting at
`mc/insert-numbers-default' or ARG.

\(fn ARG)" t nil)

(autoload 'mc/insert-letters "multiple-cursors/mc-separate-operations" "\
Insert increasing letters for each cursor, starting at 0 or ARG.
     Where letter[0]=a letter[2]=c letter[26]=aa

\(fn ARG)" t nil)

(autoload 'mc/reverse-regions "multiple-cursors/mc-separate-operations" "\


\(fn)" t nil)

(autoload 'mc/sort-regions "multiple-cursors/mc-separate-operations" "\


\(fn)" t nil)

(autoload 'mc/vertical-align "multiple-cursors/mc-separate-operations" "\
Aligns all cursors vertically with a given CHARACTER to the one with the
highest colum number (the rightest).
Might not behave as intended if more than one cursors are on the same line.

\(fn CHARACTER)" t nil)

(autoload 'mc/vertical-align-with-space "multiple-cursors/mc-separate-operations" "\
Aligns all cursors with whitespace like `mc/vertical-align' does

\(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "multiple-cursors/mc-separate-operations" '("mc/insert-numbers-default" "mc--")))

;;;***

;;;### (autoloads nil "multiple-cursors/multiple-cursors-core" "multiple-cursors/multiple-cursors-core.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from multiple-cursors/multiple-cursors-core.el

(autoload 'multiple-cursors-mode "multiple-cursors/multiple-cursors-core" "\
Mode while multiple cursors are active.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "multiple-cursors/multiple-cursors-core" '("multiple-cursors-mode" "unsupported-cmd" "deactivate-cursor-after-undo" "activate-cursor-for-undo")))

;;;***

;;;### (autoloads nil "multiple-cursors/rectangular-region-mode"
;;;;;;  "multiple-cursors/rectangular-region-mode.el" (0 0 0 0))
;;; Generated autoloads from multiple-cursors/rectangular-region-mode.el

(autoload 'set-rectangular-region-anchor "multiple-cursors/rectangular-region-mode" "\
Anchors the rectangular region at point.

Think of this one as `set-mark' except you're marking a rectangular region. It is
an exceedingly quick way of adding multiple cursors to multiple lines.

\(fn)" t nil)

(autoload 'rectangular-region-mode "multiple-cursors/rectangular-region-mode" "\
A mode for creating a rectangular region to edit

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "multiple-cursors/rectangular-region-mode" '("rectangular-region-mode" "rrm/")))

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/htmlize" "org-mode/contrib/lisp/htmlize.el"
;;;;;;  (21273 39857 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/htmlize.el

(autoload 'htmlize-buffer "org-mode/contrib/lisp/htmlize" "\
Convert BUFFER to HTML, preserving colors and decorations.

The generated HTML is available in a new buffer, which is returned.
When invoked interactively, the new buffer is selected in the current
window.  The title of the generated document will be set to the buffer's
file name or, if that's not available, to the buffer's name.

Note that htmlize doesn't fontify your buffers, it only uses the
decorations that are already present.  If you don't set up font-lock or
something else to fontify your buffers, the resulting HTML will be
plain.  Likewise, if you don't like the choice of colors, fix the mode
that created them, or simply alter the faces it uses.

\(fn &optional BUFFER)" t nil)

(autoload 'htmlize-region "org-mode/contrib/lisp/htmlize" "\
Convert the region to HTML, preserving colors and decorations.
See `htmlize-buffer' for details.

\(fn BEG END)" t nil)

(autoload 'htmlize-file "org-mode/contrib/lisp/htmlize" "\
Load FILE, fontify it, convert it to HTML, and save the result.

Contents of FILE are inserted into a temporary buffer, whose major mode
is set with `normal-mode' as appropriate for the file type.  The buffer
is subsequently fontified with `font-lock' and converted to HTML.  Note
that, unlike `htmlize-buffer', this function explicitly turns on
font-lock.  If a form of highlighting other than font-lock is desired,
please use `htmlize-buffer' directly on buffers so highlighted.

Buffers currently visiting FILE are unaffected by this function.  The
function does not change current buffer or move the point.

If TARGET is specified and names a directory, the resulting file will be
saved there instead of to FILE's directory.  If TARGET is specified and
does not name a directory, it will be used as output file name.

\(fn FILE &optional TARGET)" t nil)

(autoload 'htmlize-many-files "org-mode/contrib/lisp/htmlize" "\
Convert FILES to HTML and save the corresponding HTML versions.

FILES should be a list of file names to convert.  This function calls
`htmlize-file' on each file; see that function for details.  When
invoked interactively, you are prompted for a list of files to convert,
terminated with RET.

If TARGET-DIRECTORY is specified, the HTML files will be saved to that
directory.  Normally, each HTML file is saved to the directory of the
corresponding source file.

\(fn FILES &optional TARGET-DIRECTORY)" t nil)

(autoload 'htmlize-many-files-dired "org-mode/contrib/lisp/htmlize" "\
HTMLize dired-marked files.

\(fn ARG &optional TARGET-DIRECTORY)" t nil)

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/org-bullets" "org-mode/contrib/lisp/org-bullets.el"
;;;;;;  (21273 39857 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/org-bullets.el

(autoload 'org-bullets-mode "org-mode/contrib/lisp/org-bullets" "\
UTF-8 bullets for `org-mode'.

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/org-colview-xemacs"
;;;;;;  "org-mode/contrib/lisp/org-colview-xemacs.el" (21273 39857
;;;;;;  0 0))
;;; Generated autoloads from org-mode/contrib/lisp/org-colview-xemacs.el

(autoload 'org-columns-remove-overlays "org-mode/contrib/lisp/org-colview-xemacs" "\
Remove all currently active column overlays.

\(fn)" t nil)

(autoload 'org-columns-get-format-and-top-level "org-mode/contrib/lisp/org-colview-xemacs" "\


\(fn)" nil nil)

(autoload 'org-columns-compute "org-mode/contrib/lisp/org-colview-xemacs" "\
Sum the values of property PROPERTY hierarchically, for the entire buffer.

\(fn PROPERTY)" t nil)

(autoload 'org-columns-number-to-string "org-mode/contrib/lisp/org-colview-xemacs" "\
Convert a computed column number to a string value, according to FMT.

\(fn N FMT &optional PRINTF)" nil nil)

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/org-contacts" "org-mode/contrib/lisp/org-contacts.el"
;;;;;;  (21273 39857 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/org-contacts.el

(autoload 'org-contacts "org-mode/contrib/lisp/org-contacts" "\
Create agenda view for contacts matching NAME.

\(fn NAME)" t nil)

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/org-registry" "org-mode/contrib/lisp/org-registry.el"
;;;;;;  (21273 39857 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/org-registry.el

(autoload 'org-registry-show "org-mode/contrib/lisp/org-registry" "\
Show Org files where there are links pointing to the current
buffer.

\(fn &optional VISIT)" t nil)

(autoload 'org-registry-visit "org-mode/contrib/lisp/org-registry" "\
If an Org file contains a link to the current location, visit
this file.

\(fn)" t nil)

(autoload 'org-registry-initialize "org-mode/contrib/lisp/org-registry" "\
Initialize `org-registry-alist'.
If FROM-SCRATCH is non-nil or the registry does not exist yet,
create a new registry from scratch and eval it. If the registry
exists, eval `org-registry-file' and make it the new value for
`org-registry-alist'.

\(fn &optional FROM-SCRATCH)" t nil)

(autoload 'org-registry-insinuate "org-mode/contrib/lisp/org-registry" "\
Call `org-registry-update' after saving in Org-mode.
Use with caution.  This could slow down things a bit.

\(fn)" t nil)

(autoload 'org-registry-update "org-mode/contrib/lisp/org-registry" "\
Update the registry for the current Org file.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/org-screenshot" "org-mode/contrib/lisp/org-screenshot.el"
;;;;;;  (21273 39857 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/org-screenshot.el

(autoload 'org-screenshot-take "org-mode/contrib/lisp/org-screenshot" "\
Take a screenshot and insert link to it at point, if image
display is already on (see \\[org-toggle-inline-images])
screenshot will be displayed as an image

Screen area for the screenshot is selected with the mouse, left
click on a window screenshots that window, while left click and
drag selects a region. Pressing any key cancels the screen shot

With `C-u' universal argument waits one second after target is
selected before taking the screenshot. With double `C-u' wait two
seconds.

With triple `C-u' wait 3 seconds, and also rings the bell when
screenshot is done, any more `C-u' after that increases delay by
2 seconds

\(fn &optional DELAY)" t nil)

(autoload 'org-screenshot-rotate-prev "org-mode/contrib/lisp/org-screenshot" "\
Rotate last screenshot with one of the previously taken
screenshots from the same directory. If DIR is negative, rotate
in the other direction

\(fn DIR)" t nil)

(autoload 'org-screenshot-rotate-next "org-mode/contrib/lisp/org-screenshot" "\
Rotate last screenshot with one of the previously taken
screenshots from the same directory. If DIR is negative, rotate
in the other direction

\(fn DIR)" t nil)

(autoload 'org-screenshot-show-unused "org-mode/contrib/lisp/org-screenshot" "\
Open A Dired buffer with unused screenshots marked

\(fn)" t nil)

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/org-toc" "org-mode/contrib/lisp/org-toc.el"
;;;;;;  (21273 39857 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/org-toc.el

(autoload 'org-toc-show "org-mode/contrib/lisp/org-toc" "\
Show the table of contents of the current Org-mode buffer.

\(fn &optional DEPTH POSITION)" t nil)

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/org-track" "org-mode/contrib/lisp/org-track.el"
;;;;;;  (21273 39857 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/org-track.el

(autoload 'org-track-fetch-package "org-mode/contrib/lisp/org-track" "\
Fetch Org package depending on `org-track-fetch-package-extension'.
If DIRECTORY is defined, unpack the package there, i.e. add the
subdirectory org-mode/ to DIRECTORY.

\(fn &optional DIRECTORY)" t nil)

(autoload 'org-track-compile-org "org-mode/contrib/lisp/org-track" "\
Compile all *.el files that come with org-mode.
Generate the autoloads file `org-loaddefs.el'.

DIRECTORY is where the directory org-mode/ lives (i.e. the
          parent directory of your local repo.

\(fn &optional DIRECTORY)" t nil)

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/ox-freemind" "org-mode/contrib/lisp/ox-freemind.el"
;;;;;;  (21273 39857 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/ox-freemind.el

(autoload 'org-freemind-export-to-freemind "org-mode/contrib/lisp/ox-freemind" "\
Export current buffer to a Freemind Mindmap file.

If narrowing is active in the current buffer, only export its
narrowed part.

If a region is active, export that region.

A non-nil optional argument ASYNC means the process should happen
asynchronously.  The resulting file should be accessible through
the `org-export-stack' interface.

When optional argument SUBTREEP is non-nil, export the sub-tree
at point, extracting information from the headline properties
first.

When optional argument VISIBLE-ONLY is non-nil, don't export
contents of hidden elements.

When optional argument BODY-ONLY is non-nil, only write code
between \"<body>\" and \"</body>\" tags.

EXT-PLIST, when provided, is a property list with external
parameters overriding Org default settings, but still inferior to
file-local settings.

Return output file's name.

\(fn &optional ASYNC SUBTREEP VISIBLE-ONLY BODY-ONLY EXT-PLIST)" t nil)

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/ox-koma-letter" "org-mode/contrib/lisp/ox-koma-letter.el"
;;;;;;  (21591 21489 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/ox-koma-letter.el

(autoload 'org-koma-letter-export-as-latex "org-mode/contrib/lisp/ox-koma-letter" "\
Export current buffer as a KOMA Scrlttr2 letter.

If narrowing is active in the current buffer, only export its
narrowed part.

If a region is active, export that region.

A non-nil optional argument ASYNC means the process should happen
asynchronously.  The resulting buffer should be accessible
through the `org-export-stack' interface.

When optional argument SUBTREEP is non-nil, export the sub-tree
at point, extracting information from the headline properties
first.

When optional argument VISIBLE-ONLY is non-nil, don't export
contents of hidden elements.

When optional argument BODY-ONLY is non-nil, only write code
between \"\\begin{letter}\" and \"\\end{letter}\".

EXT-PLIST, when provided, is a proeprty list with external
parameters overriding Org default settings, but still inferior to
file-local settings.

Export is done in a buffer named \"*Org KOMA-LETTER Export*\".  It
will be displayed if `org-export-show-temporary-export-buffer' is
non-nil.

\(fn &optional ASYNC SUBTREEP VISIBLE-ONLY BODY-ONLY EXT-PLIST)" t nil)

(autoload 'org-koma-letter-export-to-latex "org-mode/contrib/lisp/ox-koma-letter" "\
Export current buffer as a KOMA Scrlttr2 letter (tex).

If narrowing is active in the current buffer, only export its
narrowed part.

If a region is active, export that region.

A non-nil optional argument ASYNC means the process should happen
asynchronously.  The resulting file should be accessible through
the `org-export-stack' interface.

When optional argument SUBTREEP is non-nil, export the sub-tree
at point, extracting information from the headline properties
first.

When optional argument VISIBLE-ONLY is non-nil, don't export
contents of hidden elements.

When optional argument BODY-ONLY is non-nil, only write code
between \"\\begin{letter}\" and \"\\end{letter}\".

EXT-PLIST, when provided, is a property list with external
parameters overriding Org default settings, but still inferior to
file-local settings.

When optional argument PUB-DIR is set, use it as the publishing
directory.

Return output file's name.

\(fn &optional ASYNC SUBTREEP VISIBLE-ONLY BODY-ONLY EXT-PLIST)" t nil)

(autoload 'org-koma-letter-export-to-pdf "org-mode/contrib/lisp/ox-koma-letter" "\
Export current buffer as a KOMA Scrlttr2 letter (pdf).

If narrowing is active in the current buffer, only export its
narrowed part.

If a region is active, export that region.

A non-nil optional argument ASYNC means the process should happen
asynchronously.  The resulting file should be accessible through
the `org-export-stack' interface.

When optional argument SUBTREEP is non-nil, export the sub-tree
at point, extracting information from the headline properties
first.

When optional argument VISIBLE-ONLY is non-nil, don't export
contents of hidden elements.

When optional argument BODY-ONLY is non-nil, only write code
between \"\\begin{letter}\" and \"\\end{letter}\".

EXT-PLIST, when provided, is a property list with external
parameters overriding Org default settings, but still inferior to
file-local settings.

Return PDF file's name.

\(fn &optional ASYNC SUBTREEP VISIBLE-ONLY BODY-ONLY EXT-PLIST)" t nil)

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/ox-rss" "org-mode/contrib/lisp/ox-rss.el"
;;;;;;  (21591 21489 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/ox-rss.el

(autoload 'org-rss-export-as-rss "org-mode/contrib/lisp/ox-rss" "\
Export current buffer to a RSS buffer.

If narrowing is active in the current buffer, only export its
narrowed part.

If a region is active, export that region.

A non-nil optional argument ASYNC means the process should happen
asynchronously.  The resulting buffer should be accessible
through the `org-export-stack' interface.

When optional argument SUBTREEP is non-nil, export the sub-tree
at point, extracting information from the headline properties
first.

When optional argument VISIBLE-ONLY is non-nil, don't export
contents of hidden elements.

Export is done in a buffer named \"*Org RSS Export*\", which will
be displayed when `org-export-show-temporary-export-buffer' is
non-nil.

\(fn &optional ASYNC SUBTREEP VISIBLE-ONLY)" t nil)

(autoload 'org-rss-export-to-rss "org-mode/contrib/lisp/ox-rss" "\
Export current buffer to a RSS file.

If narrowing is active in the current buffer, only export its
narrowed part.

If a region is active, export that region.

A non-nil optional argument ASYNC means the process should happen
asynchronously.  The resulting file should be accessible through
the `org-export-stack' interface.

When optional argument SUBTREEP is non-nil, export the sub-tree
at point, extracting information from the headline properties
first.

When optional argument VISIBLE-ONLY is non-nil, don't export
contents of hidden elements.

Return output file's name.

\(fn &optional ASYNC SUBTREEP VISIBLE-ONLY)" t nil)

(autoload 'org-rss-publish-to-rss "org-mode/contrib/lisp/ox-rss" "\
Publish an org file to RSS.

FILENAME is the filename of the Org file to be published.  PLIST
is the property list for the given project.  PUB-DIR is the
publishing directory.

Return output file name.

\(fn PLIST FILENAME PUB-DIR)" nil nil)

;;;***

;;;### (autoloads nil "org-mode/contrib/lisp/ox-taskjuggler" "org-mode/contrib/lisp/ox-taskjuggler.el"
;;;;;;  (21704 62839 0 0))
;;; Generated autoloads from org-mode/contrib/lisp/ox-taskjuggler.el

(autoload 'org-taskjuggler-export "org-mode/contrib/lisp/ox-taskjuggler" "\
Export current buffer to a TaskJuggler file.

The exporter looks for a tree with tag that matches
`org-taskjuggler-project-tag' and takes this as the tasks for
this project.  The first node of this tree defines the project
properties such as project name and project period.

If there is a tree with tag that matches
`org-taskjuggler-resource-tag' this tree is taken as resources
for the project.  If no resources are specified, a default
resource is created and allocated to the project.

Also the TaskJuggler project will be created with default reports
as defined in `org-taskjuggler-default-reports'.

If narrowing is active in the current buffer, only export its
narrowed part.

If a region is active, export that region.

A non-nil optional argument ASYNC means the process should happen
asynchronously.  The resulting file should be accessible through
the `org-export-stack' interface.

When optional argument SUBTREEP is non-nil, export the sub-tree
at point, extracting information from the headline properties
first.

When optional argument VISIBLE-ONLY is non-nil, don't export
contents of hidden elements.

Return output file's name.

\(fn &optional ASYNC SUBTREEP VISIBLE-ONLY)" t nil)

(autoload 'org-taskjuggler-export-and-process "org-mode/contrib/lisp/ox-taskjuggler" "\
Export current buffer to a TaskJuggler file and process it.

The exporter looks for a tree with tag that matches
`org-taskjuggler-project-tag' and takes this as the tasks for
this project.  The first node of this tree defines the project
properties such as project name and project period.

If there is a tree with tag that matches
`org-taskjuggler-resource-tag' this tree is taken as resources
for the project.  If no resources are specified, a default
resource is created and allocated to the project.

Also the TaskJuggler project will be created with default reports
as defined in `org-taskjuggler-default-reports'.

If narrowing is active in the current buffer, only export its
narrowed part.

If a region is active, export that region.

When optional argument SUBTREEP is non-nil, export the sub-tree
at point, extracting information from the headline properties
first.

When optional argument VISIBLE-ONLY is non-nil, don't export
contents of hidden elements.

Return a list of reports.

\(fn &optional SUBTREEP VISIBLE-ONLY)" t nil)

(autoload 'org-taskjuggler-export-process-and-open "org-mode/contrib/lisp/ox-taskjuggler" "\
Export current buffer to a TaskJuggler file, process and open it.

Export and process the file using
`org-taskjuggler-export-and-process' and open the generated
reports with a browser.

If you are targeting TaskJuggler 2.4 (see
`org-taskjuggler-target-version') the processing and display of
the reports is done using the TaskJuggler GUI.

\(fn &optional SUBTREEP VISIBLE-ONLY)" t nil)

;;;***

;;;### (autoloads nil "org-mode/lisp/org" "org-mode/lisp/org.el"
;;;;;;  (21704 62839 0 0))
;;; Generated autoloads from org-mode/lisp/org.el

(autoload 'org-babel-do-load-languages "org-mode/lisp/org" "\
Load the languages defined in `org-babel-load-languages'.

\(fn SYM VALUE)" nil nil)

(autoload 'org-babel-load-file "org-mode/lisp/org" "\
Load Emacs Lisp source code blocks in the Org-mode FILE.
This function exports the source code using `org-babel-tangle'
and then loads the resulting file using `load-file'.  With prefix
arg (noninteractively: 2nd arg) COMPILE the tangled Emacs Lisp
file to byte-code before it is loaded.

\(fn FILE &optional COMPILE)" t nil)

(autoload 'org-version "org-mode/lisp/org" "\
Show the org-mode version in the echo area.
With prefix argument HERE, insert it at point.
When FULL is non-nil, use a verbose version string.
When MESSAGE is non-nil, display a message with the version.

\(fn &optional HERE FULL MESSAGE)" t nil)

(autoload 'turn-on-orgtbl "org-mode/lisp/org" "\
Unconditionally turn on `orgtbl-mode'.

\(fn)" nil nil)

(autoload 'org-clock-persistence-insinuate "org-mode/lisp/org" "\
Set up hooks for clock persistence.

\(fn)" nil nil)

(autoload 'org-mode "org-mode/lisp/org" "\
Outline-based notes management and organizer, alias
\"Carsten's outline-mode for keeping track of everything.\"

Org-mode develops organizational tasks around a NOTES file which
contains information about projects as plain text.  Org-mode is
implemented on top of outline-mode, which is ideal to keep the content
of large files well structured.  It supports ToDo items, deadlines and
time stamps, which magically appear in the diary listing of the Emacs
calendar.  Tables are easily created with a built-in table editor.
Plain text URL-like links connect to websites, emails (VM), Usenet
messages (Gnus), BBDB entries, and any files related to the project.
For printing and sharing of notes, an Org-mode file (or a part of it)
can be exported as a structured ASCII or HTML file.

The following commands are available:

\\{org-mode-map}

\(fn)" t nil)

(autoload 'org-cycle "org-mode/lisp/org" "\
TAB-action and visibility cycling for Org-mode.

This is the command invoked in Org-mode by the TAB key.  Its main purpose
is outline visibility cycling, but it also invokes other actions
in special contexts.

- When this function is called with a prefix argument, rotate the entire
  buffer through 3 states (global cycling)
  1. OVERVIEW: Show only top-level headlines.
  2. CONTENTS: Show all headlines of all levels, but no body text.
  3. SHOW ALL: Show everything.
  When called with two `C-u C-u' prefixes, switch to the startup visibility,
  determined by the variable `org-startup-folded', and by any VISIBILITY
  properties in the buffer.
  When called with three `C-u C-u C-u' prefixed, show the entire buffer,
  including any drawers.

- When inside a table, re-align the table and move to the next field.

- When point is at the beginning of a headline, rotate the subtree started
  by this line through 3 different states (local cycling)
  1. FOLDED:   Only the main headline is shown.
  2. CHILDREN: The main headline and the direct children are shown.
               From this state, you can move to one of the children
               and zoom in further.
  3. SUBTREE:  Show the entire subtree, including body text.
  If there is no subtree, switch directly from CHILDREN to FOLDED.

- When point is at the beginning of an empty headline and the variable
  `org-cycle-level-after-item/entry-creation' is set, cycle the level
  of the headline by demoting and promoting it to likely levels.  This
  speeds up creation document structure by pressing TAB once or several
  times right after creating a new headline.

- When there is a numeric prefix, go up to a heading with level ARG, do
  a `show-subtree' and return to the previous cursor position.  If ARG
  is negative, go up that many levels.

- When point is not at the beginning of a headline, execute the global
  binding for TAB, which is re-indenting the line.  See the option
  `org-cycle-emulate-tab' for details.

- Special case: if point is at the beginning of the buffer and there is
  no headline in line 1, this function will act as if called with prefix arg
  (C-u TAB, same as S-TAB) also when called without prefix arg.
  But only if also the variable `org-cycle-global-at-bob' is t.

\(fn &optional ARG)" t nil)

(autoload 'org-global-cycle "org-mode/lisp/org" "\
Cycle the global visibility.  For details see `org-cycle'.
With \\[universal-argument] prefix arg, switch to startup visibility.
With a numeric prefix, show all headlines up to that level.

\(fn &optional ARG)" t nil)
(put 'orgstruct-heading-prefix-regexp 'safe-local-variable 'stringp)

(autoload 'orgstruct-mode "org-mode/lisp/org" "\
Toggle the minor mode `orgstruct-mode'.
This mode is for using Org-mode structure commands in other
modes.  The following keys behave as if Org-mode were active, if
the cursor is on a headline, or on a plain list item (both as
defined by Org-mode).

\(fn &optional ARG)" t nil)

(autoload 'turn-on-orgstruct "org-mode/lisp/org" "\
Unconditionally turn on `orgstruct-mode'.

\(fn)" nil nil)

(autoload 'turn-on-orgstruct++ "org-mode/lisp/org" "\
Unconditionally turn on `orgstruct++-mode'.

\(fn)" nil nil)

(autoload 'org-run-like-in-org-mode "org-mode/lisp/org" "\
Run a command, pretending that the current buffer is in Org-mode.
This will temporarily bind local variables that are typically bound in
Org-mode to the values they have in Org-mode, and then interactively
call CMD.

\(fn CMD)" nil nil)

(autoload 'org-store-link "org-mode/lisp/org" "\
\\<org-mode-map>Store an org-link to the current location.
This link is added to `org-stored-links' and can later be inserted
into an org-buffer with \\[org-insert-link].

For some link types, a prefix arg is interpreted.
For links to Usenet articles, arg negates `org-gnus-prefer-web-links'.
For file links, arg negates `org-context-in-file-links'.

A double prefix arg force skipping storing functions that are not
part of Org's core.

A triple prefix arg force storing a link for each line in the
active region.

\(fn ARG)" t nil)

(autoload 'org-insert-link-global "org-mode/lisp/org" "\
Insert a link like Org-mode does.
This command can be called in any mode to insert a link in Org-mode syntax.

\(fn)" t nil)

(autoload 'org-open-at-point-global "org-mode/lisp/org" "\
Follow a link like Org-mode does.
This command can be called in any mode to follow a link that has
Org-mode syntax.

\(fn)" t nil)

(autoload 'org-open-link-from-string "org-mode/lisp/org" "\
Open a link in the string S, as if it was in Org-mode.

\(fn S &optional ARG REFERENCE-BUFFER)" t nil)

(autoload 'org-switchb "org-mode/lisp/org" "\
Switch between Org buffers.
With one prefix argument, restrict available buffers to files.
With two prefix arguments, restrict available buffers to agenda files.

Defaults to `iswitchb' for buffer name completion.
Set `org-completion-use-ido' to make it use ido instead.

\(fn &optional ARG)" t nil)

(defalias 'org-ido-switchb 'org-switchb)

(defalias 'org-iswitchb 'org-switchb)

(autoload 'org-cycle-agenda-files "org-mode/lisp/org" "\
Cycle through the files in `org-agenda-files'.
If the current buffer visits an agenda file, find the next one in the list.
If the current buffer does not, find the first agenda file.

\(fn)" t nil)

(autoload 'org-submit-bug-report "org-mode/lisp/org" "\
Submit a bug report on Org-mode via mail.

Don't hesitate to report any problems or inaccurate documentation.

If you don't have setup sending mail from (X)Emacs, please copy the
output buffer into your mail program, as it gives us important
information about your Org-mode version and configuration.

\(fn)" t nil)

(autoload 'org-reload "org-mode/lisp/org" "\
Reload all org lisp files.
With prefix arg UNCOMPILED, load the uncompiled versions.

\(fn &optional UNCOMPILED)" t nil)

(autoload 'org-customize "org-mode/lisp/org" "\
Call the customize function with org as argument.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "org-mode/lisp/org-agenda" "org-mode/lisp/org-agenda.el"
;;;;;;  (21704 62839 0 0))
;;; Generated autoloads from org-mode/lisp/org-agenda.el

(autoload 'org-toggle-sticky-agenda "org-mode/lisp/org-agenda" "\
Toggle `org-agenda-sticky'.

\(fn &optional ARG)" t nil)

(autoload 'org-agenda "org-mode/lisp/org-agenda" "\
Dispatch agenda commands to collect entries to the agenda buffer.
Prompts for a command to execute.  Any prefix arg will be passed
on to the selected command.  The default selections are:

a     Call `org-agenda-list' to display the agenda for current day or week.
t     Call `org-todo-list' to display the global todo list.
T     Call `org-todo-list' to display the global todo list, select only
      entries with a specific TODO keyword (the user gets a prompt).
m     Call `org-tags-view' to display headlines with tags matching
      a condition  (the user is prompted for the condition).
M     Like `m', but select only TODO entries, no ordinary headlines.
L     Create a timeline for the current buffer.
e     Export views to associated files.
s     Search entries for keywords.
S     Search entries for keywords, only with TODO keywords.
/     Multi occur across all agenda files and also files listed
      in `org-agenda-text-search-extra-files'.
<     Restrict agenda commands to buffer, subtree, or region.
      Press several times to get the desired effect.
>     Remove a previous restriction.
#     List \"stuck\" projects.
!     Configure what \"stuck\" means.
C     Configure custom agenda commands.

More commands can be added by configuring the variable
`org-agenda-custom-commands'.  In particular, specific tags and TODO keyword
searches can be pre-defined in this way.

If the current buffer is in Org-mode and visiting a file, you can also
first press `<' once to indicate that the agenda should be temporarily
\(until the next use of \\[org-agenda]) restricted to the current file.
Pressing `<' twice means to restrict to the current subtree or region
\(if active).

\(fn &optional ARG ORG-KEYS RESTRICTION)" t nil)

(autoload 'org-batch-agenda "org-mode/lisp/org-agenda" "\
Run an agenda command in batch mode and send the result to STDOUT.
If CMD-KEY is a string of length 1, it is used as a key in
`org-agenda-custom-commands' and triggers this command.  If it is a
longer string it is used as a tags/todo match string.
Parameters are alternating variable names and values that will be bound
before running the agenda command.

\(fn CMD-KEY &rest PARAMETERS)" nil t)

(autoload 'org-batch-agenda-csv "org-mode/lisp/org-agenda" "\
Run an agenda command in batch mode and send the result to STDOUT.
If CMD-KEY is a string of length 1, it is used as a key in
`org-agenda-custom-commands' and triggers this command.  If it is a
longer string it is used as a tags/todo match string.
Parameters are alternating variable names and values that will be bound
before running the agenda command.

The output gives a line for each selected agenda item.  Each
item is a list of comma-separated values, like this:

category,head,type,todo,tags,date,time,extra,priority-l,priority-n

category     The category of the item
head         The headline, without TODO kwd, TAGS and PRIORITY
type         The type of the agenda entry, can be
                todo               selected in TODO match
                tagsmatch          selected in tags match
                diary              imported from diary
                deadline           a deadline on given date
                scheduled          scheduled on given date
                timestamp          entry has timestamp on given date
                closed             entry was closed on given date
                upcoming-deadline  warning about deadline
                past-scheduled     forwarded scheduled item
                block              entry has date block including g. date
todo         The todo keyword, if any
tags         All tags including inherited ones, separated by colons
date         The relevant date, like 2007-2-14
time         The time, like 15:00-16:50
extra        Sting with extra planning info
priority-l   The priority letter if any was given
priority-n   The computed numerical priority
agenda-day   The day in the agenda where this is listed

\(fn CMD-KEY &rest PARAMETERS)" nil t)

(autoload 'org-store-agenda-views "org-mode/lisp/org-agenda" "\
Store agenda views.

\(fn &rest PARAMETERS)" t nil)

(autoload 'org-batch-store-agenda-views "org-mode/lisp/org-agenda" "\
Run all custom agenda commands that have a file argument.

\(fn &rest PARAMETERS)" nil t)

(autoload 'org-agenda-list "org-mode/lisp/org-agenda" "\
Produce a daily/weekly view from all files in variable `org-agenda-files'.
The view will be for the current day or week, but from the overview buffer
you will be able to go to other days/weeks.

With a numeric prefix argument in an interactive call, the agenda will
span ARG days.  Lisp programs should instead specify SPAN to change
the number of days.  SPAN defaults to `org-agenda-span'.

START-DAY defaults to TODAY, or to the most recent match for the weekday
given in `org-agenda-start-on-weekday'.

When WITH-HOUR is non-nil, only include scheduled and deadline
items if they have an hour specification like [h]h:mm.

\(fn &optional ARG START-DAY SPAN WITH-HOUR)" t nil)

(autoload 'org-search-view "org-mode/lisp/org-agenda" "\
Show all entries that contain a phrase or words or regular expressions.

With optional prefix argument TODO-ONLY, only consider entries that are
TODO entries.  The argument STRING can be used to pass a default search
string into this function.  If EDIT-AT is non-nil, it means that the
user should get a chance to edit this string, with cursor at position
EDIT-AT.

The search string can be viewed either as a phrase that should be found as
is, or it can be broken into a number of snippets, each of which must match
in a Boolean way to select an entry.  The default depends on the variable
`org-agenda-search-view-always-boolean'.
Even if this is turned off (the default) you can always switch to
Boolean search dynamically by preceding the first word with  \"+\" or \"-\".

The default is a direct search of the whole phrase, where each space in
the search string can expand to an arbitrary amount of whitespace,
including newlines.

If using a Boolean search, the search string is split on whitespace and
each snippet is searched separately, with logical AND to select an entry.
Words prefixed with a minus must *not* occur in the entry.  Words without
a prefix or prefixed with a plus must occur in the entry.  Matching is
case-insensitive.  Words are enclosed by word delimiters (i.e. they must
match whole words, not parts of a word) if
`org-agenda-search-view-force-full-words' is set (default is nil).

Boolean search snippets enclosed by curly braces are interpreted as
regular expressions that must or (when preceded with \"-\") must not
match in the entry.  Snippets enclosed into double quotes will be taken
as a whole, to include whitespace.

- If the search string starts with an asterisk, search only in headlines.
- If (possibly after the leading star) the search string starts with an
  exclamation mark, this also means to look at TODO entries only, an effect
  that can also be achieved with a prefix argument.
- If (possibly after star and exclamation mark) the search string starts
  with a colon, this will mean that the (non-regexp) snippets of the
  Boolean search must match as full words.

This command searches the agenda files, and in addition the files listed
in `org-agenda-text-search-extra-files'.

\(fn &optional TODO-ONLY STRING EDIT-AT)" t nil)

(autoload 'org-todo-list "org-mode/lisp/org-agenda" "\
Show all (not done) TODO entries from all agenda file in a single list.
The prefix arg can be used to select a specific TODO keyword and limit
the list to these.  When using \\[universal-argument], you will be prompted
for a keyword.  A numeric prefix directly selects the Nth keyword in
`org-todo-keywords-1'.

\(fn &optional ARG)" t nil)

(autoload 'org-tags-view "org-mode/lisp/org-agenda" "\
Show all headlines for all `org-agenda-files' matching a TAGS criterion.
The prefix arg TODO-ONLY limits the search to TODO entries.

\(fn &optional TODO-ONLY MATCH)" t nil)

(autoload 'org-agenda-list-stuck-projects "org-mode/lisp/org-agenda" "\
Create agenda view for projects that are stuck.
Stuck projects are project that have no next actions.  For the definitions
of what a project is and how to check if it stuck, customize the variable
`org-stuck-projects'.

\(fn &rest IGNORE)" t nil)

(autoload 'org-diary "org-mode/lisp/org-agenda" "\
Return diary information from org files.
This function can be used in a \"sexp\" diary entry in the Emacs calendar.
It accesses org files and extracts information from those files to be
listed in the diary.  The function accepts arguments specifying what
items should be listed.  For a list of arguments allowed here, see the
variable `org-agenda-entry-types'.

The call in the diary file should look like this:

   &%%(org-diary) ~/path/to/some/orgfile.org

Use a separate line for each org file to check.  Or, if you omit the file name,
all files listed in `org-agenda-files' will be checked automatically:

   &%%(org-diary)

If you don't give any arguments (as in the example above), the default value
of `org-agenda-entry-types' is used: (:deadline :scheduled :timestamp :sexp).
So the example above may also be written as

   &%%(org-diary :deadline :timestamp :sexp :scheduled)

The function expects the lisp variables `entry' and `date' to be provided
by the caller, because this is how the calendar works.  Don't use this
function from a program - use `org-agenda-get-day-entries' instead.

\(fn &rest ARGS)" nil nil)

(autoload 'org-agenda-check-for-timestamp-as-reason-to-ignore-todo-item "org-mode/lisp/org-agenda" "\
Do we have a reason to ignore this TODO entry because it has a time stamp?

\(fn &optional END)" nil nil)

(autoload 'org-agenda-set-restriction-lock "org-mode/lisp/org-agenda" "\
Set restriction lock for agenda, to current subtree or file.
Restriction will be the file if TYPE is `file', or if type is the
universal prefix '(4), or if the cursor is before the first headline
in the file.  Otherwise, restriction will be to the current subtree.

\(fn &optional TYPE)" t nil)

(autoload 'org-calendar-goto-agenda "org-mode/lisp/org-agenda" "\
Compute the Org-mode agenda for the calendar date displayed at the cursor.
This is a command that has to be installed in `calendar-mode-map'.

\(fn)" t nil)

(autoload 'org-agenda-to-appt "org-mode/lisp/org-agenda" "\
Activate appointments found in `org-agenda-files'.
With a \\[universal-argument] prefix, refresh the list of
appointments.

If FILTER is t, interactively prompt the user for a regular
expression, and filter out entries that don't match it.

If FILTER is a string, use this string as a regular expression
for filtering entries out.

If FILTER is a function, filter out entries against which
calling the function returns nil.  This function takes one
argument: an entry from `org-agenda-get-day-entries'.

FILTER can also be an alist with the car of each cell being
either 'headline or 'category.  For example:

  '((headline \"IMPORTANT\")
    (category \"Work\"))

will only add headlines containing IMPORTANT or headlines
belonging to the \"Work\" category.

ARGS are symbols indicating what kind of entries to consider.
By default `org-agenda-to-appt' will use :deadline*, :scheduled*
\(i.e., deadlines and scheduled items with a hh:mm specification)
and :timestamp entries.  See the docstring of `org-diary' for
details and examples.

If an entry has a APPT_WARNTIME property, its value will be used
to override `appt-message-warning-time'.

\(fn &optional REFRESH FILTER &rest ARGS)" t nil)

;;;***

;;;### (autoloads nil "org-mode/lisp/org-capture" "org-mode/lisp/org-capture.el"
;;;;;;  (21591 21489 0 0))
;;; Generated autoloads from org-mode/lisp/org-capture.el

(autoload 'org-capture-string "org-mode/lisp/org-capture" "\
Capture STRING with the template selected by KEYS.

\(fn STRING &optional KEYS)" t nil)

(autoload 'org-capture "org-mode/lisp/org-capture" "\
Capture something.
\\<org-capture-mode-map>
This will let you select a template from `org-capture-templates', and then
file the newly captured information.  The text is immediately inserted
at the target location, and an indirect buffer is shown where you can
edit it.  Pressing \\[org-capture-finalize] brings you back to the previous state
of Emacs, so that you can continue your work.

When called interactively with a \\[universal-argument] prefix argument GOTO, don't capture
anything, just go to the file/headline where the selected template
stores its notes.  With a double prefix argument \\[universal-argument] \\[universal-argument], go to the last note
stored.

When called with a `C-0' (zero) prefix, insert a template at point.

ELisp programs can set KEYS to a string associated with a template
in `org-capture-templates'.  In this case, interactive selection
will be bypassed.

If `org-capture-use-agenda-date' is non-nil, capturing from the
agenda will use the date at point as the default date.  Then, a
`C-1' prefix will tell the capture process to use the HH:MM time
of the day at point (if any) or the current HH:MM time.

\(fn &optional GOTO KEYS)" t nil)

(autoload 'org-capture-import-remember-templates "org-mode/lisp/org-capture" "\
Set `org-capture-templates' to be similar to `org-remember-templates'.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "org-mode/lisp/org-colview" "org-mode/lisp/org-colview.el"
;;;;;;  (21273 39858 0 0))
;;; Generated autoloads from org-mode/lisp/org-colview.el

(autoload 'org-columns-remove-overlays "org-mode/lisp/org-colview" "\
Remove all currently active column overlays.

\(fn)" t nil)

(autoload 'org-columns-get-format-and-top-level "org-mode/lisp/org-colview" "\


\(fn)" nil nil)

(autoload 'org-columns "org-mode/lisp/org-colview" "\
Turn on column view on an org-mode file.
When COLUMNS-FMT-STRING is non-nil, use it as the column format.

\(fn &optional COLUMNS-FMT-STRING)" t nil)

(autoload 'org-columns-compute "org-mode/lisp/org-colview" "\
Sum the values of property PROPERTY hierarchically, for the entire buffer.

\(fn PROPERTY)" t nil)

(autoload 'org-columns-number-to-string "org-mode/lisp/org-colview" "\
Convert a computed column number to a string value, according to FMT.

\(fn N FMT &optional PRINTF)" nil nil)

(autoload 'org-dblock-write:columnview "org-mode/lisp/org-colview" "\
Write the column view table.
PARAMS is a property list of parameters:

:width    enforce same column widths with <N> specifiers.
:id       the :ID: property of the entry where the columns view
	  should be built.  When the symbol `local', call locally.
	  When `global' call column view with the cursor at the beginning
	  of the buffer (usually this means that the whole buffer switches
	  to column view).  When \"file:path/to/file.org\", invoke column
	  view at the start of that file.  Otherwise, the ID is located
	  using `org-id-find'.
:hlines   When t, insert a hline before each item.  When a number, insert
	  a hline before each level <= that number.
:vlines   When t, make each column a colgroup to enforce vertical lines.
:maxlevel When set to a number, don't capture headlines below this level.
:skip-empty-rows
	  When t, skip rows where all specifiers other than ITEM are empty.
:format   When non-nil, specify the column view format to use.

\(fn PARAMS)" nil nil)

(autoload 'org-insert-columns-dblock "org-mode/lisp/org-colview" "\
Create a dynamic block capturing a column view table.

\(fn)" t nil)

(autoload 'org-agenda-columns "org-mode/lisp/org-colview" "\
Turn on or update column view in the agenda.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "org-mode/lisp/org-compat" "org-mode/lisp/org-compat.el"
;;;;;;  (21591 21489 0 0))
;;; Generated autoloads from org-mode/lisp/org-compat.el

(autoload 'org-check-version "org-mode/lisp/org-compat" "\
Try very hard to provide sensible version strings.

\(fn)" nil t)

;;;***

;;;### (autoloads nil "org-mode/lisp/org-macs" "org-mode/lisp/org-macs.el"
;;;;;;  (21591 21489 0 0))
;;; Generated autoloads from org-mode/lisp/org-macs.el

(autoload 'org-load-noerror-mustsuffix "org-mode/lisp/org-macs" "\
Load FILE with optional arguments NOERROR and MUSTSUFFIX.  Drop the MUSTSUFFIX argument for XEmacs, which doesn't recognize it.

\(fn FILE)" nil t)

;;;***

;;;### (autoloads nil "org-mode/lisp/org-version" "org-mode/lisp/org-version.el"
;;;;;;  (21704 62843 0 0))
;;; Generated autoloads from org-mode/lisp/org-version.el

(autoload 'org-release "org-mode/lisp/org-version" "\
The release version of org-mode.
  Inserted by installing org-mode or when a release is made.

\(fn)" nil nil)

(autoload 'org-git-version "org-mode/lisp/org-version" "\
The Git version of org-mode.
  Inserted by installing org-mode or when a release is made.

\(fn)" nil nil)

(defvar org-odt-data-dir "/usr/share/emacs/etc/org" "\
The location of ODT styles.")

;;;***

;;;### (autoloads nil "ox-jira/ox-jira" "ox-jira/ox-jira.el" (0 0
;;;;;;  0 0))
;;; Generated autoloads from ox-jira/ox-jira.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "ox-jira/ox-jira" '("ox-jira-")))

;;;***

;;;### (autoloads nil "ox-pandoc/ox-pandoc" "ox-pandoc/ox-pandoc.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ox-pandoc/ox-pandoc.el

(autoload 'org-pandoc-export-to-asciidoc "ox-pandoc/ox-pandoc" "\
Export to asciidoc.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-asciidoc-and-open "ox-pandoc/ox-pandoc" "\
Export to asciidoc and open.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-as-asciidoc "ox-pandoc/ox-pandoc" "\
Export as asciidoc.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-beamer "ox-pandoc/ox-pandoc" "\
Export to beamer.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-beamer-and-open "ox-pandoc/ox-pandoc" "\
Export to beamer and open.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-as-beamer "ox-pandoc/ox-pandoc" "\
Export as beamer.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-beamer-pdf "ox-pandoc/ox-pandoc" "\
Export to beamer-pdf.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-beamer-pdf-and-open "ox-pandoc/ox-pandoc" "\
Export to beamer-pdf and open.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-commonmark "ox-pandoc/ox-pandoc" "\
Export to commonmark.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-commonmark-and-open "ox-pandoc/ox-pandoc" "\
Export to commonmark and open.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-as-commonmark "ox-pandoc/ox-pandoc" "\
Export as commonmark.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-context "ox-pandoc/ox-pandoc" "\
Export to context.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-context-and-open "ox-pandoc/ox-pandoc" "\
Export to context and open.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-as-context "ox-pandoc/ox-pandoc" "\
Export as context.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-context-pdf "ox-pandoc/ox-pandoc" "\
Export to context-pdf.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-context-pdf-and-open "ox-pandoc/ox-pandoc" "\
Export to context-pdf and open.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-docbook4 "ox-pandoc/ox-pandoc" "\
Export to docbook4.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-docbook4-and-open "ox-pandoc/ox-pandoc" "\
Export to docbook4 and open.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-as-docbook4 "ox-pandoc/ox-pandoc" "\
Export as docbook4.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-docbook5 "ox-pandoc/ox-pandoc" "\
Export to docbook5.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-docbook5-and-open "ox-pandoc/ox-pandoc" "\
Export to docbook5 and open.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-as-docbook5 "ox-pandoc/ox-pandoc" "\
Export as docbook5.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-docx "ox-pandoc/ox-pandoc" "\
Export to docx.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-docx-and-open "ox-pandoc/ox-pandoc" "\
Export to docx and open.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-dokuwiki "ox-pandoc/ox-pandoc" "\
Export to dokuwiki.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-dokuwiki-and-open "ox-pandoc/ox-pandoc" "\
Export to dokuwiki and open.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-as-dokuwiki "ox-pandoc/ox-pandoc" "\
Export as dokuwiki.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-dzslides "ox-pandoc/ox-pandoc" "\
Export to dzslides.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-dzslides-and-open "ox-pandoc/ox-pandoc" "\
Export to dzslides and open.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-as-dzslides "ox-pandoc/ox-pandoc" "\
Export as dzslides.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-epub2 "ox-pandoc/ox-pandoc" "\
Export to epub2.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-epub2-and-open "ox-pandoc/ox-pandoc" "\
Export to epub2 and open.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-epub3 "ox-pandoc/ox-pandoc" "\
Export to epub3.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-epub3-and-open "ox-pandoc/ox-pandoc" "\
Export to epub3 and open.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-fb2 "ox-pandoc/ox-pandoc" "\
Export to fb2.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-fb2-and-open "ox-pandoc/ox-pandoc" "\
Export to fb2 and open.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-as-fb2 "ox-pandoc/ox-pandoc" "\
Export as fb2.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-gfm "ox-pandoc/ox-pandoc" "\
Export to gfm.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-gfm-and-open "ox-pandoc/ox-pandoc" "\
Export to gfm and open.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-as-gfm "ox-pandoc/ox-pandoc" "\
Export as gfm.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-haddock "ox-pandoc/ox-pandoc" "\
Export to haddock.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-haddock-and-open "ox-pandoc/ox-pandoc" "\
Export to haddock and open.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-as-haddock "ox-pandoc/ox-pandoc" "\
Export as haddock.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-html4 "ox-pandoc/ox-pandoc" "\
Export to html4.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-html4-and-open "ox-pandoc/ox-pandoc" "\
Export to html4 and open.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-as-html4 "ox-pandoc/ox-pandoc" "\
Export as html4.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-html5 "ox-pandoc/ox-pandoc" "\
Export to html5.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-html5-and-open "ox-pandoc/ox-pandoc" "\
Export to html5 and open.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-as-html5 "ox-pandoc/ox-pandoc" "\
Export as html5.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-html5-pdf "ox-pandoc/ox-pandoc" "\
Export to html5-pdf.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-html5-pdf-and-open "ox-pandoc/ox-pandoc" "\
Export to html5-pdf and open.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-icml "ox-pandoc/ox-pandoc" "\
Export to icml.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-icml-and-open "ox-pandoc/ox-pandoc" "\
Export to icml and open.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-as-icml "ox-pandoc/ox-pandoc" "\
Export as icml.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-jats "ox-pandoc/ox-pandoc" "\
Export to jats.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-jats-and-open "ox-pandoc/ox-pandoc" "\
Export to jats and open.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-as-jats "ox-pandoc/ox-pandoc" "\
Export as jats.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-json "ox-pandoc/ox-pandoc" "\
Export to json.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-json-and-open "ox-pandoc/ox-pandoc" "\
Export to json and open.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-as-json "ox-pandoc/ox-pandoc" "\
Export as json.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-latex "ox-pandoc/ox-pandoc" "\
Export to latex.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-latex-and-open "ox-pandoc/ox-pandoc" "\
Export to latex and open.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-as-latex "ox-pandoc/ox-pandoc" "\
Export as latex.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-latex-pdf "ox-pandoc/ox-pandoc" "\
Export to latex-pdf.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-latex-pdf-and-open "ox-pandoc/ox-pandoc" "\
Export to latex-pdf and open.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-man "ox-pandoc/ox-pandoc" "\
Export to man.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-man-and-open "ox-pandoc/ox-pandoc" "\
Export to man and open.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-as-man "ox-pandoc/ox-pandoc" "\
Export as man.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-markdown "ox-pandoc/ox-pandoc" "\
Export to markdown.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-markdown-and-open "ox-pandoc/ox-pandoc" "\
Export to markdown and open.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-as-markdown "ox-pandoc/ox-pandoc" "\
Export as markdown.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-markdown_mmd "ox-pandoc/ox-pandoc" "\
Export to markdown_mmd.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-markdown_mmd-and-open "ox-pandoc/ox-pandoc" "\
Export to markdown_mmd and open.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-as-markdown_mmd "ox-pandoc/ox-pandoc" "\
Export as markdown_mmd.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-markdown_phpextra "ox-pandoc/ox-pandoc" "\
Export to markdown_phpextra.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-markdown_phpextra-and-open "ox-pandoc/ox-pandoc" "\
Export to markdown_phpextra and open.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-as-markdown_phpextra "ox-pandoc/ox-pandoc" "\
Export as markdown_phpextra.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-markdown_strict "ox-pandoc/ox-pandoc" "\
Export to markdown_strict.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-markdown_strict-and-open "ox-pandoc/ox-pandoc" "\
Export to markdown_strict and open.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-as-markdown_strict "ox-pandoc/ox-pandoc" "\
Export as markdown_strict.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-mediawiki "ox-pandoc/ox-pandoc" "\
Export to mediawiki.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-mediawiki-and-open "ox-pandoc/ox-pandoc" "\
Export to mediawiki and open.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-as-mediawiki "ox-pandoc/ox-pandoc" "\
Export as mediawiki.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-ms "ox-pandoc/ox-pandoc" "\
Export to ms.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-ms-and-open "ox-pandoc/ox-pandoc" "\
Export to ms and open.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-as-ms "ox-pandoc/ox-pandoc" "\
Export as ms.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-ms-pdf "ox-pandoc/ox-pandoc" "\
Export to ms-pdf.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-ms-pdf-and-open "ox-pandoc/ox-pandoc" "\
Export to ms-pdf and open.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-muse "ox-pandoc/ox-pandoc" "\
Export to muse.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-muse-and-open "ox-pandoc/ox-pandoc" "\
Export to muse and open.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-as-muse "ox-pandoc/ox-pandoc" "\
Export as muse.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-native "ox-pandoc/ox-pandoc" "\
Export to native.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-native-and-open "ox-pandoc/ox-pandoc" "\
Export to native and open.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-as-native "ox-pandoc/ox-pandoc" "\
Export as native.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-odt "ox-pandoc/ox-pandoc" "\
Export to odt.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-odt-and-open "ox-pandoc/ox-pandoc" "\
Export to odt and open.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-opendocument "ox-pandoc/ox-pandoc" "\
Export to opendocument.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-opendocument-and-open "ox-pandoc/ox-pandoc" "\
Export to opendocument and open.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-as-opendocument "ox-pandoc/ox-pandoc" "\
Export as opendocument.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-opml "ox-pandoc/ox-pandoc" "\
Export to opml.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-opml-and-open "ox-pandoc/ox-pandoc" "\
Export to opml and open.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-as-opml "ox-pandoc/ox-pandoc" "\
Export as opml.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-org "ox-pandoc/ox-pandoc" "\
Export to org.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-org-and-open "ox-pandoc/ox-pandoc" "\
Export to org and open.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-as-org "ox-pandoc/ox-pandoc" "\
Export as org.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-plain "ox-pandoc/ox-pandoc" "\
Export to plain.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-plain-and-open "ox-pandoc/ox-pandoc" "\
Export to plain and open.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-as-plain "ox-pandoc/ox-pandoc" "\
Export as plain.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-pptx "ox-pandoc/ox-pandoc" "\
Export to pptx.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-pptx-and-open "ox-pandoc/ox-pandoc" "\
Export to pptx and open.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-revealjs "ox-pandoc/ox-pandoc" "\
Export to revealjs.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-revealjs-and-open "ox-pandoc/ox-pandoc" "\
Export to revealjs and open.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-as-revealjs "ox-pandoc/ox-pandoc" "\
Export as revealjs.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-rst "ox-pandoc/ox-pandoc" "\
Export to rst.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-rst-and-open "ox-pandoc/ox-pandoc" "\
Export to rst and open.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-as-rst "ox-pandoc/ox-pandoc" "\
Export as rst.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-rtf "ox-pandoc/ox-pandoc" "\
Export to rtf.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-rtf-and-open "ox-pandoc/ox-pandoc" "\
Export to rtf and open.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-as-rtf "ox-pandoc/ox-pandoc" "\
Export as rtf.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-s5 "ox-pandoc/ox-pandoc" "\
Export to s5.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-s5-and-open "ox-pandoc/ox-pandoc" "\
Export to s5 and open.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-as-s5 "ox-pandoc/ox-pandoc" "\
Export as s5.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-slideous "ox-pandoc/ox-pandoc" "\
Export to slideous.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-slideous-and-open "ox-pandoc/ox-pandoc" "\
Export to slideous and open.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-as-slideous "ox-pandoc/ox-pandoc" "\
Export as slideous.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-slidy "ox-pandoc/ox-pandoc" "\
Export to slidy.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-slidy-and-open "ox-pandoc/ox-pandoc" "\
Export to slidy and open.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-as-slidy "ox-pandoc/ox-pandoc" "\
Export as slidy.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-tei "ox-pandoc/ox-pandoc" "\
Export to tei.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-tei-and-open "ox-pandoc/ox-pandoc" "\
Export to tei and open.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-as-tei "ox-pandoc/ox-pandoc" "\
Export as tei.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-texinfo "ox-pandoc/ox-pandoc" "\
Export to texinfo.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-texinfo-and-open "ox-pandoc/ox-pandoc" "\
Export to texinfo and open.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-as-texinfo "ox-pandoc/ox-pandoc" "\
Export as texinfo.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-textile "ox-pandoc/ox-pandoc" "\
Export to textile.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-textile-and-open "ox-pandoc/ox-pandoc" "\
Export to textile and open.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-as-textile "ox-pandoc/ox-pandoc" "\
Export as textile.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-zimwiki "ox-pandoc/ox-pandoc" "\
Export to zimwiki.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-to-zimwiki-and-open "ox-pandoc/ox-pandoc" "\
Export to zimwiki and open.

\(fn &optional A S V B E)" t nil)

(autoload 'org-pandoc-export-as-zimwiki "ox-pandoc/ox-pandoc" "\
Export as zimwiki.

\(fn &optional A S V B E)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "ox-pandoc/ox-pandoc" '("org-pandoc-")))

;;;***

;;;### (autoloads nil "php-mode-improved/php-mode-improved" "php-mode-improved/php-mode-improved.el"
;;;;;;  (21530 56992 0 0))
;;; Generated autoloads from php-mode-improved/php-mode-improved.el

(defvar php-mode-to-use (progn (require 'mumamo nil t) (if (fboundp 'nxhtml-mumamo-turn-on) 'nxhtml-mumamo-turn-on (if (fboundp 'html-mumamo-turn-on) 'html-mumamo-turn-on 'php-mode))) "\
Major mode turn on function to use for php files.")

(custom-autoload 'php-mode-to-use "php-mode-improved/php-mode-improved" t)

(defvar php-file-patterns '("\\.php[s34]?\\'" "\\.phtml\\'" "\\.inc\\'") "\
List of file patterns for which to automatically invoke `php-mode'.")

(custom-autoload 'php-file-patterns "php-mode-improved/php-mode-improved" nil)

(autoload 'php-mode "php-mode-improved/php-mode-improved" "\
Major mode for editing PHP code.

\\{php-mode-map}

\(fn)" t nil)

;;;***

;;;### (autoloads nil "pkg-info/pkg-info" "pkg-info/pkg-info.el"
;;;;;;  (22061 64698 0 0))
;;; Generated autoloads from pkg-info/pkg-info.el

(autoload 'pkg-info-library-original-version "pkg-info/pkg-info" "\
Get the original version in the header of LIBRARY.

The original version is stored in the X-Original-Version header.
This header is added by the MELPA package archive to preserve
upstream version numbers.

LIBRARY is either a symbol denoting a named feature, or a library
name as string.

If SHOW is non-nil, show the version in the minibuffer.

Return the version from the header of LIBRARY as list.  Signal an
error if the LIBRARY was not found or had no X-Original-Version
header.

See Info node `(elisp)Library Headers' for more information
about library headers.

\(fn LIBRARY &optional SHOW)" t nil)

(autoload 'pkg-info-library-version "pkg-info/pkg-info" "\
Get the version in the header of LIBRARY.

LIBRARY is either a symbol denoting a named feature, or a library
name as string.

If SHOW is non-nil, show the version in the minibuffer.

Return the version from the header of LIBRARY as list.  Signal an
error if the LIBRARY was not found or had no proper header.

See Info node `(elisp)Library Headers' for more information
about library headers.

\(fn LIBRARY &optional SHOW)" t nil)

(autoload 'pkg-info-defining-library-original-version "pkg-info/pkg-info" "\
Get the original version of the library defining FUNCTION.

The original version is stored in the X-Original-Version header.
This header is added by the MELPA package archive to preserve
upstream version numbers.

If SHOW is non-nil, show the version in mini-buffer.

This function is mainly intended to find the version of a major
or minor mode, i.e.

   (pkg-info-defining-library-version 'flycheck-mode)

Return the version of the library defining FUNCTION.  Signal an
error if FUNCTION is not a valid function, if its defining
library was not found, or if the library had no proper version
header.

\(fn FUNCTION &optional SHOW)" t nil)

(autoload 'pkg-info-defining-library-version "pkg-info/pkg-info" "\
Get the version of the library defining FUNCTION.

If SHOW is non-nil, show the version in mini-buffer.

This function is mainly intended to find the version of a major
or minor mode, i.e.

   (pkg-info-defining-library-version 'flycheck-mode)

Return the version of the library defining FUNCTION.  Signal an
error if FUNCTION is not a valid function, if its defining
library was not found, or if the library had no proper version
header.

\(fn FUNCTION &optional SHOW)" t nil)

(autoload 'pkg-info-package-version "pkg-info/pkg-info" "\
Get the version of an installed PACKAGE.

If SHOW is non-nil, show the version in the minibuffer.

Return the version as list, or nil if PACKAGE is not installed.

\(fn PACKAGE &optional SHOW)" t nil)

(autoload 'pkg-info-version-info "pkg-info/pkg-info" "\
Obtain complete version info for LIBRARY and PACKAGE.

LIBRARY is a symbol denoting a named feature, or a library name
as string.  PACKAGE is a symbol denoting an ELPA package.  If
omitted or nil, default to LIBRARY.

If SHOW is non-nil, show the version in the minibuffer.

When called interactively, prompt for LIBRARY.  When called
interactively with prefix argument, prompt for PACKAGE as well.

Return a string with complete version information for LIBRARY.
This version information contains the version from the headers of
LIBRARY, and the version of the installed PACKAGE, the LIBRARY is
part of.  If PACKAGE is not installed, or if the PACKAGE version
is the same as the LIBRARY version, do not include a package
version.

\(fn LIBRARY &optional PACKAGE SHOW)" t nil)

;;;***

;;;### (autoloads nil "popup/popup" "popup/popup.el" (0 0 0 0))
;;; Generated autoloads from popup/popup.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "popup/popup" '("popup-")))

;;;***

;;;### (autoloads nil "popwin/popwin" "popwin/popwin.el" (21523 1278
;;;;;;  0 0))
;;; Generated autoloads from popwin/popwin.el

(autoload 'popwin:popup-buffer "popwin/popwin" "\
Show BUFFER in a popup window and return the popup window. If
NOSELECT is non-nil, the popup window will not be selected. If
STICK is non-nil, the popup window will be stuck. If TAIL is
non-nil, the popup window will show the last contents. Calling
`popwin:popup-buffer' during `popwin:popup-buffer' is allowed. In
that case, the buffer of the popup window will be replaced with
BUFFER.

\(fn BUFFER &key (width popwin:popup-window-width) (height popwin:popup-window-height) (position popwin:popup-window-position) NOSELECT DEDICATED STICK TAIL)" t nil)

(autoload 'popwin:display-buffer "popwin/popwin" "\
Display BUFFER-OR-NAME, if possible, in a popup window, or as
usual. This function can be used as a value of
`display-buffer-function'.

\(fn BUFFER-OR-NAME &optional NOT-THIS-WINDOW)" t nil)

(autoload 'popwin:pop-to-buffer "popwin/popwin" "\
Same as `pop-to-buffer' except that this function will use
`popwin:display-buffer-1' instead of `display-buffer'.

\(fn BUFFER &optional OTHER-WINDOW NORECORD)" t nil)

(autoload 'popwin:universal-display "popwin/popwin" "\
Call the following command interactively with letting
`popwin:special-display-config' be
`popwin:universal-display-config'. This wil be useful when
displaying buffers in popup windows temporarily.

\(fn)" t nil)

(autoload 'popwin:one-window "popwin/popwin" "\
Delete other window than the popup window. C-g restores the
original window configuration.

\(fn)" t nil)

(autoload 'popwin:popup-buffer-tail "popwin/popwin" "\
Same as `popwin:popup-buffer' except that the buffer will be
`recenter'ed at the bottom.

\(fn &rest SAME-AS-POPWIN:POPUP-BUFFER)" t nil)

(autoload 'popwin:find-file "popwin/popwin" "\
Edit file FILENAME with popup window by `popwin:popup-buffer'.

\(fn FILENAME &optional WILDCARDS)" t nil)

(autoload 'popwin:find-file-tail "popwin/popwin" "\
Edit file FILENAME with popup window by
`popwin:popup-buffer-tail'.

\(fn FILE &optional WILDCARD)" t nil)

(autoload 'popwin:messages "popwin/popwin" "\
Display *Messages* buffer in a popup window.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "rainbow-delimiters/rainbow-delimiters" "rainbow-delimiters/rainbow-delimiters.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from rainbow-delimiters/rainbow-delimiters.el

(autoload 'rainbow-delimiters-mode "rainbow-delimiters/rainbow-delimiters" "\
Highlight nested parentheses, brackets, and braces according to their depth.

\(fn &optional ARG)" t nil)

(autoload 'rainbow-delimiters-mode-enable "rainbow-delimiters/rainbow-delimiters" "\
Enable `rainbow-delimiters-mode'.

\(fn)" nil nil)

(autoload 'rainbow-delimiters-mode-disable "rainbow-delimiters/rainbow-delimiters" "\
Disable `rainbow-delimiters-mode'.

\(fn)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "rainbow-delimiters/rainbow-delimiters" '("rainbow-delimiters-")))

;;;***

;;;### (autoloads nil "rainbow-delimiters/rainbow-delimiters-test"
;;;;;;  "rainbow-delimiters/rainbow-delimiters-test.el" (0 0 0 0))
;;; Generated autoloads from rainbow-delimiters/rainbow-delimiters-test.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "rainbow-delimiters/rainbow-delimiters-test" '("highlights-matching-" "should-do-nothing" "fontify-" "with-")))

;;;***

;;;### (autoloads nil "restclient/restclient" "restclient/restclient.el"
;;;;;;  (21280 24561 0 0))
;;; Generated autoloads from restclient/restclient.el

(autoload 'restclient-http-send-current "restclient/restclient" "\


\(fn &optional RAW)" t nil)

(autoload 'restclient-http-send-current-raw "restclient/restclient" "\


\(fn)" t nil)

(autoload 'restclient-mode "restclient/restclient" "\


\(fn)" t nil)

;;;***

;;;### (autoloads nil "rtags/src/ac-rtags" "rtags/src/ac-rtags.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from rtags/src/ac-rtags.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "rtags/src/ac-rtags" '("ac-rtags-" "rtags-location-regx")))

;;;***

;;;### (autoloads nil "rtags/src/company-rtags" "rtags/src/company-rtags.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from rtags/src/company-rtags.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "rtags/src/company-rtags" '("company-rtags")))

;;;***

;;;### (autoloads nil "rtags/src/flycheck-rtags" "rtags/src/flycheck-rtags.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from rtags/src/flycheck-rtags.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "rtags/src/flycheck-rtags" '("flycheck-rtags-")))

;;;***

;;;### (autoloads nil "rtags/src/helm-rtags" "rtags/src/helm-rtags.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from rtags/src/helm-rtags.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "rtags/src/helm-rtags" '("create-helm-rtags-source" "helm-rtags-")))

;;;***

;;;### (autoloads nil "rtags/src/ivy-rtags" "rtags/src/ivy-rtags.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from rtags/src/ivy-rtags.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "rtags/src/ivy-rtags" '("ivy-rtags-")))

;;;***

;;;### (autoloads nil "rtags/src/rtags" "rtags/src/rtags.el" (0 0
;;;;;;  0 0))
;;; Generated autoloads from rtags/src/rtags.el

(autoload 'rtags-set-periodic-reparse-timeout "rtags/src/rtags" "\
Set `rtags-periodic-reparse-timeout' to TIME.

\(fn TIME)" t nil)

(autoload 'rtags-call-bury-or-delete "rtags/src/rtags" "\
Call `rtags-bury-buffer-function' function.

\(fn)" t nil)

(autoload 'rtags-next-match "rtags/src/rtags" "\


\(fn)" t nil)

(autoload 'rtags-previous-match "rtags/src/rtags" "\


\(fn)" t nil)

(autoload 'rtags-next-diag "rtags/src/rtags" "\


\(fn)" t nil)

(autoload 'rtags-previous-diag "rtags/src/rtags" "\


\(fn)" t nil)

(autoload 'rtags-preprocess-file "rtags/src/rtags" "\
Preprocess selected region or buffer.
If optional BUFFER is given, use BUFFER instead of `current-buffer'.
It uses the stored compile command from the RTags database for preprocessing.

\(fn &optional BUFFER)" t nil)

(autoload 'rtags-asm-file "rtags/src/rtags" "\
Assemble buffer.
If optional BUFFER is given, use BUFFER instead of `current-buffer'.
It uses the stored compile command from the RTags database for assembling.

\(fn &optional BUFFER)" t nil)

(autoload 'rtags-set-current-project "rtags/src/rtags" "\
Set active project.
Uses `completing-read' to ask for the project.

\(fn)" t nil)

(autoload 'rtags-print-symbol-info "rtags/src/rtags" "\
Print information about the symbol under cursor.

\(fn &optional VERBOSE)" t nil)

(autoload 'rtags-symbol-type "rtags/src/rtags" "\
Print symbol type under cursor.

\(fn)" t nil)

(autoload 'rtags-print-dependencies "rtags/src/rtags" "\
Print dependency information of the file in buffer.

If optional PREFIX is given, a selection of what type of dependency
information should be shown will be offered. Currently only one can
be chosen.
\"includes\"        - Print includes the file in buffer includes.
\"included-by\"     - Print files which include the file in buffer.
\"depends-on\"      - Print files the file in buffer depends on.
\"depended-on\"     - ...
\"tree-depends-on\" - ...

If optional BUFFER is given print dependencies for file in BUFFER
instead of file from `current-buffer'.

\(fn &optional PREFIX BUFFER)" t nil)

(defvar rtags-dependency-tree-data nil)

(autoload 'rtags-references-tree "rtags/src/rtags" "\


\(fn)" t nil)

(autoload 'rtags-find-functions-called-by-this-function "rtags/src/rtags" "\


\(fn)" t nil)

(autoload 'rtags-find-all-functions-called-this-function "rtags/src/rtags" "\


\(fn)" nil nil)

(autoload 'rtags-list-results "rtags/src/rtags" "\
Show the RTags results buffer.

\(fn)" t nil)

(autoload 'rtags-print-source-arguments "rtags/src/rtags" "\


\(fn &optional BUFFER)" t nil)

(autoload 'rtags-print-class-hierarchy "rtags/src/rtags" "\


\(fn)" t nil)

(autoload 'rtags-print-enum-value-at-point "rtags/src/rtags" "\


\(fn &optional LOCATION)" t nil)

(autoload 'rtags-goto-offset "rtags/src/rtags" "\


\(fn POS)" t nil)

(autoload 'rtags-location-stack-filter "rtags/src/rtags" "\


\(fn PATH/LAMBDA/RX)" t nil)

(autoload 'rtags-location-stack-jump "rtags/src/rtags" "\


\(fn BY)" t nil)

(autoload 'rtags-location-stack-visualize-update "rtags/src/rtags" "\


\(fn)" nil nil)

(autoload 'rtags-enable-standard-keybindings "rtags/src/rtags" "\
Setup standard keybindings for the RTags commands.

If optional MAP is non-nil, add the keys to MAP instead of `c-mode-base-map'.
If optional PREFIX is non-nil, use PREFIX as prefix key for the commands,
default is \"C-c r \". It doesn't matter whether you add a space at the end
of PREFIX or not, if doesn't contain one, one will be added.

\(fn &optional MAP PREFIX)" t nil)

(autoload 'rtags-print-current-location "rtags/src/rtags" "\


\(fn)" t nil)

(autoload 'rtags-location-stack-forward "rtags/src/rtags" "\


\(fn)" t nil)

(autoload 'rtags-location-stack-back "rtags/src/rtags" "\


\(fn)" t nil)

(autoload 'rtags-location-stack-reset "rtags/src/rtags" "\


\(fn)" t nil)

(autoload 'rtags-find-symbol-at-point "rtags/src/rtags" "\
Find the natural target for the symbol under the cursor and moves to that location.
For references this means to jump to the definition/declaration of the referenced symbol (it jumps to the definition if it is indexed).
For definitions it jumps to the declaration (if there is only one) For declarations it jumps to the definition.
If called with prefix, open first match in other window

\(fn &optional PREFIX)" t nil)

(autoload 'rtags-find-references-at-point "rtags/src/rtags" "\
Find all references to the symbol under the cursor.

If there's exactly one result jump directly to it, and if optional
PREFIX is given jump to it in other window. If there's more show a
buffer with the different alternatives and jump to the first one, if
`rtags-jump-to-first-match' is true. References to references will be
treated as references to the referenced symbol.

\(fn &optional PREFIX)" t nil)

(autoload 'rtags-find-virtuals-at-point "rtags/src/rtags" "\
List all reimplementations of function under cursor.
This includes both declarations and definitions.

\(fn &optional PREFIX)" t nil)

(autoload 'rtags-find-all-references-at-point "rtags/src/rtags" "\


\(fn &optional PREFIX)" t nil)

(autoload 'rtags-guess-function-at-point "rtags/src/rtags" "\


\(fn)" t nil)

(autoload 'rtags-rename-symbol "rtags/src/rtags" "\
Rename symbol (identifier) at point.

Normally this function will ask the user (via minibuffer) for the
replacement and then ask for confirmation.  However, when the scope
of the symbol at point is just one file (the file that's being
visited by current buffer), the variable `rtags-use-multiple-cursors'
is non-nil and the `multiple-cursors' package is available, then this
function will create fake cursors at all occurrences of the symbol.

The optional argument NO-CONFIRM means agree to all replacements and
can be specified with a prefix argument.

\(fn &optional NO-CONFIRM)" t nil)

(autoload 'rtags-find-symbol "rtags/src/rtags" "\


\(fn &optional PREFIX)" t nil)

(autoload 'rtags-find-references "rtags/src/rtags" "\


\(fn &optional PREFIX)" t nil)

(autoload 'rtags-find-symbol-current-file "rtags/src/rtags" "\


\(fn)" t nil)

(autoload 'rtags-find-references-current-file "rtags/src/rtags" "\


\(fn)" t nil)

(autoload 'rtags-find-symbol-current-dir "rtags/src/rtags" "\


\(fn)" t nil)

(autoload 'rtags-find-references-current-dir "rtags/src/rtags" "\


\(fn)" t nil)

(autoload 'rtags-clear-diagnostics-overlays "rtags/src/rtags" "\


\(fn &optional BUF)" t nil)

(autoload 'rtags-is-running "rtags/src/rtags" "\


\(fn)" t nil)

(autoload 'rtags-cycle-through-diagnostics "rtags/src/rtags" "\


\(fn)" t nil)

(autoload 'rtags-fix-fixit-at-point "rtags/src/rtags" "\
Apply compiler fix-it at point.

\(fn)" t nil)

(autoload 'rtags-restart-tracking-timer "rtags/src/rtags" "\


\(fn)" t nil)

(autoload 'rtags-post-command-hook "rtags/src/rtags" "\


\(fn)" t nil)

(autoload 'rtags-toggle-diagnostics-suspended "rtags/src/rtags" "\


\(fn &optional QUIET)" t nil)

(autoload 'rtags-set-diagnostics-suspended "rtags/src/rtags" "\


\(fn &optional QUIET)" t nil)

(autoload 'rtags-stop-diagnostics "rtags/src/rtags" "\


\(fn)" t nil)

(autoload 'rtags-clear-diagnostics "rtags/src/rtags" "\


\(fn)" t nil)

(autoload 'rtags-diagnostics "rtags/src/rtags" "\


\(fn &optional RESTART)" t nil)

(autoload 'rtags-compilation-flags "rtags/src/rtags" "\


\(fn)" t nil)

(autoload 'rtags-close-taglist "rtags/src/rtags" "\


\(fn)" t nil)

(autoload 'rtags-taglist "rtags/src/rtags" "\


\(fn &optional DEST-WINDOW)" t nil)

(autoload 'rtags-select "rtags/src/rtags" "\


\(fn &optional OTHER-WINDOW REMOVE SHOW)" t nil)

(autoload 'rtags-select-other-window "rtags/src/rtags" "\


\(fn &optional NOT-OTHER-WINDOW)" t nil)

(autoload 'rtags-select-caller "rtags/src/rtags" "\


\(fn &optional NOT-OTHER-WINDOW)" t nil)

(autoload 'rtags-select-caller-other-window "rtags/src/rtags" "\


\(fn)" t nil)

(autoload 'rtags-show-in-other-window "rtags/src/rtags" "\


\(fn)" t nil)

(autoload 'rtags-select-and-remove-rtags-buffer "rtags/src/rtags" "\


\(fn)" t nil)

(autoload 'rtags-imenu "rtags/src/rtags" "\


\(fn)" t nil)

(autoload 'rtags-flatten-max-depth-one "rtags/src/rtags" "\


\(fn UNFLATTENED)" nil nil)

(autoload 'rtags-create-index-function "rtags/src/rtags" "\


\(fn)" t nil)

(autoload 'rtags-activate-imenu "rtags/src/rtags" "\
Overrides imenu index generation function for the current function.

\(fn)" t nil)

(autoload 'rtags-copy-and-print-current-location "rtags/src/rtags" "\


\(fn)" t nil)

(autoload 'rtags-find-file "rtags/src/rtags" "\
Find files matching a file pattern in the RTags database.

With PREFIX and when `rtags-use-filename-completion' is nil,
negate `rtags-find-file-prefer-exact-match' when matching files.

Initial file pattern to match is obtained from `rtags-current-symbol'
which can be overridden by specifying DEFAULT-FILE

\(fn &optional PREFIX DEFAULT-FILE)" t nil)

(autoload 'rtags-show-rtags-buffer "rtags/src/rtags" "\


\(fn)" t nil)

(autoload 'rtags-fixit "rtags/src/rtags" "\


\(fn &optional EDIFF BUFFER)" t nil)

(autoload 'rtags-remove-other-window "rtags/src/rtags" "\


\(fn)" t nil)

(autoload 'rtags-update-current-project "rtags/src/rtags" "\


\(fn)" t nil)

(autoload 'rtags-show-target-in-other-window "rtags/src/rtags" "\
DEST-WINDOW : destination window. Can be nil; in this case the current window is split
according to `rtags-other-window-window-size-percentage'.
CENTER-WINDOW : if true the target window is centered.
TRY-DECLARATION-FIRST : first try to find the declaration of the item, then the
definition.

\(fn &optional DEST-WINDOW CENTER-WINDOW TRY-DECLARATION-FIRST)" t nil)

(autoload 'rtags-suspend-file "rtags/src/rtags" "\


\(fn &optional ARG)" t nil)

(autoload 'rtags-unsuspend-file "rtags/src/rtags" "\


\(fn)" t nil)

(autoload 'rtags-toggle-file-suspended "rtags/src/rtags" "\


\(fn)" t nil)

(autoload 'rtags-clear-suspended-files "rtags/src/rtags" "\


\(fn &optional A B)" t nil)

(autoload 'rtags-suspend-all-files "rtags/src/rtags" "\


\(fn &optional A)" t nil)

(autoload 'rtags-list-suspended-files "rtags/src/rtags" "\


\(fn)" t nil)

(autoload 'rtags-compile-file "rtags/src/rtags" "\


\(fn &optional BUFFER)" t nil)

(autoload 'rtags-recompile-file "rtags/src/rtags" "\


\(fn)" t nil)

(autoload 'rtags-quit-rdm "rtags/src/rtags" "\
Quit the RTags process (rdm).

\(fn)" t nil)

(autoload 'rtags-restart-process "rtags/src/rtags" "\
Restart the RTags process (rdm).

\(fn)" t nil)

(autoload 'rtags-start-process-unless-running "rtags/src/rtags" "\
Launch the RTags process (rdm) if it's not already started.

\(fn)" t nil)

(autoload 'rtags-reparse-file "rtags/src/rtags" "\
WAIT-REPARSING : t to wait for reparsing to finish, nil for async (no waiting).

\(fn &optional BUFFER PERIODIC)" t nil)

(autoload 'rtags-maybe-reparse-file "rtags/src/rtags" "\


\(fn &optional BUFFER)" t nil)

(autoload 'rtags-display-summary "rtags/src/rtags" "\
Display a short text describing the item at point.
See `rtags-get-summary-text' for details.
If `rtags-display-summary-as-tooltip' is t, a tooltip is displayed.

\(fn &optional HIDE-EMPTY POS)" t nil)

(autoload 'rtags-display-summary-as-message "rtags/src/rtags" "\
Display a short text in message area describing the item at point.
See `rtags-get-summary-text' for details.

\(fn)" t nil)

(autoload 'rtags-get-include-file-for-symbol "rtags/src/rtags" "\
Insert #include declaration to buffer corresponding to the input symbol.
With optional PREFIX insert include at point.

\(fn &optional PREFIX)" t nil)

(autoload 'rtags-make-member "rtags/src/rtags" "\
Create a stub member functions. Type a declaration and then
`rtags-make-member' can be used to create the stub definition in
the class.

\(fn)" t nil)

(autoload 'rtags-check-includes "rtags/src/rtags" "\


\(fn)" t nil)

(autoload 'rtags-tokens "rtags/src/rtags" "\


\(fn &optional FROM TO CALLBACK)" t nil)

(autoload 'rtags-create-doxygen-comment "rtags/src/rtags" "\
Creates doxygen comment for function at point.

Comment will be inserted before current line. It uses yasnippet to let
the user enter missing field manually.

\(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "rtags/src/rtags" '("rtags-")))

;;;***

;;;### (autoloads nil "smartscan/smartscan" "smartscan/smartscan.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from smartscan/smartscan.el

(autoload 'smartscan-symbol-go-forward "smartscan/smartscan" "\
Jumps forward to the next symbol at point

\(fn)" t nil)

(autoload 'smartscan-symbol-go-backward "smartscan/smartscan" "\
Jumps backward to the previous symbol at point

\(fn)" t nil)

(autoload 'smartscan-symbol-replace "smartscan/smartscan" "\
Replaces the symbol at point with another string in the entire buffer.

With C-u the scope is limited to the current defun, as defined by
`narrow-to-defun'.

This function uses `search-forward' and `replace-match' to do the
actual work.

\(fn ARG)" t nil)

(autoload 'smartscan-mode "smartscan/smartscan" "\
Jumps between other symbols found at point.

When Smart Scan mode is enabled, you can jump between the all the
symbols in your current buffer that point is on.

You can customize Smart Scan by editing
`smartscan-use-extended-syntax' and `smartscan-symbol-selector'.

Key bindings:
\\{smartscan-map}

\(fn &optional ARG)" t nil)

(defvar global-smartscan-mode nil "\
Non-nil if Global Smartscan mode is enabled.
See the `global-smartscan-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `global-smartscan-mode'.")

(custom-autoload 'global-smartscan-mode "smartscan/smartscan" nil)

(autoload 'global-smartscan-mode "smartscan/smartscan" "\
Toggle Smartscan mode in all buffers.
With prefix ARG, enable Global Smartscan mode if ARG is positive;
otherwise, disable it.  If called from Lisp, enable the mode if
ARG is omitted or nil.

Smartscan mode is enabled in all buffers where
`smartscan-mode-turn-on' would do it.
See `smartscan-mode' for more information on Smartscan mode.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "smartscan/smartscan" '(#("smartscan-" 0 10 (face font-lock-function-name-face fontified nil)))))

;;;***

;;;### (autoloads nil "smex/smex" "smex/smex.el" (21268 30409 0 0))
;;; Generated autoloads from smex/smex.el

(autoload 'smex "smex/smex" "\


\(fn)" t nil)

(autoload 'smex-initialize "smex/smex" "\


\(fn)" t nil)

;;;***

;;;### (autoloads nil "soap-client/jira2" "soap-client/jira2.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from soap-client/jira2.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "soap-client/jira2" '("jira2-")))

;;;***

;;;### (autoloads nil "soap-client/soap-client" "soap-client/soap-client.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from soap-client/soap-client.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "soap-client/soap-client" '("soap-")))

;;;***

;;;### (autoloads nil "soap-client/soap-inspect" "soap-client/soap-inspect.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from soap-client/soap-inspect.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "soap-client/soap-inspect" '("soap-")))

;;;***

;;;### (autoloads nil "spinner/spinner" "spinner/spinner.el" (0 0
;;;;;;  0 0))
;;; Generated autoloads from spinner/spinner.el

(autoload 'spinner-create "spinner/spinner" "\
Create a spinner of the given TYPE.
The possible TYPEs are described in `spinner--type-to-frames'.

FPS, if given, is the number of desired frames per second.
Default is `spinner-frames-per-second'.

If BUFFER-LOCAL is non-nil, the spinner will be automatically
deactivated if the buffer is killed.  If BUFFER-LOCAL is a
buffer, use that instead of current buffer.

When started, in order to function properly, the spinner runs a
timer which periodically calls `force-mode-line-update' in the
curent buffer.  If BUFFER-LOCAL was set at creation time, then
`force-mode-line-update' is called in that buffer instead.  When
the spinner is stopped, the timer is deactivated.

DELAY, if given, is the number of seconds to wait after starting
the spinner before actually displaying it. It is safe to cancel
the spinner before this time, in which case it won't display at
all.

\(fn &optional TYPE BUFFER-LOCAL FPS DELAY)" nil nil)

(autoload 'spinner-start "spinner/spinner" "\
Start a mode-line spinner of given TYPE-OR-OBJECT.
If TYPE-OR-OBJECT is an object created with `make-spinner',
simply activate it.  This method is designed for minor modes, so
they can use the spinner as part of their lighter by doing:
    '(:eval (spinner-print THE-SPINNER))
To stop this spinner, call `spinner-stop' on it.

If TYPE-OR-OBJECT is anything else, a buffer-local spinner is
created with this type, and it is displayed in the
`mode-line-process' of the buffer it was created it.  Both
TYPE-OR-OBJECT and FPS are passed to `make-spinner' (which see).
To stop this spinner, call `spinner-stop' in the same buffer.

Either way, the return value is a function which can be called
anywhere to stop this spinner.  You can also call `spinner-stop'
in the same buffer where the spinner was created.

FPS, if given, is the number of desired frames per second.
Default is `spinner-frames-per-second'.

DELAY, if given, is the number of seconds to wait until actually
displaying the spinner. It is safe to cancel the spinner before
this time, in which case it won't display at all.

\(fn &optional TYPE-OR-OBJECT FPS DELAY)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "spinner/spinner" '("spinner-")))

;;;***

;;;### (autoloads nil "swiper/colir" "swiper/colir.el" (0 0 0 0))
;;; Generated autoloads from swiper/colir.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "swiper/colir" '("colir-")))

;;;***

;;;### (autoloads nil "swiper/counsel" "swiper/counsel.el" (0 0 0
;;;;;;  0))
;;; Generated autoloads from swiper/counsel.el

(autoload 'counsel-el "swiper/counsel" "\
Elisp completion at point.

\(fn)" t nil)

(autoload 'counsel-cl "swiper/counsel" "\
Common Lisp completion at point.

\(fn)" t nil)

(autoload 'counsel-clj "swiper/counsel" "\
Clojure completion at point.

\(fn)" t nil)

(autoload 'counsel-company "swiper/counsel" "\
Complete using `company-candidates'.

\(fn)" t nil)

(autoload 'counsel-irony "swiper/counsel" "\
Inline C/C++ completion using Irony.

\(fn)" t nil)

(autoload 'counsel-describe-variable "swiper/counsel" "\
Forward to `describe-variable'.

Variables declared using `defcustom' are highlighted according to
`ivy-highlight-face'.

\(fn)" t nil)

(autoload 'counsel-describe-function "swiper/counsel" "\
Forward to `describe-function'.

Interactive functions (i.e., commands) are highlighted according
to `ivy-highlight-face'.

\(fn)" t nil)

(autoload 'counsel-set-variable "swiper/counsel" "\
Set a variable, with completion.

When the selected variable is a `defcustom' with the type boolean
or radio, offer completion of all possible values.

Otherwise, offer a variant of `eval-expression', with the initial
input corresponding to the chosen variable.

With a prefix arg, restrict list to variables defined using
`defcustom'.

\(fn SYM)" t nil)

(autoload 'counsel-apropos "swiper/counsel" "\
Show all matching symbols.
See `apropos' for further information on what is considered
a symbol and how to search for them.

\(fn)" t nil)

(autoload 'counsel-info-lookup-symbol "swiper/counsel" "\
Forward to `info-lookup-symbol' with ivy completion.

\(fn SYMBOL &optional MODE)" t nil)

(autoload 'counsel-M-x "swiper/counsel" "\
Ivy version of `execute-extended-command'.
Optional INITIAL-INPUT is the initial input in the minibuffer.
This function integrates with either the `amx' or `smex' package
when available, in that order of precedence.

\(fn &optional INITIAL-INPUT)" t nil)

(autoload 'counsel-load-library "swiper/counsel" "\
Load a selected the Emacs Lisp library.
The libraries are offered from `load-path'.

\(fn)" t nil)

(autoload 'counsel-find-library "swiper/counsel" "\
Visit a selected the Emacs Lisp library.
The libraries are offered from `load-path'.

\(fn)" t nil)

(autoload 'counsel-load-theme "swiper/counsel" "\
Forward to `load-theme'.
Usable with `ivy-resume', `ivy-next-line-and-call' and
`ivy-previous-line-and-call'.

\(fn)" t nil)

(autoload 'counsel-descbinds "swiper/counsel" "\
Show a list of all defined keys and their definitions.
If non-nil, show only bindings that start with PREFIX.
BUFFER defaults to the current one.

\(fn &optional PREFIX BUFFER)" t nil)

(autoload 'counsel-faces "swiper/counsel" "\
Complete faces with preview.
Actions are provided by default for describing or customizing the
selected face.

\(fn)" t nil)

(autoload 'counsel-git "swiper/counsel" "\
Find file in the current Git repository.
INITIAL-INPUT can be given as the initial minibuffer input.

\(fn &optional INITIAL-INPUT)" t nil)

(autoload 'counsel-git-grep "swiper/counsel" "\
Grep for a string in the current git repository.
When CMD is a string, use it as a \"git grep\" command.
When CMD is non-nil, prompt for a specific \"git grep\" command.
INITIAL-INPUT can be given as the initial minibuffer input.

\(fn &optional CMD INITIAL-INPUT)" t nil)

(autoload 'counsel-git-stash "swiper/counsel" "\
Search through all available git stashes.

\(fn)" t nil)

(autoload 'counsel-git-change-worktree "swiper/counsel" "\
Find the file corresponding to the current buffer on a different worktree.

\(fn)" t nil)

(autoload 'counsel-git-checkout "swiper/counsel" "\
Call the \"git checkout\" command.

\(fn)" t nil)

(autoload 'counsel-git-log "swiper/counsel" "\
Call the \"git log --grep\" shell command.

\(fn)" t nil)

(autoload 'counsel-find-file "swiper/counsel" "\
Forward to `find-file'.
When INITIAL-INPUT is non-nil, use it in the minibuffer during completion.

\(fn &optional INITIAL-INPUT)" t nil)

(autoload 'counsel-recentf "swiper/counsel" "\
Find a file on `recentf-list'.

\(fn)" t nil)

(autoload 'counsel-bookmark "swiper/counsel" "\
Forward to `bookmark-jump' or `bookmark-set' if bookmark doesn't exist.

\(fn)" t nil)

(autoload 'counsel-bookmarked-directory "swiper/counsel" "\
Ivy interface for bookmarked directories.

With a prefix argument, this command creates a new bookmark which points to the
current value of `default-directory'.

\(fn)" t nil)

(autoload 'counsel-file-register "swiper/counsel" "\
Search file in register.

You cannot use Emacs' normal register commands to create file
registers.  Instead you must use the `set-register' function like
so: `(set-register ?i \"/home/eric/.emacs.d/init.el\")'.  Now you
can use `C-x r j i' to open that file.

\(fn)" t nil)

(autoload 'counsel-locate "swiper/counsel" "\
Call the \"locate\" shell command.
INITIAL-INPUT can be given as the initial minibuffer input.

\(fn &optional INITIAL-INPUT)" t nil)

(autoload 'counsel-fzf "swiper/counsel" "\
Open a file using the fzf shell command.
INITIAL-INPUT can be given as the initial minibuffer input.
INITIAL-DIRECTORY, if non-nil, is used as the root directory for search.
FZF-PROMPT, if non-nil, is passed as `ivy-read' prompt argument.

\(fn &optional INITIAL-INPUT INITIAL-DIRECTORY FZF-PROMPT)" t nil)

(autoload 'counsel-dpkg "swiper/counsel" "\
Call the \"dpkg\" shell command.

\(fn)" t nil)

(autoload 'counsel-rpm "swiper/counsel" "\
Call the \"rpm\" shell command.

\(fn)" t nil)

(autoload 'counsel-file-jump "swiper/counsel" "\
Jump to a file below the current directory.
List all files within the current directory or any of its subdirectories.
INITIAL-INPUT can be given as the initial minibuffer input.
INITIAL-DIRECTORY, if non-nil, is used as the root directory for search.

\(fn &optional INITIAL-INPUT INITIAL-DIRECTORY)" t nil)

(autoload 'counsel-dired-jump "swiper/counsel" "\
Jump to a directory (in dired) below the current directory.
List all subdirectories within the current directory.
INITIAL-INPUT can be given as the initial minibuffer input.
INITIAL-DIRECTORY, if non-nil, is used as the root directory for search.

\(fn &optional INITIAL-INPUT INITIAL-DIRECTORY)" t nil)

(autoload 'counsel-ag "swiper/counsel" "\
Grep for a string in the current directory using ag.
INITIAL-INPUT can be given as the initial minibuffer input.
INITIAL-DIRECTORY, if non-nil, is used as the root directory for search.
EXTRA-AG-ARGS string, if non-nil, is appended to `counsel-ag-base-command'.
AG-PROMPT, if non-nil, is passed as `ivy-read' prompt argument.

\(fn &optional INITIAL-INPUT INITIAL-DIRECTORY EXTRA-AG-ARGS AG-PROMPT)" t nil)

(autoload 'counsel-pt "swiper/counsel" "\
Grep for a string in the current directory using pt.
INITIAL-INPUT can be given as the initial minibuffer input.
This uses `counsel-ag' with `counsel-pt-base-command' instead of
`counsel-ag-base-command'.

\(fn &optional INITIAL-INPUT)" t nil)

(autoload 'counsel-ack "swiper/counsel" "\
Grep for a string in the current directory using ack.
INITIAL-INPUT can be given as the initial minibuffer input.
This uses `counsel-ag' with `counsel-ack-base-command' replacing
`counsel-ag-base-command'.

\(fn &optional INITIAL-INPUT)" t nil)

(autoload 'counsel-rg "swiper/counsel" "\
Grep for a string in the current directory using rg.
INITIAL-INPUT can be given as the initial minibuffer input.
INITIAL-DIRECTORY, if non-nil, is used as the root directory for search.
EXTRA-RG-ARGS string, if non-nil, is appended to `counsel-rg-base-command'.
RG-PROMPT, if non-nil, is passed as `ivy-read' prompt argument.

\(fn &optional INITIAL-INPUT INITIAL-DIRECTORY EXTRA-RG-ARGS RG-PROMPT)" t nil)

(autoload 'counsel-grep "swiper/counsel" "\
Grep for a string in the file visited by the current buffer.
When non-nil, INITIAL-INPUT is the initial search pattern.

\(fn &optional INITIAL-INPUT)" t nil)

(autoload 'counsel-grep-or-swiper "swiper/counsel" "\
Call `swiper' for small buffers and `counsel-grep' for large ones.
When non-nil, INITIAL-INPUT is the initial search pattern.

\(fn &optional INITIAL-INPUT)" t nil)

(autoload 'counsel-org-tag "swiper/counsel" "\
Add or remove tags in `org-mode'.

\(fn)" t nil)

(autoload 'counsel-org-tag-agenda "swiper/counsel" "\
Set tags for the current agenda item.

\(fn)" t nil)

(defalias 'counsel-org-goto #'counsel-outline)

(autoload 'counsel-org-goto-all "swiper/counsel" "\
Go to a different location in any org file.

\(fn)" t nil)

(autoload 'counsel-org-file "swiper/counsel" "\
Browse all attachments for current Org file.

\(fn)" t nil)

(autoload 'counsel-org-entity "swiper/counsel" "\
Complete Org entities using Ivy.

\(fn)" t nil)

(autoload 'counsel-org-capture "swiper/counsel" "\
Capture something.

\(fn)" t nil)

(autoload 'counsel-org-agenda-headlines "swiper/counsel" "\
Choose from headers of `org-mode' files in the agenda.

\(fn)" t nil)

(autoload 'counsel-tmm "swiper/counsel" "\
Text-mode emulation of looking and choosing from a menubar.

\(fn)" t nil)

(autoload 'counsel-yank-pop "swiper/counsel" "\
Ivy replacement for `yank-pop'.
With a plain prefix argument (\\[universal-argument]),
temporarily toggle the value of `counsel-yank-pop-after-point'.
Any other value of ARG has the same meaning as in `yank-pop', but
`counsel-yank-pop-preselect-last' determines its default value.
See also `counsel-yank-pop-filter' for how to filter candidates.

Note: Duplicate elements of `kill-ring' are always deleted.

\(fn &optional ARG)" t nil)

(autoload 'counsel-imenu "swiper/counsel" "\
Jump to a buffer position indexed by imenu.

\(fn)" t nil)

(autoload 'counsel-list-processes "swiper/counsel" "\
Offer completion for `process-list'.
The default action deletes the selected process.
An extra action allows to switch to the process buffer.

\(fn)" t nil)

(autoload 'counsel-expression-history "swiper/counsel" "\
Select an element of `read-expression-history'.
And insert it into the minibuffer.  Useful during `eval-expression'.

\(fn)" t nil)

(autoload 'counsel-shell-command-history "swiper/counsel" "\
Browse shell command history.

\(fn)" t nil)

(autoload 'counsel-minibuffer-history "swiper/counsel" "\
Browse minibuffer history.

\(fn)" t nil)

(autoload 'counsel-esh-history "swiper/counsel" "\
Browse Eshell history.

\(fn)" t nil)

(autoload 'counsel-shell-history "swiper/counsel" "\
Browse shell history.

\(fn)" t nil)

(autoload 'counsel-outline "swiper/counsel" "\
Jump to an outline heading with completion.

\(fn)" t nil)

(autoload 'counsel-ibuffer "swiper/counsel" "\
Use ibuffer to switch to another buffer.
NAME specifies the name of the buffer (defaults to \"*Ibuffer*\").

\(fn &optional NAME)" t nil)

(autoload 'counsel-switch-to-shell-buffer "swiper/counsel" "\
Switch to a shell buffer, or create one.

\(fn)" t nil)

(autoload 'counsel-unicode-char "swiper/counsel" "\
Insert COUNT copies of a Unicode character at point.
COUNT defaults to 1.

\(fn &optional COUNT)" t nil)

(autoload 'counsel-colors-emacs "swiper/counsel" "\
Show a list of all supported colors for a particular frame.

You can insert or kill the name or hexadecimal RGB value of the
selected color.

\(fn)" t nil)

(autoload 'counsel-colors-web "swiper/counsel" "\
Show a list of all W3C web colors for use in CSS.

You can insert or kill the name or hexadecimal RGB value of the
selected color.

\(fn)" t nil)

(autoload 'counsel-rhythmbox "swiper/counsel" "\
Choose a song from the Rhythmbox library to play or enqueue.

\(fn)" t nil)

(autoload 'counsel-linux-app "swiper/counsel" "\
Launch a Linux desktop application, similar to Alt-<F2>.

\(fn)" t nil)

(defvar counsel-mode nil "\
Non-nil if Counsel mode is enabled.
See the `counsel-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `counsel-mode'.")

(custom-autoload 'counsel-mode "swiper/counsel" nil)

(autoload 'counsel-mode "swiper/counsel" "\
Toggle Counsel mode on or off.
Turn Counsel mode on if ARG is positive, off otherwise. Counsel
mode remaps built-in emacs functions that have counsel
replacements.

Local bindings (`counsel-mode-map'):
\\{counsel-mode-map}

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "swiper/counsel" '("counsel-" "tmm-km-list" "ivy-function-called-at-point")))

;;;***

;;;### (autoloads nil "swiper/ivy" "swiper/ivy.el" (0 0 0 0))
;;; Generated autoloads from swiper/ivy.el

(autoload 'ivy-resume "swiper/ivy" "\
Resume the last completion session.

\(fn)" t nil)

(autoload 'ivy-read "swiper/ivy" "\
Read a string in the minibuffer, with completion.

PROMPT is a format string, normally ending in a colon and a
space; %d anywhere in the string is replaced by the current
number of matching candidates.  For the literal % character,
escape it with %%. See also `ivy-count-format'.

COLLECTION is either a list of strings, a function, an alist, or
a hash table.

PREDICATE is applied to filter out the COLLECTION immediately.
This argument is for `completing-read' compat.

When REQUIRE-MATCH is non-nil, only members of COLLECTION can be
selected, i.e. custom text.

If INITIAL-INPUT is not nil, then insert that input in the
minibuffer initially.

HISTORY is a name of a variable to hold the completion session
history.

KEYMAP is composed with `ivy-minibuffer-map'.

If PRESELECT is not nil, then select the corresponding candidate
out of the ones that match the INITIAL-INPUT.

DEF is for compatibility with `completing-read'.

UPDATE-FN is called each time the current candidate(s) is changed.

When SORT is t, use `ivy-sort-functions-alist' for sorting.

ACTION is a lambda function to call after selecting a result.  It
takes a single string argument.

UNWIND is a lambda function to call before exiting.

RE-BUILDER is a lambda function to call to transform text into a
regex pattern.

MATCHER is to override matching.

DYNAMIC-COLLECTION is a boolean to specify if the list of
candidates is updated after each input by calling COLLECTION.

CALLER is a symbol to uniquely identify the caller to `ivy-read'.
It is used, along with COLLECTION, to determine which
customizations apply to the current completion session.

\(fn PROMPT COLLECTION &key PREDICATE REQUIRE-MATCH INITIAL-INPUT HISTORY PRESELECT DEF KEYMAP UPDATE-FN SORT ACTION UNWIND RE-BUILDER MATCHER DYNAMIC-COLLECTION CALLER)" nil nil)

(autoload 'ivy-completing-read "swiper/ivy" "\
Read a string in the minibuffer, with completion.

This interface conforms to `completing-read' and can be used for
`completing-read-function'.

PROMPT is a string that normally ends in a colon and a space.
COLLECTION is either a list of strings, an alist, an obarray, or a hash table.
PREDICATE limits completion to a subset of COLLECTION.
REQUIRE-MATCH is a boolean value.  See `completing-read'.
INITIAL-INPUT is a string inserted into the minibuffer initially.
HISTORY is a list of previously selected inputs.
DEF is the default value.
INHERIT-INPUT-METHOD is currently ignored.

\(fn PROMPT COLLECTION &optional PREDICATE REQUIRE-MATCH INITIAL-INPUT HISTORY DEF INHERIT-INPUT-METHOD)" nil nil)

(defvar ivy-mode nil "\
Non-nil if Ivy mode is enabled.
See the `ivy-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `ivy-mode'.")

(custom-autoload 'ivy-mode "swiper/ivy" nil)

(autoload 'ivy-mode "swiper/ivy" "\
Toggle Ivy mode on or off.
Turn Ivy mode on if ARG is positive, off otherwise.
Turning on Ivy mode sets `completing-read-function' to
`ivy-completing-read'.

Global bindings:
\\{ivy-mode-map}

Minibuffer bindings:
\\{ivy-minibuffer-map}

\(fn &optional ARG)" t nil)

(autoload 'ivy-switch-buffer "swiper/ivy" "\
Switch to another buffer.

\(fn)" t nil)

(autoload 'ivy-switch-view "swiper/ivy" "\
Switch to one of the window views stored by `ivy-push-view'.

\(fn)" t nil)

(autoload 'ivy-switch-buffer-other-window "swiper/ivy" "\
Switch to another buffer in another window.

\(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "swiper/ivy" '("ivy-" "with-ivy-window")))

;;;***

;;;### (autoloads nil "swiper/ivy-hydra" "swiper/ivy-hydra.el" (0
;;;;;;  0 0 0))
;;; Generated autoloads from swiper/ivy-hydra.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "swiper/ivy-hydra" '("ivy-" "hydra-ivy")))

;;;***

;;;### (autoloads nil "swiper/ivy-overlay" "swiper/ivy-overlay.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from swiper/ivy-overlay.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "swiper/ivy-overlay" '("ivy-")))

;;;***

;;;### (autoloads nil "swiper/ivy-test" "swiper/ivy-test.el" (0 0
;;;;;;  0 0))
;;; Generated autoloads from swiper/ivy-test.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "swiper/ivy-test" '("ivy-" "command-execute-setting-this-command")))

;;;***

;;;### (autoloads nil "swiper/swiper" "swiper/swiper.el" (0 0 0 0))
;;; Generated autoloads from swiper/swiper.el

(autoload 'swiper-avy "swiper/swiper" "\
Jump to one of the current swiper candidates.

\(fn)" t nil)

(autoload 'swiper "swiper/swiper" "\
`isearch' with an overview.
When non-nil, INITIAL-INPUT is the initial search pattern.

\(fn &optional INITIAL-INPUT)" t nil)

(autoload 'swiper-all "swiper/swiper" "\
Run `swiper' for all open buffers.

\(fn &optional INITIAL-INPUT)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "swiper/swiper" '("swiper-")))

;;;***

;;;### (autoloads nil "tempo-snippets/tempo-snippets" "tempo-snippets/tempo-snippets.el"
;;;;;;  (21268 30202 0 0))
;;; Generated autoloads from tempo-snippets/tempo-snippets.el

(autoload 'tempo-snippets-clear-all "tempo-snippets/tempo-snippets" "\
Clear all tempo-snippet overlays.

\(fn)" t nil)

(autoload 'tempo-snippets-clear-oldest "tempo-snippets/tempo-snippets" "\
Clear the oldest tempo-snippet overlays.

\(fn)" t nil)

(autoload 'tempo-snippets-clear-latest "tempo-snippets/tempo-snippets" "\
Clear the latest tempo-snippet overlays.

\(fn)" t nil)

(autoload 'tempo-snippets-previous-field "tempo-snippets/tempo-snippets" "\
Jump to the previous editable tempo-snippet field.
You can also use `tempo-forward-mark', which will include more points of
interest.

\(fn &optional ARG)" t nil)

(autoload 'tempo-snippets-next-field "tempo-snippets/tempo-snippets" "\
Jump to the next editable tempo-snippet field.
You can also use `tempo-backward-mark', which will include more points of
interest.

\(fn &optional ARG)" t nil)

(autoload 'tempo-define-snippet "tempo-snippets/tempo-snippets" "\
`tempo-snippets' version of `tempo-define-template'.
Use with the same arguments as `tempo-define-template'.  The resulting template
will prompt for input right in the buffer instead of the minibuffer.

\(fn NAME ELEMENTS &optional TAG DOCUMENTATION TAGLIST)" nil nil)

(autoload 'tempo-snippets-insert-template "tempo-snippets/tempo-snippets" "\
`tempo-snippets' version of `tempo-insert-template.'

\(fn TEMPLATE ON-REGION)" nil nil)

(autoload 'tempo-snippets-complete-tag "tempo-snippets/tempo-snippets" "\
`tempo-snippets' version of `tempo-complete-tag.'

\(fn &optional SILENT)" t nil)

;;;***

;;;### (autoloads nil "treepy/treepy" "treepy/treepy.el" (0 0 0 0))
;;; Generated autoloads from treepy/treepy.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "treepy/treepy" '("treepy-")))

;;;***

;;;### (autoloads nil "url-http-ntlm/url-http-ntlm" "url-http-ntlm/url-http-ntlm.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from url-http-ntlm/url-http-ntlm.el

(autoload 'url-ntlm-auth "url-http-ntlm/url-http-ntlm" "\
Return an NTLM HTTP authorization header.
Get the contents of the Authorization header for a HTTP response
using NTLM authentication, to access URL.  Because NTLM is a
two-step process, this function expects to be called twice, first
to generate the NTLM type 1 message (request), then to respond to
the server's type 2 message (challenge) with a suitable response.

url-get-authentication' calls `url-ntlm-auth' once when checking
what authentication schemes are supported (PROMPT and ARGS are
nil), and then twice for every stage of the handshake: the first
time PROMPT is nil, the second, t; ARGS contains the server
response's \"WWW-Authenticate\" header, munged by
`url-parse-args'.

If PROMPT is not t then this function just returns nil.  This is
to avoid calculating responses twice.

OVERWRITE and REALM are ignored.

ARGS is expected to contain the WWW-Authentication header from
the server's last response.  These are used by
`url-http-get-stage' to determine what stage we are at.

\(fn URL &optional PROMPT OVERWRITE REALM ARGS)" nil nil)

(url-register-auth-scheme "ntlm" nil 8)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "url-http-ntlm/url-http-ntlm" '("url-http-ntlm--")))

;;;***

;;;### (autoloads nil "visual-regexp-steroids/visual-regexp-steroids"
;;;;;;  "visual-regexp-steroids/visual-regexp-steroids.el" (21517
;;;;;;  46908 0 0))
;;; Generated autoloads from visual-regexp-steroids/visual-regexp-steroids.el

(autoload 'vr/select-replace "visual-regexp-steroids/visual-regexp-steroids" "\


\(fn)" t nil)

(autoload 'vr/select-query-replace "visual-regexp-steroids/visual-regexp-steroids" "\


\(fn)" t nil)

(autoload 'vr/select-mc-mark "visual-regexp-steroids/visual-regexp-steroids" "\


\(fn)" t nil)

;;;***

;;;### (autoloads nil "visual-regexp/visual-regexp" "visual-regexp/visual-regexp.el"
;;;;;;  (21510 58497 0 0))
;;; Generated autoloads from visual-regexp/visual-regexp.el

(autoload 'vr/mc-mark "visual-regexp/visual-regexp" "\
Convert regexp selection to multiple cursors.

\(fn REGEXP START END)" nil nil)

(autoload 'vr/replace "visual-regexp/visual-regexp" "\
Regexp-replace with live visual feedback.

\(fn REGEXP REPLACE START END)" t nil)

(autoload 'vr/query-replace "visual-regexp/visual-regexp" "\
Use vr/query-replace like you would use query-replace-regexp.

\(fn REGEXP REPLACE START END)" t nil)

;;;***

;;;### (autoloads nil "wgrep/wgrep" "wgrep/wgrep.el" (22204 17725
;;;;;;  0 0))
;;; Generated autoloads from wgrep/wgrep.el

(autoload 'wgrep-setup "wgrep/wgrep" "\
Setup wgrep preparation.

\(fn)" nil nil)

(add-hook 'grep-setup-hook 'wgrep-setup)

;;;***

;;;### (autoloads nil "wgrep/wgrep-ack" "wgrep/wgrep-ack.el" (22204
;;;;;;  17725 0 0))
;;; Generated autoloads from wgrep/wgrep-ack.el

(autoload 'wgrep-ack-and-a-half-setup "wgrep/wgrep-ack" "\


\(fn)" nil nil)

(autoload 'wgrep-ack-setup "wgrep/wgrep-ack" "\


\(fn)" nil nil)

(add-hook 'ack-and-a-half-mode-hook 'wgrep-ack-and-a-half-setup)

(add-hook 'ack-mode-hook 'wgrep-ack-setup)

;;;***

;;;### (autoloads nil "wgrep/wgrep-ag" "wgrep/wgrep-ag.el" (0 0 0
;;;;;;  0))
;;; Generated autoloads from wgrep/wgrep-ag.el

(autoload 'wgrep-ag-setup "wgrep/wgrep-ag" "\


\(fn)" nil nil)

(add-hook 'ag-mode-hook 'wgrep-ag-setup)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "wgrep/wgrep-ag" '("wgrep-ag-")))

;;;***

;;;### (autoloads nil "wgrep/wgrep-helm" "wgrep/wgrep-helm.el" (0
;;;;;;  0 0 0))
;;; Generated autoloads from wgrep/wgrep-helm.el

(autoload 'wgrep-helm-setup "wgrep/wgrep-helm" "\


\(fn)" nil nil)

(add-hook 'helm-grep-mode-hook 'wgrep-helm-setup)

(add-hook 'helm-moccur-mode-hook 'wgrep-helm-setup)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "wgrep/wgrep-helm" '("wgrep-helm-")))

;;;***

;;;### (autoloads nil "wgrep/wgrep-pt" "wgrep/wgrep-pt.el" (22204
;;;;;;  17725 0 0))
;;; Generated autoloads from wgrep/wgrep-pt.el

(autoload 'wgrep-pt-setup "wgrep/wgrep-pt" "\


\(fn)" nil nil)

(add-hook 'pt-search-mode-hook 'wgrep-pt-setup)

;;;***

;;;### (autoloads nil "with-editor/with-editor" "with-editor/with-editor.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from with-editor/with-editor.el

(autoload 'with-editor-export-editor "with-editor/with-editor" "\
Teach subsequent commands to use current Emacs instance as editor.

Set and export the environment variable ENVVAR, by default
\"EDITOR\".  The value is automatically generated to teach
commands to use the current Emacs instance as \"the editor\".

This works in `shell-mode', `term-mode' and `eshell-mode'.

\(fn &optional (ENVVAR \"EDITOR\"))" t nil)

(autoload 'with-editor-export-git-editor "with-editor/with-editor" "\
Like `with-editor-export-editor' but always set `$GIT_EDITOR'.

\(fn)" t nil)

(autoload 'with-editor-export-hg-editor "with-editor/with-editor" "\
Like `with-editor-export-editor' but always set `$HG_EDITOR'.

\(fn)" t nil)

(defvar shell-command-with-editor-mode nil "\
Non-nil if Shell-Command-With-Editor mode is enabled.
See the `shell-command-with-editor-mode' command
for a description of this minor mode.")

(custom-autoload 'shell-command-with-editor-mode "with-editor/with-editor" nil)

(autoload 'shell-command-with-editor-mode "with-editor/with-editor" "\
Teach `shell-command' to use current Emacs instance as editor.

Teach `shell-command', and all commands that ultimately call that
command, to use the current Emacs instance as editor by executing
\"EDITOR=CLIENT COMMAND&\" instead of just \"COMMAND&\".

CLIENT is automatically generated; EDITOR=CLIENT instructs
COMMAND to use to the current Emacs instance as \"the editor\",
assuming no other variable overrides the effect of \"$EDITOR\".
CLIENT may be the path to an appropriate emacsclient executable
with arguments, or a script which also works over Tramp.

Alternatively you can use the `with-editor-async-shell-command',
which also allows the use of another variable instead of
\"EDITOR\".

\(fn &optional ARG)" t nil)

(autoload 'with-editor-async-shell-command "with-editor/with-editor" "\
Like `async-shell-command' but with `$EDITOR' set.

Execute string \"ENVVAR=CLIENT COMMAND\" in an inferior shell;
display output, if any.  With a prefix argument prompt for an
environment variable, otherwise the default \"EDITOR\" variable
is used.  With a negative prefix argument additionally insert
the COMMAND's output at point.

CLIENT is automatically generated; ENVVAR=CLIENT instructs
COMMAND to use to the current Emacs instance as \"the editor\",
assuming it respects ENVVAR as an \"EDITOR\"-like variable.
CLIENT may be the path to an appropriate emacsclient executable
with arguments, or a script which also works over Tramp.

Also see `async-shell-command' and `shell-command'.

\(fn COMMAND &optional OUTPUT-BUFFER ERROR-BUFFER ENVVAR)" t nil)

(autoload 'with-editor-shell-command "with-editor/with-editor" "\
Like `shell-command' or `with-editor-async-shell-command'.
If COMMAND ends with \"&\" behave like the latter,
else like the former.

\(fn COMMAND &optional OUTPUT-BUFFER ERROR-BUFFER ENVVAR)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "with-editor/with-editor" '("with-editor" "start-file-process--with-editor-process-filter" "server-" "shell-command--shell-command-with-editor-mode")))

;;;***

;;;### (autoloads nil "yaml-mode/yaml-mode" "yaml-mode/yaml-mode.el"
;;;;;;  (23006 9687 0 0))
;;; Generated autoloads from yaml-mode/yaml-mode.el

(let ((loads (get 'yaml 'custom-loads))) (if (member '"yaml-mode/yaml-mode" loads) nil (put 'yaml 'custom-loads (cons '"yaml-mode/yaml-mode" loads))))

(autoload 'yaml-mode "yaml-mode/yaml-mode" "\
Simple mode to edit YAML.

\\{yaml-mode-map}

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("\\.\\(e?ya?\\|ra\\)ml\\'" . yaml-mode))

;;;***

;;;### (autoloads nil nil ("el-get/el-get-install.el" "fsm/fsm-autoloads.el"
;;;;;;  "fsm/fsm-pkg.el" "lsp-mode/lsp-dhall.el" "lsp-mode/lsp-svelte.el"
;;;;;;  "lsp-mode/lsp.el" "multiple-cursors/multiple-cursors-pkg.el"
;;;;;;  "multiple-cursors/multiple-cursors.el" "url-http-ntlm/url-http-ntlm-autoloads.el"
;;;;;;  "url-http-ntlm/url-http-ntlm-pkg.el") (0 0 0 0))

;;;***

(provide '.loaddefs)
;; Local Variables:
;; version-control: never
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; .loaddefs.el ends here
