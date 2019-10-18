; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------
;;  display setting
;; ------------------------------
;; display on mode-line
(line-number-mode t)
(column-number-mode t)
;; total lines on
(setcar mode-line-position
        '(:eval (format "%d" (count-lines (point-max) (point-min)))))

;; don't display
(setq inhibit-startup-screen t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(set-scroll-bar-mode nil)

;; display full-path on title bar
(setq frame-title-format
      (format "%%f - Emacs@%s" (system-name)))

;; conver tab to space
(setq-default indent-tabs-mode nil)

;; tab-width
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(c-tab-always-indent nil)
 '(helm-ff-auto-update-initial-value nil)
 '(package-selected-packages
   (quote
    (jedi wgrep sublime-themes helm-gtags elscreen csharp-mode auto-complete)))
 '(tab-width 4))

;; input "yes or no" converts to "y or n"
(fset 'yes-or-no-p 'y-or-n-p)

;; row-space
(setq-default line-spacing 0)

;; hi-light bracket((), {}...)
(show-paren-mode t)
