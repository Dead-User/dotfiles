
(require 'msm)
(require 'sov)
(require 'hydra)


;; I map Capslock to ESC (at system level). I prefer using ESC to switch between
;; different editing states (in whatever editor). But, certainly, emacs keys are
;; useful ...
(setq meta-prefix-char 5)

(msm-define-state normal
  :type normal
  :init-value nil
  :lighter " NORMAL")

(msm-define-keys normal
		 ((kbd "i") '(lambda () (interactive) (msm-enter-state 'insert)))
		 ((kbd "n") 'sov-forward-char/move)
		 ((kbd "N") 'sov-forward-char/expand)
		 ((kbd "t") 'sov-backward-char/move)
		 ((kbd "T") 'sov-backward-char/expand)
		 ((kbd "h") 'sov-next-line/move)
		 ((kbd "H") 'sov-next-line/expand)
		 ((kbd "r") 'sov-previous-line/move)
		 ((kbd "R") 'sov-previous-line/expand)
		 ((kbd "C-t") 'sov-beginning-of-line/move)
		 ((kbd "C-n") 'sov-end-of-line/move)
		 ((kbd "x") 'sov-line/select)
		 ((kbd "X") 'sov-line/expand)
		 ((kbd "j") 'sov-forward-word/select)
		 ((kbd "J") 'sov-forward-word/expand)
		 ((kbd "k") 'sov-backward-word/select)
		 ((kbd "K") 'sov-backward-word/expand)
                 ((kbd "g") 'hydra-sov-goto/move/body)
                 ((kbd "G") 'hydra-sov-goto/expand/body)
		 ((kbd "%") 'sov-select-whole-buffer)
		 ((kbd "d") 'sov-kill)
		 ((kbd "c")
		  '(lambda ()
		     (interactive)
		     (sov-kill)
		     (msm-enter-state 'insert)))
		 ((kbd "y") 'sov-copy-region)
                 ((kbd "p") 'yank)
		 ((kbd "u") 'undo-tree-undo)
		 ((kbd "U") 'undo-tree-redo)
;                 ((kbd ":") 'enchanced-evaluate-command)
		 ((kbd ":") 'execute-extended-command)
                 ((kbd "C") 'mc/mark-next-like-this)
                 ((kbd "s") 'mc/mark-all-in-region)
                 ((kbd ";") '(lambda () (interactive) (mc/keyboard-quit) (sov-reduce-region-to-point))))

(defun enchanced-evaluate-command ()
  (interactive)
  (eval-expression (read-minibuffer ":" (cons "()" 2))))

(defhydra hydra-sov-goto/move (:hint nil
                               :exit t)
  "goto mode (move)
g : beginning of buffer    e : end of buffer
r : one page down          h : one page up
0 : beginning of line      $ : end of line
"
  ("g" sov-beginning-of-buffer/move)
  ("e" sov-end-of-buffer/move)
  ("r" sov-scroll-down/move)
  ("h" sov-scroll-up/move)
  ("0" sov-beginning-of-line/move)
  ("$" sov-end-of-line/move))

(defhydra hydra-sov-goto/expand (:hint nil
                                 :exit t)
  "goto mode (expand)
g : beginning of buffer    e : end of buffer
0 : beginning of line      $ : end of line
"
  ("g" sov-beginning-of-buffer/expand)
  ("e" sov-end-of-buffer/expand)
  ("0" sov-beginning-of-line/expand)
  ("$" sov-end-of-line/expand))


(msm-define-state insert
  :type insert
  :init-value nil
  :lighter " INSERT")

(msm-define-keys insert
		 ((kbd "<ESC>") '(lambda () (interactive) (msm-enter-state 'normal))))


(msm-define-state minibuffer
  :type insert
  :init-value nil
  :lighter " MINIBUFFER")

(msm-define-keys minibuffer
		 ((kbd "<ESC>") 'keyboard-quit))


(provide 'key-binding)
