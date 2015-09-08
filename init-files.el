(dir-locals-set-class-variables 'new_arch
 '((c++-mode
  (ma-compile-command . "~/bin/my_compile")
  (tags-table-list . ("/scratch/apel/new_arch/.tags")))
   (c-mode
    (ma-compile-command . "~/bin/my_compile")
    (tags-table-list . ("/scratch/apel/new_arch/.tags")))
   ))

(dir-locals-set-class-variables 'llvm_test
 '((c++-mode
  (ma-compile-command . "make -C /home/home_dev/apel/llvm_test/obj")
  (ma-make-target . nil)
  (ma-build-dir . nil)
  (tags-table-list . ("/scratch2/apel/llvm-3.1.src/TAGS")))
  (cmake-mode
  (ma-compile-command . "make -C /home/home_dev/apel/llvm_test/obj")
  (ma-make-target . nil)
  (ma-build-dir . nil))))

(dir-locals-set-class-variables 'llvm_src
 '((c++-mode
  (tags-table-list . ("/scratch2/apel/llvm-3.1.src/TAGS")))))

(dir-locals-set-class-variables 'atomic
 '((c++-mode
    (ma-compile-command . "make -C /home/home_dev/apel/atomic/obj")
    (ma-make-target . nil)
    (ma-build-dir . nil))))

(dir-locals-set-class-variables 'squish
 '((python-mode
  (tags-table-list . ("/scratch2/apel/SpckTest/SquishTestSuites/TAGS")))))

(dir-locals-set-class-variables 'runtimetree
 '((c++-mode
    (ma-compile-command . "make -C /scratch/apel/runtimetree/obj")
    (ma-make-target . nil)
    (ma-build-dir . nil))))



(dir-locals-set-directory-class  "/scratch/apel/new_arch/develop/" 'new_arch)
(dir-locals-set-directory-class  "/home/home_dev/apel/llvm_test/" 'llvm_test)
(dir-locals-set-directory-class  "/scratch2/apel/llvm-3.1.src" 'llvm_src)
(dir-locals-set-directory-class  "/usr/local/include/llvm" 'llvm_src)
(dir-locals-set-directory-class  "/home/home_dev/apel/atomic/" 'atomic)
(dir-locals-set-directory-class  "/scratch/apel/runtimetree/" 'runtimetree)
(dir-locals-set-directory-class  "/scratch2/apel/SpckTest/SquishTestSuites" 'squish)
