

(add-to-list 'load-path "~/.emacs.d/lisp/")

(require 'my-packages)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (undo-tree))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'key-binding)
(require 'appearance)



;;; Options
(global-display-line-numbers-mode "relative")
;(setq global-linum-mode "relative")

(setq xterm-extra-capabilities nil)

(setq initial-buffer-choice nil)

(setq-default indent-tabs-mode nil)

(setq make-backup-files nil)
(setq auto-save-default nil)

(global-undo-tree-mode)

(setq msm-global-default-state 'normal)

(add-hook 'minibuffer-setup-hook '(lambda () (msm-enter-state 'minibuffer)))
(add-hook 'minibuffer-exit-hook  '(lambda () (msm-pop-state)))
