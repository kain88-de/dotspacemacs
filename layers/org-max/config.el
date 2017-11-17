(with-eval-after-load 'org
  (setq org-agenda-files (list "~/org/organizer.org"))

  (setq org-todo-keywords
        '((sequence "TODO(t)" "WAITING FOR(w)" "SOMEDAY(s)" "|" "DONE(d!)" "CANCELED(c@)")))

  (setq org-capture-templates
        '(("p" "capture" entry (file+headline "/home/max/org/organizer.org" "Inbox")
           "* %? \n")))

  ;; setup org publish
  (setq org-export-async-debug t)
  (setq org-publish-project-alist
        '(("orgfiles"
           :base-directory "~/blog/org"
           :base-extension "org"
           :publishing-directory "~/blog/content/posts"
           :publishing-function org-md-publish-to-md
           :section-number nil
           :with-toc nil)))

  ;; this has to be wrapped otherwise spacemacs doesn't start
  (with-eval-after-load 'ox-latex
    (setq org-latex-listings 't)
    (setq org-export-backends (quote (ascii beamer html icalendar latex md)))
    (add-to-list 'org-latex-packages-alist '("" "listings"))
    (add-to-list 'org-latex-packages-alist '("" "color"))
    (add-to-list 'org-latex-classes '("revtex4-1"
                                      "\\documentclass{revtex4-1}
                                        [NO-DEFAULT-PACKAGES]
                                        [PACKAGES]
                                        [EXTRA]"
                                      ("\\section{%s}" . "\\section*{%s}")
                                      ("\\subsection{%s}" . "\\subsection*{%s}")
                                      ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                                      ("\\paragraph{%s}" . "\\paragraph*{%s}")
                                      ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

    (setq org-latex-pdf-process
          '("latexmk -shell-escape -interaction=nonstopmode -pdf -f %f"
            "latexmk -c"))
    )

  )
