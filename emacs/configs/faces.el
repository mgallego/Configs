(custom-set-variables

 '(column-number-mode t)
 '(display-time-mode t)
 '(font-use-system-font t)
 '(nxml-child-indent 4)
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes (quote (wombat))))
(custom-set-faces
 )

(custom-set-faces
 '(default ((t (:family "Liberation Mono" :foundry "unknown" :slant normal :weight normal :height 100 :width normal))))
 )
(setq display-time-24hr-format t    
      display-time-load-average nil) 
(display-time)

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

(setq split-height-threshold 0)
(setq split-width-threshold 0)

(set-face-attribute 'default nil :height 90)

(defun sacha/increase-font-size ()
  (interactive)
  (set-face-attribute 'default
                      nil
                      :height
                      (ceiling (* 1.10
                                  (face-attribute 'default :height)))))
(defun sacha/decrease-font-size ()
  (interactive)
  (set-face-attribute 'default
                      nil
                      :height
                      (floor (* 0.9
                                  (face-attribute 'default :height)))))
(global-set-key (kbd "C-+") 'sacha/increase-font-size)
(global-set-key (kbd "C--") 'sacha/decrease-font-size)

(setq c-basic-offset 4) ; 2 tabs indenting
(setq indent-tabs-mode nil)
(add-hook 'html-mode-hook
	  (lambda ()
	    (setq indent-tabs-mode t)
	    (setq tab-width 4)
	    (setq c-basic-indent 4)))
