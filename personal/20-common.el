(prelude-require-packages '(use-package yasnippet iedit evil-iedit-state
                                      highlight-thing evil-matchit
                                      eacl lorem-ipsum tinypng dumb-jump
                                      0x0 reveal-in-folder charmap))

;; Yet another snippet library, which is awesome. Allows you to expand
;; commonly used code templates into your buffer. Use it everywhere!
;; see https://joaotavora.github.io/yasnippet/
(require 'yasnippet)
(yas-global-mode +1)

(setq create-lockfiles nil)

(require 'iedit)
(require 'evil-iedit-state)

;; https://github.com/fgeller/highlight-thing.el
(require 'highlight-thing)
;; Don't highlight the thing at point itself. Default is nil.
(setq highlight-thing-exclude-thing-under-point t)
(setq highlight-thing-ignore-list '("false" "true" "null" "undefined" "let"))
(add-hook 'web-mode-hook 'highlight-thing-mode)
(add-hook 'js2-mode-hook 'highlight-thing-mode)

;; Treat hyphen and underscore as word delimiters in Evil mode.
;; https://github.com/emacs-evil/evil#underscore-_-is-not-a-word-character
;; Examples:
;;   - (modify-syntax-entry ?- "w" js2-mode-syntax-table)
;;   - (add-hook 'c-mode-common-hook #'(lambda () (modify-syntax-entry ?_ "w")))
(add-hook 'after-change-major-mode-hook #'(lambda ()
                                            (modify-syntax-entry ?_ "w")
                                            ;; (modify-syntax-entry ?- "w")
                                            ))


(require 'evil-matchit)
(global-evil-matchit-mode 1)

;; https://github.com/redguardtoo/eacl
;; <eacl-complete-line>, <eacl-complete-multiline>
;; Ivy is required for eacl.
(require 'eacl)

(setq
  web-mode-attr-indent-offset nil ;; indent by first attr
  web-mode-markup-indent-offset 2
  web-mode-css-indent-offset 2
  web-mode-code-indent-offset 2
  web-mode-sql-indent-offset 2

  company-dabbrev-downcase nil
  company-dabbrev-code-other-buffers 'all
  company-dabbrev-code-everywhere t
  )

(add-to-list 'projectile-other-file-alist '("js" "hbs" "scss" "css"))
(add-to-list 'projectile-other-file-alist '("hbs" "js" "scss" "css"))
(add-to-list 'projectile-other-file-alist '("scss" "hbs" "js" "css"))
(add-to-list 'projectile-other-file-alist '("css" "hbs" "js" "scss"))

;; Fast "helm-projectile-find-file" (SPC p f)
;; Use projectile-invalidate-cache to clear cache (SPC p I)
(setq projectile-enable-caching t)

(add-hook 'prog-mode-hook (lambda ()
                            (diff-hl-flydiff-mode t)
                            (diff-hl-margin-mode)
                            ))

;; In Evil mode, how can I prevent adding to the kill ring when I yank text,
;; visual mode over other text, then paste over?
;; https://emacs.stackexchange.com/questions/28135/in-evil-mode-how-can-i-prevent-adding-to-the-kill-ring-when-i-yank-text-visual
(setq evil-kill-on-visual-paste nil)
;;;; Also, don't yank text that was killed by "d" (delete) evil command:
;; (defun evil-paste-after-from-0 ()
;;   (interactive)
;;   (let ((evil-this-register ?0))
;;     (call-interactively 'evil-paste-after)))
;; (define-key evil-normal-state-map "p" 'evil-paste-after-from-0)

(setq-default case-fold-search nil) ; make searches case sensitive (isearch)

(setq echo-keystrokes 0.02)
(setq-default indicate-buffer-boundaries 'left)
(setq large-file-warning-threshold (* 1024 1024))
(setq-default tab-width 2)
(setq sentence-end-double-space nil)
