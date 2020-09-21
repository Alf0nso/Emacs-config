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
(set-default-font "Consolas 14")

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

;; Theme (colors of the emacs editor)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (tango-dark)))
;; '(gradle-mode t)
 '(package-selected-packages
   (quote
    (org-bullets treemacs-persp treemacs-magit treemacs-icons-dired treemacs gradle-mode which-key pdf-tools helm gnu-elpa-keyring-update))))
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

;; Eshell stuff
(defalias 'ff 'find-file)
(defalias 'ffo 'find-file-other-window)

(setq eshell-prompt-regexp "^[^#$\n]*[#$] "
      eshell-prompt-function
      (lambda nil
        (concat
	 "[" "grass" "]"
	 (if (= (user-uid) 0) "# " " λ "))))

;;;
;; Org
(setq org-hide-emphasis-markers t)

;; Java
(add-hook 'java-mode-hook 'gradle-mode)
