(require 'php-mode)
	 
;;COLUMN WARNING
(setq-default fci-rule-column 120)
(setq fci-handle-truncate-lines nil)
(add-hook 'php-mode-hook 'auto-fci-mode)
(defun auto-fci-mode (&optional unused)
  (if (> (frame-width) 80)
      (fci-mode 1)
    (fci-mode 0))
)

(global-set-key[f2] 'phpunit-single-test)
(global-set-key[f3] 'phpcs)
(global-set-key[f4] 'php-lint)
(global-set-key[f5] 'phpmd)
(global-set-key (kbd "C-c n") 'my-goto-next-error)
(global-set-key (kbd "M-p") 'php-project-open)
(global-set-key (kbd "<C-tab>") 'yas/expand)

(defun test-phpcs-phplint ()
  (interactive)
  (php-compile-run :phpcs));; t :phpcs t :phpmd t ))

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
(c-set-offset 'case-label '+)
(C-set-offset 'arglist-close 'c-lineup-arglist-operators))
(c-set-offset 'arglist-intro '+) ; for FAPI arrays and DBTNG
(c-set-offset 'arglist-cont-nonempty 'c-lineup-math)

;;twig
(setq auto-mode-alist
      (append '(("\\.html.twig?$" . jinja2-mode)) auto-mode-alist))

(setq auto-mode-alist
      (append '(("\\.html?$" . jinja2-mode)) auto-mode-alist))

;; Flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)
(setq flycheck-php-executable "php")
(setq flycheck-php-phpcs-executable "~/bin/php/phpcs")
(setq flycheck-phpcs-standard "PSR2")
(setq flycheck-phpmd-rulesets "unusedcode")
(setq flycheck-php-phpmd-executable "~/bin/php/phpmd")
(setq flycheck-global-modes '(php+-mode))
(add-hook 'php-mode-hook 'flycheck-mode)

;; Projectile
(add-hook 'php-mode-hook 'projectile-mode)
(setq projectile-tags-command "ctags -Re -f \"%s\" %s --PHP-kinds=cfid --regex-PHP=\"/(abstract |final )class ([^ ]*)/\\1/c/\" --regex-PHP=\"/(public |static |final |abstract |protected |private )+function ([^ (]*)/\\2/f/\"")


(defun php-cs-fixer ()
  "fix-php-cs-problems"
  (interactive)
  (shell-command
   (concat
    "php "
    (expand-file-name "bin/php-cs-fixer fix --verbose " (eproject-root))
    (buffer-file-name)))
  (revert-buffer)
)
