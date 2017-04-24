;;; packages.el --- C/C++ Layer packages File for Spacemacs
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(setq cpp-packages
  '(
    cc-mode
    disaster
    clang-format
    cmake-mode
    cmake-ide
    company
    (company-c-headers :toggle (configuration-layer/package-usedp 'company))
    flycheck
    gdb-mi
    ggtags
    helm-cscope
    helm-gtags
    irony
    rtags
    semantic
    srefactor
    stickyfunc-enhance
    xcscope
    ))

(defun cpp/init-cc-mode ()
  (use-package cc-mode
    :defer t
    :init
    (progn
      (add-to-list 'auto-mode-alist
                   `("\\.h\\'" . ,cpp-default-mode-for-headers)))
    :config
    (progn
      (require 'compile)
      (c-toggle-auto-newline 1)
      (spacemacs/set-leader-keys-for-major-mode 'c-mode
        "ga" 'projectile-find-other-file
        "gA" 'projectile-find-other-file-other-window)
      (spacemacs/set-leader-keys-for-major-mode 'c++-mode
        "ga" 'projectile-find-other-file
        "gA" 'projectile-find-other-file-other-window))))

(defun cpp/init-disaster ()
  (use-package disaster
    :defer t
    :commands (disaster)
    :init
    (progn
      (spacemacs/set-leader-keys-for-major-mode 'c-mode
        "D" 'disaster)
      (spacemacs/set-leader-keys-for-major-mode 'c++-mode
        "D" 'disaster))))

(defun cpp/init-clang-format ()
  (use-package clang-format
    :if cpp-enable-clang-support
    :init
    (spacemacs/set-leader-keys-for-major-mode 'c-mode
      "=" 'max/format-region-or-buffer)
    (spacemacs/set-leader-keys-for-major-mode 'c++-mode
      "=" 'max/format-region-or-buffer)
    (when cpp-enable-clang-format-on-save
      (spacemacs/add-to-hooks 'spacemacs/clang-format-on-save
                              '(c-mode-hook c++-mode-hook)))))

(defun cpp/init-cmake-mode ()
  (use-package cmake-mode
    :mode (("CMakeLists\\.txt\\'" . cmake-mode) ("\\.cmake\\'" . cmake-mode))))

(defun cpp/init-cmake-ide ()
  (use-package cmake-ide
    :config
    (cmake-ide-setup)))

(defun cpp/post-init-company ()
  (when (configuration-layer/package-usedp 'cmake-mode)
    (spacemacs|add-company-backends :backends company-cmake :modes cmake-mode))
  (when (configuration-layer/package-usedp 'company-c-headers)
    (spacemacs|add-company-backends :backends company-c-headers :modes c-mode-common))
  (when cpp-enable-clang-support
    (spacemacs|add-company-backends :backends company-clang
      :modes c-mode-common)
    (spacemacs|add-company-backends :backends company-rtags :modes c-mode-common)
    (setq company-clang-prefix-guesser 'spacemacs/company-more-than-prefix-guesser)
    (setq company-clang-arguments '("-std=c++11"))
    (spacemacs/add-to-hooks 'spacemacs/cpp-load-clang-args
                            '(c-mode-hook c++-mode-hook))))

(defun cpp/init-company-c-headers ()
  (use-package company-c-headers
    :defer t))

(defun cpp/post-init-flycheck ()
  (dolist (mode '(c-mode c++-mode))
    (spacemacs/enable-flycheck mode))
  (when cpp-enable-clang-support
    (setq-default flycheck-clang-language-standard "c++11")
    (spacemacs/add-to-hooks 'spacemacs/cpp-load-clang-args '(c-mode-hook c++-mode-hook))))

(defun cpp/post-init-ggtags ()
  (add-hook 'c-mode-local-vars-hook #'spacemacs/ggtags-mode-enable)
  (add-hook 'c++-mode-local-vars-hook #'spacemacs/ggtags-mode-enable))

(defun cpp/init-gdb-mi ()
  (use-package gdb-mi
    :defer t
    :init
    (setq
     ;; use gdb-many-windows by default when `M-x gdb'
     gdb-many-windows t
     ;; Non-nil means display source file containing the main routine at startup
     gdb-show-main t)))

(defun cpp/post-init-helm-gtags ()
  (spacemacs/helm-gtags-define-keys-for-mode 'c-mode)
  (spacemacs/helm-gtags-define-keys-for-mode 'c++-mode))

(defun cpp/init-irony ()
  (use-package irony
    :config
    (add-hook 'irony-mode-hook 'max/irony-mode-hook)
    (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)))

(defun cpp/init-rtags ()
  (use-package rtags))

(defun cpp/post-init-semantic ()
  (spacemacs/add-to-hooks 'semantic-mode '(c-mode-hook c++-mode-hook)))

(defun cpp/post-init-srefactor ()
  (spacemacs/set-leader-keys-for-major-mode 'c-mode "r" 'srefactor-refactor-at-point)
  (spacemacs/set-leader-keys-for-major-mode 'c++-mode "r" 'srefactor-refactor-at-point)
  (spacemacs/add-to-hooks 'spacemacs/lazy-load-srefactor '(c-mode-hook c++-mode-hook)))

(defun cpp/post-init-stickyfunc-enhance ()
  (spacemacs/add-to-hooks 'spacemacs/lazy-load-stickyfunc-enhance '(c-mode-hook c++-mode-hook)))

(defun cpp/pre-init-xcscope ()
  (spacemacs|use-package-add-hook xcscope
    :post-init
    (dolist (mode '(c-mode c++-mode))
      (spacemacs/set-leader-keys-for-major-mode mode "gi" 'cscope-index-files))))

(defun cpp/pre-init-helm-cscope ()
  (spacemacs|use-package-add-hook xcscope
    :post-init
    (dolist (mode '(c-mode c++-mode))
      (spacemacs/setup-helm-cscope mode))))
