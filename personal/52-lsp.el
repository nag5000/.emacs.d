(prelude-require-packages '(lsp-mode helm-lsp company-lsp))

;; (add-hook 'js2-mode-hook #'lsp-deferred)

;;;; it's done by lsp-mode automatically due to "lsp-auto-configure t"
;;(push 'company-lsp company-backends)

(setq company-lsp-cache-candidates 'auto)
(setq lsp-restart 'ignore)

;; Doesn't work?
;; (setq eldoc-echo-area-use-multiline-p nil)
(setq lsp-eldoc-hook nil)
