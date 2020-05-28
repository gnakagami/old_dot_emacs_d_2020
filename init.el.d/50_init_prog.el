; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------
;;  compile
;; ------------------------------
;; Follow compile buffer
(setq compilation-scroll-output t)
;; Select execute file.
(setq compile-command "make")

;; ------------------------------
;;  c-mode
;; ------------------------------
(defvar my-tab-width 4)  ;;;; // -*- tab-width : 4 ; c-basic-offset : 4 -*-
;(defvar my-tab-width 8)  ;;;; // -*- tab-width : 8 ; c-basic-offset : 8 -*-
(defun my-c-mode-hook ()
  "Original C, C++ mode set up function"
  ;;(setq c-default-sytle "linux")
  (setq c-basic-offset (symbol-value 'my-tab-width))    ;; indent width
  (setq tab-width      (symbol-value 'my-tab-width))    ;; tab width
  (setq indent-tabs-mode nil)                           ;; if nil, indent is spaces.
 ;(setq c-syntactic-indentation nil)                    ;; No Indentation
 ;(setq c-tab-always-indent nil)
  (c-set-offset 'substatement-open 0)
  (c-set-offset 'case-label        4)
 ;(c-toggle-auto-hungry-stat 0)
 ;(c-toggle-auto-stat 1)
  (local-set-key "\C-c\C-c"  'compile)
  )

(add-hook 'c-mode-hook   'my-c-mode-hook)
(add-hook 'c++-mode-hook 'my-c-mode-hook)

;; ------------------------------
;;  BAT file mode
;; ------------------------------
(progn
  (setq auto-mode-alist
        (append
         (list (cons "\\.[bB][aA][tT]$" 'bat-mode))
         ;; For DOS init files
         (list (cons "CONFIG\\."   'bat-mode))
         (list (cons "AUTOEXEC\\." 'bat-mode))
         auto-mode-alist))
  (autoload 'bat-mode "bat-mode" "DOS and Windows BAT files" t)
  )

;; char-mode is sjis
(modify-coding-system-alist 'file "\\.bat\\'" 'sjis-dos)
(modify-coding-system-alist 'file "\\.sql\\'" 'sjis-dos)

;; ------------------------------
;;  shell-script
;; ------------------------------
(defun my-sh-mode-hook ()
  ""
  (interactive)
  (setq sh-basic-offset          4
        sh-indentation           4
        sh-indent-for-case-label 4
        sh-indent-for-case-alt  '+
        )
  (setq tab-width 4)
  (setq indent-tabs-mode nil))

(add-hook 'sh-mode-hook 'my-sh-mode-hook)

;; ------------------------------
;; java-mode
;; ------------------------------
(defun my-java-mode-hook ()
  ""
  (setq tab-witdh 4)
  (setq indent-tabs-mode nil)
  (setq c-basic-offset 4))

(add-hook 'java-mode-hook 'my-java-mode-hook)

;; ------------------------------
;; emacs-lisp mode
;; ------------------------------
(defun my-elisp-mode-hook ()
  ""
  (setq indent-tabs-mode nil) ;; Use spaces, not tabs.
  (put 'lambda 'lisp-indent-function 'defun)
  (put 'while  'lisp-indent-function 1)
  (put 'if     'lisp-indent-function 0)
)

(add-hook 'emacs-lisp-mode-hook 'my-elisp-mode-hook)

;; ------------------------------
;; js-mode
;; ------------------------------
(defun my-js-mode-hook ()
  "Hooks for js-mode."
  (setq tab-width 4)
  (setq js-indent-level 4)
  (setq indent-tabs-mode nil)
)

(add-hook 'js-mode-hook 'my-js-mode-hook)

;; ------------------------------
;;  power shell
;; ------------------------------
(defun my-powershell-mode-hook ()
  ""
  (setq tab-witdh 4)
  (setq indent-tabs-mode nil)
)

(add-hook 'powershell-mode-hook 'my-powershell-mode-hook)
;; char-mode is sjis
(modify-coding-system-alist 'file "\\.ps1\\'" 'sjis-dos)

;; ------------------------------
;;  c# mode
;; ------------------------------
(autoload 'csharp-mode "csharp-mode" "Major mode for editing C# code." t)
(setq auto-mode-alist
      (append '(("\\.cs$" . csharp-mode)) auto-mode-alist))

(defun my-cs-mode-hook ()
  ""
  (setq tab-witdh 4)
  (setq indent-tabs-mode nil))

;; 文字コードをSJISにする
(modify-coding-system-alist 'file "\\.cs\\'" 'sjis-dos)
;; char-mode is sjis
(add-hook 'csharp-mode-hook 'my-cs-mode-hook)
