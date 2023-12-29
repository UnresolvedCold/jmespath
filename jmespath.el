;;; jmespath.el --- Query JSON using jmespath -*- lexical-binding: t; -*-

;; Copyright (C) 2023 Shubham Kumar

;; Author: Shubham Kumar <unresolved.shubham@gmail.com>
;; Maintainer: Shubham Kumar <unresolved.shubham@gmail.com>
;; Created: December 17, 2023
;; Modified: December 17, 2023
;; Version: 0.0.1
;; Keywords: json, data, languages, tools
;; Homepage: https://github.com/unresolvedcold/jmespath
;; Package-Requires: ((emacs "24.3"))

;; This file is not part of GNU Emacs.

;; Permission is hereby granted, free of charge, to any person obtaining a copy
;; of this software and associated documentation files (the "Software"), to deal
;; in the Software without restriction, including without limitation the rights
;; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
;; copies of the Software, and to permit persons to whom the Software is
;; furnished to do so, subject to the following conditions:

;; The above copyright notice and this permission notice shall be included in all
;; copies or substantial portions of the Software.

;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
;; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
;; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
;; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
;; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
;; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
;; SOFTWARE.

;;; Commentary:

;; A simple jmespath parser that uses jp underneath to query the json file.  All
;; you need to do is run the `jmespath-query' function and enter your jmespath
;; query.  The queried result will be displayed in the *JMESPath Result* buffer

;; This package depends on the jp utility: https://github.com/jmespath/jp

;;; Code:

(defun jmespath-query (query)
  "Execute a JMESPath QUERY on the current buffer."
  (interactive "sEnter JMESPath query: ")
  (save-excursion
    (let* ((json-data (buffer-substring-no-properties (point-min) (point-max)))
           (quoted-json-data (shell-quote-argument json-data))
           (quoted-query (shell-quote-argument query))
           (result (shell-command-to-string (format "echo %s | jp %s" quoted-json-data quoted-query)))
           (result-buffer (get-buffer-create "*JMESPath Result*")))
      (with-current-buffer result-buffer
        (erase-buffer)
        (insert (format "JMESPath Query: %s\n\n" query))
        (insert result)
        (pop-to-buffer result-buffer)))))

(provide 'jmespath)
;;; jmespath.el ends here
