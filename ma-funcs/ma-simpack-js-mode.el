(require 'lsp)

(defconst ma-simpack-js-typescript-files '("SpckGUI" "SpckModel" "SpckWizard" "SpckCompat"))
(defconst ma-simpack-js--insertion-text
"import { Spck, Script, System } from \"./SpckModel\";\n
import { Dir, File } from \"./SpckCompat\";\n
import { MessageBox, Tree } from \"./SpckGUI\";\n")
(defconst ma-simpack-js--insertion-marker "\n// Automatically added marker added by Emacs mode ma-simpack-js-mode\n\n")
(defconst ma-simpack-js--config-filename "tsconfig.json")

(defconst ma-simpack-js--mirrored-dirs
  '(("/ssh:mal1@dell1254cem:/home/home_dev/MAL1/scripts" . "/home/martin/scripts")
    ("/ssh:mal1@dell1254cem:/home/home_dev/MAL1/devs" . "/home/martin/devs")))

(defun ma-simpack-js--mirrored(filename)
  "If 'FILENAME' is located on a remote mirrored directory, return the corresponding local filename, otherwise return nil."
  (when (file-remote-p filename)
    (dolist (entry ma-simpack-js--mirrored-dirs)
      (when (string-prefix-p (car entry) filename)
        (cl-return (concat (cdr entry) (substring filename (length (car entry)))))))))

(defun ma-simpack-js--gen-tsconfig (directory)
  "Generate a tsconfig file in the given DIRECTORY as containing the TypeScript files and all .sjs files in this directory."
  (let ((filename (concat directory ma-simpack-js--config-filename))
        (files (directory-files directory nil "\\.sjs$")))
    (with-temp-file filename
      (insert "{\n \"files\" :\n   [\n")
      (dolist (file files)
        (insert "     \"" file "\",\n"))
      (dolist (file ma-simpack-js-typescript-files)
        (insert "    \"" file "\",\n")
        (insert "    \"" (file-name-with-extension file ".ts") "\",\n"))
      (insert "   ]\n")
      (insert "}\n"))))

(defun ma-simpack-js--insert-header()
  "Insert a header into the current buffer, so the Typescript engine finds the relevant completion info."
    (goto-char (point-min))
    (insert ma-simpack-js--insertion-text)
    (insert ma-simpack-js--insertion-marker))

(defun ma-simpack-js--write-sjs-file()
  "Function called from 'write-contents-functions' hook to write the region after the header to the sjs file."
  (message "ma-simpack-js--write-sjs-file called")
  (save-excursion
    (goto-char (point-min))
    (let* ((region-end (search-forward ma-simpack-js--insertion-marker))
           (ts-file (buffer-file-name))
           (sjs-file (file-name-with-extension ts-file ".sjs")))
      (write-region region-end (point-max) sjs-file)))
  nil)

(defun ma-simpack-js--sjs-loaded()
  "Function to call in Javascript hook to handle SJS/TS file pairs."
  (message "ma-simpack-js--sjs-loaded called")
  (let* ((sjs-file (or (ma-simpack-js--mirrored (buffer-file-name)) (buffer-file-name)))
         (ts-file (file-name-with-extension sjs-file ".ts")))
    (if (or (not (file-exists-p ts-file))(file-newer-than-file-p sjs-file ts-file))
        (progn
          (ma-simpack-js--gen-tsconfig (file-name-directory sjs-file))
          (ma-simpack-js--insert-header)
          ;; Writing to ts-file automatically switches the buffer to Typescript mode
          (write-file ts-file t))
      (find-file ts-file))))

(defun ma-simpack-js--ts-loaded()
  "Function to call in Typescript hook to handle SJS/TS file pairs."
  (message "ma-simpack-js--ts-loaded called")
  (let* ((ts-file (or (ma-simpack-js--mirrored (buffer-file-name)) (buffer-file-name)))
         (sjs-file (file-name-with-extension ts-file ".sjs")))
    (if (ma-simpack-js--mirrored (buffer-file-name))
        (find-file ts-file)
      (when (and (file-exists-p sjs-file) (file-newer-than-file-p sjs-file ts-file))
          (message "WARNING: SJS file is newer than TS file!"))
      (add-hook 'write-contents-functions 'ma-simpack-js--write-sjs-file 0 t))))

(define-minor-mode ma-simpack-js-mode
  "Toggles ma-simpack-js minor mode."
  :global t
  :group 'ma-simpack-js

  (if ma-simpack-js-mode
      (progn
        (add-hook 'js2-mode-hook 'ma-simpack-js--sjs-loaded)
        (add-hook 'typescript-ts-mode-hook 'ma-simpack-js--ts-loaded))
    (progn
        (remove-hook 'js2-mode-hook 'ma-simpack-js--sjs-loaded)
        (remove-hook 'typescript-ts-mode-hook 'ma-simpack-js--ts-loaded))))

(provide 'ma-simpack-js-mode)



;; Idea: When user opens SJS file, for which no TS file exists, create TS file with contents of SJS file and added header
;; When user opens SJS file and TS file exists, check, which file is newer
;; - If TS file is newer, simply open TS file in a buffer and kill the buffer with SJS file
;; - If TS File is older, remove TS file and replace as if newer
;; When user open TS file and SJS file exists, check, which file is newer
;; - If TS File is newer, simply open it
;; - If TS file is older, issue warning to the user
;;
;; Set buffer-local variable write-contents-functions to contain a function, which writes the part of the TS buffer after the header to the SJS file and returns nil.
;; This causes both files to be written, when the TS buffer is saved
