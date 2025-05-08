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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Init block courtesy of sakurawald --- https://github.com/sakurawald/.dotfiles/blob/master/lem/.lem/init.lisp
;; Tab keybindings
(define-key lem-vi-mode:*normal-keymap* "Leader t c" 'lem/frame-multiplexer::frame-multiplexer-create-with-previous-buffer) 
(define-key lem-vi-mode:*normal-keymap* "Leader t d" 'lem/frame-multiplexer::frame-multiplexer-delete)

(define-key lem-vi-mode:*normal-keymap* "Leader 0" 'lem/frame-multiplexer::frame-multiplexer-switch-0)
(define-key lem-vi-mode:*normal-keymap* "Leader 1" 'lem/frame-multiplexer::frame-multiplexer-switch-1)
(define-key lem-vi-mode:*normal-keymap* "Leader 2" 'lem/frame-multiplexer::frame-multiplexer-switch-2)
(define-key lem-vi-mode:*normal-keymap* "Leader 3" 'lem/frame-multiplexer::frame-multiplexer-switch-3)
(define-key lem-vi-mode:*normal-keymap* "Leader 4" 'lem/frame-multiplexer::frame-multiplexer-switch-4)
(define-key lem-vi-mode:*normal-keymap* "Leader 5" 'lem/frame-multiplexer::frame-multiplexer-switch-5)
(define-key lem-vi-mode:*normal-keymap* "Leader 6" 'lem/frame-multiplexer::frame-multiplexer-switch-6)
(define-key lem-vi-mode:*normal-keymap* "Leader 7" 'lem/frame-multiplexer::frame-multiplexer-switch-7)
(define-key lem-vi-mode:*normal-keymap* "Leader 8" 'lem/frame-multiplexer::frame-multiplexer-switch-8)
(define-key lem-vi-mode:*normal-keymap* "Leader 9" 'lem/frame-multiplexer::frame-multiplexer-switch-9)


;; automatically load paredit when opening a lisp file
(defun pared-hook ()
  (lem-paredit-mode:paredit-mode t))
(add-hook lem-lisp-mode:*lisp-mode-hook* #'pared-hook)

;;;; -- s-exp --
;; TIP: Use `)` to move over the list.
;; TIP: Use `g m` to move to the matching item.
(define-key lem-vi-mode:*normal-keymap* "Leader s m" 'mark-sexp)
(define-key lem-vi-mode:*normal-keymap* "Leader s k" 'lem-paredit-mode:paredit-kill)
(define-key lem-vi-mode:*normal-keymap* "Leader s w" 'lem-paredit-mode:paredit-wrap-round)
(define-key lem-vi-mode:*normal-keymap* "Leader s W" 'lem-paredit-mode:paredit-splice)
(define-key lem-vi-mode:*normal-keymap* "Leader s b" 'lem-paredit-mode:paredit-barf)
(define-key lem-vi-mode:*normal-keymap* "Leader s s" 'lem-paredit-mode:paredit-slurp)
(define-key lem-vi-mode:*normal-keymap* "Leader s t" 'transpose-sexps)
(define-key lem-vi-mode:*normal-keymap* "Leader s r" 'lem-paredit-mode:paredit-raise)

(define-key lem-vi-mode:*normal-keymap* "C-h" 'window-move-left)
(define-key lem-vi-mode:*normal-keymap* "C-j" 'window-move-down)
(define-key lem-vi-mode:*normal-keymap* "C-k" 'window-move-up)
(define-key lem-vi-mode:*normal-keymap* "C-l" 'window-move-right)

;; End of Block
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; buffer search keybindings
(defvar *search-keymap*
  (make-keymap :name '*search*)
  "Keymap for commands related to buffer searches.")

(define-key lem-vi-mode:*normal-keymap* "Leader x" *search-keymap*)
;; (undefined-key lem-vi-mode:*normal-keymap* "Space")
(define-keys *search-keymap* 
  ("g" 'lem/grep:grep)
  ("f" 'lem/language-mode:find-definitions)
  ("r" 'lem/language-mode:find-references))

;; lsp keybindings
(defvar *lsp-keymap*
  (make-keymap :name '*lsp*)
  "Keymap for commands related to the current lsp being used.")

(define-key lem-vi-mode:*normal-keymap* "Leader l" *lsp-keymap*)
;; (undefined-key lem-vi-mode:*normal-keymap* "Space")
(define-keys *lsp-keymap* 
  ("d" 'lem-lsp-mode/lsp-mode::lsp-document-diagnostics))

;;(add-hook lem/buffer:before-save-hook 'lem-lsp-mode/lsp-mode::lsp-document-format)

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

#|
Due to arch not allowing pip to be installed at the system level
	a virtual environment needs to be created. With the virtual env
	you can install pylsp via the pip install "python-lsp-server[all]"
	this install pylsp with all additional lsp functionality including
	error checking, formatting, style checking etc.
	Check the readme for all options.
Now you need to actually point to where the lsp program was installed
	this is located in the bin folder of the virtual environment.
|#
;; Now I need to add a hook to start pylsp with tcp on initial major mode start
(lem-lsp-mode/lsp-mode::define-language-spec
    (py-spec lem-python-mode:python-mode)
  :language-id "python"
  :root-uri-patterns '("pyproject.toml" "setup.py" "__init__.py")
  :command '("/home/dunderscore/workspaces/git-repos/.venv/bin/pylsp")
  :readme-url "https://github.com/python-lsp/python-lsp-server"
  :connection-mode :tcp
  :port 2087)

(lem-lsp-mode/lsp-mode::define-language-spec
    (rust-spec lem-rust-mode:rust-mode)
  :language-id "rust"
  :root-uri-patterns '("Cargo.toml")
  :command '("/home/dunderscore/.cargo/bin/rust-analyzer" "--stdio")
  :connection-mode :stdio)
