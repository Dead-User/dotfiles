;;; msm.el --- Multi State Modal editing facilities -*- lexical-binding: t -*-
;;

;;; Commentary:
;; This file provides facilities for defining one's own VIM-like multi-state
;; modal editing, allowing more than two modes to be defined.
;; States in msm.el are represented by minor modes. Each state has its own
;; associated minor mode and keymap.

(defvar msm-current-state 'normal
  "The current state of msm.el")

(defvar msm-previous-states nil
  "A list of previous states entered, used for state recovery when temporarily
switching to other states.")

(defvar msm-state-list nil
  "The list of defined states of msm.el.
Each element should have the from (list name toggle-command keymap),
where NAME is the name of the state, TOGGLE-COMMAND is its associated
minor mode toggling command, and KEYMAP is its keymap")

(defvar msm-default-state-for-major-modes nil
  "An association list of the form `((major-mode state) ...), specifying the
default msm state to enter when entering a new major mode. If the associated
state is `nil', msm will disable all states.")

(defvar msm-global-default-state nil
  "This value, if non-nil, serves as the default state when no entry is found
in `msm-default-state-for-major-modes'.")

;; States generally have two kinds. One is similar to the NORMAl state of VIM,
;; with all inserting commands disabled. msm.el additionally disables <ESC>, 
;; avoiding conflict with emacs's builtin M- key-bindings.
;;
;; The other kind of states are similar to the INSERT state of VIM, with all
;; self-inserting keys enabled. msm.el leaves most of emacs commands available
;; in such states, unlike evil.
(defun msm-make-normal-keymap ()
  "Create a NORMAL-style keymap."
  (let ((keymap (make-sparse-keymap)))
    (suppress-keymap keymap)
    (define-key keymap (kbd "<ESC>") 'undefined)
    (define-key keymap (kbd "<RET>") 'undefined)
    (define-key keymap (kbd "?\t") 'undefined)
    (define-key keymap (kbd "<DEL>") 'undefined)
    keymap))

(defalias 'msm-make-insert-keymap 'make-sparse-keymap
  "Create a INSERT-style keymap.")


;; As you might expect, defining many states in msm.el results in many different
;; minor modes. Having more than one of these modes enabled would be a disaster
;; in most of times. So a main job of msm.el is to guarantee that no two msm.el
;; defined states would be enabled at the same time.
;;
;; To achieve this, it is required that all state switching be done through the
;; following functions, so that msm.el can manage states properly.
(defun msm-switch-to-state (target-state)
  "Switch to msm.el state TARGET-STATE."
  (interactive)
  (let* ((current-state-entry (assoc msm-current-state msm-state-list))
	 (current-state-toggle-command (nth 1 current-state-entry))
	 (target-state-entry (or (assoc target-state msm-state-list)
				 (error "msm.el: Undefined state %s." (symbol-name target-state))))
	 (target-state-toggle-command (nth 1 target-state-entry)))
    (funcall current-state-toggle-command -1)
    (funcall target-state-toggle-command 1)
    (setq msm-current-state target-state)))

(defun msm-enter-state (target-state)
  "Switch to msm.el state TARGET-STATE, pushing current state to the previous states list"
  (interactive)
  (setq msm-previous-states (cons msm-current-state msm-previous-states))
  (msm-switch-to-state target-state))

(defun msm-pop-state ()
  "Pop the last state from the previous states list and switch to it."
  (interactive)
  (let ((last-state (or (car msm-previous-states)
			(error "msm.el: No previous states to pop."))))
    (setq msm-previous-states (cdr msm-previous-states))
    (msm-switch-to-state last-state)))




;; Useful for integration with other tools like hydra.
(defun msm-get-keymap-of-state (state)
  "Get the keymap of msm state STATE."
  (let ((entry (assoc state msm-state-list)))
    (if entry
        (nth 2 entry)
      (error "msm.el: Undefined state %s" state))))

;; This macro is used to define keybindings for msm states.
;; STATES can be a list of or a single msm state names, specifying msm states to define
;; the key bindings.
;; KEY-CMD-ALIST is a list of the form `((key command) ...), where KEY and COMMAND are
;; exactly those the builtin `define-key' accepts.
(defmacro msm-define-keys (states &rest key-cmd-alist)
  "Define key-binding for all msm-states in STATES (STATES can be a single state rather
than a list, too), with key-bindings specified in KEY-CMD-ALIST, in (list key command)
format."
  `(progn
     ,@(seq-map
        (lambda (state)
          `(let* ((state-keymap (msm-get-keymap-of-state (quote ,state))))
             (progn
               ,@(seq-map (lambda (entry)
                            `(define-key state-keymap ,(nth 0 entry) ,(nth 1 entry)))
                          key-cmd-alist))))
       (if (consp states) states (list states)))))


;; This macro defines a new msm state called NAME.
;; Specifying a keyword argument `:type' (either `normal' or `insert') in ARGS tells the
;; macro which type of state will be defined, affecting the defalut keymap of the new state.
;; All other arguments in ARGS will be directly passed to `define-minor-mode'.
;;
;; This macro also record information about the new state, so it is necessary to use this
;; macro to define msm states instead of ordinary minor modes.
(defmacro msm-define-state (name &rest args)
  (declare (indent defun))
  (let* ((state-type (or (plist-get args :type) 'normal))
         (minor-mode-name (make-symbol (concat "msm-state-" (symbol-name name)))))
    `(let ((init-keymap ,(if (equal state-type 'normal)
			    '(msm-make-normal-keymap)
			  '(msm-make-insert-keymap))))
       (define-minor-mode ,minor-mode-name
	 ,(concat "Toggle minor mode for msm state " (symbol-name name))
	  :keymap init-keymap
	  ,@args)
       (add-to-list 'msm-state-list (list (quote ,name) (quote ,minor-mode-name) init-keymap)))))



;; Auto state entering facilities.
(defun msm-disable-all-states ()
  (interactive)
  (mapc
   (lambda (entry)
     (funcall (nth 1 entry) -1))
   msm-state-list))

(defun msm-enter-default-state ()
  (let ((entry (assoc major-mode msm-default-state-for-major-modes)))
    (cond
     ; No default state specified
     ((not entry)
      (if msm-global-default-state
	  (msm-enter-state msm-global-default-state)
	(msm-disable-all-states)))
     ; It is specified that no states should be enabled
     ((not (cdr entry))
      (msm-disable-all-states))
     (t
      (msm-enter-state (cdr entry))))))

(add-hook 'buffer-list-update-hook 'msm-enter-default-state)
(add-hook 'after-change-major-mode-hook 'msm-enter-default-state)

(provide 'msm)
