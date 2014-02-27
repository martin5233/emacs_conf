(require 'tempo-snippets)
(tempo-define-snippet "c-for-it"
  '(> "for (" (p "Type: " type) "::iterator " (p "Iterator: " it) " = "
      (p "Container: " container) ".begin(); "
      (s it) " != " (s container) ".end(); ++" (s it) ")" n  "{" > n > p r n "}" >)
  "fori"
  "Insert a C++ for loop iterating over an STL container."
  nil)

(tempo-define-snippet "c-for-const-it"
  '(> "for (" (p "Type: " type) "::const_iterator " (p "Iterator: " it) " = "
      (p "Container: " container) ".begin(); "
      (s it) " != " (s container) ".end(); ++" (s it) ")" n  "{" > n > p r n "}" >)
  "forc"
  "Insert a C++ for loop iterating over an STL container."
  nil)

(tempo-define-snippet "c-for-it-templ"
  '(> "for (" (p "Type: " type) "::iterator<" (p "Class: " class) "> "  (p "Iterator: " it) " = "
      (p "Container: " container) ".begin<" (s class) ">(); "
      (s it) " != " (s container) ".end<" (s class) ">(); ++" (s it) ")" n  "{" > n > p r n "}" >)
  "tfori"
  "Insert a C++ for loop iterating over a templated container."
  nil)

(tempo-define-snippet "c-for-const-it-templ"
  '(> "for (" (p "Type: " type) "::const_iterator<" (p "Class: " class) "> "  (p "Iterator: " it) " = "
      (p "Container: " container) ".begin<" (s class) ">(); "
      (s it) " != " (s container) ".end<" (s class) ">(); ++" (s it) ")" n  "{" > n > p r n "}" >)
  "tforc"
  "Insert a C++ for loop iterating over a templated container."
  nil)

(add-hook 'c++-mode-hook
       (lambda ()
         (tempo-snippets-add-mode-abbrev 'tempo-template-c-for-const-it "forc")
         (tempo-snippets-add-mode-abbrev 'tempo-template-c-for-it "fori")
         (tempo-snippets-add-mode-abbrev 'tempo-template-c-for-it-templ "tfori")
         (tempo-snippets-add-mode-abbrev 'tempo-template-c-for-const-it-templ "tforc")))
