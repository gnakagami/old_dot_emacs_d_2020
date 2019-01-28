; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; 簡単メモツール
(load "easy-memo")
(setq memo-work-dir "~/.emacs.d/memo")  ; 保存先
(setq memo-view-is-show-when-updown nil)

;; 日付挿入
(defun my-insert-date ()
  (interactive)
  (setq system-time-locale "C")
  (insert (concat
           (format-time-string "%Y/%m/%d")
          ;(format-time-string "%Y/%m/%d(%a) %H:%M:%S"))))
           )))

;; 日付挿入
(defun my-insert-time ()
  (interactive)
  (setq system-time-locale "C")
  (insert (concat
           (format-time-string "%H:%M:%S")
          ;(format-time-string "%Y/%m/%d(%a) %H:%M:%S"))))
           )))


(global-set-key [(control ?\;)] 'my-insert-date)
(global-set-key [(control ?\:)] 'my-insert-time)
;(global-set-key "\C-h" 'delete-backward-char)
