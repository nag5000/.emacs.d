;; https://github.com/Fuco1/dired-hacks
;; https://github.com/clemera/dired-git-info
(prelude-require-packages '(dired-collapse dired-git-info))
(require 'dired-collapse)

(add-hook 'dired-mode-hook #'dired-collapse-mode)

(with-eval-after-load 'dired
  (define-key dired-mode-map ")" 'dired-git-info-mode))
