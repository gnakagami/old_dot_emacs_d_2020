; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------
;;  dired
;; ------------------------------
(load "dired-x")

;; don't new buffer in dired
(defvar my-dired-before-buffer nil)
(defadvice dired-advertised-find-file
  (before kill-dired-buffer activate)
  (setq my-dired-before-buffer (current-buffer)))
(defadvice dired-advertised-find-file
  (after kill-dired-buffer-after activate)
  (if (eq major-mode 'dired-mode)
      (kill-buffer my-dired-before-buffer)))
(defadvice dired-up-directory
  (before kill-up-dired-buffer activate)
  (setq my-dired-before-buffer (current-buffer)))
(defadvice dired-up-directory
  (after kill-up-dired-buffer-after activate)
  (if (eq major-mode 'dired-mode)
      (kill-buffer my-dired-before-buffer)))

(add-hook 'dired-mode-hook
          (lambda ()
            (define-key dired-mode-map "E" 'dired-open-explorer)
            (define-key dired-mode-map "O" 'dired-open-winapp)
            ))
(defun dired-open-explorer ()
  (interactive)
  (let ((directory (dired-current-directory)))
    (if (not (file-directory-p directory))
        (message "path isn't exist")
      (progn
        (message "Open by Explorer.")
        (start-process "open explorer" nil "cygstart" directory))
      )))

(defun dired-open-winapp ()
  (interactive)
  (let ((file (dired-get-filename)))
    (if (not (file-exists-p file))
        (message "path isn't exist")
      (progn
        (message "Open by windows application.")
        (start-process "open application" nil "cygstart" file))
      )))

;; Customize Date/Time format
;;   -L : シンボリックリンクをディレクトリとして表示
(setq dired-listing-switches
      "-alh --group-directories-first --time-style \"+%y-%m-%d %H:%M:%S\"")

;;
;; 表示項目を指定
;;
(require 'dired-details-s)
(setq dired-details-s-types
  '((size-time  . (user group size time))
    (all        . (perms links user group size time))
    (no-details . ())))
