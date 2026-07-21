;; Fonts
(setq doom-theme 'doom-ayu-mirage)

(setq doom-font (font-spec
                 :family "Ioskeley Mono"
                 :size 20)

      doom-variable-pitch-font (font-spec
                                :family "Ioskeley Mono"
                                :size 20)

      doom-big-font (font-spec
                     :family "Ioskeley Mono"
                     :size 22))

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
