(require 'tempo-snippets)
(tempo-define-snippet "c-for-it"
  '(> "for (auto " (p "Iterator: " it) " = "
      (p "Container: " container) ".begin(); "
      (s it) " != " (s container) ".end(); ++" (s it) ")" n  "{" > n > p r n "}" >)
  "fori"
  "Insert a C++ for loop iterating over an STL container."
  nil)

(tempo-define-snippet "c-for-it-templ"
  '(> "for (auto " (p "Iterator: " it) " = "
      (p "Container: " container) ".begin<" (p "Class: " class) ">(); "
      (s it) " != " (s container) ".end<" (s class) ">(); ++" (s it) ")" n  "{" > n > p r n "}" >)
  "tfori"
  "Insert a C++ for loop iterating over a templated container."
  nil)

(tempo-define-snippet "mu4e-mfg"
  '("Mit freundlichen Grüßen" n n
      "Martin Apel" n)
  "mfg"
  "Mit freundlichen Grüßen."
  nil)
(tempo-define-snippet "mu4e-vg"
  '("Viele Grüße" n n
      "Martin" n)
  "vg"
  "Viele Grüße."
  nil)
(tempo-define-snippet "mu4e-hg"
  '("Herzliche Grüße" n n
      "Martin" n)
  "hg"
  "Herzliche Grüße."
  nil)

(add-hook 'c++-mode-hook
       (lambda ()
         (tempo-snippets-add-mode-abbrev 'tempo-template-c-for-it "fori")
         (tempo-snippets-add-mode-abbrev 'tempo-template-c-for-it-templ "tfori")))

(add-hook 'mu4e-compose-mode-hook
          (lambda ()
            ;; Workaround for bug 14413
            (setq local-abbrev-table message-mode-abbrev-table)
            (tempo-snippets-add-mode-abbrev 'tempo-template-mu4e-mfg "mfg")
            (tempo-snippets-add-mode-abbrev 'tempo-template-mu4e-vg "vg")
            (tempo-snippets-add-mode-abbrev 'tempo-template-mu4e-hg "hg")
            ))
