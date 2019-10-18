; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------
;;  cur-mode (rectangle select)
;;   http://dev.ariel-networks.com/articles/emacs/part5/
;; ------------------------------
(cua-mode t)
(setq cua-enable-cua-keys nil)
(define-key global-map (kbd "C-x SPC") 'cua-set-rectangle-mark)

;; ------------------------------
;;  elscreen (multi-screen)
;; ------------------------------
(elscreen-start)
(setq elscreen-display-tab nil)

;; ------------------------------
;;  wgrep (direct editing on grep result)
;; ------------------------------
(require 'wgrep nil t)
;; enter "e", enter wgrep-mode
(setf wgrep-enable-key "e")
;; save buffer when exit wgrep.
(setq wgrep-auto-save-buffer t)
;; adapt changing on read-only buffer
(setq wgrep-change-readonly-file t)

;; ------------------------------
;;  magit (git client)
;; ------------------------------
(require 'magit)

;; ------------------------------
;;  speedbar
;; ------------------------------
(setq sr-speedbar-right-side nil)

;; ------------------------------
;;  junk-file
;; ------------------------------
(require 'open-junk-file)
(if (eq system-type 'gnu/linux)
    (setq junk-dir-root "~/win_home/sources/junk")
    (setq junk-dir-root "~/works/junk"))
(setq open-junk-file-format (concat junk-dir-root "/%y%m%d-%H%M%S."))
(global-set-key "\C-xj" 'open-junk-file)

;; ------------------------------
;;  ssh
;; ------------------------------
(require 'tramp)
(setq tramp-default-method "ssh")

;; ------------------------------
;;  insert date text
;; ------------------------------
(defun my-insert-date () ;; date
  (interactive)
  (setq system-time-locale "C")
  (insert (concat
           (format-time-string "%Y/%m/%d")
          ;(format-time-string "%Y/%m/%d(%a) %H:%M:%S"))))
           )))
(defun my-insert-time () ;; time
  (interactive)
  (setq system-time-locale "C")
  (insert (concat
           (format-time-string "%H:%M:%S")
          ;(format-time-string "%Y/%m/%d(%a) %H:%M:%S"))))
           )))
(global-set-key [(control ?\;)] 'my-insert-date)
(global-set-key [(control ?\:)] 'my-insert-time)
