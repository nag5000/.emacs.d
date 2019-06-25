(prelude-require-packages '(yasnippet iedit evil-iedit-state highlight-thing
                                      evil-goggles evil-matchit eacl lorem-ipsum))

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
;; NOTE: for JS mode there is lsp-mode with the same feature.
(add-hook 'web-mode-hook 'highlight-thing-mode)

;; https://github.com/edkolev/evil-goggles
(require 'evil-goggles)
(evil-goggles-mode)

;; Treat hyphen and underscore as word delimiters in Evil mode.
;; https://github.com/emacs-evil/evil#underscore-_-is-not-a-word-character
;; Examples:
;;   - (modify-syntax-entry ?- "w" js2-mode-syntax-table)
;;   - (add-hook 'c-mode-common-hook #'(lambda () (modify-syntax-entry ?_ "w")))
(add-hook 'after-change-major-mode-hook #'(lambda ()
                                            (modify-syntax-entry ?_ "w")
                                            (modify-syntax-entry ?- "w")))


(require 'evil-matchit)
(global-evil-matchit-mode 1)

;; https://github.com/redguardtoo/eacl
;; <eacl-complete-line>, <eacl-complete-multiline>
;; Ivy is required for eacl.
(require 'eacl)

(setq
  ;; https://github.com/syohex/emacs-helm-ag#customize
  ;; Use .agignore file at project root if this variable is non nil.
  ;; You can also use .ignore file at project root.
  helm-ag-use-agignore t

  ;; Default: "ag --nocolor --nogroup". --follow: Follow symlinks.
  helm-ag-base-command "ag --nocolor --nogroup --follow"

  web-mode-attr-indent-offset nil ;; indent by first attr
  web-mode-markup-indent-offset 2
  web-mode-css-indent-offset 2
  web-mode-code-indent-offset 2
  web-mode-sql-indent-offset 2

  company-dabbrev-downcase nil)

(add-to-list 'projectile-other-file-alist '("js" "hbs" "scss" "css"))
(add-to-list 'projectile-other-file-alist '("hbs" "js" "scss" "css"))
(add-to-list 'projectile-other-file-alist '("scss" "hbs" "js" "css"))
(add-to-list 'projectile-other-file-alist '("css" "hbs" "js" "scss"))

;; Fast "helm-projectile-find-file" (SPC p f)
;; Use projectile-invalidate-cache to clear cache (SPC p I)
(setq projectile-enable-caching t)
