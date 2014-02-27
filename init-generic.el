(define-generic-mode
  'spck-mode
  '("!")
  '("body"
    "constr"
    "control"
    "ens"
    "express"
    "force"
    "joint"
    "marker"
    "poly"
    "prim"
    "road"
    "refsys"
    "sensor"
    "slv"
    "substr"
    "subvar"
    "track"
    "timex"
    "view"
    "yout")
  '(
    ("\\(\\$[A-Za-z0-9_]+\\)" 1 font-lock-variable-name-face)
    ("\\([+-]?[0-9]\\.[0-9]+E[+-][0-9]+\\)" 1 font-lock-constant-face)
    ("'\\([^']+\\)'" 1 font-lock-string-face)
    )
  '("\\.sys$" "\\.ani$" "\\.spck$")
  (list
   (function
    (lambda ()
      (setq imenu-generic-expression
       '((nil "(.*\\(\\$[A-Za-z0-9_]+\\).*) *=" 1)))
      (imenu-add-menubar-index)
      (local-set-key [?\C-c ?\C-j] 'imenu))))
  "A mode for SIMPACK model files"
)
