
;;rutas de carga de archivos .el
(setq load-path (cons "~/.emacs.d" load-path))
(add-to-list 'load-path "~/elisp")


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
(setq c-basic-offset 2) ; 2 tabs indenting
(setq indent-tabs-mode nil)
(setq fill-column 78)
(c-set-offset 'case-label '+)
(c-set-offset 'arglist-close 'c-lineup-arglist-operators))
(c-set-offset 'arglist-intro '+) ; for FAPI arrays and DBTNG
(c-set-offset 'arglist-cont-nonempty 'c-lineup-math)

;;yaml
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))


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

(require 'color-theme)

;;(set-foreground-color "white")
;;(set-cursor-color "green")
;;(set-background-color "black")
