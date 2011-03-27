(setq load-path (cons "~/.emacs.d" load-path))
 
(add-to-list 'load-path "~/elisp")

(require 'php-mode)

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