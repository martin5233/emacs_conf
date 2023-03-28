(defconst ma-simpack-js-typescript-files '("SpckGUI" "SpckModel" "SpckWizard" "SpckCompat"))
(defconst ma-simpack-js--insertion-text
"import { Spck, Script, System } from \"./SpckModel\";\n
import { Dir, File, } from \"./SpckCompat\";\n
import { MessageBox, Tree } from \"./SpckGUI\";\n")
(defconst ma-simpack-js--insertion-marker "\n// Automatically added marker added by Emacs mode ma-simpack-js-model\n\n")

(defcustom ma-simpack-js-local-dir "~/simpack-js/"
  "Local directory, where to keep local copies."
  :type 'string
  :group 'ma-simpack-js)

(defun ma-simpack-js--gen-tsconfig (directory)
  "Generate a tsconfig file in the given DIRECTORY as containing the TypeScript files and all .sjs files in this directory."
  (let ((filename (concat directory "tsconfig.json"))
        (files (directory-files directory nil "\\.sjs$")))
    (with-temp-file filename
      (insert "{\n \"files\" :\n   [\n")
      (dolist (file files)
        (insert "     \"" file "\",\n"))
      (dolist (file ma-simpack-js-typescript-files)
        (insert "    \"" file "\",\n"))
      (insert "   ]\n")
      (insert "}\n"))))

(defun ma-simpack-js--create-local-copy(orig-file)
  "Creates a copy of the current sjs file in a local directory, inserts statements to enable Javascript completion and edits the local file.
The copy is also put into ma-simpack-js-mode, but with a local variable indicating it to be the slave buffer."
  (let* ((local-dir ma-simpack-js-local-dir)
         (local-file (concat local-dir (file-name-nondirectory orig-file))))
    (when (not (file-accessible-directory-p local-dir))
      (make-directory local-dir))
    (set-visited-file-name local-file t)
    (goto-char (point-min))
    (insert ma-simpack-js--insertion-text)
    (insert ma-simpack-js--insertion-marker)
    (setq-local ma-simpack-js--orig-file orig-file)
    (narrow-to-region (point) (point-max))
    (save-buffer)
    (make-variable-buffer-local 'after-save-hook)
    (add-hook 'after-save-hook 'ma-simpack-js--copy-back)
    (ma-simpack-js--gen-tsconfig local-dir)
    (lsp)
    ))

(defun ma-simpack-js--copy-back()
  "Copies the contents of the current buffer back to its original file, after stripping the extra additions."
  (goto-char (point-min))
  (let* ((region-start (search-forward ma-simpack-js--insertion-marker))
         (region-end (point-max))
         (text-to-copy (buffer-substring-no-properties region-start region-end))
         (buffer (find-file-noselect ma-simpack-js--orig-file)))
    (with-current-buffer buffer
      (erase-buffer)
      (insert text-to-copy)
      (save-buffer))
    (kill-buffer buffer)))


;; (defun ma-js-lsp-support-prepare-lsp ()
;;   "Prepare editing in current buffer by copying the necessary TypeScript files into the same directory and starting LSP."
;;   (ma-js-lsp-support--gen-tsconfig (buffer-file-name))
;;   (lsp))

;; (add-hook 'js2-mode-hook 'ma-js-lsp-support-prepare-lsp)

(define-minor-mode ma-simpack-js-mode
  "Toggles ma-simpack-js minor mode."
  :global nil
  :lighter "[spck]"
  :group 'ma-simpack-js

  (when (and ma-simpack-js-mode
             (not (local-variable-p 'ma-simpack-js--orig-file))
             (not (string-equal (file-name-directory (buffer-file-name)) ma-simpack-js-local-dir)))
      (ma-simpack-js--create-local-copy (buffer-file-name))))

(provide 'ma-simpack-js-mode)
