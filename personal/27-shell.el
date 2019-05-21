;; https://github.com/kyagi/shell-pop-el
(prelude-require-package 'shell-pop)
(require 'shell-pop)

;; https://github.com/syl20bnr/spacemacs/blob/c7a103a772/layers/%2Btools/shell/config.el#L15
;; move point to the end of buffer on new output
;;(setq comint-move-point-for-output t)

(setq shell-pop-window-size 30)
(setq shell-pop-full-span t)
(setq shell-pop-shell-type '("ansi-term" "*ansi-term*"
                             (lambda () (ansi-term shell-pop-term-shell))))
(setq shell-pop-term-shell "/usr/bin/zsh")

;; https://github.com/kyagi/shell-pop-el/issues/62
;; need to do this manually or not picked up by `shell-pop'
;; http://pragmaticemacs.com/emacs/pop-up-a-quick-shell-with-shell-pop/
(shell-pop--set-shell-type 'shell-pop-shell-type shell-pop-shell-type)

;; https://github.com/syl20bnr/spacemacs/blob/c7a103a772d808101d7635ec10f292ab9202d9ee/layers/%2Btools/shell/funcs.el#L12
(defun xx/projectile-shell-pop ()
  "Open a term buffer at projectile project root."
  (interactive)
  (let ((default-directory (projectile-project-root)))
    (call-interactively 'shell-pop)))
