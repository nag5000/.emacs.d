(prelude-require-package 'mwim)
(require 'mwim)

;; GLOBAL KEYINDINGS
(global-set-key (kbd "<f5>") 'evil-write-all)

;; [C-a] Move to the beginning/end of code in the current line.
;; unbind inc/dec number (defined in prelude-evil.el).
(define-key evil-normal-state-map (kbd "C-A") nil)
(define-key evil-normal-state-map (kbd "C-S-A") nil)
(global-set-key (kbd "C-a") 'mwim)
(define-key prelude-mode-map (kbd "C-a") 'mwim)
(setq mwim-position-functions '(mwim-code-beginning mwim-code-end))

;; LEADER KEYBINDINGS INIT

(prelude-require-package 'evil-leader)
(require 'evil-leader)

;; If you set evil-leader/in-all-states to non-nil (before loading evil-leader
;; or via customize) you can access the leader keymap still with
;; the non-normal-prefix + leader. non-normal-prefix is "C-" by default.
(setq evil-leader/in-all-states t)

(evil-leader/set-leader "<SPC>")
(setq evil-leader/no-prefix-mode-rx '("magit-.*-mode"))

;; To ensure leader key works in startup *Messages* buffer.
;; The reason that *Messages* is already exists when evil-mode is activated.
;; https://github.com/cofi/evil-leader/issues/10#issuecomment-29973298
;; https://github.com/noctuid/evil-guide/issues/11
;; See also "Note" here https://github.com/cofi/evil-leader/blob/39f7014bcf8b36463e0c7512c638bda4bac6c2cf/README.org#usage.
(evil-mode nil)
(global-evil-leader-mode)
(evil-mode 1)

;; LEADER KEYBINDINGS

(evil-leader/set-key "v" 'er/expand-region)
(setq expand-region-contract-fast-key "V")

;; add search capability to expand-region
(defadvice er/prepare-for-more-expansions-internal
    (around helm-ag/prepare-for-more-expansions-internal activate)
  ad-do-it
  (let ((new-msg (concat (car ad-return-value)
                         ", / to search in project, "
                         "f to search in files, "
                         "b to search in opened buffers"))
        (new-bindings (cdr ad-return-value)))
    (cl-pushnew
     '("/" (lambda ()
             (call-interactively
              'helm-projectile-ag)))
     new-bindings)
    (cl-pushnew
     '("f" (lambda ()
             (call-interactively
              'helm-do-ag)))
     new-bindings)
    (cl-pushnew
     '("b" (lambda ()
             (call-interactively
              'helm-do-ag-buffers)))
     new-bindings)
    (setq ad-return-value (cons new-msg new-bindings))))

(evil-leader/set-key "/" 'helm-projectile-ag)

(evil-leader/set-key "!" 'shell-command)
(evil-leader/set-key "'" 'shell)

;; AVY
(evil-leader/set-key
  "<SPC><SPC>" 'avy-goto-line
  "<SPC>g" 'avy-goto-line
  "<SPC>w" 'avy-goto-word-1
  "<SPC>c" 'avy-goto-char
  "<SPC>s" 'avy-goto-char-in-line
  "<SPC>r" 'avy-resume

  ;; Custom commands defined in _avy-commands.el.
  "<SPC>a" 'avy-goto-word-in-line ;; also [gw] in normal state.
  "<SPC>(" 'avy-goto-open-paren
  "<SPC>)" 'avy-goto-close-paren
  "<SPC>f" 'avy-goto-function-def
  "<SPC>," 'avy-goto-comma
  "<SPC>." 'avy-goto-dot
)

;; FILE
(evil-leader/set-key
  "fa" 'helm-do-ag
  "ff" 'helm-find-files
  "fr" 'helm-recentf
  "fj" 'dired-jump
  "fs" 'save-buffer
  "fS" 'evil-write-all
  "fD" 'delete-current-buffer-file
  "fR" 'rename-current-buffer-file
  "fy" 'show-and-copy-buffer-filename
  "ft" 'sr-speedbar-toggle
)

;; BUFFER
(evil-leader/set-key
  "TAB" 'evil-switch-to-windows-last-buffer
  "bn" 'next-buffer
  "bp" 'previous-buffer
  "ba" 'helm-buffers-list
  "bb" 'helm-projectile-switch-to-buffer
  "bd" 'kill-this-buffer
  "bm" 'view-echo-area-messages
)

;; Window
;; [s-w] ace-window (select a window)
;; [S-<right/up/left/down>] windmove-right/up/left/down (move to window)
(evil-leader/set-key
  "wd" 'delete-window
  "wm" 'xx/toggle-maximize-window

  "wH" 'evil-window-move-far-left
  "wJ" 'evil-window-move-very-bottom
  "wK" 'evil-window-move-very-top
  "wL" 'evil-window-move-far-right

  "wh" 'evil-window-left
  "wj" 'evil-window-down
  "wk" 'evil-window-up
  "wl" 'evil-window-right

  "w-" 'split-window-below
  "w/" 'split-window-right
  "w=" 'balance-windows

  "w." 'iresize-mode
  "w]" 'enlarge-window
  "w[" 'shrink-window
  "w+" 'shrink-window-if-larger-than-buffer
)

;; PROJECTile
(evil-leader/set-key
  "pf" 'projectile-find-file
  "p'" 'projectile-run-shell
  "p!" 'projectile-run-shell-command-in-root
)

;; ?
(evil-leader/set-key
  "rl" 'helm-resume
)

;; ?
(evil-leader/set-key
  "xa" 'align-regexp
)

;; VCS
(evil-leader/set-key
  "gs" 'magit-status
  "gd" 'magit-dispatch
)

;; Quit
(evil-leader/set-key
  "qq" 'save-buffers-kill-emacs
)