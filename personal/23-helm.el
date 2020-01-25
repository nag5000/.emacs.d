(helm-autoresize-mode 1)
(setq helm-autoresize-max-height 40)
(setq helm-autoresize-min-height 10)

(setq
 ;; https://github.com/syohex/emacs-helm-ag#customize
 ;; Use .agignore file at project root if this variable is non nil.
 ;; You can also use .ignore file at project root.
 helm-ag-use-agignore t

 ;; Default: "ag --nocolor --nogroup". --follow: Follow symlinks.
 helm-ag-base-command "ag --nocolor --nogroup --follow"
)
