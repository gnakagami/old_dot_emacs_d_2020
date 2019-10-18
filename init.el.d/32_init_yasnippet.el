; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------
;;  yasnippet
;; ------------------------------
(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/mysnippets"
        "~/.emacs.d/yasnippets"
        ))

;; insert snippet
(define-key yas-minor-mode-map (kbd "C-x i i") 'yas-insert-snippet)
;; create new snippet
(define-key yas-minor-mode-map (kbd "C-x i n") 'yas-new-snippet)
;; view/edit snippet file
(define-key yas-minor-mode-map (kbd "C-x i v") 'yas-visit-snippet-file)

(yas-global-mode 1)
