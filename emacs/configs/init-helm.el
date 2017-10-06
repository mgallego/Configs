;; helm
(require 'helm)
(require 'helm-config)
(require 'helm-projectile)
(require 'helm-etags-plus)

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
;; (global-set-key (kbd "C-x C-f") 'helm-find-files)

(global-set-key (kbd "M-.") 'helm-etags-plus-select)
(global-set-key (kbd "C-x f") 'helm-projectile-find-file)
(global-set-key (kbd "C-x r b") 'helm-bookmarks)
(global-set-key (kbd "C-x m") 'helm-M-x)
