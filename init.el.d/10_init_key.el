; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------
;;  key bind
;; ------------------------------
(global-set-key "\C-h" 'delete-backward-char)
(global-set-key "\M-g" 'goto-line)

;; invert C-j and Return key
(electric-indent-mode -1)

;; invalid global C-z
(global-unset-key "\C-z")

;; move window(Shift + Cursor Key)
(windmove-default-keybindings)
(setq windmove-wrap-around t)

