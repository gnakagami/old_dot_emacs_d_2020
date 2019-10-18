; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------
;;  elpy
;; ------------------------------
(elpy-enable)
(setq elpy-rpc-backend "rope") ; or 'jedi'

(defun my-python-compile ()
  "Use compile to run python programs"
  (interactive)
  (compile (concat "python " (buffer-file-name)))
)

(add-hook
 'elpy-mode-hook
 (lambda ()
   (auto-complete-mode -1)
   ;; (py-yapf-enable-on-save)
   (define-key elpy-mode-map "\C-c\C-c" 'my-python-compile)
   (highlight-indentation-mode -1))
)

;; ------------------------------
;;  yapf
;; ------------------------------
(require 'py-yapf)

;; ------------------------------
;;  ein for editing jupyter-notebook
;; ------------------------------
(require 'ein)

