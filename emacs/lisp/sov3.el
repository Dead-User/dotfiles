
(defvar sov-state 'normal
  "The state of SOV.el")

(defvar sov-state-stack nil
  "The stack holding previous, saved states.")

(defvar sov-normal-keymap
  (make-sparse-keymap)
  "The keymap for the builtin NORMAL state of SOV.el.")
(suppress-keymap sov-normal-keymap)

(define-minor-mode sov-normal
  "Toggle the minor mode for the NORMAL state of SOV."
  :init-value nil
  :lighter " NORMAL"
  :keymap sov-normal-keymap)
  

(defvar sov-insert-keymap
  (make-sparse-keymap)
  "The keymap for the builtin INSERT state of SOV.el.")

(define-minor-mode sov-insert
  "Toggle the minor mode for the INSERT state of SOV."
  :init-value nil
  :lighter " INSERT"
  :keymap sov-insert-keymap)


(defvar sov-minibuffer-keymap
  (make-sparse-keymap)
  "The keymap for the builtin MINIBUFFER state of SOV.el.")

(define-minor-mode sov-minibuffer
  "Toggle the minor mode for the MINIBUFFER state of SOV."
  :init-value nil
  :lighter nil
  :keymap sov-minibuffer-keymap)

(defvar sov-states
  (list '(normal . sov-normal)
	'(insert . sov-insert)
	'(minibuffer . sov-minibuffer))
  "An association list with SOV states as keys and
their associated minor modes as values.")

(defun sov-switch-to-state (state)
  "Switch to the SOV state STATE."
  (let ((current-minor-mode
	 (cdr (assoc sov-state sov-states)))
	(target-minor-mode
	 (cdr (assoc state sov-states))))
    (funcall current-minor-mode -1)
    (funcall target-minor-mode 1)
    (setq sov-state state)))
    

(defun sov-enter-state (state)
  "Enter SOV state STATE, pushing it to the stack."
  (add-to-list 'sov-state-stack sov-state)
  (sov-switch-to-state state))

(defun sov-pop-state ()
  "Pop the last state from the stack, switching to it."
  (when (and (consp sov-state-stack)
	     (not (nullp sov-state-stack)))
    (let ((last-state (car sov-state-stack)))
      (setq sov-state-stack (cdr sov-state-stack))
      (sov-switch-to-state last-state))))



(defvar sov-default-state-for-major-modes
  nil
  "An association list with major modes as keys and
SOV states as values. When entering a new major mode,
SOV first tries to get the default state from this
alist, and uses 'normal if nothing is found.")

(defun sov-enter-default-state ()
  "Select a default SOV state and enter it."
  (let ((default-state
	  (or (cdr (assoc major-mode sov-default-state-for-major-modes))
	      'normal)))
	(sov-enter-state default-state)))


(add-hook 'buffer-list-update-hook 'sov-enter-default-state)
(add-hook 'minibuffer-setup-hook '(lambda () (sov-enter-state 'minibuffer)))
(add-hook 'minibuffer-exit-hook 'sov-pop-state)
   
(defmacro sov-define-movement-command (name &rest action)
  (declare (indent defun))
  (let* ((name/override (intern (concat "sov-" name)))
	 (name/expand (intern (concat "sov-" name "/expand"))))
    `(progn
       (defun ,name/override (prefix-arg)
	 (interactive "p")
	 ,(message "Discard current selection while performing %s" name)
	 ,@action
	 (set-mark-command nil))
       (defun ,name/expand (prefix-arg)
	 (interactive "p")
	 ,(message "Expand current selection by performing %s" name)
	 (unless (use-region-p)
	   (set-mark-command nil))
	 ,@action
	 (setq mark-active t)))))

(sov-define-movement-command "forward-char"  (forward-char  prefix-arg))
(sov-define-movement-command "backward-char" (backward-char prefix-arg))
(sov-define-movement-command "next-line"     (next-line     prefix-arg))
(sov-define-movement-command "previous-line" (previous-line prefix-arg))

(sov-define-movement-command "forward-word"  (forward-word  prefix-arg))
(sov-define-movement-command "backward-word" (backward-word prefix-arg))

(sov-define-movement-command "beginning-of-line"
			     (beginning-of-line prefix-arg))
(sov-define-movement-command "end-of-line"
			     (end-of-line prefix-arg))


;; The line selection commands are, unexpectedly, complex.
;; We want them to have the following behavious:
;; 1. Repeating this commands result in continuously selecting lines,
;;    instead of getting stuck in one line
;; 2. Since
(defun sov-select-line ()
  (interactive)
  (if (or (not (use-region-p))
	  (>= (point) (mark)))
      (progn
        (beginning-of-line nil)
        (set-mark-command nil)
        (end-of-line nil)
	(forward-char 1))
    (progn
      (end-of-line nil)
      (set-mark-command nil)
      (beginning-of-line nil)
      (backward-char 1))))
      
(defun sov-select-line/expand ()
  (interactive)
  (save-excursion
    (beginning-of-line)
    (setq bol (point))
    (end-of-line)
    (setq eol (point)))
  (cond
   ((or (not (use-region-p))
	(and (<= (point) (mark))
	     (>= (point) bol)))
    (progn
      (beginning-of-line nil)
      (set-mark-command nil)
      (goto-char (+ eol 1))))
    ((<= (point) (mark))
     (end-of-line nil))
    ;; Now we have (> (point) (mark))
    ((<= (point) eol)
     (progn
       (end-of-line nil)
       (set-mark-command nil)
       (goto-char (- bol 1))))
    (t
     (beginnig-of-line nil))))
  

    

(sov-define-movement-command "beginning-of-buffer"
			     (beginning-of-buffer))
(sov-define-movement-command "end-of-buffer"
			     (end-of-buffer))

(sov-define-movement-command "goto-line"
			     (goto-line prefix-arg))

(defun sov-delete (beg end)
  (interactive "r")
  (if (use-region-p)
      (kill-region beg end)
    (delete-char 1)))



(define-key sov-normal-keymap (kbd "t") 'sov-backward-char)
(define-key sov-normal-keymap (kbd "T") 'sov-backward-char/expand)
(define-key sov-normal-keymap (kbd "n") 'sov-forward-char)
(define-key sov-normal-keymap (kbd "N") 'sov-forward-char/expand)
(define-key sov-normal-keymap (kbd "r") 'sov-previous-line)
(define-key sov-normal-keymap (kbd "R") 'sov-previous-line/expand)
(define-key sov-normal-keymap (kbd "h") 'sov-next-line)
(define-key sov-normal-keymap (kbd "H") 'sov-next-line/expand)
(define-key sov-normal-keymap (kbd "C-t") 'sov-beginning-of-line)
(define-key sov-normal-keymap (kbd "C-n") 'sov-end-of-line)
(define-key sov-normal-keymap (kbd "x") 'sov-select-line)
(define-key sov-normal-keymap (kbd "X") 'sov-select-line/expand)
(define-key sov-normal-keymap (kbd "j") 'sov-forward-word)
(define-key sov-normal-keymap (kbd "J") 'sov-forward-word/expand)
(define-key sov-normal-keymap (kbd "k") 'sov-backward-word)
(define-key sov-normal-keymap (kbd "K") 'sov-backward-word/expand)
(define-key sov-normal-keymap (kbd ":") 'execute-extended-command)
(define-key sov-normal-keymap (kbd "d") 'sov-delete)
(define-key sov-normal-keymap (kbd "u") 'undo-tree-undo)
(define-key sov-normal-keymap (kbd "U") 'undo-tree-redo)
(define-key sov-normal-keymap (kbd "p") 'yank)
(define-key sov-normal-keymap (kbd "y") 'kill-ring-save)
(define-key sov-normal-keymap (kbd "i") '(lambda () (interactive) (sov-enter-state 'insert)))
(define-key sov-normal-keymap (kbd "<ESC>") 'undefined)

(define-key sov-insert-keymap (kbd "<ESC>")
  '(lambda () (interactive) (sov-enter-state 'normal)))

(provide 'sov3)
