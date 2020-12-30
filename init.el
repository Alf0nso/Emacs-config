
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
 '(erc-modules
   '(autojoin button completion fill irccontrols list match menu move-to-prompt netsplit networks noncommands readonly ring smiley stamp spelling track))
 '(package-selected-packages
   '(elpy ein processing-mode s-buffer let-alist graphviz-dot-mode live-py-mode exwm ytdl haskell-mode treemacs-icons-dired dired-subtree dired+ sparql-mode pdf-tools auto-complete auctex use-package smex pyvenv org-bullets gradle-mode which-key helm gnu-elpa-keyring-update)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(dired-subtree-depth-1-face ((t nil)))
 '(dired-subtree-depth-2-face ((t nil)))
 '(dired-subtree-depth-3-face ((t nil)))
 '(dired-subtree-depth-4-face ((t nil)))
 '(dired-subtree-depth-5-face ((t nil)))
 '(dired-subtree-depth-6-face ((t nil))))
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
