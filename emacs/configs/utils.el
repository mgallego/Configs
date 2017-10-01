;; multicursor
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)


;;AUTOCOMPLETE
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

(require 'fiplr)
(setq fiplr-root-markers '(".git" ".svn"))
(setq fiplr-ignored-globs '((directories (".git" ".svn" "vendor" "provisioning" "bin" "docs" "swagger-converter" "swagger2" "tests" "web" "venv"))
                            (files ("*.jpg" "*.png" "*.zip" "*~" "*.pyc"))))
;; (global-set-key (kbd "C-x f") 'fiplr-find-file)

(require 'helm-etags-plus)
(global-set-key (kbd "C-.") 'helm-etags-plus-select)

(hc-toggle-highlight-trailing-whitespace t)


;; https://www.emacswiki.org/emacs/AceJump
(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)


(require 'swiper-helm)
(define-key global-map (kbd "C-s") 'swiper-helm)

(require 'which-key)
(which-key-mode)

(define-key global-map (kbd "C-c g") 'magit-status)

