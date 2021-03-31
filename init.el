
;;; Package stuff
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)
;;;

;;; In case stuff no on melpa, can always use el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
;;;

;;; el-get for extra things I might want
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path
	     "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)
;;;

;;;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ediprolog-program "swipl")
 '(ediprolog-system 'swi)
 '(erc-modules
   '(autojoin button completion fill irccontrols list match menu move-to-prompt netsplit networks noncommands readonly ring smiley stamp spelling track))
 '(jde-jdk-registry '(("14.0.2" . "c:/Program Files/Java/jdk-14.0.2")))
 '(jdee-jdk-registry '(("1.4.0.2" . "C:\\Program Files\\Java\\jdk-14.0.2\\")))
 '(jdee-server-dir "~\\.emacs.d\\jdee-server")
 '(olivetti-body-width 70)
 '(org-agenda-files
   '("~/.emacs.d/config.org" "~/Org/todo.org" "~/Org/Tasks.org" "~/Org/Birthdays.org"))
 '(org-fontify-quote-and-verse-blocks t)
 '(package-selected-packages
   '(ivy deft org-roam-server forth-mode fira-code-mode pretty-mode ob-prolog connection calfw-org calfw org-roam go-autocomplete common-lisp-snippets go-mode ox-hugo ein jdee lsp-java java-snippets yasnippet-classic-snippets elfeed slime ediprolog paredit cider clojure-mode transmission tide js2-mode nodejs-repl auto-complete-c-headers aggressive-indent yasnippet-snippets proof-general writeroom-mode olivetti scad-mode scad-preview chess elpy processing-mode s-buffer let-alist graphviz-dot-mode live-py-mode exwm ytdl haskell-mode treemacs-icons-dired dired-subtree dired+ sparql-mode pdf-tools auto-complete auctex use-package smex pyvenv org-bullets gradle-mode which-key helm gnu-elpa-keyring-update))
 '(writeroom-added-width-left 5)
 '(writeroom-border-width 20)
 '(writeroom-fringes-outside-margins t)
 '(writeroom-global-effects
   '(writeroom-set-fullscreen writeroom-set-alpha writeroom-set-menu-bar-lines writeroom-set-tool-bar-lines writeroom-set-vertical-scroll-bars writeroom-set-bottom-divider-width writeroom-set-internal-border-width)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-tooltip ((t (:background "AntiqueWhite4" :foreground "pink1"))))
 '(dired-subtree-depth-1-face ((t nil)))
 '(dired-subtree-depth-2-face ((t nil)))
 '(dired-subtree-depth-3-face ((t nil)))
 '(dired-subtree-depth-4-face ((t nil)))
 '(dired-subtree-depth-5-face ((t nil)))
 '(dired-subtree-depth-6-face ((t nil)))
 '(helm-M-x-key ((t (:extend t :foreground "sky blue" :underline t))))
 '(helm-ff-directory ((t (:extend t :foreground "MistyRose3"))))
 '(helm-match ((t (:extend t :foreground "NavajoWhite1"))))
 '(org-quote ((t (:inherit face-faded :extend t :background "gray30" :slant italic))))
 '(tab-bar ((t (:inherit variable-pitch :background "#3f3f3f" :foreground "MistyRose1")))))
;;;;;;;

;;; Making sure use package is working
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
;;;

;;; Load org file configuration
(org-babel-load-file (expand-file-name
		      "~/.emacs.d/config.org"))
;;; Configuration written my org file
