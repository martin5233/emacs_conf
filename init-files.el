(dir-locals-set-class-variables 'new_arch
 '((c++-mode
  (ma-compile-command . "~/bin/my_compile")
  (tags-file-name . "/scratch/apel/new_arch/.tags"))
   (c-mode
    (ma-compile-command . "~/bin/my_compile")
    (tags-file-name . "/scratch/apel/new_arch/.tags"))
   ))

(dir-locals-set-class-variables 'llvm_test
 '((c++-mode
  (ma-compile-command . "make -C /home/home_dev/apel/llvm_test/obj")
  (ma-make-target . nil)
  (ma-build-dir . nil)
  (tags-file-name . "/scratch2/apel/llvm-3.1.src/TAGS"))
  (cmake-mode
  (ma-compile-command . "make -C /home/home_dev/apel/llvm_test/obj")
  (ma-make-target . nil)
  (ma-build-dir . nil))))

(dir-locals-set-class-variables 'llvm_src
 '((c++-mode
  (tags-file-name . "/scratch2/apel/llvm-3.1.src/TAGS"))))

(dir-locals-set-class-variables 'atomic
 '((c++-mode
    (ma-compile-command . "make -C /home/home_dev/apel/atomic/obj")
    (ma-make-target . nil)
    (ma-build-dir . nil))))

(dir-locals-set-directory-class  "/scratch/apel/new_arch/develop/" 'new_arch)
(dir-locals-set-directory-class  "/home/home_dev/apel/llvm_test/" 'llvm_test)
(dir-locals-set-directory-class  "/scratch2/apel/llvm-3.1.src" 'llvm_src)
(dir-locals-set-directory-class  "/usr/local/include/llvm" 'llvm_src)
(dir-locals-set-directory-class  "/home/home_dev/apel/atomic/" 'atomic)
