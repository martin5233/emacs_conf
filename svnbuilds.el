(require 'emacsql-mysql)
(require 'magit-section)

(defun ma-get-svn-rev ()
  "Retrieves a hash from the current location in the buffer and try to transform this hash to the corresponding svn build id."
  (interactive)
  (let* ((hash (magit-thing-at-point 'git-revision t))
         (pattern (concat hash "%"))
         (db (emacsql-mysql
              "svntest"
              :user "svntest"
              :password "!svntest!"
              :host "dell231cem.ux.dsone.3ds.com"
              :debug t))
         (query-result (emacsql db [:select [ revision ]
                                            :from revisions
                                            :where (like (funcall lower (funcall hex commit)) $r1)] pattern)))
    (if query-result
        (let ((svnbuild (car (car query-result))))
          (message (format "SVN-Build corresponding to hash %s is %d" hash svnbuild)))
      (message (format "Did not find SVN-build corresponding to hash %s hash" hash)))))
