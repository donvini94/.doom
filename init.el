;;; init.el -*- lexical-binding: t; -*-

(doom!
 :completion
 (company +childframe)             ; the ultimate code completion backend
 (vertico +icons)           ; the search engine of the future

 :input
 japanase

 :ui
 doom              ; what makes DOOM look the way it does
 ;;doom-dashboard    ; a nifty splash screen for Emacs
 (emoji +unicode)  ; 🙂
 hl-todo           ; highlight TODO/FIXME/NOTE/DEPRECATED/HACK/REVIEW
 (ligatures +extra)          ; ligatures and symbols to make your code pretty again
 modeline          ; snazzy, Atom-inspired modeline, plus API
 nav-flash         ; blink cursor line after big motions
 neotree           ; a project drawer, like NERDTree for vim
 ophints           ; highlight the region an operation acts on
 (popup +defaults)   ; tame sudden yet inevitable temporary windows
 vc-gutter         ; vcs diff in the fringe
 vi-tilde-fringe   ; fringe tildes to mark beyond EOB
 (window-select +numbers)     ; visually switch windows
 workspaces        ; tab emulation, persistence & separate workspaces
 zen               ; distraction-free coding or writing

 :editor
 (evil +everywhere); come to the dark side, we have cookies
 file-templates    ; auto-snippets for empty files
 fold              ; (nigh) universal code folding
 (format +onsave)  ; automated prettiness
 snippets          ; my elves. They type so I don't have to
 word-wrap         ; soft wrapping with language-aware indent

 :emacs
 (dired +dirvish +icons)             ; making dired pretty [functional]
 electric          ; smarter, keyword-based electric-indent
 (ibuffer +icons)         ; interactive buffer management
 (undo +tree)              ; persistent, smarter undo for your inevitable mistakes
 vc                ; version-control and Emacs, sitting in a tree

 :term
 eshell            ; the elisp shell that works everywhere
 vterm

 :checkers
 syntax              ; tasing you for every semicolon you forget

 :tools
 (debugger +lsp)          ; FIXME stepping through code, to help you add bugs
 direnv
 (docker +lsp)
 editorconfig      ; let someone else argue about tabs vs spaces
 ;;ein               ; tame Jupyter notebooks with emacs
 (eval +overlay)     ; run code, run (also, repls)
 (lookup +docsets)              ; navigate your code and its documentation
 (lsp +peek)               ; M-x vscode
 (magit +forge)             ; a git porcelain for Emacs
 pass              ; password manager for nerds
 pdf               ; pdf enhancements

 :os
 (:if IS-MAC macos)  ; improve compatibility with macOS
 tty               ; improve the terminal Emacs experience

 :lang
 emacs-lisp        ; drown in parentheses
 ;;(go +lsp)
 (haskell +lsp)    ; a language that's lazier than I am
 (json +lsp)              ; At least it ain't XML
 javascript        ; all(hope(abandon(ye(who(enter(here))))))
 (latex +latexmk +cdlatex +fold +lsp)             ; writing papers in Emacs has never been so fun
 (markdown +grip)          ; writing docs for people to ignore
 (nix)               ; I hereby declare "nix geht mehr!"
 (org +dragndrop +pomodoro +pandoc +roam2)               ; organize your plain life in plain text
 ;;plantuml          ; diagrams for confusing people more
 (python +lsp +pyright +poetry)            ; beautiful is better than ugly
 (rust +lsp)              ; Fe2O3.unwrap().unwrap().unwrap().unwrap()
 (sh +lsp)                ; she sells {ba,z,fi}sh shells on the C xor
 web               ; the tubes
 (yaml +lsp)              ; JSON, but readable

 :config
 literate
 (default +bindings +smartparens))
