
(require 'cl)

(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (setq package-archives
	'(("gnu" . "https://elpa.emacs-china.org/gnu/")
	  ("melpa" . "https://elpa.emacs-china.org/melpa/"))))

(defvar my/packages
  '(use-package
    undo-tree
    monokai-theme
    hydra
    multiple-cursors
    proof-general))

(let ((first-to-install? nil))
  (loop for pkg in my/packages
	when (not (package-installed-p pkg))
	do (progn
	     (when (not first-to-install?)
	       (message "%s" "Updating packages...")
	       (package-refresh-contents)
	       (setq first-to-install? t))
    	     (package-install pkg))))

(provide 'my-packages)
