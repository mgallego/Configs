
;;(setq load-path (cons "~/.emacs.d" load-path))
(add-to-list 'load-path "~/.emacs.modes")
(add-to-list 'load-path "~/.emacs.modes/popup-el")

;; MODES
(add-to-list 'load-path "~/.emacs.modes/php-mode")
(require 'php-mode)
(add-to-list 'load-path "~/.emacs.modes/yaml-mode")
(require 'yaml-mode)
(add-to-list 'load-path "~/.emacs.modes/eproject")
(require 'eproject)
(add-to-list 'load-path "~/.emacs.modes/sf.el")
(require 'sf)
;; (add-to-list 'load-path "~/.emacs.modes/lorem-ipsum")
;; (require 'lorem-ipsum)
(add-to-list 'load-path "~/.emacs.modes/auto-complete")
(require 'auto-complete-config)
;; (add-to-list 'load-path "~/.emacs.modes/emacs-flymake-phpcs")
;; (require 'flymake-phpcs)
(add-to-list 'load-path "~/.emacs.modes/Fill-Column-Indicator")
(require 'fill-column-indicator)
(add-to-list 'load-path "~/.emacs.modes/tomatinho")
(require 'tomatinho)
;; (add-to-list 'load-path "~/.emacs.modes/geben-svn")
;; (require 'geben)
;;(add-to-list 'load-path "~/.emacs.modes/yasnippet")
;;(require 'yasnippet)
(require 'tramp)
(add-to-list 'load-path "~/.emacs.modes/markdown-mode")
(require 'markdown-mode)
(load-file "~/.emacs.modes/phpdocumentor.el/phpdocumentor.el")
(add-to-list 'load-path "~/.emacs.modes/phpplus-mode")
(require 'php+-mode)
(php+-mode-setup)
;; (load "~/.emacs.modes/nxhtml/autostart.el")
;;(add-to-list 'load-path "~/.emacs.modes/twig-mode")
;;(require 'twig)
;; (add-to-list 'load-path "~/.emacs.modes/org-jira")
;; (setq jiralib-url "https://picmnt.atlassian.net/")
;; (require 'org-jira)
;; (add-to-list 'load-path "~/.emacs.modes/emacs-soap-client")
;; (require 'soap-client)
(add-to-list 'load-path "~/.emacs.modes/jinja2-mode")
(require 'jinja2-mode)
;;(require 'flymake-jslint)

;;; Emacs is not a package manager, and here we load its package manager!
(require 'package)
(dolist (source '(("marmalade" . "http://marmalade-repo.org/packages/")
                  ("elpa" . "http://tromey.com/elpa/")
                  ;; TODO: Maybe, use this after emacs24 is released
                  ;; (development versions of packages)
                  ("melpa" . "http://melpa.milkbox.net/packages/")
                  ))
  (add-to-list 'package-archives source t))
(package-initialize)

;;; Required packages
;;; everytime emacs starts, it will automatically check if those packages are
;;; missing, it will install them automatically
(when (not package-archive-contents)
  (package-refresh-contents))
(defvar mgallego/packages
  '(ac-js2 js2-mode yasnippet paredit flycheck web-beautify js2-refactor highlight-chars flymake-easy flymake-jslint feature-mode restclient find-file-in-project neotree ))
(dolist (p mgallego/packages)
  (when (not (package-installed-p p))
    (package-install p)))

(require 'restclient)
(require 'neotree)
(require 'find-file-in-project)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;  EMACS  ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq column-number-mode t)
(setq make-backup-files nil);;eliminar backup automático
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
 '(font-use-system-font t)
 '(nxml-child-indent 4)
 '(package-selected-packages
   (quote
    (find-file-in-project neotree restclient web-beautify paredit js2-refactor highlight-chars flymake-jslint flycheck feature-mode ac-js2)))
 '(php+-mode-show-project-in-modeline t)
 '(phpcs-standard "PSR2")
 '(show-paren-mode t)
 '(tool-bar-mode nil))



(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Liberation Mono" :foundry "unknown" :slant normal :weight normal :height 100 :width normal)))))
(setq display-time-24hr-format t    
      display-time-load-average nil) 
(display-time)

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;  PERSONAL FUNCTIONS  ;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;  AND  ;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;  KEYBINDING  ;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;FUNCTIONS
(defun open-dot-emacs ()
  "opening-dot-emacs"
  (interactive) ;this makes the function a command too
  (find-file "~/.emacs")
)


;;KEYS
(global-set-key[f2] 'phpunit-single-test)
(global-set-key[f3] 'phpcs)
(global-set-key[f4] 'php-lint)
(global-set-key[f5] 'phpmd)
;; (global-set-key[f3] 'eshell) ;;abre un buffer eshell al pulsar la tecla F3
;; (global-set-key[f4] 'sql-mysql)
;;(global-set-key (kbd "C-c d") 'credmp/flymake-display-err-minibuf)
(global-set-key (kbd "C-c n") 'my-goto-next-error)
(global-set-key (kbd "M-p") 'php-project-open)
(global-set-key (kbd "<C-tab>") 'yas/expand)


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

(defun test-phpcs-phplint ()
  (interactive)
  (php-compile-run :phpcs));; t :phpcs t :phpmd t ))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;  MODES  ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
;;(setq fill-column 78)
(c-set-offset 'case-label '+)
(C-set-offset 'arglist-close 'c-lineup-arglist-operators))
(c-set-offset 'arglist-intro '+) ; for FAPI arrays and DBTNG
(c-set-offset 'arglist-cont-nonempty 'c-lineup-math)


;;HTML
(add-hook 'html-mode-hook
        (lambda ()
          ;; Default indentation is usually 2 spaces, changing to 4.
          (set (make-local-variable 'sgml-basic-offset) 4)))


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
;; (setq yas-snippet-dirs
;;       '("~/.emacs.modes/yasnippet"
;;         ))
(yas-global-mode 1)

;;AUTOCOMPLETE
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
;;; set the trigger key so that it can work together with yasnippet on tab key,
;;; if the word exists in yasnippet, pressing tab will cause yasnippet to
;;; activate, otherwise, auto-complete will
(ac-set-trigger-key "TAB")
(ac-set-trigger-key "<tab>")

;;LOREM IPSUM
(add-hook 'sgml-mode-hook (lambda ()
			    (setq Lorem-ipsum-paragraph-separator "<br><br>\n"
				  Lorem-ipsum-sentence-separator "&nbsp;&nbsp;"
				  Lorem-ipsum-list-beginning "<ul>\n"
				  Lorem-ipsum-list-bullet "<li>"
				  Lorem-ipsum-list-item-end "</li>\n"
				  Lorem-ipsum-list-end "</ul>\n")))


;; ;;FLYMAKE PHP -- CODE SNIFFER
;; (setq flymake-phpcs-command "~/.emacs.modes/emacs-flymake-phpcs/bin/flymake_phpcs")
;; (setq flymake-phpcs-standard
;;   "/usr/share/php/PHP/CodeSniffer/Standards/PSR2")
;; (setq flymake-phpcs-show-rule t)

;; (defun credmp/flymake-display-err-minibuf () 
;;       "Displays the error/warning for the current line in the minibuffer"
;;       (interactive)
;;       (let* ((line-no             (flymake-current-line-no))
;;              (line-err-info-list  (nth 0 (flymake-find-err-info flymake-err-info line-no)))
;;              (count               (length line-err-info-list))
;;              )
;;         (while (> count 0)
;;            (when line-err-info-list
;;            (let* ((file       (flymake-ler-file (nth (1- count) line-err-info-list)))
;;                    (full-file  (flymake-ler-full-file (nth (1- count) line-err-info-list)))
;;                    (text (flymake-ler-text (nth (1- count) line-err-info-list)))
;;                    (line       (flymake-ler-line (nth (1- count) line-err-info-list))))
;;               (message "[%s] %s" line text)
;;               )
;;             )
;;           (setq count (1- count)))))

;; (defun my-goto-next-error ()
;;   (interactive)
;;   (flymake-goto-next-error)
;;   (credmp/flymake-display-err-minibuf)
;; )


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

;;POMODORO
(global-set-key (kbd "<f12>") 'tomatinho)


;;YASNIPPET
;; (setq yas-snippet-dirs
;;       '("~/.emacs.modes/yasnippet-php-mode"
;;         ))
;; (yas-global-mode 1)

;;TRAMP
(setq tramp-default-method "scp")

;;MARKDOWN
(add-to-list 'auto-mode-alist '("\\.markdown" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md" . markdown-mode))

(defun jean-claude (var)
  "print-a-php-var-dump"
  (interactive "sVar:")
  (setq inicio (point))
  (insert (concat "echo '<br/> Jean Claude var_dump in " (file-name-base) " " (what-line) "';\n"))
  (insert (concat "echo '<br/><pre>';\nvar_dump(" var  ");\necho '</pre>';"))
  (indent-region inicio (point))
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

(setq split-height-threshold 0)
(setq split-width-threshold 0)

(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(set-face-attribute 'default nil :height 110)

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

;; ;;mumamo
;; (when (and (equal emacs-major-version 24)
;;            (equal emacs-minor-version 2))
;;   (eval-after-load "mumamo"
;;     '(setq mumamo-per-buffer-local-vars
;;            (delq 'buffer-file-name mumamo-per-buffer-local-vars))))
;; (setq auto-mode-alist
;;       (append '(("\\.html.twig?$" . django-html-mumamo-mode)) auto-mode-alist))
;; (setq mumamo-background-colors nil) 
;; (add-to-list 'auto-mode-alist '("\\.html.twig$" . django-html-mumamo-mode))


(setq c-basic-offset 4) ; 2 tabs indenting
(setq indent-tabs-mode nil)
;; (add-hook 'django-html-mumamo-mode-hook
;; 	  (lambda ()
;; 	    (setq indent-tabs-mode t)
;; 	    (setq tab-width 4)
;; 	    (setq c-basic-indent 4)))

(add-hook 'html-mode-hook
	  (lambda ()
	    (setq indent-tabs-mode t)
	    (setq tab-width 4)
	    (setq c-basic-indent 4)))


;;php+-mode
(setq auto-mode-alist
      (append '(("\\.php?$" . php+-mode)) auto-mode-alist))
(add-to-list 'auto-mode-alist '("\\.php$" . php+-mode))

;;twig-minor-mode
;;  (setq auto-mode-alist
;;        (append '(("\\.twig?$" . twig-minor-mode)) auto-mode-alist))
;; (add-to-list 'auto-mode-alist '("\\.twig$" . twig-minor-mode))

(setq auto-mode-alist
      (append '(("\\.less?$" . css-mode)) auto-mode-alist))
(add-to-list 'auto-mode-alist '("\\.less$" . css-mode))


;;Jira-mode

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;JS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;MAC OX;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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

(hc-toggle-highlight-trailing-whitespace t)

(require 'iso-transl)

;;Load not versionable configurations
(if (file-exists-p "~/.emacs.d/work-php-projects")
    (load "~/.emacs.d/work-php-projects"))

(if (file-exists-p "~/.emacs.d/epa-config")
    (load "~/.emacs.d/epa-config"))

(if (file-exists-p "~/.emacs.d/org-config")
    (load "~/.emacs.d/org-config"))
