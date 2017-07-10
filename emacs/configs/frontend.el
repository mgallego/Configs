(setq auto-mode-alist
      (append '(("\\.html.twig?$" . jinja2-mode)) auto-mode-alist))

(setq auto-mode-alist
      (append '(("\\.html?$" . jinja2-mode)) auto-mode-alist))

(add-hook 'html-mode-hook
   (lambda ()
    ;; Default indentation is usually 2 spaces, changing to 4.
    (set (make-local-variable 'sgml-basic-offset) 4)))

(add-hook 'sgml-mode-hook
  (lambda ()
    (set (make-local-variable 'sgml-basic-offset) 4)
  )
)

(add-hook 'jinja2-mode-hook
  (lambda ()
    (set (make-local-variable 'sgml-basic-offset) 4)
  )
)
