; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-
;; ------------------------------
;;  load-path
;; ------------------------------
(add-to-list 'load-path "~/.emacs.d/site-lisp")

;; ------------------------------
;;  package system
;; ------------------------------
(require 'package)
;; package repogitory
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

(unless (eq system-type 'darwin)
  (package-initialize))

;; ------------------------------
;; base setting
;; ------------------------------
;; don't backup file
(setq make-backup-files nil)

;; charactor code
(set-language-environment "UTF-8")
;(set-language-environment "Japanese")

;; import system path
(setq exec-path-from-shell-arguments '("-l"))
(exec-path-from-shell-initialize)

;; convert system-type for windows wsl
(setq-default system-type-wsl  system-type) ;; get the system-type value
(cond
 ;; If type is "gnu/linux", override to "wsl/linux" if it's WSL.
 ((eq system-type-wsl 'gnu/linux)
  (when (string-match "Linux.*Microsoft.*Linux"
                      (shell-command-to-string "uname -a"))
     (setq-default system-type-wsl "wsl/linux"))))

;; ------------------------------
;; init-loader
;; ------------------------------
(require 'init-loader)
(init-loader-load "~/.emacs.d/init.el.d/")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(c-tab-always-indent nil)
 '(helm-ff-auto-update-initial-value nil)
 '(package-selected-packages
   (quote
    (ssh py-yapf markdown-mode+ markdown-preview-mode mozc elpy migemo ein helm-gtags cmake-mode sql-indent dockerfile-mode exec-path-from-shell powershell markdown-mode markdown-preview-eww open-junk-file auto-install dracula-theme csharp-mode magit sr-speedbar yasnippet py-autopep8 jedi wgrep auto-complete helm elscreen init-loader)))
 '(tab-width 4))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
