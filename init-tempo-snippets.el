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

(add-hook 'c++-mode-hook
       (lambda ()
         (tempo-snippets-add-mode-abbrev 'tempo-template-c-for-it "fori")
         (tempo-snippets-add-mode-abbrev 'tempo-template-c-for-it-templ "tfori")))
