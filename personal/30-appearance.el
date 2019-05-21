(setq
  evil-emacs-state-cursor     '(box "violet")
  evil-insert-state-cursor    '((bar . 2) "LimeGreen")
  ;; In some readonly buffers like *Help*
  evil-motion-state-cursor    '(box "DarkGray")
  evil-normal-state-cursor    '(box "DeepSkyBlue2")
  ;; e.g. after pressing ">" or "=" w/o selection.
  evil-operator-state-cursor  '(hbar "DeepSkyBlue2")
  ;; After pressing "r" in normal mode.
  evil-replace-state-cursor   '(box "red2")
  evil-visual-state-cursor    '(box "RoyalBlue")
)

;; wider buffer name in helm-buffers-list.
(setq helm-buffer-max-length 40)
;; instead of "..." use a smaller unicode ellipsis
(setq helm-buffers-end-truncated-string "…")

(setq display-line-numbers-type 'relative)
;;; Maybe it is better to use avy-goto-line (<SPC><SPC><SPC> or <SPC><SPC>g).
;; (add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; https://www.emacswiki.org/emacs/SrSpeedbar
;; https://www.emacswiki.org/emacs/SpeedBar
;; <sr-speedbar-toggle>
(require 'sr-speedbar)
;;(setq speedbar-use-images nil)
(setq sr-speedbar-default-width 25)
(setq sr-speedbar-right-side nil)
(setq speedbar-initial-expansion-list-name "buffers")
