;-*- Emacs-Lisp -*-
;; ----------------------------------------------------
;; �t�@�C���� :
;;   easy-memo.el
;;
;; �T�v :
;;   �ȒP�Ƀ���������悤���Ƃ�ړI�Ƃ���Emacs Lisp
;;
;; �쐬�� :
;;   v1.0 - 2011/10/12(��)
;; �쐬�� :
;;   g.nakagami
;;
;; �g���� :
;;  .emacs�Ɉȉ��̓��e���L��
;;    ;; easy-memo.el�����[�h
;;    (load "easy-memo")
;;    ;; memo�t�@�C���ۑ��ꏊ
;;    (setq memo-work-dir "memo�t�@�C����ۑ��������f�B���N�g��")
;;
;;  ��́A"M-x memo"�ŁAmemo-work-dir�ȉ��Ƀt�@�C���𐶐����ĊJ��
;;
;;  �쐬�����t�@�C���̈ꗗ��\���ł��郂�[�h��p��
;;   "M-x memo-view"�ŁAmemo-view���[�h�Ɉڍs
;;
;;   [f], [b],[��] [�E] : ���ړ�
;;   [n], [p],[��] [��] : �㉺�ړ�
;;   [Return] : �\�� & �J�[�\���ړ�
;;   [Shift]  : �\��
;;
;; �I�v�V���� :
;;   memo-view-is-show-when-updown : �㉺�ړ�����Ƃ��ɓ����Ƀt�@�C�����J��
;;    ��).emacs�ɋL��
;;      (setq memo-view-is-show-when-updown t) ;; t or nil
;;
;; �R�}���h�T���v���F
;;   �����c�[��
;;   (load "easy-memo")
;;   (setq memo-work-dir "c:/gnakagami/works/memo")	;; �ۑ��ꏊ
;;   (setq memo-view-is-show-when-updown nil)	;; �㉺�ړ��Ɠ����Ƀt�@�C���͊J���Ȃ�
;;
;; ----------------------------------------------------

;; ************************************************************************************
;; memo
;; ************************************************************************************
;; ----------------------------------------
;; �֐��� : memo-find-file
;; �T�v   : �t�@�C�����J��
;; ----------------------------------------
(defun memo-find-file (work-dir year month day)
  (let ((dir (concat work-dir "/" year "/" month)))
    (if (file-directory-p dir)
	(find-file (expand-file-name (concat dir "/" year month day "_memo.txt")))
      (message "�t�@�C�����J���܂���")
      )
    )
  )

;; ----------------------------------------
;; �֐��� : memo-rename-and-find-file
;; �T�v   : ���łɂ���t�@�C���͖��O��ς��ĐV�����t�@�C�����J��
;; ----------------------------------------
(defun memo-rename-and-find-file (work-dir year month day)
  (let ((dir  (concat work-dir "/" year "/" month))
		(file (concat work-dir "/" year "/" month "/" year month day "_memo.txt")))
    (if (file-directory-p dir)
	(progn
	  ;; ���łɃt�@�C��������ꍇ
	  (if (file-exists-p (expand-file-name file))
	      (let ((i 1) (i-max 100))
		(while (<= i i-max)
		  (setq rename-file-name (concat dir "/" year month day "_memo_" (format "%03d" i) ".txt"))
		  (if (not (file-exists-p (expand-file-name rename-file-name)))
		      (progn
				;; ���l�[������
				(rename-file (expand-file-name file) (expand-file-name rename-file-name))
				;; �o�b�t�@���Ȃ��ꍇ�͉������Ȃ�
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
      (message "�t�@�C�����J���܂���")
      )
    )
  )

;; ----------------------------------------
;; �֐��� : memo-make-dir
;; �T�v   : �N/���̃f�B���N�g�����쐬����
;; ----------------------------------------
(defun memo-make-dir (work-dir year month)
  ;; ��ƃf�B���N�g�������邩�`�F�b�N
  (if (file-directory-p memo-work-dir)
      (progn
	;; �N�̃f�B���N�g��
	(if (not (file-directory-p (concat work-dir "/" year)))
	    (eshell-command (concat "mkdir" " " work-dir "/" year)))
	;; ���̃f�B���N�g��
	(if (not (file-directory-p (concat work-dir "/" year "/" month)))
	    (eshell-command (concat "mkdir" " " work-dir "/" year "/" month)))
	;; �f�B���N�g�����ł��Ă��邩��Ԃ�
	(file-directory-p (concat work-dir "/" year "/" month))
	)
    nil    ;; ��ƃf�B���N�g�����Ȃ�
    )
  )

;; ���łɂ�����t�̃���������Ƃ��͐V�K�ɍ쐬
(defun memo-new ()
  "���łɂ�����t�̃���������Ƃ��͐V�K�ɍ쐬"
  (interactive)			;; �����Ȃ�
  (let ((year  (format-time-string "%Y"))
	(month (format-time-string "%m"))
	(day   (format-time-string "%d")))
    ;; �N���̃t�H���_���쐬
    (if (memo-make-dir memo-work-dir year month)
	;; ���݂̓��t�̃t�@�C�����J�� ���͂�����̂͑ޔ�
	(memo-rename-and-find-file memo-work-dir year month day)
      (message "�f�B���N�g���̍쐬�Ɏ��s���܂���")
      )
    )
  )

;; ----------------------------------------
;; �������[�h�{��
;; ----------------------------------------
(defun memo ()
  "�ȈՃ������Ƃ��ē��t�Ɍ��т����t�@�C�����J���܂�"
  (interactive)			;; �����Ȃ�
  ;(defun memo-work-dir "c:/nakagami/works/memo") ;; �����p�f�B���N�g��
  (defun memo-work-dir "~/") ;; �����p�f�B���N�g��
  (let ((year  (format-time-string "%Y"))
	(month (format-time-string "%m"))
	(day   (format-time-string "%d")))
    ;; �N���̃t�H���_���쐬
    (if (memo-make-dir memo-work-dir year month)
	;; ���݂̓��t�̃t�@�C�����J��
	(memo-find-file memo-work-dir year month day)
      (message "�f�B���N�g���̍쐬�Ɏ��s���܂���")
      )
    )
  )

;; ************************************************************************************
;; memo-view
;; ************************************************************************************
;; ----------------------------------------
;; �t���[���̐���
;; ----------------------------------------
(defun memo-view-make-frame ()
  ;; �t���[�����̃E�B���h�E��1�ɂ���
  (if (not (one-window-p)) (delete-other-windows))
  ;; �E�B���h�E���̕ۑ�
  (setq memo-view-disp-win (selected-window))
  ;; �E�B���h�E�̍������擾(window-height)���āA
  ;; ���݂̃E�B���h�E(selected-window)���A����15�s�󂯂ĕ�������
  (split-window (selected-window) (- (window-height) 15) nil)
  ;; ���̃E�B���h�E�Ɉړ�����
  (other-window 1)
  ;; --------------------
  ;; �J�����_�[�p�o�b�t�@���쐬
  ;; --------------------
  (switch-to-buffer memo-cal-buffer)
  ;; �E�B���h�E�ɃJ�����_�[�p�o�b�t�@��\��
  (set-window-buffer (selected-window) memo-cal-buffer)
  ;; �ǂݎ���p�ɂ���
  (setq buffer-read-only 1)
  ;; �E�B���h�E���̕ۑ�
  (setq memo-view-cal-win (selected-window))
  ;; �E�B���h�E�����E�ɕ���
  (split-window (selected-window) 35 1)
  ;; ���̃E�B���h�E�Ɉړ�����
  (other-window 1)
  ;; --------------------
  ;; ���X�g�p�o�b�t�@�쐬
  ;; --------------------
  ;; �o�b�t�@��؊�(�Ȃ���ΐV�K�쐬)
  (switch-to-buffer memo-list-buffer)
  ;; �E�B���h�E�Ƀ��X�g�p�o�b�t�@��\��
  (set-window-buffer (selected-window) memo-list-buffer)
  ;; �ǂݎ���p�ɂ���
  (setq buffer-read-only 1)
  ;; �E�B���h�E���̕ۑ�
  (setq memo-view-win (selected-window))
  )


;; ----------------------------------------
;; �w�肵�����t�̃��������X�g�ɂ��邩�m�F
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
	;; ���ʂ�Ԃ�
	exist
	)
  )

;; ----------------------------------------
;; ���̓������擾
;; ----------------------------------------
(defun memo-view-get-day-of-month (year month) ;; ���l
  (let ((next-year 1) (next-month 1))
	(if (>= month 12)
		(progn
		  (setq next-year (+ year 1) next-month 1)
		  )
	  (setq next-year year next-month (+ month 1))
	  )
	;; ����0��n�����ƂŁA�O���̍Ō�̓����擾����
	(string-to-int (format-time-string "%d" (encode-time 0 0 0 0 next-month next-year)))
	)
  )

;; ----------------------------------------
;; ���̎n�܂�̗j�����擾(0:��-6:��)
;; ----------------------------------------
(defun memo-view-get-start-week (year month) ;; ���l
  (% (+ (string-to-int (format-time-string "%w" (encode-time 0 0 0 1 month year))) 6) 7)
  )

;; ----------------------------------------
;; �J�����_�[�̕`��
;; ----------------------------------------
(defun memo-view-make-calendar ()
  (interactive)
  (set-buffer memo-cal-buffer)
  ;; �ǂݎ���p����
  (setq buffer-read-only nil)
  ;; �\��������
  (erase-buffer)
  (insert (concat "         " memo-view-cur-year "�N" memo-view-cur-month "��" "\n"))
  ;; �J�����_�[
  (let ((year (string-to-int memo-view-cur-year)) (month (string-to-int memo-view-cur-month))
		(day 1) (day-max 1)
		(start-flg nil) (start-week 0)
		(i 0) (j 0)
		(exist-line-str "") (memo-exist-str " �P") (memo-not-exist-str "   ")
		(week 0) (week-list (list "mon" "tue" "wed" "thu" "fri" "sat" "sun")))
	(setq day-max (memo-view-get-day-of-month year month))
	(setq start-week (memo-view-get-start-week year month))
	(while (<= day day-max)
	  (setq week 0 exist-line-str " ")	  ;; �T�P�ʂŏ������������
	  (insert " ")
	  (while (< week 7)
		(if (= i 0)
		    ;; �j���\��
		    (insert (nth week week-list))
		  ;; �J�����_�[�\��
		  (progn
			;; �J�n�j�����`�F�b�N
		    (if (= week start-week) (setq start-flg t))
			;; ���\��
			(if start-flg
				(progn
				  (insert (format "%3d" day))
				  (if (memo-view-check-memo-exist year month day)
					  (setq exist-line-str (concat exist-line-str memo-exist-str))
					(setq exist-line-str (concat exist-line-str memo-not-exist-str)))
				  (setq day (+ day 1))
				  ;; ������I��点��
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
  ;; �ǂݎ���p�ɂ���
  (setq buffer-read-only 1)
  )

;; ----------------------------------------
;; ���X�g�̍쐬
;; ----------------------------------------
(defun memo-view-make-list (year month day)
  (set-buffer memo-list-buffer)
  (setq memo-view-cur-year year memo-view-cur-month month memo-view-cur-day day)
  ;; �ǂݎ���p����
  (setq buffer-read-only nil)
  ;; �\��������
  (erase-buffer)
  ;; ���X�g����
  (if (not (file-directory-p memo-work-dir))
      (insert (concat " ��ƃf�B���N�g��������܂��� : " memo-work-dir "\n" ))
    (progn
      ;; �t�@�C�������X�g�ŕ\��
      (setq memo-view-memolist (directory-files (concat memo-work-dir "/" memo-view-cur-year "/" memo-view-cur-month) nil "\\.txt" nil))
      (setq memo-view-memonum  (safe-length memo-view-memolist))
      ;;(message (concat "filenum : " (int-to-string memo-view-memonum) " : " (int-to-string (safe-length memo-view-memolist))))
	  (insert (concat memo-work-dir "/" memo-view-cur-year "/" memo-view-cur-month "\n"))
      (if (= 0 memo-view-memonum)
		  (insert " �t�@�C��������܂���")
		(progn
		  ;; ���X�g
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
  ;; �ǂݎ���p�ɂ���
  (setq buffer-read-only 1)
  ;; �J�����_�[�̕`��
  (memo-view-make-calendar)
  (set-buffer memo-list-buffer)
  )

;; ----------------------------------------
;; ���݂̃J�[�\���s���擾
;; ----------------------------------------
(defun memo-view-get-cur-line ()
  (string-to-int (substring (what-line) (length "Line ") (length (what-line))))
  )

;; ----------------------------------------
;; �J�[�\���̍s�ړ�
;; ----------------------------------------
(defun memo-view-move-cur (cur)
  (setq memo-view-cursor cur)
  (goto-line memo-view-cursor)
  (beginning-of-line)
  )

;; ----------------------------------------
;; �J�[�\���������ʒu�Ɉړ�������
;; ----------------------------------------
(defun memo-view-init-cur ()
  (memo-view-move-cur memo-view-init-line)
  )

;; ----------------------------------------
;; ���X�g�ϐ�memolist���烁���̃p�X���擾����
;; ----------------------------------------
(defun memo-view-get-path-from-memolist (index)
  (if (and (< index (safe-length memo-view-memolist)) (file-directory-p memo-work-dir))
	  (concat memo-work-dir "/" memo-view-cur-year "/" memo-view-cur-month "/" (nth index memo-view-memolist))
	)
  )

;; ----------------------------------------
;; memo�t�@�C�����J��
;; ----------------------------------------
(defun memo-view-open-memo-file (cur do-move)
  ;; �J�[�\���͈̔̓`�F�b�N
  (if (>= cur memo-view-init-line)
	  (let ((file-path (memo-view-get-path-from-memolist (- cur memo-view-init-line))))
		 (if (file-exists-p (expand-file-name file-path))
			 (let ((cur-win (selected-window)))
			   ;;(other-window 1)
			   (if (windowp memo-view-disp-win) (select-window memo-view-disp-win) (ohter-window 1))
			   (find-file file-path)
			   ;; do-move��t�̂Ƃ��̂݁A�J�[�\�����������Ɉڂ�
			   (if (not do-move) (select-window cur-win))
			   )
		   (message (concat file-path " �́A����܂���"))
		   )
		 )
	(message "�J�[�\���ʒu�Ƀ���������܂���")
	)
  )

;; ----------------------------------------
;; �J�[�\���ʒu�ɂ���t�@�C�����J��
;; ----------------------------------------
(defun memo-view-open-cur-file (do-move)
  (memo-view-open-memo-file (memo-view-get-cur-line) do-move)
  )

;; ----------------------------------------
;; ���̌��ֈړ�
;; ----------------------------------------
(defun memo-view-next-month ()
  (interactive)	;; �����Ȃ�
  ;; ���̌��Ɉړ�
  (let ((next-year  (format-time-string "%Y" (encode-time 0 0 0 (string-to-int memo-view-cur-day) (+ (string-to-int memo-view-cur-month) 1) (string-to-int memo-view-cur-year))))
		(next-month (format-time-string "%m" (encode-time 0 0 0 (string-to-int memo-view-cur-day) (+ (string-to-int memo-view-cur-month) 1) (string-to-int memo-view-cur-year))))
		(next-date  (format-time-string "%d" (encode-time 0 0 0 (string-to-int memo-view-cur-day) (+ (string-to-int memo-view-cur-month) 1) (string-to-int memo-view-cur-year))))
		)
	;;(message (concat next-year "/" next-month "/" next-date))
	(memo-view-make-list next-year next-month next-date)
	;; �J�[�\���ʒu������
	(memo-view-init-cur)
	)
  )

;; ----------------------------------------
;; �O�̌��ֈړ�
;; ----------------------------------------
(defun memo-view-prev-month ()
  (interactive)	;; �����Ȃ�
  ;; �O�̌��Ɉړ�
  (let ((prev-year  (format-time-string "%Y" (encode-time 0 0 0 (string-to-int memo-view-cur-day) (- (string-to-int memo-view-cur-month) 1) (string-to-int memo-view-cur-year))))
		(prev-month (format-time-string "%m" (encode-time 0 0 0 (string-to-int memo-view-cur-day) (- (string-to-int memo-view-cur-month) 1) (string-to-int memo-view-cur-year))))
		(prev-date  (format-time-string "%d" (encode-time 0 0 0 (string-to-int memo-view-cur-day) (- (string-to-int memo-view-cur-month) 1) (string-to-int memo-view-cur-year))))
		)
	;;(message (concat prev-year "/" prev-month "/" prev-date))
	(memo-view-make-list prev-year prev-month prev-date)
	;; �J�[�\���ʒu������
	(memo-view-init-cur)
	)
  )

;; ----------------------------------------
;; ���ֈړ�
;; ----------------------------------------
(defun memo-view-down-list ()
  (interactive)
  ;; �J�[�\���̈ړ�
  (forward-line)
  (beginning-of-line)
  ;;(message (what-line))
  ;; �t�@�C�����J��
  (if memo-view-is-show-when-updown (memo-view-open-cur-file nil))
  )

;; ----------------------------------------
;; ��̌��ֈړ�
;; ----------------------------------------
(defun memo-view-up-list ()
  (interactive)
  (if (> (memo-view-get-cur-line) memo-view-init-line)
      (progn
		(forward-line -1)
		(beginning-of-line)
		;; �t�@�C�����J��
		(if memo-view-is-show-when-updown (memo-view-open-cur-file nil))
		)
    )
  )

;; ----------------------------------------
;; �������J��(�J�[�\�����ړ�)
;; ----------------------------------------
(defun memo-view-select-list ()
  (interactive)
  (memo-view-open-cur-file t)
  )

;; ----------------------------------------
;; �������J��(�J�[�\���͈ړ����Ȃ�)
;; ----------------------------------------
(defun memo-view-show-list ()
  (interactive)
  (memo-view-open-cur-file nil)
  )

;; ----------------------------------------
;; ���W���[���[�h�ݒ�
;; ----------------------------------------
(defun memo-view-set-mode ()
  (setq major-mode 'memo-list-mode)		; ���W���[���[�h�ݒ�
  (setq mode-name  "memo-list")				; ���[�h���C���ɕ\����������
  (setq memo-view-local-map (make-keymap))	; �L�[�}�b�v�ݒ�
  ;; �L�[�}�b�v
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
;; �{��
;; ----------------------------------------
(defun memo-view ()
  "Memo�r���[�A"
  (interactive)	;; �����Ȃ�
  ;; ���X�g�p�o�b�t�@��
  (setq memo-list-buffer " *memo list*")
  ;; �J�����_�[�p�o�b�t�@��
  (setq memo-cal-buffer  " *memo calendar*")
  ;; �擪�s(�������͌��o��)
  (setq memo-view-init-line 2)
    ;; ����������
  (setq memo-view-now-year  (format-time-string "%Y"))
  (setq memo-view-now-month (format-time-string "%m"))
  (setq memo-view-now-day   (format-time-string "%d"))
  ;(defvar memo-work-dir "c:/nakagami/works/memo")
  ;(defvar memo-view-is-show-when-updown nil)
  (defvar memo-work-dir "~/")
  (defvar memo-view-is-show-when-updown t)
  ;; �t���[��/�o�b�t�@�̐���
  (memo-view-make-frame)
  ;; ���W���[���[�h�ݒ�
  (memo-view-set-mode)
  ;; memo���X�g�쐬
  (memo-view-make-list memo-view-now-year memo-view-now-month memo-view-now-day)
  ;; �����J�[�\���ʒu
  (memo-view-init-cur)
  )