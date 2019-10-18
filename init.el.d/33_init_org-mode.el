; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------
;;  org-mode
;; ------------------------------
;; 見出しの余分な*を消す
(setq org-hide-leading-stars t)

;; 画像をインラインで表示
(setq org-startup-with-inline-images t)

;; .orgファイルは自動的にorg-mode
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

;; org-directory内のファイルすべてからagendaを作成する
(setq my-org-agenda-dir "~/org/")
(setq org-agenda-files (list my-org-agenda-dir))

;; DONEの時刻を記録
(setq org-log-done 'time)

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/todo.org" "Tasks")
     "* TODO %?\n  %i\n  %a")
        ("j" "Journal" entry (file+datetree "~/org/journal.org")
     "* %?\nEntered on %U\n  %i\n  %a")
        ("d" "Dialy" entry (file+datetree "~/org/dialy.org")
     "* %?\nEntered on %U\n  %i\n  %a")))

;; RSS Feed
(setq org-feed-alist
      '(
        ("IT Pro"
         "http://itpro.nikkeibp.co.jp/rss/ITpro.rdf"
         "~/org/feeds.org" "IT Pro RSS")
        ("IT Pro News"
         "http://itpro.nikkeibp.co.jp/rss/news.rdf"
         "~/org/feeds.org" "IT Pro News RSS")
        ("IT Pro System"
         "http://itpro.nikkeibp.co.jp/rss/system.rdf"
         "~/org/feeds.org" "IT Pro System RSS")
        ("IT Pro Network"
         "http://itpro.nikkeibp.co.jp/rss/develop.rdf"
         "~/org/feeds.org" "IT Pro Network RSS")
        ("Softeware Design"
         "http://gihyo.jp/magazine/SD/feed/rss1"
         "~/org/feeds.org" "Software Design RSS")
        ("ASCII.jp"
         "http://ascii.jp/it/rss.xml"
         "~/org/feeds.org" "ASCII.jp TECH RSS")
        ))
