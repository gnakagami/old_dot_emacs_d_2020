; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

(defun my-python-compile ()
  "Use compile to run python programs"
  (interactive)
  (compile (concat "python " (buffer-file-name)))
  (jedi:ac-setup)
  (setq jedi:complete-on-dot t)
  (local-set-key (kbd "M-TAB") 'jedi:complete)
)

(defun my-python-mode-hook ()
  (local-set-key "\C-c\C-c" 'my-python-compile))
(add-hook 'python-mode-hook 'my-python-mode-hook)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Jedi
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(jedi:setup)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

(define-key jedi-mode-map (kbd "<C-tab>") nil) ;;C-tabはウィンドウの移動に用いる
(setq ac-sources
      (delete 'ac-source-words-in-same-mode-buffers ac-sources)) ;;jediの補完候補だけでいい
(add-to-list 'ac-sources 'ac-source-filename)
(add-to-list 'ac-sources 'ac-source-jedi-direct)
;; (define-key python-mode-map "\C-ct" 'jedi:goto-definition)
;; (define-key python-mode-map "\C-cb" 'jedi:goto-definition-pop-marker)
;; (define-key python-mode-map "\C-cr" 'helm-jedi-related-names)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; autopep8
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'py-autopep8)
(setq py-autopep8-options '("--max-line-length=200"))
(setq flycheck-flake8-maximum-line-length 200)
(py-autopep8-enable-on-save)
