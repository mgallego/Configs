;;PATHS
(setq load-path (cons "~/.emacs.d" load-path))
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
(add-to-list 'load-path "~/.emacs.modes/lorem-ipsum")
(require 'lorem-ipsum)
(add-to-list 'load-path "~/.emacs.modes/auto-complete")
(require 'auto-complete-config)
(add-to-list 'load-path "~/.emacs.modes/emacs-flymake-phpcs")
(require 'flymake-phpcs)
(add-to-list 'load-path "~/.emacs.modes/Fill-Column-Indicator")
(require 'fill-column-indicator)
(add-to-list 'load-path "~/.emacs.modes/tomatinho")
(require 'tomatinho)
(add-to-list 'load-path "~/.emacs.modes/geben-svn")
(require 'geben)
(add-to-list 'load-path "~/.emacs.modes/yasnippet")
(require 'yasnippet)
(require 'tramp)
(add-to-list 'load-path "~/.emacs.modes/markdown-mode")
(require 'markdown-mode)
(load-file "~/.emacs.modes/phpdocumentor.el/phpdocumentor.el")



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
 '(nxml-child-indent 4)
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "DejaVu Sans Mono" :foundry "unknown" :slant normal :weight normal :height 109 :width normal)))))
(setq display-time-24hr-format t    
      display-time-load-average nil) 
(display-time)



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
(global-set-key[f3] 'eshell) ;;abre un buffer eshell al pulsar la tecla F3
(global-set-key[f4] 'sql-mysql)
(global-set-key (kbd "C-c d") 'credmp/flymake-display-err-minibuf)
(global-set-key (kbd "C-c n") 'my-goto-next-error)
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


;;AUTOCOMPLETE
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


;;FLYMAKE PHP -- CODE SNIFFER
(setq flymake-phpcs-command "~/.emacs.modes/emacs-flymake-phpcs/bin/flymake_phpcs")
(setq flymake-phpcs-standard
  "/usr/share/php/PHP/CodeSniffer/Standards/PSR2")
(setq flymake-phpcs-show-rule t)

(defun credmp/flymake-display-err-minibuf () 
      "Displays the error/warning for the current line in the minibuffer"
      (interactive)
      (let* ((line-no             (flymake-current-line-no))
             (line-err-info-list  (nth 0 (flymake-find-err-info flymake-err-info line-no)))
             (count               (length line-err-info-list))
             )
        (while (> count 0)
           (when line-err-info-list
           (let* ((file       (flymake-ler-file (nth (1- count) line-err-info-list)))
                   (full-file  (flymake-ler-full-file (nth (1- count) line-err-info-list)))
                   (text (flymake-ler-text (nth (1- count) line-err-info-list)))
                   (line       (flymake-ler-line (nth (1- count) line-err-info-list))))
              (message "[%s] %s" line text)
              )
            )
          (setq count (1- count)))))

(defun my-goto-next-error ()
  (interactive)
  (flymake-goto-next-error)
  (credmp/flymake-display-err-minibuf)
)


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
(setq yas-snippet-dirs
      '("~/.emacs.modes/yasnippet-php-mode"
        ))
(yas-global-mode 1)

;;TRAMP
(setq tramp-default-method "scp")

;;MARKDOWN
(add-to-list 'auto-mode-alist '("\\.markdown" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md" . markdown-mode))

(defun jean-claude (var)
  "print-a-php-var-dump"
  (interactive "sVar:")
  (setq inicio (point))
  (insert (concat "echo '<pre>';\nvar_dump(" var  ");\necho '<\pre>';"))
  (indent-region inicio (point))
)

(defun doctrine-jean-claude (var)
  "print-a-php-var-dump"
  (interactive "sVar:")
  (setq inicio (point))
  (insert (concat "echo '<pre>';\n\\Doctrine\\Common\\Util\\Debug::dump(" var  ");\necho '<\pre>';"))
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
