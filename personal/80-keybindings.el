(prelude-require-package 'mwim)
(require 'mwim)

;; GLOBAL KEYINDINGS
(global-set-key (kbd "<f5>") 'evil-write-all)

;; jump commands act only within the current buffer.
;; <C-o> (evil-jump-backward), <C-i> (evil-jump-forward)
;; are available by default.
(setq evil-jumps-cross-buffers nil)
(global-set-key (kbd "<f6>") 'evil-show-jumps)

(global-set-key (kbd "<f8>")  'centaur-tabs-backward)
(global-set-key (kbd "<f9>") 'centaur-tabs-forward)
(global-set-key (kbd "C-x <left>") 'centaur-tabs-backward)
(global-set-key (kbd "C-x <right>") 'centaur-tabs-forward)
(global-set-key (kbd "C-x <C-left>") 'centaur-tabs-backward)
(global-set-key (kbd "C-x <C-right>") 'centaur-tabs-forward)
(global-set-key (kbd "C-<") 'centaur-tabs-backward)
(global-set-key (kbd "C->") 'centaur-tabs-forward)

;; [C-a] Move to the beginning/end of code in the current line.
;; unbind inc/dec number (defined in prelude-evil.el).
(define-key evil-normal-state-map (kbd "C-A") nil)
(define-key evil-normal-state-map (kbd "C-S-A") nil)
(global-set-key (kbd "C-a") 'mwim)
(define-key prelude-mode-map (kbd "C-a") 'mwim)
(setq mwim-position-functions '(mwim-code-beginning mwim-code-end))

;; <C-n>, <C-.>, <C-/>, <C-c />
(define-key evil-insert-state-map (kbd "C-/") 'eacl-complete-line)
(define-key evil-insert-state-map (kbd "C-.") 'eacl-complete-multiline)
(global-set-key (kbd "C-c /") 'company-files)  ; Force complete file names on "C-c /" key

(define-key evil-normal-state-map (kbd "q") 'avy-goto-char-timer)
(define-key evil-normal-state-map (kbd "Q") 'evil-record-macro)

(define-key emmet-mode-keymap (kbd "TAB") 'emmet-expand-line) ; <C-j> and <C-return> by default

;; highlight-changes-mode
;; <[[>, <]]> go to next/prev change.
(define-key evil-motion-state-map (kbd "]]") 'highlight-changes-next-change)
(define-key evil-motion-state-map (kbd "[[") 'highlight-changes-previous-change)

;; EVIL + MAGIT
;; optional: this is the evil state that evil-magit will use
;; (setq evil-magit-state 'normal)
;; optional: disable additional bindings for yanking text
;; (setq evil-magit-use-y-for-yank nil)
(prelude-require-package 'evil-magit)
(require 'evil-magit)

;; LEADER KEYBINDINGS INIT

(prelude-require-package 'evil-leader)
(require 'evil-leader)

;; If you set evil-leader/in-all-states to non-nil (before loading evil-leader
;; or via customize) you can access the leader keymap still with
;; the non-normal-prefix + leader. non-normal-prefix is "C-" by default.
;;
;; https://github.com/cofi/evil-leader/issues/31
;;;;(setq evil-leader/in-all-states t)

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
(evil-leader/set-key "'" 'shell-pop)

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
  "ff" 'projectile-find-file-in-directory
  "fr" 'helm-recentf
  "fj" 'dired-jump
  "fs" 'save-buffer
  "fS" 'evil-write-all
  "fD" 'delete-current-buffer-file
  "fR" 'rename-current-buffer-file
  "fy" 'show-and-copy-buffer-filename
  "ft" 'neotree-toggle
  "fo" 'helm-projectile-find-other-file
)

;; BUFFER
(evil-leader/set-key
  "TAB" 'crux-switch-to-previous-buffer
  "b1" (lambda () (interactive) (iflipb-select-buffer 0))
  "b2" (lambda () (interactive) (iflipb-select-buffer 1))
  "b3" (lambda () (interactive) (iflipb-select-buffer 2))
  "b4" (lambda () (interactive) (iflipb-select-buffer 3))
  "b5" (lambda () (interactive) (iflipb-select-buffer 4))
  "b6" (lambda () (interactive) (iflipb-select-buffer 5))
  "b7" (lambda () (interactive) (iflipb-select-buffer 6))
  "b8" (lambda () (interactive) (iflipb-select-buffer 7))
  "b9" (lambda () (interactive) (iflipb-select-buffer 8))
  "b0" (lambda () (interactive) (iflipb-select-buffer 9))
  "bn" 'iflipb-next-buffer
  "bp" 'iflipb-previous-buffer
  "ba" 'helm-buffers-list
  "bb" 'helm-projectile-switch-to-buffer
  "bd" 'kill-this-buffer
  "bm" 'view-echo-area-messages
  "bD" 'crux-kill-other-buffers
  ";"  'frog-jump-buffer-same-project
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
  "p'" 'xx/projectile-shell-pop
  "p!" 'projectile-run-shell-command-in-root
  "pI" 'projectile-invalidate-cache
  "pp" 'projectile-switch-project
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
  "gt" 'git-timemachine-toggle
  "gb" 'magit-blame
)

;; ember-mode
(require 'ember-mode)
(evil-leader/set-key "e" 'ember-command-prefix)

;; Open...
(evil-leader/set-key
  "or" 'browse-at-remote
)

;; Highlight...
(evil-leader/set-key
  ;; highlight-changes-mode
  "hct" 'highlight-changes-visible-mode
  "hcc" (lambda () (interactive) (highlight-changes-remove-highlight (point-min) (point-max)))
  "hcp" 'highlight-changes-previous-change ;; Better use <[[>.
  "hcn" 'highlight-changes-next-change ;; Better use <]]>.
)

;; Quit
(evil-leader/set-key
  "qq" 'save-buffers-kill-emacs
)
