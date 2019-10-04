(setq
 ;; 2 space tab width
 js-indent-level 2
 js2-basic-offset 2

 ;; "When nil, case labels are indented on the same level as the
 ;; containing switch statement.  Otherwise, all lines inside
 ;; switch statement body are indented one additional level."
 js2-indent-switch-body t
 js-switch-indent-offset 2)

(prelude-require-packages '(ember-mode))
(setq ember-completion-system 'helm)
(add-hook 'ember-mode-hook (lambda ()
                             (if (equal major-mode 'js2-mode)
                                 (yas-activate-extra-mode 'js2-mode-ember))
                             (if (equal major-mode 'web-mode)
                                 (yas-activate-extra-mode 'web-mode-ember))))
