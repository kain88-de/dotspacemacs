(with-eval-after-load 'org
  (setq org-agenda-files (list "~/Dropbox/org/"))

  (setq org-todo-keywords
        '((sequence "TODO(t)" "WAITING FOR(w)" "SOMEDAY(s)" "NEXT(n)" "|" "DONE(d!)" "CANCELED(c@)")))

  (setq org-capture-templates
        '(("p" "capture" entry (file+headline "/home/max/Dropbox/org/organizer.org" "Inbox")
           "* %? \n")))

  ;; Agenda views
  (setq org-agenda-custom-commands
        '(
          ("n" todo "NEXT")
          ("d" "Agenda + Next Actions" ((agenda) (todo "NEXT")))
          )
        )
)
