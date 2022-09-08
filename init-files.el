
(dir-locals-set-class-variables 'new_arch
 '((c++-mode
  (ma-compile-command . "~/bin/my_remote_compile.sh"))
   (c-mode
    (ma-compile-command . "~/bin/my_remote_compile.sh")
   )))

(dir-locals-set-class-variables 'squish
 '((python-mode)))

(dir-locals-set-directory-class  "/scratch/apel/new_arch/develop/" 'new_arch)
(dir-locals-set-directory-class  "/scratch/apel/SpckTest/SquishTestSuites" 'squish)
