;; https://github.com/wasamasa/shackle
(prelude-require-package 'shackle)
(require 'shackle)

(setq shackle-default-rule '(:select t))

;; Examples: https://github.com/kaushalmodi/.emacs.d/blob/2c576770e4b18b47cafa7cae28046182cec70a5b/setup-files/setup-shackle.el#L15
(setq shackle-rules '(
     ;; https://github.com/kyagi/shell-pop-el/issues/51#issuecomment-331516739
    ("\\*shell\\*" :regexp t :same t)
    (neotree-mode :select t :align left)
    ;; from https://github.com/wasamasa/shackle#examples
    ("\\`\\*helm.*?\\*\\'" :regexp t :align t :size 0.4)
    (magit-status-mode :select t :inhibit-window-quit t :same t)
    (magit-log-mode :select t :inhibit-window-quit t :same t)
    ;; noselect to select commit message buffer instead
    (magit-diff-mode :select nil :inhibit-window-quit t)
    ("\\*evil-jumps\\*" :regexp t :popup t :align below :size 0.4)
))

;; from https://github.com/wasamasa/shackle#examples
(setq helm-display-function 'pop-to-buffer) ; make helm play nice

(shackle-mode)


;; https://github.com/jrosdahl/iflipb
;; <iflipb-next-buffer>, <iflipb-previous-buffer>
(prelude-require-package 'iflipb)
(require 'iflipb)

;; This variable determines whether iflipb-previous-buffer should use the
;; previous buffer list when it's the first iflipb-*-buffer command in a row.
;; In other words: Running iflipb-previous-buffer after editing a buffer will
;; act as if the current buffer was not visited; it will stay in its original
;; place in the buffer list.
(setq iflipb-permissive-flip-back t)

(setq iflipb-ignore-buffers '("^[*]" "^magit:" "^magit-"))


;; https://github.com/waymondo/frog-jump-buffer
;; (prelude-require-package 'frog-jump-buffer)   --- MELPA submission is in progress (see ./00-vendor-frog-jump-buffer.el)
;; (require 'frog-jump-buffer)


;; evil-jump: kill buffer AND WINDOW TOO on <q> and <return> press.
(define-key evil-list-view-mode-map (kbd "q") #'kill-buffer-and-window)
(defun evil--show-jumps-select-action (jump)
  (let ((position (string-to-number (elt jump 1)))
        (file (car (elt jump 2))))
    (kill-buffer-and-window)
    (switch-to-buffer (find-file file))
    (goto-char position)))
