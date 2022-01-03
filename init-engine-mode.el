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

(setq engine/browser-function 'eaf-open-browser-other-window)
(engine-mode t)
