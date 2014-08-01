;;; atl-stash.el --- Interface to Atlassian Stash    -*- lexical-binding: t; -*-

;; Copyright (C) 2014  Martin Apel

;; Author: Martin Apel <martin.apel@simpack.de>
;; Keywords: vc, comm

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Interface to Atlassian Stash
;; Provides functions to display Stash status for current user (pull requests to review, own pull requests)

;;; Code:
(require 'request)
(require 'password-cache)
(require 'json)

(defcustom ma-stash-url "https://stash.intec.dom:7990"
  "URL of Stash server")

(defcustom ma-SIMPACK-ca-cert "/home/home_dev/apel/SIMPACK_CA.cer"
  "Location of certificate of SIMPACK CA")

(defvar ma-mode-line-string "Unknown" "This variable contains the status of open pull requests from Stash")
(defvar ma-last-repo-update nil "This variable contains the last time the repository list has been updated")
(defvar ma-repo-list nil "List of Stash projects and repositories")
(defvar ma-stash-access-headers nil "Headers needed to access Stash")
(defvar ma-open-pr-count 0 "Number of open pull-requests to review")
(defvar ma-own-pr-count 0 "Number of own pull-requests to review")
(defvar ma-num-repos-to-update 0 "Number of repositories to update")

(defun ma-init-headers ()
  "Initialize headers variable ma-stash-access-headers for Stash access"
  (let* ((pwd (password-read-and-add (concat "Stash password for user " (user-login-name) ": ") "dummy"))
         (auth (concat "Basic " (base64-encode-string (concat (user-login-name) ":" pwd)))))
    (setq ma-stash-access-headers (list '("Content-Type" . "application/json") (cons "Authorization" auth)))
    )
  )

(defun ma-update-projects-if-necessary ()
  "Update the list of projects and repositories for stash"
  (if (not (and (floatp ma-last-repo-update) (< (- (float-time) ma-last-repo-update) 3600)))
      (progn
        (message "Updating Stash project and repository list")
        (setq ma-repo-list nil)
        (request (concat ma-stash-url "/rest/api/1.0/projects")
                 :headers ma-stash-access-headers
                 :parser 'json-read
                 :sync t
                 :success (function*
                           (lambda (&key data &allow-other-keys)
                             (let* ((values (assoc-default 'values data))
                                    (result nil))
                               (dotimes (i (length values))
                                 (ma-update-repositories (assoc-default 'key (aref values i)))
                                 )
                               )
                             ))
                 )
        (setq ma-last-repo-update (float-time))
        )
    )
  )

(defun ma-update-repositories (project)
  "Returns the list of repositories for the given project"
  (request (concat ma-stash-url (format "/rest/api/1.0/projects/%s/repos" project))
           :headers ma-stash-access-headers
           :parser 'json-read
           :sync t
           :success (function*
                     (lambda (&key data &allow-other-keys)
                       (let ((values (assoc-default 'values data))
                             (result nil))
                         (progn
                           (dotimes (i (length values) result)
                             (push (assoc-default 'slug (aref values i)) result)
                             )
                           (add-to-list 'ma-repo-list (cons project result)))
                         )))
           )
  )

(defun ma-decompose-stash-info (data)
  "Decompose information delivered by Stash and put the result into ma-mode-line-string"
  (let ((values (assoc-default 'values data)))
    (progn
      (dotimes (i (length values))
        (let* ((value (aref values i))
               (author (assoc-default 'name (assoc-default 'user (assoc-default 'author value))))
               (reviewers (assoc-default 'reviewers value))
               (saw-myself-in-reviewers nil))
          (progn
            (if (string-equal author (user-login-name))
                (setq ma-own-pr-count (1+ ma-own-pr-count)))
            (dotimes (j (length reviewers))
              (let* ((reviewer (aref reviewers j))
                     (name (assoc-default 'name (assoc-default 'user reviewer)))
                     (approved (assoc-default 'approved reviewer)))
                (if (and (string-equal name (user-login-name)) (eq approved :json-false))
                    (setq saw-myself-in-reviewers t))
                ))
            (if saw-myself-in-reviewers
                (setq ma-open-pr-count (1+ ma-open-pr-count)))
            )
          )
        )
      (setq ma-num-repos-to-update (1- ma-num-repos-to-update))
      (if (= ma-num-repos-to-update 0)
          (progn
            (setq ma-mode-line-string (format "%d/%d" ma-own-pr-count ma-open-pr-count))
            (force-mode-line-update)
            )
        )
      )
    )
  )

(defun ma-update-stash-info ()
  "Provide information about the current state of Stash pull requests"
  (ma-init-headers)
  (setenv "CURL_CA_BUNDLE" ma-SIMPACK-ca-cert)
  (ma-update-projects-if-necessary)
  (setq ma-open-pr-count 0)
  (setq ma-own-pr-count 0)
  (setq ma-num-repos-to-update 0)
  (dolist (project ma-repo-list)
    (setq ma-num-repos-to-update (+ ma-num-repos-to-update (length (cdr project)))))
  
  (dolist (project ma-repo-list)
    (dolist (repo (cdr project))
      (request (concat ma-stash-url (format "/rest/api/1.0/projects/%s/repos/%s/pull-requests" (car project) repo))
               :headers ma-stash-access-headers
               :parser 'json-read
               :sync nil
               :success (function*
                         (lambda (&key data &allow-other-keys)
                           (ma-decompose-stash-info data)
                           ))
               )
      )
    )
  )

(ma-update-stash-info)
(add-to-list 'mode-line-misc-info '(" " ma-mode-line-string " ") t)
(run-with-timer 60 60 'ma-update-stash-info)

(provide 'atl-stash)
;;; atl-stash.el ends here
