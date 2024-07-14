(in-package :lem-user)

(setf lem-core::*default-prompt-gravity* :bottom-display)
(setf lem/prompt-window::*prompt-completion-window-gravity* :horizontally-above-window)
(setf lem/prompt-window::*fill-width* t)

;; Start vi-mode
(lem-vi-mode:vi-mode)
(lem-lisp-mode:toggle-paren-coloring)

;; vi-mode Keybindings
(setf (variable-value 'lem-vi-mode:leader-key :global) "Space")
(define-key lem-vi-mode:*normal-keymap* "Leader Space" 'execute-command)


;;(defvar *keymap*
;;  (make-keymap :name '*keymap*)
;;  "Toplevel keymap for all of my user commands.")

;;(define-key *global-keymap* "Space" *keymaps*)

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

(define-key lem-vi-mode:*normal-keymap* "Leader m" *window-keymap*)
;; (undefined-key lem-vi-mode:*normal-keymap* "Space")
(define-keys *window-keymap* 
  ("j" 'forward-paragraph)
  ("k" 'backward-paragraph)
  ("J" 'next-page)
  ("K" 'previous-page))

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