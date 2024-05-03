(in-package :lem-user)

;; Start vi-mode
(lem-vi-mode:vi-mode)

;; vi-mode Keybindings
(setf (variable-value 'lem-vi-mode:leader-key) "Space")
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
(define-keys *window-keymap* 
  ("/" 'split-active-window-vertically)
  ("|" 'split-active-window-horizontally)
  ("d" 'delete-active-window)
  ("Tab" 'switch-to-last-focused-window))

;; vi-mode buffer keybindings
(defvar *buffer-keymap*
  (make-keymap :name '*buffer*)
  "Keymap for commands related to buffer manipulation.")

(define-key lem-vi-mode:*normal-keymap* "Leader b" *buffer-keymap*)
(define-keys *buffer-keymap* 
  ("b" 'select-buffer)
  ("r" 'rename-buffer)
  ("k" 'delete-buffer)
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
