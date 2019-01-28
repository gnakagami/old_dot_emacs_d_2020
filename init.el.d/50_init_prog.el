; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Compile
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Follow compile buffer
(setq compilation-scroll-output t)

;; Select execute file.
(setq compile-command "make")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; c-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; BAT File Mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; shell-script
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-sh-mode-hook ()
  ""
  (interactive)
  (setq sh-basic-offset          4
        sh-indentation           4
        sh-indent-for-case-label 4
        sh-indent-for-case-alt  '+
        )
  (setq tab-width 4)
  (setq indent-tabs-mode nil)
  )
(add-hook 'sh-mode-hook 'my-sh-mode-hook)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; java-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-java-mode-hook ()
  ""
  (setq tab-witdh 4)
  (setq indent-tabs-mode nil)
  (setq c-basic-offset 4))
(add-hook 'java-mode-hook 'my-java-mode-hook)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; emacs-lisp mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-elisp-mode-hook ()
  ""
  (setq indent-tabs-mode nil) ;; Use spaces, not tabs.
  (put 'lambda 'lisp-indent-function 'defun)
  (put 'while  'lisp-indent-function 1)
  (put 'if     'lisp-indent-function 0)
)

(add-hook 'emacs-lisp-mode-hook 'my-elisp-mode-hook)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; js-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-js-mode-hook ()
  "Hooks for js-mode."
  (setq tab-width 4)
  (setq js-indent-level 4)
  (setq indent-tabs-mode nil)
)
(add-hook 'js-mode-hook 'my-js-mode-hook)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Power shell
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-powershell-mode-hook ()
  ""
  (setq tab-witdh 4)
  (setq indent-tabs-mode nil)
)
(add-hook 'powershell-mode-hook 'my-powershell-mode-hook)
;; 文字コードをSJISにする
(modify-coding-system-alist 'file "\\.ps1\\'" 'sjis)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; c# mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'csharp-mode "csharp-mode" "Major mode for editing C# code." t)
(setq auto-mode-alist
      (append '(("\\.cs$" . csharp-mode)) auto-mode-alist))

(defun my-cs-mode-hook ()
  ""
  (setq tab-witdh 4)
  (setq indent-tabs-mode nil))

(add-hook 'csharp-mode-hook 'my-cs-mode-hook)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SQL Mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C-c C-c : 'sql-send-paragraph
;; C-c C-r : 'sql-send-region
;; C-c C-s : 'sql-send-string
;; C-c C-b : 'sql-send-buffer
;; (require 'sql)

;; (add-hook 'sql-interactive-mode-hook
;;           #'(lambda ()
;;               (interactive)
;;               (set-buffer-process-coding-system 'sjis-unix 'sjis-unix )
;;               (setq show-trailing-whitespace nil)))

;; ;; starting SQL mode loading sql-indent / sql-complete
;; (eval-after-load "sql"
;;   '(progn
;;      (load-library "sql-indent")
;;      (load-library "sql-complete")
;;      (load-library "sql-transform")))

;; (setq auto-mode-alist
;;       (cons '("\\.sql$" . sql-mode) auto-mode-alist))

;; (sql-set-product-feature
;;  'ms :font-lock 'sql-mode-ms-font-lock-keywords)

;; (defcustom sql-ms-program "sqlcmd"
;;   "Command to start sqlcmd by SQL Server."
;;   :type 'file
;;   :group 'SQL)

;; (sql-set-product-feature
;;  'ms :sql-program 'sql-ms-program)
;; (sql-set-product-feature
;;  'ms :sqli-prompt-regexp "^[0-9]*>")
;; (sql-set-product-feature
;;  'ms :sqli-prompt-length 5)

;; (defcustom sql-ms-login-params
;;   '(user password server database)
;;   "Login parameters to needed to connect to mssql."
;;   :type '(repeat (choice
;;                   (const user)
;;                   (const password)
;;                   (const server)
;;                   (const database)))
;;   :group 'SQL)

;; (defcustom sql-ms-options '("-U" "-P" "-S" "-d")
;;   "List of additional options for `sql-ms-program'."
;;   :type '(repeat string)
;;   :group 'SQL)

;; (defun sql-connect-ms ()
;;   "Connect ti SQL Server DB in a comint buffer."
;;   ;; Do something with `sql-user', `sql-password',
;;   ;; `sql-database', and `sql-server'.
;;   (let ((f #'(lambda (op val)
;;                (unless (string= "" val)
;;                  (setq sql-ms-options
;;                        (append (list op val) sql-ms-options)))))
;;         (params `(("-U" . ,sql-user)("-P" . ,sql-password)
;;                   ("-S" . ,sql-server)("-d" . ,sql-database))))
;;     (dolist (pair params)
;;       (funcall f (car pair)(cdr pair)))
;;     (sql-connect-1 sql-ms-program sql-ms-options)))

;; (sql-set-product-feature
;;  'ms :sqli-login 'sql-ms-login-params)
;; (sql-set-product-feature
;;  'ms :sqli-connect 'sql-connect-ms)

;; (defun run-mssql ()
;;   "Run mssql by SQL Server as an inferior process."
;;   (interactive)
;;   (sql-product-interactive 'ms))

;; (eval-after-load "sql"
;;   '(load-library "sql-indent"))


