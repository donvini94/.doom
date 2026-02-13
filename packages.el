;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; Org enhancements
(package! anki-editor
  :recipe (:host github :repo "anki-editor/anki-editor"))
(package! org-auto-tangle)
(package! org-modern
  :recipe (:host github :repo "minad/org-modern"))
(package! org-clock-convenience)

;; Themes
(package! modus-themes)

;; Utilities
(package! csv-mode)
(package! ultra-scroll)  ; ~40% faster than pixel-scroll-precision-mode
(package! claude-code-ide
  :recipe (:host github :repo "manzaltu/claude-code-ide.el"))
(package! eca :recipe (:host github :repo "editor-code-assistant/eca-emacs" :files ("*.el")))
(package! devcontainer
  :recipe (:host github :repo "johannes-mueller/devcontainer.el"))
;; Document reader (replaces pdf-tools, also handles EPUB, MOBI, etc.)
(package! reader
  :recipe (:host nil
           :type git
           :repo "https://codeberg.org/divyaranjan/emacs-reader"
           :files ("*.el" "render-core.dylib" "render-core.so")
           :pre-build ("make" "all")))

;; Disable pdf-tools and related packages since reader replaces them
(package! pdf-tools :disable t)
(package! org-pdftools :disable t)
(package! saveplace-pdf-view :disable t)

