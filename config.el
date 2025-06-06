;; [[file:config.org::*Defaults][Defaults:1]]
(setq user-full-name "Vincenzo Pace"
      user-mail-address "vincenzo.pace94@icloud.com")

(display-battery-mode 1)
(setq-default
      delete-by-moving-to-trash t
      window-combination-resize t
      x-stretch-cursor t
      cursor-type nil
      major-mode 'org-mode
      history-length 1000
      prescient-history-length 1000)

(setq undo-limit 800000000
      evil-want-fine-undo t
      +global-word-wrap-mode +1
      truncate-string-ellipsis "…"
      password-cache-expiry nil
      doom-fallback-buffer-name "► Doom"
      +doom-dashboard-name "► Doom")
(display-time-mode 1)
(setq evil-vsplit-window-right t
      evil-split-window-below t)

(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit)
  (consult-buffer))
;; Defaults:1 ends here

;; [[file:config.org::*Company][Company:1]]
(after! company
  (setq company-idle-delay 0
        company-show-quick-access t
        ))
;; Company:1 ends here

;; [[file:config.org::*Keybindings][Keybindings:1]]
(map! "C-c s" #'org-save-all-org-buffers)
(after! pdf-tools
  (map! :map pdf-view-mode-map
        :n "h" #'pdf-annot-add-highlight-markup-annotation))
(map! :leader
      :prefix "m a"
      :desc "Org download clipboard" "c" #'org-download-clipboard)
;; Keybindings:1 ends here

;; [[file:config.org::*Keybindings within ibuffer mode][Keybindings within ibuffer mode:1]]
(evil-define-key 'normal ibuffer-mode-map
  (kbd "f c") 'ibuffer-filter-by-content
  (kbd "f d") 'ibuffer-filter-by-directory
  (kbd "f f") 'ibuffer-filter-by-filename
  (kbd "f m") 'ibuffer-filter-by-mode
  (kbd "f n") 'ibuffer-filter-by-name
  (kbd "f x") 'ibuffer-filter-disable
  (kbd "g h") 'ibuffer-do-kill-lines
  (kbd "g H") 'ibuffer-update)
;; Keybindings within ibuffer mode:1 ends here

;; [[file:config.org::*Configuring Dashboard][Configuring Dashboard:1]]
(use-package dashboard
  :init      ;; tweak dashboard config before loading it
  (setq dashboard-set-heading-icons nil)
  (setq dashboard-set-file-icons nil)
  (setq dashboard-startup-banner "~/.config/doom/doom-emacs-dash.png")  ;; use custom image as banner
  (setq dashboard-center-content nil) ;; set to 't' for centered content
  (setq dashboard-items '((recents . 5)
                          (agenda . 5 )
                          (bookmarks . 5)
                          (projects . 5)))
  :config
  (dashboard-setup-startup-hook)
  (dashboard-modify-heading-icons '((recents . "file-text")
                                    (bookmarks . "book"))))
;; Configuring Dashboard:1 ends here

;; [[file:config.org::*Dashboard in Emacsclient][Dashboard in Emacsclient:1]]
(setq doom-fallback-buffer-name "*dashboard*")
;; Dashboard in Emacsclient:1 ends here

;; [[file:config.org::*Theming][Theming:1]]
(setq doom-theme 'modus-vivendi)
(setq doom-font (font-spec :family "Iosevka" :weight 'normal :size 24)
      doom-variable-pitch-font (font-spec :family "Iosevka" :size 28)
      doom-big-font (font-spec :family "Iosevka" :size 32))


(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))


(setq display-line-numbers-type 'relative
      confirm-kill-emacs nil)

(use-package modus-themes
  :ensure
  :init
  ;; Add all your customizations prior to loading the themes
  (setq modus-themes-italic-constructs t
        modus-themes-completions '((matches . (extrabold))
                                  (selection . (semibold accented))
                                  (popup . (accented intense)))
        modus-themes-variable-pitch-headings t
        modus-themes-scale-headings t
        modus-themes-variable-pitch-ui t
        modus-themes-org-agenda
        '((header-block . (variable-pitch scale-title))
          (header-date . (grayscale bold-all)))
        modus-themes-org-blocks
        '(grayscale)
        modus-themes-mode-line
        '(borderless)
        modus-themes-region '(bg-only no-extend))
  :bind ("<f5>" . modus-themes-toggle))
;; Theming:1 ends here

;; [[file:config.org::*General Settings][General Settings:1]]
(setq org-directory "~/org/")
(setq org-agenda-files
      (append (directory-files-recursively (concat org-directory "gtd/") "\\.org$")
              (directory-files-recursively (concat org-directory "roam/daily/") "\\.org$")
              (directory-files-recursively (concat org-directory "roam/main/") "\\.org$")))
(after! org-download
      (setq org-download-method 'directory)
      (setq org-download-image-dir (concat (file-name-sans-extension (buffer-file-name)) "-img"))
      (setq org-download-image-org-width 600)
      (setq org-download-link-format "[[file:%s]]\n"
        org-download-abbreviate-filename-function #'file-relative-name)
      (setq org-download-link-format-function #'org-download-link-format-function-default)
      (setq org-download-screenshot-method "grim -g \"$(slurp)\" %s")
        )
(with-eval-after-load 'org (global-org-modern-mode))
(after! org
  :config
  (setq org-startup-folded t
        org-preview-latex-directory (expand-file-name "ltximg/" org-directory)
        org-habit-show-habits t
        org-default-notes-file (concat org-directory "/gtd/notes.org")
        org-ellipsis " ▼ "
        org-my-anki-file (expand-file-name "anki.org" org-directory)
        org-log-done 'time
        org-hide-emphasis-markers t
        org-clock-display-default-range 'untilnow
        org-pomodoro-length 25
        org-pomodoro-short-break-length 5
        org-pomodoro-long-break-length 20
        org-pomodoro-manual-break t
        org-pomodoro-play-sounds nil )
  (setq org-pretty-entities t)
)
(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "HOLD(h)" "|" "DONE(d)")))
;; General Settings:1 ends here

;; [[file:config.org::*Org Roam][Org Roam:1]]
(use-package! org-roam
  :after org
  :config
    (advice-remove 'org-roam-db-query '+org-roam-try-init-db-a))
(use-package! org-roam
        :config
        (setq org-roam-capture-templates
        '(("m" "main" plain
        "%?"
        :if-new (file+head "main/${slug}.org"
        "#+title: ${title}\n#+filetags:\n")
        :immediate-finish t
        :unnarrowed t)

        ("r" "reference" plain "%?"
        :if-new
        (file+head "reference/${slug}.org" "#+title: ${title}\n#+filetags: \n- source :: \n\n ")
        :immediate-finish t
        :unnarrowed t)

        ("P" "people" plain "%?"
        :if-new
        (file+head "people/${slug}.org" "#+title: ${title}\n#+filetags: \n* Company\n* Contact Info\n* Job title\n ")
        :immediate-finish t
        :unnarrowed t)

        ("p" "paper" plain "%?"
        :if-new
        (file+head "papers/${slug}.org" "${title}\n#+filetags: :paper:\n- source ::  \n \n* TLDR \n* Research Gap \n* Limitations \n* Contribution \n* Open Questions\n* Evidence\n* Other")
        :immediate-finish t
        :unnarrowed t)

        ("M" "meeting" plain "%?"
        :if-new
        (file+head "meetings/%<%Y%m%d%S>-${slug}.org" "Meeting of : %t\n#+filetags: :meeting:\n")
        :immediate-finish t
        :unnarrowed t)

        ("b" "book notes" plain
        "\n* Source\n\nAuthor: %^{Author}\nTitle: ${title}\nYear: %^{Year}\n\n* Summary\n\n%?"
        :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
        :unnarrowed t)))
(setq org-roam-dailies-capture-templates
      '(("d" "daily" entry
         "* %?"
         :target (file+head "%<%Y-%m-%d>.org"
                           "#+title: %<%Y-%m-%d %a>\n#+filetags:\n\n#+BEGIN: clocktable\n#+END:\n\n* The one thing \n* Today \n* Tasks [/] [%] \n - [ ] Stretch\n - [ ] Workout\n - [ ] Anki\n - [ ]\n\n* Daily Review\n** Achievement Review [0/3]\n - [ ] What did I accomplish today?\n - [ ] What went well today?\n - [ ] What's my biggest win?\n\n** Progress Tracking [0/4]\n - [ ] Career Goal Progress: [Rating 1-10] \n   - Notes:\n - [ ] Financial Goal Progress: [Rating 1-10]\n   - Notes:\n - [ ] Personal Development Progress: [Rating 1-10]\n   - Notes:\n - [ ] Health Goal Progress: [Rating 1-10]\n   - Notes:\n\n** Learning & Insights\n - What did I learn today?\n - What could I have done better?\n\n** Tomorrow's Priorities\n - Priority 1:\n - Priority 2:\n - Priority 3:"))
        ("w" "weekly" entry
         "* Weekly Review: Week %<%U>"
         :target (file+head "weekly/W%<%V_%Y>.org"
                           "#+title: Weekly Review: %<%Y-W%V>\n#+filetags: :weekly_review:\n\n* Achievement Review\n** Completed Tasks This Week\n%?\n** Major Milestones/Wins\n- \n** Missed Tasks/Opportunities\n- \n\n* Goal Progress Analysis\n** Career\n- Progress: [Rating 1-10]\n- Key accomplishments:\n- Challenges:\n- Next week's focus:\n\n** Financial\n- Savings this week:\n- Progress toward monthly goal: \n- Unexpected expenses:\n- Next week's financial priority:\n\n** Personal Development\n- Books/articles read:\n- Skills practiced:\n- Progress: [Rating 1-10]\n- Next week's focus:\n\n** Health\n- Workout consistency: [Rating 1-10]\n- Sleep quality: [Rating 1-10]\n- Nutrition quality: [Rating 1-10]\n- Next week's health priority:\n\n* Environmental Assessment\n** Changes/New Developments\n- \n** New Opportunities\n- \n** New Challenges\n- \n\n* Next Week\n** Top 3 Priorities\n1. \n2. \n3. \n\n** Specific Action Steps\n- [ ] \n- [ ] \n- [ ] \n\n* Vision Alignment Check\nAm I still aligned with my Vision 2028? [Yes/No]\nNotes:"))
        ("m" "monthly" entry
         "* Monthly Review: %<%B %Y>"
         :target (file+head "monthly/M%<%m_%Y>.org"
                           "#+title: Monthly Review: %<%B %Y>\n#+filetags: :monthly_review:\n\n* Month Overview\n%?\n** Key highlights:\n- \n** Challenges:\n- \n\n* Achievement Review\n** Monthly Goals Completed\n- \n** Monthly Goals Not Completed\n- \n** Unexpected Achievements\n- \n\n* Goal Progress Tracking\n** Career \n- Progress: [Rating 1-10]\n- Key accomplishments:\n- Learning/growth areas:\n- Relationships built:\n- Skills developed:\n- Next month's focus:\n\n** Financial\n- Monthly income:\n- Monthly expenses:\n- Savings rate: \n- Progress toward yearly goal (%):\n- Next month's financial priority:\n\n** Personal Development\n- Books completed:\n- Courses/training completed:\n- New skills practiced:\n- Habits built/maintained:\n- Areas needing improvement:\n- Next month's focus:\n\n** Health\n- Weight/body composition changes:\n- Strength/fitness improvements:\n- Sleep metrics:\n- Energy levels:\n- Areas needing attention:\n- Next month's health priority:\n\n* Resource Evaluation\n** What resources do I need to achieve next month's goals?\n- \n** What relationships should I nurture?\n- \n** What training/learning do I need?\n- \n\n* Vision Alignment Check\n** Progress toward 3-year vision:\n- Career: [Rating 1-10]\n- Financial: [Rating 1-10]\n- Personal Development: [Rating 1-10]\n- Social: [Rating 1-10]\n- Health: [Rating 1-10]\n\n** Adjustments needed to vision or approach:\n- \n\n* Quarter Planning (if applicable)\n** Quarter goals and focus areas:\n-"))
      )
))
;; Org Roam:1 ends here

;; [[file:config.org::*Org Pomodoro Statusbar][Org Pomodoro Statusbar:1]]
(defun ruborcalor/org-pomodoro-time ()
  "Return the remaining pomodoro time"
  (if (org-pomodoro-active-p)
      (cl-case org-pomodoro-state
        (:pomodoro
           (format "Pomo: %d minutes - %s" (/ (org-pomodoro-remaining-seconds) 60) org-clock-heading))
        (:short-break
         (format "Short break time: %d minutes" (/ (org-pomodoro-remaining-seconds) 60)))
        (:long-break
         (format "Long break time: %d minutes" (/ (org-pomodoro-remaining-seconds) 60)))
        (:overtime
         (format "Overtime! %d minutes" (/ (org-pomodoro-remaining-seconds) 60))))
    "No active pomo"))
;; Org Pomodoro Statusbar:1 ends here

;; [[file:config.org::*Org-auto-tangle][Org-auto-tangle:1]]
(use-package org-auto-tangle
  :defer t
  :hook (org-mode . org-auto-tangle-mode)
  :config
  (setq org-auto-tangle-default t))
;; Org-auto-tangle:1 ends here

;; [[file:config.org::*Org Capture][Org Capture:1]]
(use-package! anki-editor
  :commands (anki-editor-mode)
  :init
  (map! :leader
      :desc "Anki Push tree"
      "m a p" #'anki-editor-push-new-notes)
  :hook (org-capture-after-finalize . anki-editor-reset-cloze-number) ; Reset cloze-number after each capture.
)
;; Org-capture templates
(setq org-my-anki-file "~/org/anki.org")
(defun my-anki-editor-mode-hook ()
  (when (string-equal (buffer-file-name) (expand-file-name "~/org/anki.org"))
    (anki-editor-mode)))

(add-hook 'find-file-hook 'my-anki-editor-mode-hook)

(after! org
    (add-to-list 'org-capture-templates
    '("a" "Anki basic"
               entry
               (file+headline org-my-anki-file "Dispatch Shelf")
               "* %<%H:%M>   %^g\n:PROPERTIES:\n:ANKI_NOTE_TYPE: Basic\n:ANKI_DECK: Mega\n:END:\n** Front\n%?\n** Back\n"))
    (add-to-list 'org-capture-templates
             '("A" "Anki cloze"
               entry
               (file+headline org-my-anki-file "Dispatch Shelf")
               "* %<%H:%M>   %^g\n:PROPERTIES:\n:ANKI_NOTE_TYPE: Cloze\n:ANKI_DECK: Mega\n:END:\n** Text\n%x\n** Extra\n"))
    (add-to-list 'org-capture-templates
                '("g" "Game Dev Notes"
                  entry
                  (file+headline "~/org/my_rpg.org" "Capture")
                   "* %?\nEntered on %U\n  %i\n  %a"))
    (add-to-list 'org-capture-templates
                '("r" "Reading List"
                  entry
                  (file+headline "~/org/reading_list.org" "Capture")
                   "* %?Title\nby Author \n\nEntered on %U\n  %i\n  %a \n "))
    (add-to-list 'org-capture-templates
                '("n" "Notes"
                  entry
                  (file+headline "~/org/gtd/notes.org" "Capture")
                   "* %?\n  %i\n  %a"))
    (add-to-list 'org-capture-templates
                '("t" "ToDo"
                  entry
                  (file+headline "~/org/gtd/inbox.org" "Capture")
                   "* TODO %?\n  %i\n  %a")))
;; Allow Emacs to access content from clipboard.
(setq select-enable-clipboard t
      select-enable-primary t)

(defadvice org-capture-finalize
    (after delete-capture-frame activate)
  "Advise capture-finalize to close the frame"
  (if (equal "org-capture" (frame-parameter nil 'name))
      (delete-frame)))

(defadvice org-capture-destroy
    (after delete-capture-frame activate)
  "Advise capture-destroy to close the frame"
  (if (equal "org-capture" (frame-parameter nil 'name))
      (delete-frame)))

(defun make-orgcapture-frame ()
    "Create a new frame and run org-capture."
    (interactive)
    (make-frame '((name . "org-capture") (window-system . x)))
    (select-frame-by-name "org-capture")
    (org-capture)
    ;;(delete-other-windows)
    )
;; Org Capture:1 ends here

;; [[file:config.org::*Org agenda][Org agenda:1]]
(setq org-agenda-custom-commands
      '(("d" "Completed tasks today"
         agenda ""
         ((org-agenda-start-day "+0d")
          (org-agenda-span 1)
          (org-agenda-entry-types '(:closed))))))
;; Org agenda:1 ends here

;; [[file:config.org::*Leetcode][Leetcode:1]]
(setq leetcode-prefer-language "rust")
(setq leetcode-save-solutions t)
(setq leetcode-directory "~/code/leetcode")
;; Leetcode:1 ends here

;; [[file:config.org::*vterm][vterm:1]]
(setq vterm-shell "/etc/profiles/per-user/vincenzo/bin/nu")
;; vterm:1 ends here

;; [[file:config.org::*Nix][Nix:1]]
;(use-package lsp-nix
;  :ensure lsp-mode
;  :after (lsp-mode)
;  :demand t
;  :custom
;  (lsp-nix-nil-formatter ["nixfmt"]))
;
;(use-package nix-mode
;  :hook (nix-mode . lsp-deferred)
;  :ensure t)
;; Nix:1 ends here

;; [[file:config.org::*File permissions and ownership][File permissions and ownership:1]]
(map! :leader
      (:prefix ("d" . "dired")
       :desc "Open dired" "d" #'dired
       :desc "Dired jump to current" "j" #'dired-jump)
      (:after dired
       (:map dired-mode-map
        :desc "Peep-dired image previews" "d p" #'peep-dired
        :desc "Dired view file" "d v" #'dired-view-file)))

(evil-define-key 'normal dired-mode-map
  (kbd "M-RET") 'dired-display-file
  (kbd "h") 'dired-up-directory
  (kbd "l") 'dired-open-file ; use dired-find-file instead of dired-open.
  (kbd "m") 'dired-mark
  (kbd "t") 'dired-toggle-marks
  (kbd "u") 'dired-unmark
  (kbd "C") 'dired-do-copy
  (kbd "D") 'dired-do-delete
  (kbd "J") 'dired-goto-file
  (kbd "M") 'dired-do-chmod
  (kbd "O") 'dired-do-chown
  (kbd "P") 'dired-do-print
  (kbd "R") 'dired-do-rename
  (kbd "T") 'dired-do-touch
  (kbd "Y") 'dired-copy-filenamecopy-filename-as-kill ; copies filename to kill ring.
  (kbd "Z") 'dired-do-compress
  (kbd "+") 'dired-create-directory
  (kbd "-") 'dired-do-kill-lines
  (kbd "% l") 'dired-downcase
  (kbd "% m") 'dired-mark-files-regexp
  (kbd "% u") 'dired-upcase
  (kbd "* %") 'dired-mark-files-regexp
  (kbd "* .") 'dired-mark-extension
  (kbd "* /") 'dired-mark-directories
  (kbd "; d") 'epa-dired-do-decrypt
  (kbd "; e") 'epa-dired-do-encrypt)
;; Get file icons in dired
;; With dired-open plugin, you can launch external programs for certain extensions
;; For example, I set all .png files to open in 'sxiv' and all .mp4 files to open in 'mpv'
(setq dired-open-extensions '(("gif" . "sxiv")
                              ("jpg" . "sxiv")
                              ("png" . "sxiv")
                              ("mkv" . "mpv")
                              ("mp4" . "mpv")))
;; File permissions and ownership:1 ends here

;; [[file:config.org::*Keybindings Within Dired With Peep-Dired-Mode Enabled][Keybindings Within Dired With Peep-Dired-Mode Enabled:1]]
(evil-define-key 'normal peep-dired-mode-map
  (kbd "j") 'peep-dired-next-file
  (kbd "k") 'peep-dired-prev-file)
(add-hook 'peep-dired-hook 'evil-normalize-keymaps)
;; Keybindings Within Dired With Peep-Dired-Mode Enabled:1 ends here

;; [[file:config.org::*Making deleted files go to trash can][Making deleted files go to trash can:1]]
(setq delete-by-moving-to-trash t
      trash-directory "~/.local/share/Trash/files/")
;; Making deleted files go to trash can:1 ends here

;; [[file:config.org::*EMOJIS][EMOJIS:1]]
(use-package emojify
  :hook (after-init . global-emojify-mode))
;; EMOJIS:1 ends here

;; [[file:config.org::*NEOTREE][NEOTREE:1]]
(after! neotree
  (setq neo-smart-open t
        neo-window-fixed-size nil))
(after! doom-themes
  (setq doom-neotree-enable-variable-pitch t))
(map! :leader
      :desc "Toggle neotree file viewer" "t n" #'neotree-toggle
      :desc "Open directory in neotree" "d n" #'neotree-dir)
;; NEOTREE:1 ends here

;; [[file:config.org::*MODELINE][MODELINE:1]]
(set-face-attribute 'mode-line nil :font "Iosevka")
(setq doom-modeline-height 30     ;; sets modeline height
      doom-modeline-bar-width 5   ;; sets right bar width
      doom-modeline-persp-name t  ;; adds perspective name to modeline
      doom-modeline-persp-icon t) ;; adds folder icon next to persp name
(defun doom-modeline-conditional-buffer-encoding ()
  "We expect the encoding to be LF UTF-8, so only show the modeline when this is not the case"
  (setq-local doom-modeline-buffer-encoding
              (unless (and (memq (plist-get (coding-system-plist buffer-file-coding-system) :category)
                                 '(coding-category-undecided coding-category-utf-8))
                           (not (memq (coding-system-eol-type buffer-file-coding-system) '(1 2))))
                t)))

;;(add-hook 'after-change-major-mode-hook #'doom-modeline-conditional-buffer-encoding)
;; MODELINE:1 ends here

;; [[file:config.org::*COPILOT][COPILOT:1]]
;(use-package! copilot
;  :hook (prog-mode . copilot-mode)
;  :bind (:map copilot-completion-map
;              ("<tab>" . 'copilot-accept-completion)
;              ("TAB" . 'copilot-accept-completion)
;              ("C-TAB" . 'copilot-accept-completion-by-word)
;              ("C-<tab>" . 'copilot-accept-completion-by-word)
;              ("C-n" . 'copilot-next-completion)
;              ("C-p" . 'copilot-previous-completion))
;
;  :config
;  (add-to-list 'copilot-indentation-alist '(prog-mode 2))
;  (add-to-list 'copilot-indentation-alist '(python-mode 2))
;  (add-to-list 'copilot-indentation-alist '(closure-mode 2))
;  (add-to-list 'copilot-indentation-alist '(emacs-lisp-mode 2)))
;; COPILOT:1 ends here

;; [[file:config.org::*DEBUGGER][DEBUGGER:1]]
(with-venv
  (executable-find "python"))
  (use-package dap-mode
  :after lsp-mode
  :commands dap-debug
  :hook ((python-mode . dap-ui-mode) (python-mode . dap-mode))
  :config
  (require 'dap-python)
  (setq dap-python-debugger 'debugpy)
  (defun dap-python--pyenv-executable-find (command)
    (with-venv (executable-find "python")))

  (add-hook 'dap-stopped-hook
            (lambda (arg) (call-interactively #'dap-hydra))))

(after! dap-mode
  (setq dap-python-debugger 'debugpy))

(map! :map dap-mode-map
      :leader
      :prefix ("d" . "dap")
      ;; basics
      :desc "dap next"          "n" #'dap-next
      :desc "dap step in"       "i" #'dap-step-in
      :desc "dap step out"      "o" #'dap-step-out
      :desc "dap continue"      "c" #'dap-continue
      :desc "dap hydra"         "h" #'dap-hydra
      :desc "dap debug restart" "r" #'dap-debug-restart
      :desc "dap debug"         "s" #'dap-debug

      ;; debug
      :prefix ("dd" . "Debug")
     ;; :desc "dap debug recent"  "r" #'dap-debug-recent
     ;; :desc "dap debug last"    "l" #'dap-debug-last

      ;; eval
     ;; :prefix ("de" . "Eval")
     ;; :desc "eval"                "e" #'dap-eval
     ;; :desc "eval region"         "r" #'dap-eval-region
     ;; :desc "eval thing at point" "s" #'dap-eval-thing-at-point
     ;; :desc "add expression"      "a" #'dap-ui-expressions-add
     ;; :desc "remove expression"   "d" #'dap-ui-expressions-remove

     ;; :prefix ("db" . "Breakpoint")
     ;; :desc "dap breakpoint toggle"      "b" #'dap-breakpoint-toggle
     ;; :desc "dap breakpoint condition"   "c" #'dap-breakpoint-condition
     ;; :desc "dap breakpoint hit count"   "h" #'dap-breakpoint-hit-condition
     ;; :desc "dap breakpoint log message" "l" #'dap-breakpoint-log-message
)
;; DEBUGGER:1 ends here

;; [[file:config.org::*Japanese][Japanese:1]]
(setq fcitx-use-dbus nil
      fcitx-remote-command "fcitx5-remote")
;;(setq fcitx-use-dbus "fcitx5")
(fcitx-aggressive-setup)
;; Japanese:1 ends here
