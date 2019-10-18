; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------
;;  buffer
;; ------------------------------
;; Show candicate(M-x xxx)
(icomplete-mode 1)

;; go to current buffer when select.
(global-set-key "\C-x\C-b" 'buffer-menu)
(require 'uniquify) ;; display the directory name."
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq uniquify-ignore-buffers-re "*[^*]+*") ;; correspond to change the buffername.
(setq uniquify-min-dir-content 1) ;; display if the same file is not opned.
