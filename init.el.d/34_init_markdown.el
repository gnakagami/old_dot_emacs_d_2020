; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------
;; markdown mode
;; ------------------------------
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
