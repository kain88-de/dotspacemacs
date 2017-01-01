(setq org-journal-packages
      '(org-journal))


(defun org-journal/init-org-journal ()
    "install and initialize org-journal"
    (use-package org-journal
      :commands (org-journal-new-entry)
      :config
      (setq org-journal-dir "~/org/journal/")
      (setq org-journal-file-format "%Y-%m-%d.org")
      (setq org-journal-file-pattern (org-journal-format-string->regex "%Y-%m-%d.org"))
      (setq org-journal-time-format "")
      (org-journal-update-auto-mode-alist)))
