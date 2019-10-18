; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------
;;  markdown mode
;; ------------------------------
;;   key-bind
;;     TAB:          見出しやツリーの折り畳み
;;     C-c C-n:      次の見出しに移動
;;     C-c C-p:      前の見出しに移動
;;     C-c ← →:    見出しレベルの上げ下げ
;;     C-c ↑ ↓:    見出しの移動
;;     M-S-Enter:    見出しの追加
;;     M-Enter:      リストの追加
;;     C-c C-d:      TODOの追加(トグル)
;;     C-c ':        コードブロックでmode編集
;;     C-c C-x ENTER バッファ内で整形表示
;;     C-c C-c p     ブラウザで表示
;; ------------------------------
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(setq markdown-preview-stylesheets (list "~/.emacs.d/css/github.css"))
