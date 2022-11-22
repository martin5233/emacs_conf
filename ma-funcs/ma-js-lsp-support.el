(defconst ma-js-lsp-support-files '("SpckGUI" "SpckModel" "SpckWizard" "SpckCompat"))

(defun ma-js-lsp-support--copy-simpack-lang-files (target-dir)
  "Copies Simpack Typescript into target directory and returns the list of copied files without path."
  (let ((files (cl-mapcar (lambda (file) (concat file ".d.ts")) ma-js-lsp-support-files)))
    (dolist (file files)
      (copy-file (concat work-remote-url "/scratch/apel/new_arch/obj/64/run/node_modules/@types/" file) (concat target-dir "/") t))
    files))

(defun ma-js-lsp-support--gen-tsconfig (file-to-edit)
  "Generate a tsconfig file in the same directory as FILE-TO-EDIT containing the TypeScript files and the FILE-TO-EDIT itself."
  (let ((filename (concat (file-name-directory file-to-edit) "tsconfig.json"))
        (type-script-files (ma-js-lsp-support--copy-simpack-lang-files (file-name-directory file-to-edit))))
    (with-temp-file filename
      (insert "{\n \"files\" :\n   [\n")
      (insert "     \"" (file-name-nondirectory file-to-edit) "\",\n")
      (dolist (file type-script-files)
        (insert "    \"" file "\",\n"))
      (insert "   ]\n")
      (insert "}\n"))))

(defun ma-js-lsp-support-prepare-lsp ()
  "Prepare editing in current buffer by copying the necessary TypeScript files into the same directory and starting LSP."
  (ma-js-lsp-support--gen-tsconfig (buffer-file-name))
  (lsp))

(add-hook 'js2-mode-hook 'ma-js-lsp-support-prepare-lsp)
(provide 'ma-js-lsp-support)
