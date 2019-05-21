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

(setq iflipb-ignore-buffers '("^[*]" "^magit:" "^magit-process:"))
