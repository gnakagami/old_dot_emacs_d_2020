; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; elpy
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-python-compile ()
  "Use compile to run python programs"
  (interactive)
  (compile (concat "python " (buffer-file-name)))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; yapf
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(setq py-yapf-options `("--style", "'{based_on_style: pep8, column_limit: 100}'"))
(require 'py-yapf)
;(custom-set-variables `(py-yapf-options `("--style", "'{based_on_style: pep8, column_limit: 70}'")))
;(custom-set-variables `(py-yapf-options `("--style", "{based_on_style: google, column_limit: 100, dedent_closing_brackets=True, split_all_comma_separated_values=True}")))
;(custom-set-variables `(py-yapf-options `("--style", "{based_on_style: pep8, column_limit: 100, dedent_closing_brackets=True, split_before_first_argument=True}")))
;(custom-set-variables `(py-yapf-options `("--style", "{based_on_style: pep8, column_limit: 100, dedent_closing_brackets: True, split_before_first_argument: True, split_all_comma_separated_values: True, split_arguments_when_comma_terminated: True}")))
(custom-set-variables `(py-yapf-options `("--style", "{based_on_style: pep8, column_limit: 100}")))
;(custom-set-variables `(py-yapf-options `("--style", "google")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; elpy
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(elpy-enable)
(setq elpy-rpc-backend "rope") ; or 'jedi'
(add-hook
 'elpy-mode-hook
 (lambda ()
    (py-yapf-enable-on-save)
    (define-key elpy-mode-map "\C-c\C-c" 'my-python-compile)
    (highlight-indentation-mode -1))
)
