(load "~/.emacs.d/lisp/custom.el")

(defun EmacsOff ()
  (interactive)
  (let ((last-nonmenu-event nil))(save-buffers-kill-emacs)))

(defun EmacsRestart ()
  "Kills and Restarts Emacs Server"
  (interactive)
  (let ((proc (start-process "StartEmacsServer.bat" nil "StartEmacsServer"))))
  (EmacsOff))

(load "~/.emacs.d/lisp/iscroll.el")

(ido-mode t)
(setq ido-everywhere t)
(setq ido-enable-flex-matching t)
(setq ido-separator "\n")

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; (helm-mode 1)
;; (global-set-key (kbd "M-x") #'helm-M-x)
;; (global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
;; (global-set-key (kbd "C-x C-f") #'helm-find-files)
;; 
;; (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
;; (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
;; (define-key helm-map (kbd "C-z")  'helm-select-action)

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
  )

(yas-global-mode 1)

;; Company-mode
; No delay in showing suggestions.
(setq company-idle-delay 0)

; Show suggestions after entering one character.
(setq company-minimum-prefix-length 1)

; go back up in the end
(setq company-selection-wrap-around t)

; Use tab key to cycle through suggestions.
; ('tng' means 'tab and go')
(company-tng-configure-default)

(defun tab-indent-or-complete ()
  (interactive)
  (if (minibufferp)
      (minibuffer-complete)
    (if (or (not yas-minor-mode)
	    (null (do-yas-expand)))
	(if (check-expansion)
	    (company-complete-common)
	  (indent-for-tab-command)))))

(global-set-key [backtab] 'tab-indent-or-complete)

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
  (setq org-todo-keywords 
  '((sequence "☛ TODO(t)" "➤ NEXT(n)" "|" "✔ DONE(d)")
  (sequence "∞ WAITING(w)" "|"  "✘ CANCELED(c)")
  (sequence "∞ READING(r)" "∞ VIEWING(v)" "|"  "◤ FINISHED(f)")))
  :config (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((sparql . t)
   (R . t)
   (python . t)
   (C . t)
   (dot . t)
   (java . t)
   (lisp . t)
   (shell . t)
   (prolog . t)))

(require 'org-tempo)
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("py" . "src python :results output :exports both"))
(add-to-list 'org-structure-template-alist '("pyp" . "src python :session :results output :exports both"))
(add-to-list 'org-structure-template-alist '("cp" . "src C"))
(add-to-list 'org-structure-template-alist '("ja" . "src java :results output"))
(add-to-list 'org-structure-template-alist '("sp" . "src sparql"))
(add-to-list 'org-structure-template-alist '("dt" . "src dot"))
(add-to-list 'org-structure-template-alist '("cl" . "src lisp"))
(add-to-list 'org-structure-template-alist '("pr" . "src prolog"))

(setq org-tag-alist '((:startgroup . nil)
		      ("@University" . ?u) ("@Personal" . ?p)
		      ("@Band" . ?m)
		      (:endgroup . nil)
		      (:startgroup . nil)
		      ("Study" . ?s) ("Leisure" . ?l)
		      ("Work" . ?w)
		      (:endgroup . nil)
		      (:startgroup . nil)
		      ("Books" . ?B) ("Films" . ?F)
		      ("Series" . ?S) ("Anime" . ?A)
		      ("Music" . ?m)
		      (:endgroup . nil)
		      ))

(defun ck/org-confirm-babel-evaluate (lang body)
  (not (or (string= lang "latex") (string= lang "python")
	   (string= lang "sparql") (string= lang "emacs-lisp")
	   (string= lang "lisp") (string= lang "dot"))))
(setq org-confirm-babel-evaluate 'ck/org-confirm-babel-evaluate)

(setq org-agenda-files '("~/Org/University.org"
			 "~/Org/Personal.org"
			 "~/Org/Birthdays.org"))
(global-set-key (kbd "C-c a") 'org-agenda)
(setq org-refile-targets
      '(("~/Org/University.org" :maxlevel . 2)
	("~/Org/Personal.org" :maxlevel . 1)))

(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c c") 'org-capture)

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

(setq org-agenda-custom-commands
      '(("U" "Agenda & University"
	 ((agenda "")
	  (tags-todo "@University+Study-DONE")
	  (tags "+Level=4+Projects-DONE")))
	("P" "Agenda & Personal"
	 ((agenda "")
	  (tags-todo "@Personal-DONE")
	  (tags "+Level=3+Books")
	  (tags "+Level=3+Series")
	  (tags "+Level=3+Anime")
	  ))))

(use-package org-roam
  :ensure t
  :hook (after-init . org-roam-mode)
  :custom 
  (org-roam-directory "~/Org/roam/")
  :bind (:map org-roam-mode-map
	 (("C-c n l" . org-roam)
	  ("C-c n f" . org-roam-find-file)
	  ("C-c n g" . org-roam-graph)
	  ("C-c n b" . org-roam-switch-to-buffer)
	  ("C-c n r" . org-roam-find-ref))
	 :map org-mode-map
	 (("C-c n i" . org-roam-insert))))

(setq org-roam-completion-system 'ivy)
(setq org-roam-db-update-method 'immediate)

(use-package org-roam-server
  :ensure t
  :config
  (setq org-roam-server-host "127.0.0.1"
	org-roam-server-port 8080
	org-roam-server-authenticate nil
	org-roam-server-export-inline-images t
	org-roam-server-serve-files nil
	org-roam-server-served-file-extensions '("pdf" "mp4" "ogv")
	org-roam-server-network-poll t
	org-roam-server-network-arrows nil
	org-roam-server-network-label-truncate t
	org-roam-server-network-label-truncate-length 60
	org-roam-server-network-label-wrap-length 20))

(defun Graph ()
  (interactive)
  (if (bound-and-true-p org-roam-server-mode)
      (browse-url "http://127.0.0.1:8080")
    (org-roam-server-mode) (browse-url "http://127.0.0.1:8080")))

(global-set-key (kbd "C-c n G") 'Graph)

(use-package deft
  :after org
  :bind
  ("C-c n d" . deft)
  :custom
  (deft-recursive t)
  (deft-use-filter-string-for-filename t)
  (deft-default-extension "org")
  (deft-directory "~/Org/roam"))

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
		("epsilon" . 120518)
		("->" . 8594)
		("Wking" . 9812)
		("WQueen" . 9813)
		("WRook" . 9814)
		("WBishop" . 9815)
		("WKnight" . 9816)
		("WPawn" . 9817)
		("!sum" . ?∑)
		("<=" . 8804)
		(">=" . 8805)
		("=>" . ?➡)
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

(setq elfeed-feeds
	   '(("https://www.youtube.com/feeds/videos.xml?channel_id=UCnkp4xDOwqqJD7sSM3xdUiQ" Adam Neely YT)
	     ("https://www.youtube.com/feeds/videos.xml?channel_id=UC-lHJZR3Gqxm24_Vd_AJ5Yw" Pewdiepie YT)
	     ("https://videos.lukesmith.xyz/feeds/videos.xml?sort=-publishedAt&filter=local" Luke Smith TB))
	   )

(require 'olivetti)
(olivetti-set-width 60)
(olivetti-mode 1)

(global-set-key (kbd "C-c o") 'olivetti-mode)
(global-set-key (kbd "C-c r") 'writeroom-mode)

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

(defun start-wt ()
  (interactive)
  (let ((proc (start-process "windows terminal" nil "wt.exe" "-f" "-d" ".")))))

(global-set-key [f5] 'start-wt)

(defun Explorer ()
  (interactive)
  (let ((proc (start-process "Windows Explorer" nil "explorer.exe" ".")))))

(defun VScode ()
  (interactive)
  (let ((proc (start-process "VS Code" nil "code" (buffer-file-name))))))

(add-hook 'java-mode-hook 'gradle-mode)

(custom-set-variables
 '(jdee-server-dir "~\\.emacs.d\\jdee-server"))

(setq inferior-lisp-program "sbcl")
(add-hook 'lisp-mode-hook #'enable-paredit-mode)
(add-hook 'emacs-lisp-mode-hook #'enable-paredit-mode)

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
(setq org-format-latex-options (plist-put org-format-latex-options :scale 1.9))
(put 'dired-find-alternate-file 'disabled nil)
(add-hook 'text-mode-hook 'flyspell-mode)

(add-hook 'haskell-mode-hook 'interactive-haskell-mode)

(add-to-list 'load-path "~/.emacs.d/freest-mode/")
(require 'freest-mode)
(add-to-list 'auto-mode-alist '("\\.fst\\'" . freest-mode))

(setq processing-location "c:/processing-3.5.4/processing-java.exe")

(setq company-clang-arguments . ("-IC:\\MinGW\\include"))

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(add-hook 'js-mode-hook
	  (lambda ()
	    (define-key js-mode-map (kbd "C-x C-e") 'nodejs-repl-send-last-expression)
	    (define-key js-mode-map (kbd "C-c C-j") 'nodejs-repl-send-line)
	    (define-key js-mode-map (kbd "C-c C-r") 'nodejs-repl-send-region)
	    (define-key js-mode-map (kbd "C-c C-c") 'nodejs-repl-send-buffer)
	    (define-key js-mode-map (kbd "C-c C-l") 'nodejs-repl-load-file)
	    (define-key js-mode-map (kbd "C-c C-z") 'nodejs-repl-switch-to-repl)))

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1)
  (setq company-idle-delay 0))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

(add-hook 'typescript-mode-hook #'setup-tide-mode)

(require 'ediprolog)
(autoload 'run-prolog "prolog" "Start a Prolog sub-process." t)
(autoload 'prolog-mode "prolog" "Major mode for editing Prolog programs." t)
(setq prolog-program-name "C:/swipl/bin/swipl.exe")
(setq ediprolog-program "C:\\swipl\\bin\\swipl.exe")
;(setq ediprolog-program-switches '("-g" "set_prolog_flag(tty_control, false)"))
;(setq ediprolog-program-switches '("-g" "set_prolog_flag(readline, false)"))
(setq prolog-system 'swi)
(add-to-list 'auto-mode-alist '("\\.pl\\'" . prolog-mode))
(global-set-key [f10] 'ediprolog-dwim)

(use-package go-mode
  :mode "\\.go$"
  :interpreter "go"
  :init
  (add-hook 'go-mode-hook 'auto-complete-mode)
  )

(load "~/.emacs.d/elegant-emacs/elegance.el")

(scroll-bar-mode 0)
(menu-bar-mode 0)
(tool-bar-mode 0)
(setq visible-bell t)

(setq default-directory (concat (getenv "HOME") "/"))

(add-to-list 'default-frame-alist 
	     '(fullscreen . fullboth))

(set-face-attribute
 'default nil
 :font "Consolas 17" )

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

(global-set-key (kbd "C-d") 'delete-region)

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

(setq inhibit-startup-screen t)
(setq initial-major-mode 'text-mode)
(setq initial-scratch-message 
      "Present Day, Present Time...\n")
