; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------
;;  autocomplete
;; ------------------------------
(require 'auto-complete)
(require 'auto-complete-config)
(global-auto-complete-mode t)

(add-to-list 'ac-modes 'text-mode)         ;; enable text-mode by auto
(add-to-list 'ac-modes 'fundamental-mode)  ;; fundamental-mode
(add-to-list 'ac-modes 'org-mode)
(ac-set-trigger-key "TAB")
(setq ac-use-menu-map t)                   ;; display candidate on menu by C-n/C-p
(setq ac-use-fuzzy t)                      ;; match vague

;; (define-key ac-completing-map (kbd "C-n") 'ac-next)
;; (define-key ac-completing-map (kbd "C-p") 'ac-previous)
;; (define-key ac-completing-map (kbd "C-m") 'ac-complete)


