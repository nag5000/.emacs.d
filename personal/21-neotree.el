;; https://github.com/jaypei/emacs-neotree
(prelude-require-package 'neotree)
(require 'neotree)

;; Every time when the neotree window is opened, let it find current file and jump to node.
;; (setq neo-smart-open t)

;; <C-c p p>, <SPC p p>
(setq projectile-switch-project-action 'projectile-dired)

;; If non-nil, the hidden files are shown by default.
(setq neo-show-hidden-files t)

;; Use with evil mode
(evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-quick-look)
(evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
(evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "g") 'neotree-refresh)
(evil-define-key 'normal neotree-mode-map (kbd "n") 'neotree-next-line)
(evil-define-key 'normal neotree-mode-map (kbd "p") 'neotree-previous-line)
(evil-define-key 'normal neotree-mode-map (kbd "A") 'neotree-stretch-toggle)
(evil-define-key 'normal neotree-mode-map (kbd "H") 'neotree-hidden-file-toggle)
