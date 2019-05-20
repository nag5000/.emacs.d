;; https://github.com/abo-abo/avy/wiki/custom-commands

;; Jumping to a word start on the current line only.
(defun avy-goto-word-in-line ()
  "Jump to a word start on the current line only."
  (interactive)
  (avy-with avy-goto-word-0
    (avy-goto-word-0 nil (line-beginning-position) (line-end-position))))

;; evil integration.
(declare-function 'avy-goto-word-in-line "avy")
(evil-define-avy-motion avy-goto-word-in-line inclusive)

(define-key evil-normal-state-map "gw" 'evil-avy-goto-word-in-line)

;; Jump to an open paren.
(defun avy-goto-open-paren ()
  "Jump to an open paren."
  (interactive)
  (avy-jump "("))

;; Jump to a close paren.
(defun avy-goto-close-paren ()
  "Jump to a close paren."
  (interactive)
  (avy-jump ")"))

;; Jump to a comma.
(defun avy-goto-comma ()
  "Jump to a comma."
  (interactive)
  (avy-jump ","))

;; Jump to a dot.
(defun avy-goto-dot ()
  "Jump to a dot."
  (interactive)
  (avy-jump "."))

;; Jump to a "function".
(defun avy-goto-function-def ()
  "Jump to a \"function\" word."
  (interactive)
  (avy-jump "function"))
