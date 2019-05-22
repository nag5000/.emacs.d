(prelude-require-packages '(yasnippet iedit evil-iedit-state highlight-thing
                                      evil-goggles evil-matchit eacl))

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
(setq highlight-thing-ignore-list '("false" "true" "null" "undefined" "let" "const"))
;; Toggle auto highlighting in all programming mode buffers.
(add-hook 'prog-mode-hook 'highlight-thing-mode)

;; https://github.com/edkolev/evil-goggles
(require 'evil-goggles)
(evil-goggles-mode)

;; Treat hyphen and underscore as word delimiters in Evil mode.
;; https://github.com/emacs-evil/evil#underscore-_-is-not-a-word-character
;; Other examples:
;;   - (modify-syntax-entry ?- "w" js2-mode-syntax-table)
;;   - (add-hook 'c-mode-common-hook #'(lambda () (modify-syntax-entry ?_ "w")))
(modify-syntax-entry ?_ "w")
(modify-syntax-entry ?- "w")

(require 'evil-matchit)
(global-evil-matchit-mode 1)

;; https://github.com/redguardtoo/eacl
;; <eacl-complete-line>, <eacl-complete-multiline>
;; Ivy is required for eacl.
(require 'eacl)
