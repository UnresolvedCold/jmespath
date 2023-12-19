;;; jmespath.el --- JSON query using jmespath -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2023 Shubham Kumar
;;
;; Author: Shubham Kumar <unresolved.shubham@gmail.com>
;; Maintainer: Shubham Kumar <unresolved.shubham@gmail.com>
;; Created: December 17, 2023
;; Modified: December 17, 2023
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex tools unix vc wp
;; Homepage: https://github.com/unresolvedcold/jmespath
;; Package-Requires: ((emacs "24.3") (json-mode "1.8.0"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;; Library to query json using JMESPath.
;;
;;;  Description:
;;
;; A simple jmespath parser that used jp underneath to query the json file.
;; All you need to do is run jmespath-query function and enter your jmespath query.
;; The queried result will be displayed in the *JMESPath Result* buffer
;; Note: This requires jp library to be installed.
;; More on jp - https://github.com/jmespath/jp
;;
;;; Installation:
;;
;; This needs jp installed locally in your system.
;; This utility is dependent on json-mode, please instal that too.
;;
;;; Code:

(require 'json-mode)

(defun jmespath-query (query)
  "Execute a JMESPath QUERY on the current buffer."
  (interactive "sEnter JMESPath query: ")
  (save-excursion
    (let* ((json-data (buffer-substring-no-properties (point-min) (point-max)))
           (result (shell-command-to-string (format "echo '%s' | jp '%s'" json-data query)))
           (result-buffer (get-buffer-create "*JMESPath Result*")))
      (with-current-buffer result-buffer
        (erase-buffer)
        (insert (format "JMESPath Query: %s\n\n" query))
        (insert result)
        (jsonc-mode)
        (pop-to-buffer result-buffer)))))

(provide 'jmespath)
;;; jmespath.el ends here
