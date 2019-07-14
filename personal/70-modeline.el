;; https://github.com/Malabarba/smart-mode-line
(prelude-require-package 'smart-mode-line)
(setq sml/no-confirm-load-theme t)
(setq sml/theme 'light)
(sml/setup)

(with-eval-after-load "hilit-chg"
  (diminish 'highlight-changes-mode))

(diminish 'vi-tilde-fringe-mode)
(diminish 'yas-minor-mode)
(diminish 'flycheck-mode)
(diminish 'company-mode)
(diminish 'helm-mode)
(diminish 'editorconfig-mode)
(diminish 'whitespace-mode)
(diminish 'projectile-mode)
(diminish 'smartparens-mode)
(diminish 'prelude-mode)
(diminish 'which-key-mode)
(diminish 'beacon-mode)
(diminish 'highlight-thing-mode)
(diminish 'lsp-mode "lsp")
(diminish 'emmet-mode)
(diminish 'hi-lock-mode)

(with-eval-after-load "ember-mode"
  (diminish 'ember-mode "ember"))
