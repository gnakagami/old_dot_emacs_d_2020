; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------
;;  theme
;; ------------------------------
(add-to-list
 'custom-theme-load-path
 (file-name-as-directory (concat user-emacs-directory "theme")))

(if (display-graphic-p) (load-theme 'dracula t))

;; ------------------------------
;;  white space
;; ------------------------------
(require 'whitespace)
(setq whitespace-style '(face           ; faceで可視化
                         trailing       ; 行末
                         tabs           ; タブ
                         spaces         ; スペース
                         ;empty         ; 先頭/末尾の空行
                         space-mark     ; 表示のマッピング
                         tab-mark
                         ))

(setq whitespace-display-mappings
      '((space-mark ?\u3000 [?\u25a1])
        ;; WARNING: the mapping below has a problem.
        ;; When a TAB occupies exactly one column, it will display the
        ;; character ?\xBB at that column followed by a TAB which goes to
        ;; the next TAB column.
        ;; If this is a problem for you, please, comment the line below.
        (tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])))

(setq whitespace-space-regexp "\\(\u3000+\\)")
(global-whitespace-mode 1)

;(defvar my/bg-color "#232323")
(defvar my/bg-color "#282a36")
(set-face-attribute 'whitespace-trailing nil
                    :background my/bg-color
                    :foreground "DeepPink"
                    :underline t)
(set-face-attribute 'whitespace-tab nil
                    :background my/bg-color
                    ;:foreground "LightSkyBlue"
                    :underline t)
(set-face-attribute 'whitespace-space nil
                    :background my/bg-color
                    :foreground "GreenYellow"
                    :weight 'bold)
(set-face-attribute 'whitespace-empty nil
                    :background my/bg-color)

;; ------------------------------
;;  GUI
;; ------------------------------
(if window-system
    (progn
      ;; window frame size
      (setq initial-frame-alist
            (append (list
                     ;'(top . 0) '(left . 0)
                     '(width . 80) '(height . 30))
                    initial-frame-alist))
      (setq default-frame-alist initial-frame-alist)

      ;; (set-face-attribute 'region nil :background "#666") ;; cursor color
      ;; hl-line-mode
      (global-hl-line-mode 1)
      (set-face-background 'highlight "#333")
      (set-face-foreground 'highlight nil)
      (set-face-underline-p 'highlight t)

      ;; Linux/Windows(WSL)
      (if (eq system-type 'gnu/linux)
          (progn
            (set-face-attribute 'default nil :family "RobotoJ Mono" :height 130)
            ;; Mozc
            (setq default-input-method "japanese-mozc")
            (require 'mozc)
            ;; for flicker in bellow
            ;; -> xset -r 49
            (global-set-key (kbd "<zenkaku-hankaku>") 'toggle-input-method)

            ;; helm でミニバッファの入力時に IME の状態を継承しない
            (setq helm-inherit-input-method nil)

            ;; helm の検索パターンを mozc を使って入力した場合にエラーが発生することがあるのを改善する
            (advice-add 'mozc-helper-process-recv-response
                        :around (lambda (orig-fun &rest args)
                                  (cl-loop for return-value = (apply orig-fun args)
                                           if return-value return it)))

            ;; helm の検索パターンを mozc を使って入力する場合、入力中は helm の候補の更新を停止する
            (advice-add 'mozc-candidate-dispatch
                        :before (lambda (&rest args)
                                  (when helm-alive-p
                                    (cl-case (nth 0 args)
                                      ('update
                                       (unless helm-suspend-update-flag
                                         (helm-kill-async-processes)
                                         (setq helm-pattern "")
                                         (setq helm-suspend-update-flag t)))
                                      ('clean-up
                                       (when helm-suspend-update-flag
                                         (setq helm-suspend-update-flag nil)))))))

            ;; helm で候補のアクションを表示する際に IME を OFF にする
            (advice-add 'helm-select-action
                        :before (lambda (&rest args)
                                  (deactivate-input-method)))
       ))

      ;; Windows(WSL)
      ;; (if (string= system-type-wsl "wsl/linux")
      ;;     (progn
      ;;       (....)
      ;; ))

      ;; Mac
      (if (eq system-type 'darwin)
          (progn
            ;; font
            (set-face-attribute 'default nil :family "RobotoJ Mono" :height 160)
            ;; optionキーをMetaキーに
            (setq mac-option-modifier 'meta)
            ;; cmigemo
            (require 'migemo)
            (setq migemo-command "cmigemo")
            (setq migemo-options '("-q" "--emacs"))
            ;; Set your installed path
            (setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
            (setq migemo-user-dictionary nil)





            (setq migemo-regex-dictionary nil)
            (setq migemo-coding-system 'utf-8-unix)
            (migemo-init)))
    )
    (message "Not GUI"))
