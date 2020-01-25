;; https://github.com/hlissner/evil-snipe
;; https://github.com/syl20bnr/spacemacs/blob/develop/layers/%2Bvim/evil-snipe/README.org
(prelude-require-package 'evil-snipe)

(defvar evil-snipe-enable-alternate-f-and-t-behaviors t
  "if non nil f/F/t/T behaviors are replaced by evil-snipe behavior.")

(use-package evil-snipe
  :init
  (setq evil-snipe-scope 'whole-buffer
        evil-snipe-enable-highlight t
        evil-snipe-enable-incremental-highlight t
        evil-snipe-auto-disable-substitute t
        evil-snipe-show-prompt nil
        evil-snipe-smart-case t)
  :config
  (progn
    (evil-snipe-mode 1)
    (when  evil-snipe-enable-alternate-f-and-t-behaviors
      (setq evil-snipe-repeat-scope 'whole-buffer)
      (evil-snipe-override-mode 1))
    (diminish 'evil-snipe-local-mode)))

(add-hook 'magit-mode-hook 'turn-off-evil-snipe-mode)
(add-hook 'git-rebase-mode-hook 'turn-off-evil-snipe-mode)
(when evil-snipe-enable-alternate-f-and-t-behaviors
  (add-hook 'magit-mode-hook 'turn-off-evil-snipe-override-mode)
  (add-hook 'git-rebase-mode-hook 'turn-off-evil-snipe-override-mode))

(add-hook 'js2-mode-hook
          (lambda ()
            (make-variable-buffer-local 'evil-snipe-aliases)

            ;; js function definition
            (push '(?1 "\\b[a-zA-Z0-9_]+(.*)[ ]{") evil-snipe-aliases)

            ;; js obj key
            (push '(?2 "\\b[a-zA-Z0-9_]+:") evil-snipe-aliases)

            ;; any number
            (push '(?3 "[0-9]+") evil-snipe-aliases)

            ))
