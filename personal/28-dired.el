;; https://github.com/Fuco1/dired-hacks
(prelude-require-packages '(dired-collapse))
(require 'dired-collapse)

(add-hook 'dired-mode-hook #'dired-collapse-mode)
