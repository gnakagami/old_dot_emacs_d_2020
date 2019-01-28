; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; key bind
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key "\C-h" 'delete-backward-char)
(global-set-key "\M-g" 'goto-line)

;; C-jとReturnキーのインデント位置を逆転させる
(electric-indent-mode -1)

;; globalなC-zを無効化
(global-unset-key "\C-z")

;; Move window(Shift + Cursor Key)
(windmove-default-keybindings)
(setq windmove-wrap-around t)

