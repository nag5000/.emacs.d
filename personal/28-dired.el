;; https://github.com/Fuco1/dired-hacks
;; https://github.com/clemera/dired-git-info
(prelude-require-packages '(dired-collapse dired-git-info))
(require 'dired-collapse)

(add-hook 'dired-mode-hook #'dired-collapse-mode)

(with-eval-after-load 'dired
  (define-key dired-mode-map ")" 'dired-git-info-mode))

(require 'dired+)
;; Tell Dired to reuse Dired buffers.
;; Alt: M-x ibuffer, * / to mark buffers in dired mode, D to delete them.
(diredp-toggle-find-file-reuse-dir 1)
(setq diredp-hide-details-initially-flag nil)
;; -al is default. -h for human-readable file sizes.
(setq dired-listing-switches "-alh")
