(setq org-max-packages
      '(ob-ipython))


(defun org-max/init-ob-ipython ()
  "install ob-ipython"
  (use-package ob-ipython
    :config
    (org-babel-do-load-languages
     'org-babel-load-languages
     '((emacs-lisp . t)
       (calc . t)
       (ipython . t)
       (python . t)))
    ))
