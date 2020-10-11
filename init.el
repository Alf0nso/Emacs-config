;;;
;; Package stuff
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; always use use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Whic-key
(use-package which-key
  :ensure t
  :config (which-key-mode))

;; Ido
(ido-mode t)
(setq ido-everywhere t)
(setq ido-enable-flex-matching t)

;; Smex
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; Treemacs
(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs                 (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay      0.5
          treemacs-directory-name-transformer    #'identity
          treemacs-display-in-side-window        t
          treemacs-eldoc-display                 t
          treemacs-file-event-delay              5000
          treemacs-file-extension-regex          treemacs-last-period-regex-value
          treemacs-file-follow-delay             0.2
          treemacs-file-name-transformer         #'identity
          treemacs-follow-after-init             t
          treemacs-git-command-pipe              ""
          treemacs-goto-tag-strategy             'refetch-index
          treemacs-indentation                   2
          treemacs-indentation-string            " "
          treemacs-is-never-other-window         nil
          treemacs-max-git-entries               5000
          treemacs-missing-project-action        'ask
          treemacs-move-forward-on-expand        nil
          treemacs-no-png-images                 nil
          treemacs-no-delete-other-windows       t
          treemacs-project-follow-cleanup        nil
          treemacs-persist-file                  (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position                      'left
          treemacs-recenter-distance             0.1
          treemacs-recenter-after-file-follow    nil
          treemacs-recenter-after-tag-follow     nil
          treemacs-recenter-after-project-jump   'always
          treemacs-recenter-after-project-expand 'on-distance
          treemacs-show-cursor                   nil
          treemacs-show-hidden-files             t
          treemacs-silent-filewatch              nil
          treemacs-silent-refresh                nil
          treemacs-sorting                       'alphabetic-asc
          treemacs-space-between-root-nodes      t
          treemacs-tag-follow-cleanup            t
          treemacs-tag-follow-delay              1.5
          treemacs-user-mode-line-format         nil
          treemacs-user-header-line-format       nil
          treemacs-width                         35
          treemacs-workspace-switch-cleanup      nil)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode t)
    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple))))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

;; Treemacs python search isn't working by default
(setq treemacs-python-executable "C:/Users/afons/AppData/Local/Programs/Python/Python38-32/python.exe")

;; Gives the treemacs icons on dired
(use-package treemacs-icons-dired
  :after treemacs dired
  :ensure t
  :config (treemacs-icons-dired-mode))

;; Magit integration in emacs
(use-package treemacs-magit
  :after treemacs magit
  :ensure t)

;; Pdf-tools
(pdf-loader-install)

;; Org-bullets
(use-package org-bullets
  :ensure t
  :init
  (setq org-bullets-bullet-list
	'("◉" "➥" "➞" "➵" "➾"))
  (setq org-todo-keywords '((sequence "☛ TODO(t)" "|" "✔ DONE(d)" "|")
			    (sequence "∞ WAITING(w)" "|")
			    (sequence "|" "✘ CANCELED(c)")))
  :config (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

;;;
;; Don't show the Emacs splash screen
(setq inhibit-startup-screen t)

;; Set default-directory to Home directory
(setq default-directory (concat (getenv "HOME") "/"))

;; Hide bars and menus alarms and others
(scroll-bar-mode 0)
(menu-bar-mode 0)
(tool-bar-mode 0)
(setq visible-bell t)
(add-to-list 'default-frame-alist '(fullscreen . fullboth))
(set-face-attribute 'default nil :font "Consolas 14" )
(set-frame-font "Consolas 14" nil t)

;; Be sure that anything deleted goes to trash
(setq delete-by-moving-to-t t)

;; Emacs encondings
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

;; Better frame control
(global-set-key (kbd "C-x o") 'ace-window)

;; Theme (colors of the emacs editor)
(load-theme 'solarized-gruvbox-dark t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ein:output-area-inlined-images t)
 '(package-selected-packages
   '(ace-window sparql-mode pdf-tools ein solarized-theme auto-complete auctex use-package smex pyvenv org-bullets treemacs-persp treemacs-magit treemacs-icons-dired treemacs gradle-mode which-key helm gnu-elpa-keyring-update)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Backing up files on a directory
(setq backup-by-copying t
      backup-directory-alist '(("." . "~/.saves/"))
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

;; Spell checker
(setq ispell-program-name "C:/hunspell/bin/hunspell.exe")
(global-set-key (kbd "C-<f8>") 'flyspell-check-previous-highlighted-word)

;; Auto-complete
(use-package auto-complete
  :ensure t
  :init
  (progn
    (ac-config-default)
    (global-auto-complete-mode t)
    ))


;; Eshell stuff
; λ
(defalias 'ff 'find-file)
(defalias 'ffo 'find-file-other-window)

(setq eshell-prompt-regexp "^[^λ]+ λ ")
(setq eshell-prompt-function
  (lambda ()
    (concat (format-time-string "%Y-%m-%d" (current-time))
      (if (= (user-uid) 0) " # " " λ "))))
;;;
;; Org
(setq org-hide-emphasis-markers t)
(setq org-image-actual-width nil)

;; Java
(add-hook 'java-mode-hook 'gradle-mode)

;; Python
(setenv "WORKON_HOME" "c:/Users/afons/py_home")
(use-package ein
  :ensure t
  :init
  :config (require 'ein)
  (require 'ein-notebook)
  (require 'ein-subpackages))

;; Sparql
(add-to-list 'auto-mode-alist '("\\.sparql$" . sparql-mode))
(add-to-list 'auto-mode-alist '("\\.rq$" . sparql-mode))

;; Latex
(require 'latex)
(setq TeX-view-program-selection '((output-pdf "PDF Tools"))
      TeX-source-correlate-start-server t)
(add-hook 'TeX-after-compilation-finished-functions
           #'TeX-revert-document-buffer)
(setq org-format-latex-options (plist-put org-format-latex-options :scale 1.3))
(put 'dired-find-alternate-file 'disabled nil)

;; Org-babel
(org-babel-do-load-languages
 'org-babel-load-languages
 '((sparql . t)))

;; Dired
(add-hook 'dired-mode-hook
      (lambda ()
        (dired-hide-details-mode)))



;; Start commands
(treemacs-icons-dired-mode)


;; Rebindings
(global-set-key (kbd "C-S-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "C-S-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "C-S-<down>") 'shrink-window)
(global-set-key (kbd "C-S-<up>") 'enlarge-window)
