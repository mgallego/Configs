
;;rutas de carga de archivos .el
(setq load-path (cons "~/.emacs.d" load-path))
(add-to-list 'load-path "~/elisp")
(add-to-list 'load-path "~/Dev/lisp/sf.el")

;; modos
(require 'identica-mode)
(require 'php-mode)
(require 'yaml-mode) ;;http://github.com/yoshiki/yaml-mode  ;;http://www.emacswiki.org/emacs/YamlMode
(require 'eproject)
(require 'sf)




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

;;carga mis archivos de configuracion personalizados
;;(if (file-exists-p "~/.emacs.d/sf.el")
;;    (load-file "~/.emacs.d/sf.el"))

;;ruta para el proyecto actual de SF2
;;(setq SFPath "~/Dev/Picmnt/")

;;org mode
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)


;;org-mobile
;; Set to the location of your Org files on your local system
(setq org-directory "~/org")
;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/org/flagged.org")
;; Set to <your Dropbox root directory>/MobileOrg.
(setq org-mobile-directory "~/Dropbox/MobileOrg")

(add-to-list 'load-path "/home/moises/.emacs.d/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "/home/moises/.emacs.d//ac-dict")
(ac-config-default)

;;(require 'color-theme)

(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-dark-laptop)))


;;(set-foreground-color "white")
;;(set-cursor-color "green")
;;(set-background-color "black")


(global-linum-mode t)

(setq scroll-bar-mode-explicit t) 
(set-scroll-bar-mode `right) 

(tool-bar-mode nil)
;;(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
;; '(default ((t (:stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 109 :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))


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
(require 'lorem-ipsum)
(add-hook 'sgml-mode-hook (lambda ()
			    (setq Lorem-ipsum-paragraph-separator "<br><br>\n"
				  Lorem-ipsum-sentence-separator "&nbsp;&nbsp;"
				  Lorem-ipsum-list-beginning "<ul>\n"
				  Lorem-ipsum-list-bullet "<li>"
				  Lorem-ipsum-list-item-end "</li>\n"
				  Lorem-ipsum-list-end "</ul>\n")))

