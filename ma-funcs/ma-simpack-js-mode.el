(defconst ma-simpack-js-typescript-files '("SpckGUI" "SpckModel" "SpckWizard" "SpckCompat"))
(defconst ma-simpack-js--insertion-text
"import { Spck, Script, System } from \"./SpckModel\";\n
import { Dir, File } from \"./SpckCompat\";\n
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

(defun ma-simpack-js--insert-header()
  "Insert a header into the current buffer, so the Typescript engine finds the relevant completion info."
    (goto-char (point-min))
    (insert ma-simpack-js--insertion-text)
    (insert ma-simpack-js--insertion-marker)
    (narrow-to-region (point) (point-max)))

(defun ma-simpack-js--undo-insert-header()
  "Remove header inserted by `ma-simpack-js--insert-header'."
  (widen)
  (goto-char (point-min))
  (let* ((region-end (search-forward ma-simpack-js--insertion-marker))
         (region-start (point-min)))
    (kill-region region-start region-end)))

(defun ma-simpack-js--before-save()
  "Hook run before saving the buffer."
  (setq-local ma-simpack-js--local-file (buffer-file-name))
  (set-visited-file-name ma-simpack-js--orig-file t)
  (setq-local visited-file-pos (point))
  (ma-simpack-js--undo-insert-header))

(defun ma-simpack-js--after-save()
  "Hook run after saving the buffer."
  (set-visited-file-name ma-simpack-js--local-file t)
  (ma-simpack-js--insert-header)
  (set-buffer-modified-p nil)
  (goto-char visited-file-pos))

(defun ma-simpack-js--create-local-copy(orig-file)
  "Creates a copy of the current sjs file in a local directory, inserts statements to enable Javascript completion and edits the local file.
The copy is also put into ma-simpack-js-mode, but with a local variable indicating it to be the slave buffer."
  (let* ((local-dir ma-simpack-js-local-dir)
         (local-file (concat local-dir (file-name-nondirectory orig-file))))
    (when (not (file-accessible-directory-p local-dir))
      (make-directory local-dir))
    (setq-local ma-simpack-js--orig-file orig-file)
    (set-visited-file-name local-file t)
    (ma-simpack-js--insert-header)
    (save-buffer)
    (make-variable-buffer-local 'before-save-hook)
    (add-hook 'before-save-hook 'ma-simpack-js--before-save)
    (make-variable-buffer-local 'after-save-hook)
    (add-hook 'after-save-hook 'ma-simpack-js--after-save)
    (ma-simpack-js--gen-tsconfig local-dir)
    (lsp)
    ))

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
