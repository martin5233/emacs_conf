(require 'engine-mode)
(defengine duckduckgo
  "https://duckduckgo.com/?q=%s"
  :keybinding "d")

(defengine cppreference
  "https://en.cppreference.com/mwiki/index.php?search=%s"
  :keybinding "c")

(defengine qtreference
  "http://doc.qt.io/qt-5.12/%s.html"
  :keybinding "q")

;; Use eww by default, but use eaf-browser, if available
(setq engine/browser-function 'eww-browse-url)
(eval-after-load "eaf-browser"
  '(setq engine/browser-function 'eaf-open-browser-other-window))

(engine-mode t)
