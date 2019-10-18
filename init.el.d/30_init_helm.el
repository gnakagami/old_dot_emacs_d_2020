; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------
;;  helm
;; ------------------------------
(require 'helm)
(require 'helm-config)

(global-set-key (kbd "M-x")     'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-c i")   'helm-imenu)
(global-set-key (kbd "C-x b")   'helm-buffers-list)

(helm-mode 1)

(define-key helm-map            (kbd "C-h")   'delete-backward-char)            ;; C-h to delete
(define-key helm-map            (kbd "<tab>") 'helm-execute-persistent-action)
;(define-key helm-M-x-map        (kbd "<tab>") 'helm-execute-persistent-action)
(define-key helm-read-file-map  (kbd "<tab>") 'helm-execute-persistent-action)
(define-key helm-find-files-map (kbd "<tab>") 'helm-execute-persistent-action)  ;;
(define-key helm-find-files-map (kbd "C-h")   'delete-backward-char)            ;; C-h to delete

;; for waning
(setq ad-redefinition-action 'accept)

;; Helm for gtags
(require 'helm-gtags)
(setq helm-gtags-path-style 'root)
(setq helm-gtags-auto-update t)
(add-hook 'helm-gtags-mode-hook
          '(lambda ()
             (local-set-key (kbd "M-t") 'helm-gtags-find-tag)
             (local-set-key (kbd "M-r") 'helm-gtags-find-rtag)
             (local-set-key (kbd "M-s") 'helm-gtags-find-symbol)
             (local-set-key (kbd "C-t") 'helm-gtags-pop-stack)))
(add-hook 'c-mode-hook      'helm-gtags-mode)
(add-hook 'c++-mode-hook    'helm-gtags-mode)
(add-hook 'csharp-mode-hook 'helm-gtags-mode)
(add-hook 'python-mode-hook 'helm-gtags-mode)


