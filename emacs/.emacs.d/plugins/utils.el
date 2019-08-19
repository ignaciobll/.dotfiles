;;; utils -- Summary

;;; Commentary:

;;; Code:

(defun reopen-this-file-as-sudo ()
  "Reopens this file as sudo."
  (interactive)
  (defvar file-name
  (when-let ((file-name (buffer-file-name)))
    (find-alternate-file (concat "/sudo::" file-name)))))

(provide 'utils)
;;; utils.el ends here
