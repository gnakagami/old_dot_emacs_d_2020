;-*- Emacs-Lisp -*-
;; ----------------------------------------------------
;; ファイル名 :
;;   easy-memo.el
;;
;; 概要 :
;;   簡単にメモを取れるようことを目的としてEmacs Lisp
;;
;; 作成日 :
;;   v1.0 - 2011/10/12(水)
;; 作成者 :
;;   g.nakagami
;;
;; 使い方 :
;;  .emacsに以下の内容を記載
;;    ;; easy-memo.elをロード
;;    (load "easy-memo")
;;    ;; memoファイル保存場所
;;    (setq memo-work-dir "memoファイルを保存したいディレクトリ")
;;
;;  後は、"M-x memo"で、memo-work-dir以下にファイルを生成して開く
;;
;;  作成したファイルの一覧を表示できるモードを用意
;;   "M-x memo-view"で、memo-viewモードに移行
;;
;;   [f], [b],[左] [右] : 月移動
;;   [n], [p],[上] [下] : 上下移動
;;   [Return] : 表示 & カーソル移動
;;   [Shift]  : 表示
;;
;; オプション :
;;   memo-view-is-show-when-updown : 上下移動するときに同時にファイルも開く
;;    例).emacsに記載
;;      (setq memo-view-is-show-when-updown t) ;; t or nil
;;
;; コマンドサンプル：
;;   メモツール
;;   (load "easy-memo")
;;   (setq memo-work-dir "c:/gnakagami/works/memo")	;; 保存場所
;;   (setq memo-view-is-show-when-updown nil)	;; 上下移動と同時にファイルは開かない
;;
;; ----------------------------------------------------

;; ************************************************************************************
;; memo
;; ************************************************************************************
;; ----------------------------------------
;; 関数名 : memo-find-file
;; 概要   : ファイルを開く
;; ----------------------------------------
(defun memo-find-file (work-dir year month day)
  (let ((dir (concat work-dir "/" year "/" month)))
    (if (file-directory-p dir)
	(find-file (expand-file-name (concat dir "/" year month day "_memo.txt")))
      (message "ファイルを開けません")
      )
    )
  )

;; ----------------------------------------
;; 関数名 : memo-rename-and-find-file
;; 概要   : すでにあるファイルは名前を変えて新しいファイルを開く
;; ----------------------------------------
(defun memo-rename-and-find-file (work-dir year month day)
  (let ((dir  (concat work-dir "/" year "/" month))
		(file (concat work-dir "/" year "/" month "/" year month day "_memo.txt")))
    (if (file-directory-p dir)
	(progn
	  ;; すでにファイルがある場合
	  (if (file-exists-p (expand-file-name file))
	      (let ((i 1) (i-max 100))
		(while (<= i i-max)
		  (setq rename-file-name (concat dir "/" year month day "_memo_" (format "%03d" i) ".txt"))
		  (if (not (file-exists-p (expand-file-name rename-file-name)))
		      (progn
				;; リネームする
				(rename-file (expand-file-name file) (expand-file-name rename-file-name))
				;; バッファがない場合は何もしない
				(if (get-file-buffer (expand-file-name file))
					(kill-buffer (get-file-buffer (expand-file-name file))))
				(setq i (+ i-max 1))
				)
		    (setq i (+ i 1))
		    )
		  )
		)
	    )
	  (find-file file)
	  )
      (message "ファイルを開けません")
      )
    )
  )

;; ----------------------------------------
;; 関数名 : memo-make-dir
;; 概要   : 年/月のディレクトリを作成する
;; ----------------------------------------
(defun memo-make-dir (work-dir year month)
  ;; 作業ディレクトリがあるかチェック
  (if (file-directory-p memo-work-dir)
      (progn
	;; 年のディレクトリ
	(if (not (file-directory-p (concat work-dir "/" year)))
	    (eshell-command (concat "mkdir" " " work-dir "/" year)))
	;; 月のディレクトリ
	(if (not (file-directory-p (concat work-dir "/" year "/" month)))
	    (eshell-command (concat "mkdir" " " work-dir "/" year "/" month)))
	;; ディレクトリができているかを返す
	(file-directory-p (concat work-dir "/" year "/" month))
	)
    nil    ;; 作業ディレクトリがない
    )
  )

;; すでにある日付のメモがあるときは新規に作成
(defun memo-new ()
  "すでにある日付のメモがあるときは新規に作成"
  (interactive)			;; 引数なし
  (let ((year  (format-time-string "%Y"))
	(month (format-time-string "%m"))
	(day   (format-time-string "%d")))
    ;; 年月のフォルダを作成
    (if (memo-make-dir memo-work-dir year month)
	;; 現在の日付のファイルを開く 今はあるものは退避
	(memo-rename-and-find-file memo-work-dir year month day)
      (message "ディレクトリの作成に失敗しました")
      )
    )
  )

;; ----------------------------------------
;; メモモード本体
;; ----------------------------------------
(defun memo ()
  "簡易メモ帳として日付に結びついたファイルを開きます"
  (interactive)			;; 引数なし
  ;(defun memo-work-dir "c:/nakagami/works/memo") ;; メモ用ディレクトリ
  (defun memo-work-dir "~/") ;; メモ用ディレクトリ
  (let ((year  (format-time-string "%Y"))
	(month (format-time-string "%m"))
	(day   (format-time-string "%d")))
    ;; 年月のフォルダを作成
    (if (memo-make-dir memo-work-dir year month)
	;; 現在の日付のファイルを開く
	(memo-find-file memo-work-dir year month day)
      (message "ディレクトリの作成に失敗しました")
      )
    )
  )

;; ************************************************************************************
;; memo-view
;; ************************************************************************************
;; ----------------------------------------
;; フレームの生成
;; ----------------------------------------
(defun memo-view-make-frame ()
  ;; フレーム内のウィンドウを1つにする
  (if (not (one-window-p)) (delete-other-windows))
  ;; ウィンドウ情報の保存
  (setq memo-view-disp-win (selected-window))
  ;; ウィンドウの高さを取得(window-height)して、
  ;; 現在のウィンドウ(selected-window)を、下側15行空けて分割する
  (split-window (selected-window) (- (window-height) 15) nil)
  ;; 下のウィンドウに移動する
  (other-window 1)
  ;; --------------------
  ;; カレンダー用バッファを作成
  ;; --------------------
  (switch-to-buffer memo-cal-buffer)
  ;; ウィンドウにカレンダー用バッファを表示
  (set-window-buffer (selected-window) memo-cal-buffer)
  ;; 読み取り専用にする
  (setq buffer-read-only 1)
  ;; ウィンドウ情報の保存
  (setq memo-view-cal-win (selected-window))
  ;; ウィンドウを左右に分割
  (split-window (selected-window) 35 1)
  ;; 下のウィンドウに移動する
  (other-window 1)
  ;; --------------------
  ;; リスト用バッファ作成
  ;; --------------------
  ;; バッファを切換(なければ新規作成)
  (switch-to-buffer memo-list-buffer)
  ;; ウィンドウにリスト用バッファを表示
  (set-window-buffer (selected-window) memo-list-buffer)
  ;; 読み取り専用にする
  (setq buffer-read-only 1)
  ;; ウィンドウ情報の保存
  (setq memo-view-win (selected-window))
  )


;; ----------------------------------------
;; 指定した日付のメモがリストにあるか確認
;; ----------------------------------------
(defun memo-view-check-memo-exist (year month day)
  (let ((i 0) (exist nil)
		(memo-name "")
		(memo-date (format "%04d%02d%02d" year month day)))
	(while (and (< i memo-view-memonum) (not exist))
	  (setq memo-name (nth i memo-view-memolist))
	  (if (> (length memo-name) (length memo-date))
		  (if (string= memo-date (substring memo-name 0 (length memo-date)))
			  (setq exist t)
			)
		)
	  (setq i (+ i 1))
	  )
	;; 結果を返す
	exist
	)
  )

;; ----------------------------------------
;; 月の日数を取得
;; ----------------------------------------
(defun memo-view-get-day-of-month (year month) ;; 数値
  (let ((next-year 1) (next-month 1))
	(if (>= month 12)
		(progn
		  (setq next-year (+ year 1) next-month 1)
		  )
	  (setq next-year year next-month (+ month 1))
	  )
	;; 日に0を渡すことで、前月の最後の日を取得する
	(string-to-int (format-time-string "%d" (encode-time 0 0 0 0 next-month next-year)))
	)
  )

;; ----------------------------------------
;; 月の始まりの曜日を取得(0:月-6:日)
;; ----------------------------------------
(defun memo-view-get-start-week (year month) ;; 数値
  (% (+ (string-to-int (format-time-string "%w" (encode-time 0 0 0 1 month year))) 6) 7)
  )

;; ----------------------------------------
;; カレンダーの描画
;; ----------------------------------------
(defun memo-view-make-calendar ()
  (interactive)
  (set-buffer memo-cal-buffer)
  ;; 読み取り専用解除
  (setq buffer-read-only nil)
  ;; 表示を消す
  (erase-buffer)
  (insert (concat "         " memo-view-cur-year "年" memo-view-cur-month "月" "\n"))
  ;; カレンダー
  (let ((year (string-to-int memo-view-cur-year)) (month (string-to-int memo-view-cur-month))
		(day 1) (day-max 1)
		(start-flg nil) (start-week 0)
		(i 0) (j 0)
		(exist-line-str "") (memo-exist-str " ￣") (memo-not-exist-str "   ")
		(week 0) (week-list (list "mon" "tue" "wed" "thu" "fri" "sat" "sun")))
	(setq day-max (memo-view-get-day-of-month year month))
	(setq start-week (memo-view-get-start-week year month))
	(while (<= day day-max)
	  (setq week 0 exist-line-str " ")	  ;; 週単位で初期化するもの
	  (insert " ")
	  (while (< week 7)
		(if (= i 0)
		    ;; 曜日表示
		    (insert (nth week week-list))
		  ;; カレンダー表示
		  (progn
			;; 開始曜日をチェック
		    (if (= week start-week) (setq start-flg t))
			;; 日表示
			(if start-flg
				(progn
				  (insert (format "%3d" day))
				  (if (memo-view-check-memo-exist year month day)
					  (setq exist-line-str (concat exist-line-str memo-exist-str))
					(setq exist-line-str (concat exist-line-str memo-not-exist-str)))
				  (setq day (+ day 1))
				  ;; 無理矢理終わらせる
				  (if (> day day-max) (setq week 7))
				  )
			  (progn
				(insert "   ")
				(setq exist-line-str (concat exist-line-str memo-not-exist-str))
				)
		      )
		    )
		  )
		(if (< week 6)
			(progn
			  (insert " ")
			  (setq exist-line-str (concat exist-line-str " "))
			  )
		  )
		(setq week (+ week 1))
		)
	  (insert "\n")
	  (if (> i 0) (progn (insert exist-line-str) (insert "\n")))
	  (setq i (+ i 1))
	  )
	  ;;(if (< i 7) (insert "\n"))
	  ;;(insert "\n")
	)
  ;; 読み取り専用にする
  (setq buffer-read-only 1)
  )

;; ----------------------------------------
;; リストの作成
;; ----------------------------------------
(defun memo-view-make-list (year month day)
  (set-buffer memo-list-buffer)
  (setq memo-view-cur-year year memo-view-cur-month month memo-view-cur-day day)
  ;; 読み取り専用解除
  (setq buffer-read-only nil)
  ;; 表示を消す
  (erase-buffer)
  ;; リスト生成
  (if (not (file-directory-p memo-work-dir))
      (insert (concat " 作業ディレクトリがありません : " memo-work-dir "\n" ))
    (progn
      ;; ファイルをリストで表示
      (setq memo-view-memolist (directory-files (concat memo-work-dir "/" memo-view-cur-year "/" memo-view-cur-month) nil "\\.txt" nil))
      (setq memo-view-memonum  (safe-length memo-view-memolist))
      ;;(message (concat "filenum : " (int-to-string memo-view-memonum) " : " (int-to-string (safe-length memo-view-memolist))))
	  (insert (concat memo-work-dir "/" memo-view-cur-year "/" memo-view-cur-month "\n"))
      (if (= 0 memo-view-memonum)
		  (insert " ファイルがありません")
		(progn
		  ;; リスト
		  (let ((i 0))
			(while (< i memo-view-memonum)
			  (insert (concat " " (nth i memo-view-memolist)))
			  (setq i (+ i 1))
			  (if (< i memo-view-memonum) (insert "\n"))
			  )
			)
		  )
		)
      )
    )
  ;; 読み取り専用にする
  (setq buffer-read-only 1)
  ;; カレンダーの描画
  (memo-view-make-calendar)
  (set-buffer memo-list-buffer)
  )

;; ----------------------------------------
;; 現在のカーソル行を取得
;; ----------------------------------------
(defun memo-view-get-cur-line ()
  (string-to-int (substring (what-line) (length "Line ") (length (what-line))))
  )

;; ----------------------------------------
;; カーソルの行移動
;; ----------------------------------------
(defun memo-view-move-cur (cur)
  (setq memo-view-cursor cur)
  (goto-line memo-view-cursor)
  (beginning-of-line)
  )

;; ----------------------------------------
;; カーソルを初期位置に移動させる
;; ----------------------------------------
(defun memo-view-init-cur ()
  (memo-view-move-cur memo-view-init-line)
  )

;; ----------------------------------------
;; リスト変数memolistからメモのパスを取得する
;; ----------------------------------------
(defun memo-view-get-path-from-memolist (index)
  (if (and (< index (safe-length memo-view-memolist)) (file-directory-p memo-work-dir))
	  (concat memo-work-dir "/" memo-view-cur-year "/" memo-view-cur-month "/" (nth index memo-view-memolist))
	)
  )

;; ----------------------------------------
;; memoファイルを開く
;; ----------------------------------------
(defun memo-view-open-memo-file (cur do-move)
  ;; カーソルの範囲チェック
  (if (>= cur memo-view-init-line)
	  (let ((file-path (memo-view-get-path-from-memolist (- cur memo-view-init-line))))
		 (if (file-exists-p (expand-file-name file-path))
			 (let ((cur-win (selected-window)))
			   ;;(other-window 1)
			   (if (windowp memo-view-disp-win) (select-window memo-view-disp-win) (ohter-window 1))
			   (find-file file-path)
			   ;; do-moveがtのときのみ、カーソルをメモ側に移す
			   (if (not do-move) (select-window cur-win))
			   )
		   (message (concat file-path " は、ありません"))
		   )
		 )
	(message "カーソル位置にメモがありません")
	)
  )

;; ----------------------------------------
;; カーソル位置にあるファイルを開く
;; ----------------------------------------
(defun memo-view-open-cur-file (do-move)
  (memo-view-open-memo-file (memo-view-get-cur-line) do-move)
  )

;; ----------------------------------------
;; 次の月へ移動
;; ----------------------------------------
(defun memo-view-next-month ()
  (interactive)	;; 引数なし
  ;; 次の月に移動
  (let ((next-year  (format-time-string "%Y" (encode-time 0 0 0 (string-to-int memo-view-cur-day) (+ (string-to-int memo-view-cur-month) 1) (string-to-int memo-view-cur-year))))
		(next-month (format-time-string "%m" (encode-time 0 0 0 (string-to-int memo-view-cur-day) (+ (string-to-int memo-view-cur-month) 1) (string-to-int memo-view-cur-year))))
		(next-date  (format-time-string "%d" (encode-time 0 0 0 (string-to-int memo-view-cur-day) (+ (string-to-int memo-view-cur-month) 1) (string-to-int memo-view-cur-year))))
		)
	;;(message (concat next-year "/" next-month "/" next-date))
	(memo-view-make-list next-year next-month next-date)
	;; カーソル位置初期化
	(memo-view-init-cur)
	)
  )

;; ----------------------------------------
;; 前の月へ移動
;; ----------------------------------------
(defun memo-view-prev-month ()
  (interactive)	;; 引数なし
  ;; 前の月に移動
  (let ((prev-year  (format-time-string "%Y" (encode-time 0 0 0 (string-to-int memo-view-cur-day) (- (string-to-int memo-view-cur-month) 1) (string-to-int memo-view-cur-year))))
		(prev-month (format-time-string "%m" (encode-time 0 0 0 (string-to-int memo-view-cur-day) (- (string-to-int memo-view-cur-month) 1) (string-to-int memo-view-cur-year))))
		(prev-date  (format-time-string "%d" (encode-time 0 0 0 (string-to-int memo-view-cur-day) (- (string-to-int memo-view-cur-month) 1) (string-to-int memo-view-cur-year))))
		)
	;;(message (concat prev-year "/" prev-month "/" prev-date))
	(memo-view-make-list prev-year prev-month prev-date)
	;; カーソル位置初期化
	(memo-view-init-cur)
	)
  )

;; ----------------------------------------
;; 下へ移動
;; ----------------------------------------
(defun memo-view-down-list ()
  (interactive)
  ;; カーソルの移動
  (forward-line)
  (beginning-of-line)
  ;;(message (what-line))
  ;; ファイルを開く
  (if memo-view-is-show-when-updown (memo-view-open-cur-file nil))
  )

;; ----------------------------------------
;; 上の月へ移動
;; ----------------------------------------
(defun memo-view-up-list ()
  (interactive)
  (if (> (memo-view-get-cur-line) memo-view-init-line)
      (progn
		(forward-line -1)
		(beginning-of-line)
		;; ファイルを開く
		(if memo-view-is-show-when-updown (memo-view-open-cur-file nil))
		)
    )
  )

;; ----------------------------------------
;; メモを開く(カーソルも移動)
;; ----------------------------------------
(defun memo-view-select-list ()
  (interactive)
  (memo-view-open-cur-file t)
  )

;; ----------------------------------------
;; メモを開く(カーソルは移動しない)
;; ----------------------------------------
(defun memo-view-show-list ()
  (interactive)
  (memo-view-open-cur-file nil)
  )

;; ----------------------------------------
;; メジャーモード設定
;; ----------------------------------------
(defun memo-view-set-mode ()
  (setq major-mode 'memo-list-mode)		; メジャーモード設定
  (setq mode-name  "memo-list")				; モードラインに表示されるもの
  (setq memo-view-local-map (make-keymap))	; キーマップ設定
  ;; キーマップ
  (define-key memo-view-local-map [return] 'memo-view-select-list)
  (define-key memo-view-local-map " "      'memo-view-show-list)
  (define-key memo-view-local-map "f"      'memo-view-next-month)
  (define-key memo-view-local-map "\C-f"   'memo-view-next-month)
  (define-key memo-view-local-map [right]  'memo-view-next-month)
  (define-key memo-view-local-map "b"      'memo-view-prev-month)
  (define-key memo-view-local-map "\C-b"   'memo-view-prev-month)
  (define-key memo-view-local-map [left]   'memo-view-prev-month)
  (define-key memo-view-local-map "n"      'memo-view-down-list)
  (define-key memo-view-local-map "\C-n"   'memo-view-down-list)
  (define-key memo-view-local-map [down]   'memo-view-down-list)
  (define-key memo-view-local-map "p"      'memo-view-up-list)
  (define-key memo-view-local-map "\C-p"   'memo-view-up-list)
  (define-key memo-view-local-map [up]     'memo-view-up-list)
  (use-local-map memo-view-local-map)
)

;; ----------------------------------------
;; 本体
;; ----------------------------------------
(defun memo-view ()
  "Memoビューア"
  (interactive)	;; 引数なし
  ;; リスト用バッファ名
  (setq memo-list-buffer " *memo list*")
  ;; カレンダー用バッファ名
  (setq memo-cal-buffer  " *memo calendar*")
  ;; 先頭行(これより上は見出し)
  (setq memo-view-init-line 2)
    ;; 初期化処理
  (setq memo-view-now-year  (format-time-string "%Y"))
  (setq memo-view-now-month (format-time-string "%m"))
  (setq memo-view-now-day   (format-time-string "%d"))
  ;(defvar memo-work-dir "c:/nakagami/works/memo")
  ;(defvar memo-view-is-show-when-updown nil)
  (defvar memo-work-dir "~/")
  (defvar memo-view-is-show-when-updown t)
  ;; フレーム/バッファの生成
  (memo-view-make-frame)
  ;; メジャーモード設定
  (memo-view-set-mode)
  ;; memoリスト作成
  (memo-view-make-list memo-view-now-year memo-view-now-month memo-view-now-day)
  ;; 初期カーソル位置
  (memo-view-init-cur)
  )