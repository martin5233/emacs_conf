(dir-locals-set-class-variables 'new_arch
 '((c++-mode
  (ma-compile-command . "~/bin/my_compile")
  (tags-table-list . ("/scratch/apel/new_arch/.tags")))
   (c-mode
    (ma-compile-command . "~/bin/my_compile")
    (tags-table-list . ("/scratch/apel/new_arch/.tags")))
   ))

(dir-locals-set-class-variables 'squish
 '((python-mode
  (tags-table-list . ("/scratch/apel/SpckTest/SquishTestSuites/TAGS")))))

(dir-locals-set-class-variables 'qt-4.8
                                '((c++-mode
                                   (tags-table-list . ("/scratch/apel/qt-everywhere-enterprise-src-4.8.6/TAGS")))))

(dir-locals-set-class-variables 'boost-1.60
                                '((c++-mode
                                   (tags-table-list . ("/scratch/apel/boost_1_60_0/TAGS")))))

(dir-locals-set-directory-class  "/scratch/apel/new_arch/develop/" 'new_arch)
(dir-locals-set-directory-class  "/scratch/apel/SpckTest/SquishTestSuites" 'squish)
(dir-locals-set-directory-class  "/scratch/apel/qt-everywhere-enterprise-src-4.8.6" 'qt-4.8)
(dir-locals-set-directory-class  "/scratch/apel/boost_1_60_0" 'boost-1.60)
