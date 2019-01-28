; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; buffer
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Show candicate(M-x xxx)
(icomplete-mode 1)

;; go to current buffer when select.
(global-set-key "\C-x\C-b" 'buffer-menu)
(require 'uniquify) ;; display the directory name."
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq uniquify-ignore-buffers-re "*[^*]+*") ;; correspond to change the buffername.
(setq uniquify-min-dir-content 1) ;; display if the same file is not opned.

(let ((ws window-system))
  (cond ((eq ws 'w32) ; Windows
         ;; ミニバッファに入る時IMEを一時的にOFFにする
         (defvar my-temp-ime-mode nil)
         (defun my-into-minibuffer-func()
           (setq my-temp-ime-mode (ime-get-mode))
           (ime-force-off))
         (defun my-quit-minibuffer-func()
           (if my-temp-ime-mode (ime-force-on))
           (setq my-ime-temp nil))
         ;; 通常のミニバッファ
         (add-hook 'minibuffer-setup-hook 'my-into-minibuffer-func)
         (add-hook 'minibuffer-exit-hook 'my-quit-minibuffer-func)
         ;; インクリメンタル検索
         (add-hook 'isearch-mode-hook 'my-into-minibuffer-func)
         (add-hook 'isearch-mode-end-hook 'my-quit-minibuffer-func)
)))
