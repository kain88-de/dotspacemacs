(with-eval-after-load 'mu4e
  (setq mu4e-maildir "~/mail/maildirs")
  ;; not using smtp-async yet
  ;; some of these variables will get overridden by the contexts
  (setq
   send-mail-function 'smtpmail-send-it
   message-send-mail-function 'smtpmail-send-it
   smtpmail-smtp-server "smtp.fastmail.com"
   smtpmail-smtp-service 465
   smtpmail-stream-type 'ssl
   )
  (setq auth-sources (quote ("~/.authinfo.gpg" "~/.netrc")))
  ;; If you get your mail without an explicit command,
  ;; use "true" for the command (this is the default)
  ;; when I press U in the main view, or C-c C-u elsewhere,
  ;; this command is called, followed by the mu indexer
  (setq mu4e-get-mail-command "mbsync --all"
        mu4e-attachment-dir "~/Downloads"
        mu4e-view-show-images t
        ;; change filename to avoid duplicate UID in mbsync
        mu4e-change-filenames-when-moving t
        mu4e-compose-dont-reply-to-self t
        mu4e-context-policy 'pick-first
        message-kill-buffer-on-exit t
        ;; mu4e-user-mail-address-list ("max_linke@gmx.de" "max.linke@biophys.mpg.de" "max.linke88@gmail.de")
        )
  (setq mu4e-contexts
        `( ,(make-mu4e-context
             :name "private max_linke@gmx.de"
             :enter-func (lambda () (mu4e-message "entering private"))
             :leave-func (lambda () (mu4e-message "leave private"))
             :match-func (lambda (msg)
                           (when msg
                             (mu4e-message-contact-field-matches msg
                                                                 :to
                                                                 "max_linke@gmx.de")))
             :vars '((user-mail-address . "max_linke@gmx.de")
                     (user-full-name    . "Max Linke")
                     (mu4e-sent-folder . "/gmx/Sent")
                     (mu4e-drafts-folder . "/gmx/Drafts")
                     (mu4e-trash-folder . "/gmx/Trash")
                     (mu4e-refile-folder . (lambda (msg)
                                             (cond
                                              ((mu4e-message-contact-field-matches msg :to "@amazon.*")
                                               "/gmx/E-Commerce.Amazon")
                                              ((mu4e-message-contact-field-matches msg :to "@kickstarter.*")
                                               "/gmx/E-Commerce.Kickstarter")
                                              ((mu4e-message-contact-field-matches msg '(:to :cc) "emacs-orgmode@gnu.org")
                                               "/gmx/MailingLists.Emacs")
                                              (t (concat "/gmx/Archives." (format-time-string "%Y"))))))
                     (smtpmail-smtp-server . "mail.gmx.net")))
           ,(make-mu4e-context
             :name "work max.linke@biophys.mpg.de"
             :enter-func (lambda () (mu4e-message "entering work"))
             :leave-func (lambda () (mu4e-message "leave work"))
             :match-func (lambda (msg)
                           (when msg
                             (mu4e-message-contact-field-matches msg
                                                                 :to
                                                                 "@biophys.mpg.de")))
             :vars '((user-mail-address . "max.linke@biophys.mpg.de")
                     (user-full-name    . "Max Linke")
                     (mu4e-sent-folder . "/mpi/Sent")
                     (mu4e-drafts-folder . "/mpi/Drafts")
                     (mu4e-trash-folder . "/mpi/Trash")
                     (mu4e-refile-folder . (lambda (msg)
                                             (cond
                                              ((mu4e-message-contact-field-matches msg :to "all@biophys.mpg.de")
                                               "/mpi/Round Mails")
                                              (t (concat "/mpi/Archives." (format-time-string "%Y"))))))
                     (smtpmail-smtp-server . "smtp.biophys.mpg.de")))
           ,(make-mu4e-context
             :name "gmail max.linke88@gmail.com"
             :enter-func (lambda () (mu4e-message "entering gmail"))
             :leave-func (lambda () (mu4e-message "leave gmail"))
             :match-func (lambda (msg)
                           (when msg
                             (mu4e-message-contact-field-matches msg
                                                                 :to
                                                                 "max.linke88@gmail.com")))
             :vars '((user-mail-address . "max.link88@gmail.com")
                     (user-full-name    . "Max Linke")
                     (mu4e-sent-folder . "/gmail/[Gmail].All Mail")
                     (mu4e-drafts-folder . "/gmail/[Gmail].Drafts")
                     (mu4e-trash-folder . "/gmail/Trash")
                     (mu4e-refile-folder . "/gmail/[Gmail].All Mail")
                     (mu4e-sent-messages-behavior . delete)
                     (smtpmail-smtp-server . "smtp.googlemail.com")))
           ))
  )
