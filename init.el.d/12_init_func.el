; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; C-Ret で矩形選択
;; 詳しいキーバインド操作：http://dev.ariel-networks.com/articles/emacs/part5/
(cua-mode t)
(setq cua-enable-cua-keys nil)
;(define-key global-map (kbd "C-x SPC") 'cua-set-rectangle-mark)

;; マルチスクリーン(elscreen)
(elscreen-start)
(setq elscreen-display-tab nil)

;;grepから検索結果を直接編集(wgrep)
;; https://raw.github.com/mhayashi1120/Emacs-wgrep/master/wgrep.el
(require 'wgrep nil t)
;;; eでwgrepモードにする
(setf wgrep-enable-key "e")
;;; wgrep終了時にバッファを保存
(setq wgrep-auto-save-buffer t)
;;; read-only bufferにも変更を適用する
(setq wgrep-change-readonly-file t)

;; GITクライアント
;(require 'magit)

;; SpeedBar
(setq sr-speedbar-right-side nil)

;; Open a junk
(require 'open-junk-file)
;(setq open-junk-file-format "~/junk/%Y-%m%d-%H%M%S.")
(setq open-junk-file-format "~/win_home/junk/%Y-%m%d-%H%M%S.")
(global-set-key "\C-xj" 'open-junk-file)
