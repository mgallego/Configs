(setq make-backup-files nil)
(add-to-list 'load-path "~/.emacs.modes")

(defun load-user-file (file) (interactive "f")
  "Load a file in current user's configuration directory"
  ;; (load-file (expand-file-name file user-init-dir)))
  (load-file (expand-file-name file "~/.emacs.d")))

(load-user-file "packages.el")
(load-user-file "faces.el")
(load-user-file "init-helm.el")
(load-user-file "org-config")
(load-user-file "php.el")
(load-user-file "system.el")

