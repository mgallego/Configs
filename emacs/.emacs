(setq make-backup-files nil)

(add-to-list 'load-path "~/.emacs.modes")

(defun load-user-file (file) (interactive "f")
  "Load a file in current user's configuration directory"
  (if (file-exists-p (expand-file-name file "~/.emacs.d"))
      (load-file (expand-file-name file "~/.emacs.d")))
  )

(load-user-file "packages.el")
(load-user-file "faces.el")
(load-user-file "init-helm.el")
(load-user-file "org-config")
(load-user-file "php.el")
(load-user-file "fronted.el")
(load-user-file "system.el")
(load-user-file "utils.el")
(load-user-file "python.el")
