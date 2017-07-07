;;(setq load-path (cons "~/.emacs.d" load-path))
(add-to-list 'load-path "~/.emacs.modes")
(add-to-list 'load-path "~/.emacs.modes/popup-el")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;GENERAL CONFIG;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq column-number-mode t)
;;eliminar backup automático
(setq make-backup-files nil)
(setq tool-bar-mode nil)
(global-linum-mode t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-enabled-themes (quote (wombat)))
 '(display-time-mode t)
 '(elfeed-feeds (quote ("https://lamiradadelreplicante.com/feed/")))
 '(font-use-system-font t)
 '(nxml-child-indent 4)
 '(package-selected-packages
   (quote
    (find-file-in-project neotree restclient web-beautify paredit js2-refactor highlight-chars flymake-jslint flycheck feature-mode magit)))
 '(php+-mode-show-project-in-modeline t)
 '(php-project-list
   (quote
    (("km77" "~/Dev/km77.com/src/" "~/Dev/TAGS/km77" nil "" nil
      (("" . "")
       "" "" "" "" "" "" "" "")
      "" "")
     ("fapi" "~/Dev/fapi/src/" "~/Dev/TAGS/fapi"
      ("~/Dev/fapi/vendor/")
      "~/Dev/fapi/app" nil
      (("" . "")
       "" "" "" "" "" "" "" "")
      "Km77" ""))))
 '(phpcs-standard "PSR2")
 '(phpmd-rulesets (quote (unusedcode)))
 '(phpmd-shell-command "~/bin/php/phpmd")
 '(phpunit-shell-command "~/bin/php/phpunit")
 '(show-paren-mode t)
 '(tag-shell-command "ctags")
 '(tool-bar-mode nil))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Liberation Mono" :foundry "unknown" :slant normal :weight normal :height 100 :width normal))))
 '(elfeed-search-date-face ((t :foreground "#f0f" :weight extra-bold :underline t)))
 '(elfeed-search-title-face ((t :foreground "#f0f" :weight extra-bold :underline t))))
(setq display-time-24hr-format t    
      display-time-load-average nil) 
(display-time)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;END GENERAL CONFIG;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

:::;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;PACKAGES;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Emacs is not a package manager, and here we load its package manager!
(require 'package)
(dolist (source '(("marmalade" . "http://marmalade-repo.org/packages/")
                  ("elpa" . "http://tromey.com/elpa/")
                  ("melpa" . "https://melpa.org/packages")
                  ))
  (add-to-list 'package-archives source t))
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(when (< emacs-major-version 24)
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;;

;;; Required packages
;;; everytime emacs starts, it will automatically check if those packages are
;;; missing, it will install them automatically
(when (not package-archive-contents)
  (package-refresh-contents))
(defvar mgallego/packages
  '(js2-mode yasnippet paredit flycheck web-beautify js2-refactor highlight-chars flymake-easy flymake-jslint feature-mode restclient find-file-in-project neotree fiplr helm helm-etags-plus ace-jump-mode expand-region ))
(dolist (p mgallego/packages)
  (when (not (package-installed-p p))
    (package-install p)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;END PACKAGES;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;LOCALE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;END LOCALE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;DEFAULT FONTS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun toggle-fullscreen (&optional f)
      (interactive)
      (let ((current-value (frame-parameter nil 'fullscreen)))
           (set-frame-parameter nil 'fullscreen
                                (if (equal 'fullboth current-value)
                                    (if (boundp 'old-fullscreen) old-fullscreen nil)
                                    (progn (setq old-fullscreen current-value)
                                           'fullboth)))))
    (global-set-key [f11] 'toggle-fullscreen)
    ; Make new frames fullscreen by default. Note: this hook doesn't do
    ; anything to the initial frame if it's in your .emacs, since that file is
    ; read _after_ the initial frame is created.
    (add-hook 'after-make-frame-functions 'toggle-fullscreen)

(setq split-height-threshold 0)
(setq split-width-threshold 0)

(set-face-attribute 'default nil :height 90)

(defun sacha/increase-font-size ()
  (interactive)
  (set-face-attribute 'default
                      nil
                      :height
                      (ceiling (* 1.10
                                  (face-attribute 'default :height)))))
(defun sacha/decrease-font-size ()
  (interactive)
  (set-face-attribute 'default
                      nil
                      :height
                      (floor (* 0.9
                                  (face-attribute 'default :height)))))
(global-set-key (kbd "C-+") 'sacha/increase-font-size)
(global-set-key (kbd "C--") 'sacha/decrease-font-size)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;END DEFAULT FONTS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;DEFAULT INDENT;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq c-basic-offset 4) ; 2 tabs indenting
(setq indent-tabs-mode nil)
(add-hook 'html-mode-hook
	  (lambda ()
	    (setq indent-tabs-mode t)
	    (setq tab-width 4)
	    (setq c-basic-indent 4)))

;;COLUMN WARNING
(setq-default fci-rule-column 120)
(setq fci-handle-truncate-lines nil)
(add-hook 'after-change-major-mode-hook 'auto-fci-mode)
(add-hook 'window-size-change-functions 'auto-fci-mode)
(defun auto-fci-mode (&optional unused)
  (if (> (frame-width) 80)
      (fci-mode 1)
    (fci-mode 0))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;END DEFAULT INDENT;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;WEB DEV;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path "~/.emacs.modes/php-mode")
(require 'php-mode)
(add-to-list 'load-path "~/.emacs.modes/yaml-mode")
(require 'yaml-mode)
(add-to-list 'load-path "~/.emacs.modes/eproject")
(require 'eproject)
(add-to-list 'load-path "~/.emacs.modes/sf.el")
(require 'sf)
(add-to-list 'load-path "~/.emacs.modes/auto-complete")
(require 'auto-complete-config)
(add-to-list 'load-path "~/.emacs.modes/Fill-Column-Indicator")
(require 'fill-column-indicator)
(add-to-list 'load-path "~/.emacs.modes/tomatinho")
(require 'tramp)
(add-to-list 'load-path "~/.emacs.modes/markdown-mode")
(require 'markdown-mode)
(load-file "~/.emacs.modes/phpdocumentor.el/phpdocumentor.el")
(add-to-list 'load-path "~/.emacs.modes/phpplus-mode")
(require 'php+-mode)
(php+-mode-setup)
(add-to-list 'load-path "~/.emacs.modes/jinja2-mode")
(require 'jinja2-mode)
(require 'restclient)

(global-set-key[f2] 'phpunit-single-test)
(global-set-key[f3] 'phpcs)
(global-set-key[f4] 'php-lint)
(global-set-key[f5] 'phpmd)
(global-set-key (kbd "C-c n") 'my-goto-next-error)
(global-set-key (kbd "M-p") 'php-project-open)
(global-set-key (kbd "<C-tab>") 'yas/expand)

(defun test-phpcs-phplint ()
  (interactive)
  (php-compile-run :phpcs));; t :phpcs t :phpmd t ))

;;PHP
(add-to-list 'auto-mode-alist '("\\.module$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.install$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.engine$" . php-mode))

(setq php-mode-force-pear t)
(add-hook 'php-mode-user-hook
      '(lambda ()
         (setq indent-tabs-mode t)
         (setq tab-width 4)
         (setq c-basic-indent 4)))

(defun clean-php-mode ()
(interactive)
(php-mode)
(setq c-basic-offset 4) ; 2 tabs indenting
(setq indent-tabs-mode nil)
(c-set-offset 'case-label '+)
(C-set-offset 'arglist-close 'c-lineup-arglist-operators))
(c-set-offset 'arglist-intro '+) ; for FAPI arrays and DBTNG
(c-set-offset 'arglist-cont-nonempty 'c-lineup-math)


;;HTML
(add-hook 'html-mode-hook
        (lambda ()
          ;; Default indentation is usually 2 spaces, changing to 4.
          (set (make-local-variable 'sgml-basic-offset) 4)))

;;php+-mode
(setq auto-mode-alist
      (append '(("\\.php?$" . php+-mode)) auto-mode-alist))
(add-to-list 'auto-mode-alist '("\\.php$" . php+-mode))

(setq auto-mode-alist
      (append '(("\\.less?$" . css-mode)) auto-mode-alist))
(add-to-list 'auto-mode-alist '("\\.less$" . css-mode))

;;hl
(global-hl-line-mode 1)
(set-face-attribute hl-line-face nil :underline nil)
(set-face-background 'highlight "#222")
(set-face-foreground 'highlight nil)
(set-face-underline-p 'highlight nil)


;; Workaround the annoying warnings:
;;    Warning (mumamo-per-buffer-local-vars):
;;    Already 'permanent-local t: buffer-file-name
(when (and (equal emacs-major-version 24)
           (equal emacs-minor-version 3))
  (eval-after-load "mumamo"
    '(setq mumamo-per-buffer-local-vars
           (delq 'buffer-file-name mumamo-per-buffer-local-vars))))
;;twig
(setq auto-mode-alist
      (append '(("\\.html.twig?$" . jinja2-mode)) auto-mode-alist))

(setq auto-mode-alist
      (append '(("\\.html?$" . jinja2-mode)) auto-mode-alist))


;;feature, cucumber, behat
(add-to-list 'auto-mode-alist '("\.feature$" . feature-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;END WEB DEV;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;JS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;JAVASCRIPT CONFIGURATION (http://truongtx.me/2014/02/23/set-up-javascript-development-environment-in-emacs/)

(add-to-list 'auto-mode-alist '("\\.json$" . js-mode))
(add-hook 'js-mode-hook 'js2-minor-mode)
(add-hook 'js2-mode-hook 'ac-js2-mode)
(setq js2-highlight-level 3)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(defun my-paredit-nonlisp ()
  "Turn on paredit mode for non-lisps."
  (interactive)
  (set (make-local-variable 'paredit-space-for-delimiter-predicates)
       '((lambda (endp delimiter) nil)))
  (paredit-mode 1))
(add-hook 'js2-mode-hook 'my-paredit-nonlisp) ;use with the above function
;;npm install -g jshint
(require 'flycheck)
(add-hook 'js2-mode-hook
          (lambda () (flycheck-mode t)))
;;npm install -g js-beatufiy
(require 'web-beautify)
(require 'js2-refactor)
(js2r-add-keybindings-with-prefix "C-c C-m")
(define-key js2-mode-map "{" 'paredit-open-curly)
(define-key js2-mode-map "}" 'paredit-close-curly-and-newline)
(add-hook 'js2-mode-hook 'flymake-jslint-load)
(setq flymake-jslint-command "/usr/local/bin/jslint")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;END JS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

::;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;MAC OX;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when (eq system-type 'darwin)
  ;;A mono font family
  (set-face-attribute 'default nil :family "Menlo")
  (set-face-attribute 'default nil :height 130)
  ;;Fix Alt+Gr key
  (setq mac-right-option-modifier 'none)
  ;;Line-height
  (setq-default line-spacing 2)
  ;;Home and End keys
  (define-key global-map [home] 'beginning-of-line)
  (define-key global-map [end] 'end-of-line)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;END MAC OX;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;MINOR MODES;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'tomatinho)
(require 'neotree)
(require 'find-file-in-project)
(require 'feature-mode)

;;Neotree
(global-set-key [f8] 'neotree-toggle)
(defun neotree-project-dir ()
  "Open NeoTree using the git root."
  (interactive)
  (let ((project-dir (ffip-project-root))
	(file-name (buffer-file-name)))
    (if project-dir
	(progn
	  (neotree-dir project-dir)
	  (neotree-find file-name))
      (message "Could not find git project root."))))

(global-set-key [f9] 'neotree-project-dir)
;; open neotree in current file dir
(setq neo-smart-open t)

;;YAML
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(setq yaml-indent-offset 4) ; 2 tabs indenting


;;ORG
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

(add-hook 'org-mode-hook (lambda () (setq auto-save-default nil)))


;;; yasnippet
;;; should be loaded before auto complete so that they can work together
(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.modes/yasnippet-php-mode"
        ))
(yas-global-mode 1)
;;; set the trigger key so that it can work together with yasnippet on tab key,
;;; if the word exists in yasnippet, pressing tab will cause yasnippet to
;;; activate, otherwise, auto-complete will
(ac-set-trigger-key "TAB")
(ac-set-trigger-key "<tab>")


;;AUTOCOMPLETE
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

;;LOREM IPSUM
(add-hook 'sgml-mode-hook (lambda ()
			    (setq Lorem-ipsum-paragraph-separator "<br><br>\n"
				  Lorem-ipsum-sentence-separator "&nbsp;&nbsp;"
				  Lorem-ipsum-list-beginning "<ul>\n"
				  Lorem-ipsum-list-bullet "<li>"
				  Lorem-ipsum-list-item-end "</li>\n"
				  Lorem-ipsum-list-end "</ul>\n")))

;;POMODORO
(global-set-key (kbd "<f12>") 'tomatinho)

;;TRAMP
(setq tramp-default-method "scp")

;;MARKDOWN
(add-to-list 'auto-mode-alist '("\\.markdown" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md" . markdown-mode))

(hc-toggle-highlight-trailing-whitespace t)

(require 'iso-transl)

;; Flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)
(setq flycheck-php-executable "php")
(setq flycheck-php-phpcs-executable "~/bin/php/phpcs")
(setq flycheck-phpcs-standard "PSR2")
(setq flycheck-phpmd-rulesets "unusedcode")
(setq flycheck-php-phpmd-executable "~/bin/php/phpmd")
(setq flycheck-global-modes '(php+-mode))
(add-hook 'php+-mode-hook 'flycheck-mode)

;; fiplr is a plugin as vim fluzzyfind
(require 'fiplr)
(setq fiplr-root-markers '(".git" ".svn"))
(setq fiplr-ignored-globs '((directories (".git" ".svn" "vendor" "provisioning" "bin" "docs" "swagger-converter" "swagger2" "tests" "web" "venv"))
                            (files ("*.jpg" "*.png" "*.zip" "*~" "*.pyc"))))
(global-set-key (kbd "C-x f") 'fiplr-find-file)

;; helm
(require 'helm)
(require 'helm-config)
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
;; (global-set-key (kbd "C-x C-f") 'helm-find-files)
(require 'helm-etags-plus)
(global-set-key (kbd "C-.") 'helm-etags-plus-select)

;; Ace-Jump
(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

;; expand-region
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;; multiple-cursors
(require 'multiple-cursors)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(require 'magit)
(require 'elfeed)
(require 'elfeed-org)

(setq elfeed-db-directory "~/Dropbox/Shared/elfeeddb")
(setq elfeed-feeds
      '("http://nullprogram.com/"
        "http://planet.emacsen.org/atom.xml"
	("https://elbinario.net/feed/" softlibre privacidad hacking)
	"https://lamiradadelreplicante.com/feed/"
	))
(global-set-key (kbd "C-x w") 'elfeed)





(elfeed-org)
(setq rmh-elfeed-org-files (list "~/Dropbox/Shared/elfeed.org"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;END MINOR MODES;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;MY OWN FUNCTIONS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun open-dot-emacs ()
  "opening-dot-emacs"
  (interactive) ;this makes the function a command too
  (find-file "~/.emacs")
)

(defun jean-claude (var)
  "print-a-php-var-dump"
  (interactive "sVar:")
  (setq inicio (point))
  (insert (concat "echo '<br/> Jean Claude var_dump in " (file-name-base) " " (what-line) "';\n"))
  (insert (concat "echo '<br/><pre>';\nvar_dump(" var  ");\necho '</pre>';"))
  (indent-region inicio (point))
)


(defun show-php-functions ()
  "show-php-functions"
  (interactive)
  (occur "function")
)

(defun php-cs-fixer ()
  "fix-php-cs-problems"
  (interactive)
  (shell-command
   (concat
    "php "
    (expand-file-name "bin/php-cs-fixer fix --verbose " (eproject-root))
    (buffer-file-name)))
  (revert-buffer)
)


(defun jean-claude-die (var)
  "print-a-php-var-dump"
  (interactive "sVar:")
  (setq inicio (point))
  (jean-claude var)
  (insert "\ndie;")
  (indent-region inicio (point))
)

(defun doctrine-jean-claude (var)
  "print-a-php-var-dump"
  (interactive "sVar:")
  (setq inicio (point))
  (insert (concat "echo '<br/> Doctrine Jean Claude var_dump in " (file-name-base) " " (what-line)"';\n"))
  (insert (concat "echo '<br/><pre>';\n\\Doctrine\\Common\\Util\\Debug::dump(" var  ");\necho '</pre>';"))
  (indent-region inicio (point))
)

(defun doctrine-jean-claude-die (var)
  "print-a-php-var-dump"
  (interactive "sVar:")
  (setq inicio (point))
  (doctrine-jean-claude var)
  (insert "\ndie;")
  (indent-region inicio (point))
)

(defun ld (var)
  "print-a-ld-var-dump"
  (interactive "sVar:")
  (setq inicio (point))
  (insert (concat "echo 'Ladybug Dump (ld) in " (file-name-base) " " (what-line) "';\n"))
  (insert (concat "ld(" var  ");\n"))
  (indent-region inicio (point))
)

(defun ldd (var)
  "print-a-ldd-var-dump"
  (interactive "sVar:")
  (setq inicio (point))
  (insert (concat "echo 'Ladybug Dump Die (ldd) in " (file-name-base) " " (what-line) "';\n"))
  (insert (concat "ldd(" var  ");\n"))
  (indent-region inicio (point))
)

(define-key sf-mode-keymap
  (kbd "C-c C-j j")
  'jean-claude
)

(define-key sf-mode-keymap
  (kbd "C-c C-j d")
  'doctrine-jean-claude
)

(defun php-cs-fixer ()
  "fix-php-cs-problems"
  (interactive)
  (shell-command
   (concat
    "php "
    (expand-file-name "bin/php-cs-fixer fix --verbose " (eproject-root))
    (buffer-file-name)))
  (revert-buffer)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;END MY OWN FUNCTIONS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;NON VERSIONABLES FILES;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(if (file-exists-p "~/.emacs.d/work-php-projects")
    (load "~/.emacs.d/work-php-projects"))

(if (file-exists-p "~/.emacs.d/epa-config")
    (load "~/.emacs.d/epa-config"))

(if (file-exists-p "~/.emacs.d/org-config")
    (load "~/.emacs.d/org-config"))

(if (file-exists-p "~/.emacs.d/custom")
    (load "~/.emacs.d/custom"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;END NON VERSIONABLES FILES;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

