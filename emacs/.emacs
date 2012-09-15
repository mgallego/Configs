;;rutas de carga de archivos .el
(setq load-path (cons "~/.emacs.d" load-path))
(add-to-list 'load-path "~/.emacs.modes")

;; modos
(add-to-list 'load-path "~/.emacs.modes/php-mode")
(require 'php-mode)
(add-to-list 'load-path "~/.emacs.modes/yaml-mode")
(require 'yaml-mode) ;;http://github.com/yoshiki/yaml-mode  ;;http://www.emacswiki.org/emacs/YamlMode
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

;;configuraciones de modos
;;;;;;;;;;;;;;;;;;;;;;;;;;

;;php
(add-to-list 'auto-mode-alist '("\\.module$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.install$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.engine$" . php-mode))
(defun clean-php-mode ()
(interactive)
(php-mode)
;;(setq c-basic-offset 4) ; 2 tabs indenting
;;(setq indent-tabs-mode nil)
;;(setq fill-column 78)
(c-set-offset 'case-label '+)
(C-set-offset 'arglist-close 'c-lineup-arglist-operators))
(c-set-offset 'arglist-intro '+) ; for FAPI arrays and DBTNG
(c-set-offset 'arglist-cont-nonempty 'c-lineup-math)

(setq c-default-style "bsd"
      c-basic-offset 4)


;;html
(add-hook 'html-mode-hook
        (lambda ()
          ;; Default indentation is usually 2 spaces, changing to 4.
          (set (make-local-variable 'sgml-basic-offset) 4)))

;;yaml
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(setq yaml-indent-offset 4) ; 2 tabs indenting


;;pruebas sacadas de dotemacs.de
(global-set-key[f3] 'eshell) ;;abre un buffer eshell al pulsar la tecla F3
(global-set-key[f4] 'sql-mysql)

;;eliminar backup automático
(setq make-backup-files nil)


;;funciones
(defun open-dot-emacs ()
  "opening-dot-emacs"
  (interactive) ;this makes the function a command too
  (find-file "~/.emacs")
)


;;org mode
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

(global-linum-mode t)
(tool-bar-mode nil)

;;pantalla completa con F11
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

;;lorem ipsum
(add-hook 'sgml-mode-hook (lambda ()
			    (setq Lorem-ipsum-paragraph-separator "<br><br>\n"
				  Lorem-ipsum-sentence-separator "&nbsp;&nbsp;"
				  Lorem-ipsum-list-beginning "<ul>\n"
				  Lorem-ipsum-list-bullet "<li>"
				  Lorem-ipsum-list-item-end "</li>\n"
				  Lorem-ipsum-list-end "</ul>\n")))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (wombat)))
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;flymake php ;;para el codesnifer de PHP
(setq flymake-phpcs-command "~/.emacs.modes/emacs-flymake-phpcs/bin/flymake_phpcs")
(setq flymake-phpcs-standard
  "/usr/share/php/PHP/CodeSniffer/Standards/PSR2")
(setq flymake-phpcs-show-rule t)

(setq-default fci-rule-column 120)
(setq fci-handle-truncate-lines nil)
(add-hook 'after-change-major-mode-hook 'auto-fci-mode)
(add-hook 'window-size-change-functions 'auto-fci-mode)

(defun auto-fci-mode (&optional unused)
  (if (> (frame-width) 80)
      (fci-mode 1)
    (fci-mode 0))
)
