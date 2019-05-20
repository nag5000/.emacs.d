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
(setq highlight-thing-ignore-list '("false" "true" "null" "undefined"))
;; Toggle auto highlighting in all programming mode buffers.
(add-hook 'prog-mode-hook 'highlight-thing-mode)

(require 'window-purpose)
(purpose-mode)
