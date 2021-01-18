(load "~/.emacs.d/lisp/custom.el")

(load "~/.emacs.d/lisp/iscroll.el")

(ido-mode t)
(setq ido-everywhere t)
(setq ido-enable-flex-matching t)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(use-package which-key
  :ensure t
  :config (which-key-mode))

(pdf-loader-install)

(setq ispell-program-name
      "C:/hunspell/bin/hunspell.exe")
(global-set-key (kbd "C-<f8>")
		'flyspell-check-previous-highlighted-word)

(use-package auto-complete
  :ensure t
  :init
  (progn
    (ac-config-default)
    (global-auto-complete-mode t)))

;; Company-mode
(use-package company
  :ensure t
  :init (add-hook 'after-init-hook 'global-company-mode))

(use-package dired-subtree
  :ensure t
  :bind (:map dired-mode-map
	      ("i" . dired-subtree-insert)
	      (";" . dired-subtree-remove)
	      ("<tab>" . dired-subtree-toggle)
	      ("<backtab>" . dired-subtree-cycle)))

(use-package org-bullets
  :ensure t
  :init
  (setq org-bullets-bullet-list
	'("◉" "∴" "➞" "➵" "➾"))
  (setq org-todo-keywords '((sequence "☛ TODO(t)" "➤ NEXT(n)" "|" "✔ DONE(d)" "|")
			    (sequence "∞ WAITING(w)" "|"  "✘ CANCELED(c)")))
  :config (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((sparql . t)
   (R . t)
   (python . t)
   (C . t)
   (dot . t)
   (java . t)))

(require 'org-tempo)
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("py" . "src python :results output :exports both"))
(add-to-list 'org-structure-template-alist '("pyp" . "src python :session :results output :exports both"))
(add-to-list 'org-structure-template-alist '("cp" . "src C"))
(add-to-list 'org-structure-template-alist '("ja" . "src java :results output"))
(add-to-list 'org-structure-template-alist '("sp" . "src sparql"))
(add-to-list 'org-structure-template-alist '("dt" . "src dot"))

(defun ck/org-confirm-babel-evaluate (lang body)
  (not (or (string= lang "latex") (string= lang "python")
	   (string= lang "sparql") (string= lang "emacs-lisp"))))
(setq org-confirm-babel-evaluate 'ck/org-confirm-babel-evaluate)

(setq org-agenda-files '("~/Org/todo.org"
			 "~/Org/Tasks.org"
			 "~/Org/Birthdays.org"))
(global-set-key (kbd "C-c a") 'org-agenda)

(setq org-agenda-start-with-log-mode t)
(setq org-log-done 'time)
(setq org-ellipsis "⤵")
(setq org-log-done t)
(setq org-log-into-drawer t)

(setq org-hide-emphasis-markers t)
(setq org-image-actual-width nil)
(eval-after-load 'org
  (add-hook 'org-babel-after-execute-hook 'org-redisplay-inline-images))
(setq org-comfim-babel-evaluate nil)

(require 'dired+)
(use-package treemacs-icons-dired
  :after treemacs dired
  :ensure t
  :config (treemacs-icons-dired-mode))
(add-hook 'dired-mode-hook 'treemacs-icons-dired-mode)

(defadvice dired-subtree-toggle (after add-icons activate) (treemacs-icons-dired--display))
(defadvice dired-subtree-toggle (after add-icons activate) (revert-buffer))

(customize-set-variable 'diredp-dir-name t nil)
(customize-set-variable 'diredp-dir-heading t nil)
(customize-set-variable 'diredp-file-name t nil)
(customize-set-variable 'diredp-file-suffix t nil)

(global-prettify-symbols-mode 1)
(defun add-pretty-lambda ()
  (setq prettify-symbols-alist
	'(
	  ("lambda" . 955)
	  ("delta" . 120517)
	  ("epsilon" . 120518)
	  ("->" . 8594)
	  ("Wking" . 9812)
	  ("WQueen" . 9813)
	  ("WRook" . 9814)
	  ("WBishop" . 9815)
	  ("WKnight" . 9816)
	  ("WPawn" . 9817)
	  ("&Sum" . ∑)
	  ("<=" . 8804)
	  (">=" . 8805)
	  ("#+BEGIN_SRC"     . "λ")
	  ("#+END_SRC"       . "λ")
	  ("#+begin_src"     . "λ")
	  ("#+end_src"       . "λ")
	  )))
(add-hook 'prog-mode-hook 'add-pretty-lambda)
(add-hook 'org-mode-hook 'add-pretty-lambda)

(require 'ytdl)
(ytdl-add-field-in-download-type-list "Music"
				      "m"
				      (expand-file-name "~/Music")
				      nil)

(defalias 'ff 'find-file)
(defalias 'ffo 'find-file-other-window)

(setq 
 eshell-prompt-regexp
 "^[^λ]+ λ ")
(setq eshell-prompt-function
      (lambda ()
	(concat
	 (format-time-string
	  "%Y-%m-%d" (current-time))
	 (if
	     (= (user-uid) 0) " # " " λ "))))

(defun eshell-other-window ()
  "Open a `shell' in a new window."
  (interactive)
  (let ((buf (eshell)))
    (switch-to-buffer (other-buffer buf))
    (switch-to-buffer-other-window buf)))

(global-set-key (kbd "M-s e")
		'eshell-other-window)

(defun start-cmd ()
  (interactive)
  (let ((proc (start-process "cmd" nil "cmd.exe" "/C" "start" "\"---\"" "cmd.exe")))
    (set-process-query-on-exit-flag proc nill)))

(add-hook 'java-mode-hook 'gradle-mode)

(setq inferior-lisp-program "clisp -I")

(use-package elpy
  :ensure t
  :init
  (elpy-enable))

(use-package ein
  :ensure t
  :init
  :config (require 'ein)
  (require 'ein-notebook))
(customize-set-variable 'ein:output-area-inlined-images t)

(when (load "flymake" t)
  (add-to-list 'flymake-allowed-file-name-masks
	       '("\\.py\\'" flymake-pyflakes-init)))

(setq python-shell-interpreter "python"
      python-shell-interpreter-args "-i")

(setenv "WORKON_HOME" "c:/Users/afons/py_home")

(add-to-list 'auto-mode-alist '("\\.sparql$" . sparql-mode))
(add-to-list 'auto-mode-alist '("\\.rq$" . sparql-mode))
(add-hook 'sparql-mode-hook 'auto-complete-mode)

(require 'latex)
(setq TeX-view-program-selection '((output-pdf "PDF Tools"))
      TeX-source-correlate-start-server t)
(add-hook 'TeX-after-compilation-finished-functions
	   #'TeX-revert-document-buffer)
(setq org-format-latex-options (plist-put org-format-latex-options :scale 1.3))
(put 'dired-find-alternate-file 'disabled nil)
(add-hook 'text-mode-hook 'flyspell-mode)

(add-hook 'haskell-mode-hook 'interactive-haskell-mode)

(add-to-list 'load-path "~/.emacs.d/freest-mode/")
(require 'freest-mode)
(add-to-list 'auto-mode-alist '("\\.fst\\'" . freest-mode))

(setq processing-location "c:/processing-3.5.4/processing-java.exe")

(setq inhibit-startup-screen t)
(setq initial-major-mode 'text-mode)
(setq initial-scratch-message 
      "Present Day, Present Time...\n")

(load "~/.emacs.d/elegant-emacs/elegance.el")

(scroll-bar-mode 0)
(menu-bar-mode 0)
(tool-bar-mode 0)
(setq visible-bell t)

(setq default-directory (concat (getenv "HOME") "/"))

;(add-to-list 'default-frame-alist 
;	     '(fullscreen . fullboth))

;;(set-face-attribute
;; 'default nil
;; :font "Consolas 17" )

(set-frame-font
 "Consolas 22" nil t)

(display-time-mode 1)
(display-battery-mode 1)

(defun custom/kill-this-buffer ()
  (interactive) (kill-buffer (current-buffer)))

(global-set-key (kbd "C-x k")
		'kill-buffer-and-window)

(global-set-key (kbd "C-c k")
		'kill-buffer)

(global-set-key (kbd "C-S-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "C-S-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "C-S-<down>") 'shrink-window)
(global-set-key (kbd "C-S-<up>") 'enlarge-window)

(global-set-key (kbd "<f6>") 'whitespace-mode)

(setq utf-translate-cjk-mode nil)
(set-language-environment "UTF-8")
(setq locale-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-selection-coding-system
 (if (eq system-type 'windows-nt)
      'utf-16-le
    'utf-8))
(prefer-coding-system 'utf-8)

(setq backup-by-copying t
      backup-directory-alist '(("." . "~/.saves/"))
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)
