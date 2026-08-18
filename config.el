;; Fonts
(setq doom-theme 'doom-ayu-mirage)

(setq doom-font (font-spec
                 :family "IoskeleyMono Nerd Font Medium"
                 :size 22)

      doom-variable-pitch-font (font-spec
                                :family "IoskeleyMono Nerd Font Medium"
                                :size 22)

      doom-big-font (font-spec
                     :family "IoskeleyMono Nerd Font Medium"
                     :size 24))

;; Maximize on start
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; Show date and time in modeline
(setq display-time-format "%A, %d %B %Y, %H:%M"
      display-time-default-load-average nil)

(display-time-mode 1)

;; Save place in document when reopening files
(save-place-mode 1)

;; Dashboard banner customization
(setq +dashboard-ascii-banner-fn
      (lambda ()
        "    __               
   / / __ __ _ _   _ 
  / / '__/ _` | | | |
 / /| | | (_| | |_| |
/_/ |_|  \__,_|\__, |
               |___/ "))

;; Add trailing lines
(after! ws-butler
  (add-hook 'org-mode-hook
            (lambda ()
              (remove-hook 'before-save-hook #'ws-butler-before-save t))))

;; Automatically display inline images when opening Org files
(after! org
  (add-hook 'org-mode-hook #'org-display-inline-images))

(after! org-roam
  ;; Org-roam folder
  (setq org-roam-directory (file-truename "~/data/notes/")

        ;; Show tags in org-roam-node-find
        org-roam-node-display-template
        (concat "${title:*} "
                (propertize "${tags:20}" 'face 'org-tag)))

  ;; Capture templates
  (setq org-roam-capture-templates
        '(("d" "default" plain "%?"
           :if-new
           (file+head "%(read-file-name \"File: \" org-roam-directory)"
                      "#+title: ${title}\n#+filetags:\n\n")
           :unnarrowed t)))

  ;; Keep database updated automatically
  (org-roam-db-autosync-mode))

;; Agenda directory, needed for tags like :so:
(after! org
  (setq org-agenda-files
        (directory-files-recursively
         "~/data/notes/"
         "\\.org$")))

;; org-roam-ui
(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

(setq org-clock-sound "~/.config/doom/pomodoro/pomodoro-bell.wav")

(map! :leader
      :desc "Start org timer"
      "o t s" #'org-timer-set-timer

      :desc "Stop org timer"
      "o t k" #'org-timer-stop

      :desc "Pause org timer"
      "o t p" #'org-timer-pause-or-continue

      :desc "Continue org timer"
      "o t c" #'org-timer-pause-or-continue)

(after! elfeed
  ;; RSS feeds
  (setq elfeed-feeds
        '(
          ;; --------------------
          ;; News
          ;; --------------------
          ("https://www.aljazeera.com/xml/rss/all.xml" news world aljazeera)
          ("https://feeds.bbci.co.uk/news/rss.xml" news bbc)
          ("https://feeds.bbci.co.uk/news/world/rss.xml" news world bbc)

          ;; --------------------
          ;; Reddit
          ;; --------------------
          ("https://www.reddit.com/r/linux/.rss" reddit linux)
          ("https://www.reddit.com/r/commandline/.rss" reddit commandline)
          ("https://www.reddit.com/r/emacs/.rss" reddit emacs)

          ;; --------------------
          ;; Linux & Open Source
          ;; --------------------
          ("https://hackaday.com/blog/feed/" hackaday hardware linux)
          ("https://opensource.com/feed" opensource linux)
          ("https://www.techrepublic.com/rssfeeds/topic/open-source/" techrepublic linux opensource)
          ("https://www.phoronix.com/rss.php" linux phoronix)
          ("https://planet.kde.org/rss20.xml" linux kde)

          ;; --------------------
          ;; Programming
          ;; --------------------
          ("https://hnrss.org/frontpage" programming hackernews)
          ("https://lobste.rs/rss" programming)

          ;; --------------------
          ;; Emacs
          ;; --------------------
          ("https://planet.emacslife.com/atom.xml" emacs)

          ;; --------------------
          ;; Security
          ;; --------------------
          ("https://feeds.feedburner.com/TheHackersNews" security))))

(custom-set-faces!
  '(elfeed-search-feed-face
    :foreground "#ffffff"
    :weight bold))
