(require 'package)

(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)

(defvar required-packages
  '(
    php-mode
    fill-column-indicator
    yaml-mode
    eproject
    tramp
    markdown-mode
    jinja2-mode
    elfeed
    helm
    flycheck
    helm-etags-plus
    projectile
    helm-projectile
    company
    ac-php
    docker
    magit
    )
  "Packages which should be installed upon launch"
  )


(dolist (p required-packages)
  (when (not (package-installed-p p))
    (package-refresh-contents)
(package-install p)))

(add-to-list 'load-path "~/.emacs.modes/sf.el")
(require 'sf)
