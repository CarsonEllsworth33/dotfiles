(in-package :lem-user)

(setf lem-core::*default-prompt-gravity* :bottom-display)
(setf lem/prompt-window::*prompt-completion-window-gravity* :horizontally-above-window)
(setf lem/prompt-window::*fill-width* t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; User Defined Commands
(define-command open-init-file () ()
  (find-file
   (merge-pathnames "init.lisp" (lem-home))))

(define-command dunder-delete-to-beginning-of-line () ()
  (progn 
    (mark-set)
    (move-to-beginning-of-line)
    (let*((dunder-point (current-point))
          (start (cursor-region-beginning dunder-point))
          (end (cursor-region-end dunder-point)))
      (delete-character start (count-characters start end)))))

;; Enable Vi-mode & Paren Coloring
(lem-vi-mode:vi-mode)
(lem-lisp-mode:toggle-paren-coloring)

;; Start with line numbers
(lem/line-numbers:toggle-line-numbers 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; vi-mode Keybindings
(setf (variable-value 'lem-vi-mode:leader-key :global) "Space")
(define-key lem-vi-mode:*normal-keymap* "Leader Space" 'execute-command)

(define-key lem-vi-mode:*insert-keymap* "(" 'lem-paredit-mode:paredit-insert-paren)
(define-key lem-vi-mode:*insert-keymap* ")" 'lem-paredit-mode:paredit-close-parenthesis)
(define-key lem-vi-mode:*insert-keymap* "[" 'lem-paredit-mode:paredit-insert-bracket)
(define-key lem-vi-mode:*insert-keymap* "]" 'lem-paredit-mode:paredit-close-bracket)
(define-key lem-vi-mode:*insert-keymap* "{" 'lem-paredit-mode:paredit-insert-brace)
(define-key lem-vi-mode:*insert-keymap* "}" 'lem-paredit-mode:paredit-close-brace)
;; vi-mode window keybindings
(defvar *window-keymap*
  (make-keymap :name '*window*)
  "Keymap for commands related to window manipulation.")

(define-key lem-vi-mode:*normal-keymap* "Leader w" *window-keymap*)
;; (undefined-key lem-vi-mode:*normal-keymap* "Space")
(define-keys *window-keymap* 
  ("/" 'split-active-window-vertically)
  ("|" 'split-active-window-horizontally)
  ("d" 'delete-active-window)
  ("Tab" 'next-window))


;; vi-mode buffer keybindings
(defvar *buffer-keymap*
  (make-keymap :name '*buffer*)
  "Keymap for commands related to buffer manipulation.")

(define-key lem-vi-mode:*normal-keymap* "Leader b" *buffer-keymap*)
(define-keys *buffer-keymap* 
  ("b" 'select-buffer)
  ("r" 'rename-buffer)
  ("k" 'kill-buffer)
  ("D" 'erase-buffer)
  ("p" 'previous-buffer)
  ("n" 'next-buffer))


;; vi-mode file keybindings
(defvar *file-keymap*
  (make-keymap :name '*file*)
  "Keymap for commands related to file manipulation.")

(define-key lem-vi-mode:*normal-keymap* "Leader f" *file-keymap*)
(define-keys *file-keymap* 
  ("f" 'find-file)
  ("r" 'rename-file)
  ("D" 'delete-file)
  ("i" 'insert-file))


;; vi-mode movement keybindings
(defvar *movement-keymap*
  (make-keymap :name '*movement*)
  "Keymap for commands related to cursor movement manipulation.")

(define-key lem-vi-mode:*normal-keymap* "Leader m" *movement-keymap*)
;; (undefined-key lem-vi-mode:*normal-keymap* "Space")
(define-keys *movement-keymap* 
  ("j" 'forward-paragraph)
  ("k" 'backward-paragraph)
  ("J" 'next-page)
  ("K" 'previous-page))


;; buffer search keybindings
(defvar *search-keymap*
  (make-keymap :name '*search*)
  "Keymap for commands related to buffer searches.")

(define-key lem-vi-mode:*normal-keymap* "Leader s" *search-keymap*)
;; (undefined-key lem-vi-mode:*normal-keymap* "Space")
(define-keys *search-keymap* 
  ("g" 'lem/grep:grep)
  ("f" 'lem/language-mode:find-definitions)) 


;; Quality of life keybindings for vi insert mode
(define-keys lem-vi-mode:*insert-keymap*
  ("Shift-Backspace" 'lem-vi-mode/commands:vi-delete-previous-char)
  ("Shift-Tab" 'dunder-delete-to-beginning-of-line))

;; Quality of life keybindings for vi normal mode
(define-keys lem-vi-mode:*normal-keymap*
  ("Shift-Backspace" 'backward-delete-word)
  ("Shift-Tab" 'dunder-delete-to-beginning-of-line)
  ("J" 'forward-paragraph)
  ("K" 'backward-paragraph)
  ("H" 'previous-word)
  ("L" 'forward-word))

;; Legit Key modifications to work with Vi and my custom bindings


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LSP configuration
(lem-lsp-mode/lsp-mode::define-language-spec
    (py-spec lem-python-mode:python-mode)
  :language-id "python"
  :root-uri-patterns '("pyproject.toml" "setup.py")
  :command '("pylsp")
  :readme-url "https://github.com/python-lsp/python-lsp-server"
  :connection-mode :stdio)

(lem-lsp-mode/lsp-mode::define-language-spec
    (rust-spec lem-rust-mode:rust-mode)
  :language-id "rust"
  :root-uri-patterns '("Cargo.toml")
  :command '("/home/dunderscore/.cargo/bin/rust-analyzer" "--stdio")
  :connection-mode :stdio)
