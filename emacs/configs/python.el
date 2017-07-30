(add-hook 'python-mode-hook 'flycheck-mode)
(add-hook 'python-mode-hook 'projectile-mode)


;; sudo apt-get install pylint

(require 'virtualenvwrapper)
(venv-initialize-interactive-shells) ;; if you want interactive shell support
(venv-initialize-eshell) 
;; (add-hook 'venv-postmkvirtualenv-hook
;;           (lambda () (shell-command "pip install nose flake8 jedi")))
(setq venv-dirlookup-names '(".venv" "pyenv" ".virtual" "venv"))

(setq projectile-switch-project-action 'venv-projectile-auto-workon)
;; If you relay on another use for this action, then just add a lambda instead:
;; (setq projectile-switch-project-action
;;       '(lambda ()
;;          (venv-projectile-auto-workon)
;;          (projectile-find-file)))

;; Displaying the currently active virtualenv on the mode line
(setq-default mode-line-format (cons '(:exec venv-current-name) mode-line-format))


(require 'jedi)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)
(add-hook 'python-mode-hook 'jedi:ac-setup)

(add-hook 'python-mode-hook
          (lambda ()
	    (setq-default fci-rule-column 100)
	    (setq fci-handle-truncate-lines nil)
	    (auto-fci-mode)
	    ))

