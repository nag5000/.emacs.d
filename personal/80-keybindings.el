(prelude-require-packages '(mwim hydra))
(require 'mwim)

;; HYDRA DEFS
(defhydra dumb-jump-hydra (:color blue :columns 3)
  "Dumb Jump"
  ("g" dumb-jump-go "Go")
  ("f" dumb-jump-quick-look "Quick look")
  ("o" dumb-jump-go-other-window "Other window")
  ("e" dumb-jump-go-prefer-external "Go external")
  ("x" dumb-jump-go-prefer-external-other-window "Go external other window")
  ("i" dumb-jump-go-prompt "Prompt")
  ("b" dumb-jump-back "Back"))

(defhydra zoom-hydra ()
  "zoom"
  ("=" text-scale-increase "in")
  ("+" text-scale-increase "in")
  ("-" text-scale-decrease "out")
  ("_" text-scale-decrease "out")
  ("0" text-scale-adjust "reset" :exit t)
  ("q" nil "quit"))

(defun my/name-of-buffers (n)
  "Return the names of the first N buffers from `buffer-list'."
  (let ((bns
         (delq nil
               (mapcar
                (lambda (b)
                  (unless (string-match "^ " (setq b (buffer-name b)))
                    b))
                (buffer-list)))))
    (subseq bns 1 (min (1+ n) (length bns)))))

;; Given ("a", "b", "c"), return "[1] a, [2] b, [3] c".
(defun my/number-names (list)
  "Enumerate and concatenate LIST."
  (let ((i 0))
    (mapconcat
     (lambda (x)
       (format "[%d] %s" (cl-incf i) x))
     list
     ", ")))

(defvar my/last-buffers nil)

(defun my/switch-to-buffer (arg)
  (interactive "p")
  (switch-to-buffer
   (nth (1- arg) my/last-buffers)))

(defun my/switch-to-buffer-other-window (arg)
  (interactive "p")
  (switch-to-buffer-other-window
   (nth (1- arg) my/last-buffers)))

;; https://github.com/abo-abo/hydra/wiki/Switch-to-buffer
(defhydra switch-to-buffer-hydra (:exit nil
                                        :body-pre (setq my/last-buffers
                                                        (my/name-of-buffers 6)))
  "
Buffers: %s(my/number-names my/last-buffers)
"
  ("1" (my/switch-to-buffer 1))
  ("2" (my/switch-to-buffer 2))
  ("3" (my/switch-to-buffer 3))
  ("4" (my/switch-to-buffer 4))
  ("5" (my/switch-to-buffer 5))
  ("6" (my/switch-to-buffer 6))

  ;; ("o" my/switch-to-buffer "this window")
  ;; ("O" my/switch-to-buffer-other-window "other window")
  ("q" nil "quit"))

(defhydra hydra-dired (:hint nil :color pink)
  "
_+_ mkdir          _v_iew           _m_ark             _(_ details        _i_nsert-subdir    wdired
_C_opy             _O_ view other   _U_nmark all       _)_ omit-mode      _$_ hide-subdir    C-x C-q : edit
_D_elete           _o_pen other     _u_nmark           _l_ redisplay      _w_ kill-subdir    C-c C-c : commit
_R_ename           _M_ chmod        _t_oggle           _g_ revert buf     _e_ ediff          C-c ESC : abort
_Y_ rel symlink    _G_ chgrp        _E_xtension mark   _s_ort             _=_ pdiff
_S_ymlink          ^ ^              _F_ind marked      _._ toggle hydra   \\ flyspell
_r_sync            ^ ^              ^ ^                ^ ^                _?_ summary
_z_ compress-file  _A_ find regexp
_Z_ compress       _Q_ repl regexp

T - tag prefix
"
  ("\\" dired-do-ispell)
  ("(" dired-hide-details-mode)
  (")" dired-omit-mode)
  ("+" dired-create-directory)
  ("=" diredp-ediff)         ;; smart diff
  ("?" dired-summary)
  ("$" diredp-hide-subdir-nomove)
  ("A" dired-do-find-regexp)
  ("C" dired-do-copy)        ;; Copy all marked files
  ("D" dired-do-delete)
  ("E" dired-mark-extension)
  ("e" dired-ediff-files)
  ("F" dired-do-find-marked-files)
  ("G" dired-do-chgrp)
  ("g" revert-buffer)        ;; read all directories again (refresh)
  ("i" dired-maybe-insert-subdir)
  ("l" dired-do-redisplay)   ;; relist the marked or singel directory
  ("M" dired-do-chmod)
  ("m" dired-mark)
  ("O" dired-display-file)
  ("o" dired-find-file-other-window)
  ("Q" dired-do-find-regexp-and-replace)
  ("R" dired-do-rename)
  ("r" dired-do-rsynch)
  ("S" dired-do-symlink)
  ("s" dired-sort-toggle-or-edit)
  ("t" dired-toggle-marks)
  ("U" dired-unmark-all-marks)
  ("u" dired-unmark)
  ("v" dired-view-file)      ;; q to exit, s to search, = gets line #
  ("w" dired-kill-subdir)
  ("Y" dired-do-relsymlink)
  ("z" diredp-compress-this-file)
  ("Z" dired-do-compress)
  ("q" nil)
  ("." nil :color blue))

(define-key dired-mode-map "." 'hydra-dired/body)

(defhydra hydra-flycheck
  (:post (quit-windows-on "*Flycheck errors*") :hint nil :foreign-keys run)
  "Flycheck Errors"
  ("f" flycheck-error-list-set-filter "Filter")
  ("]" flycheck-next-error "Next")
  ("[" flycheck-previous-error "Previous")
  ("gg" flycheck-first-error "First")
  ("G" (progn (goto-char (point-max)) (flycheck-previous-error)) "Last")
  ("q" nil "quit"))

(defhydra hydra-git-timemachine (:hint nil :color pink :foreign-keys run)
"
[_n_] next rev  [_p_] prev rev [_c_] show current [_g_] go to revision [_b_] switch branch
[_w_] abbrv hash [_W_] full hash [_q_] quit
"
  ("n" git-timemachine-show-next-revision)
  ("p" git-timemachine-show-previous-revision)
  ("c" git-timemachine-show-current-revision)
  ("g" git-timemachine-show-nth-revision)
  ("b" git-timemachine-switch-branch)
  ("w" git-timemachine-kill-abbreviated-revision)
  ("W" git-timemachine-kill-revision)
  ("q" git-timemachine-quit :color blue)
)

;; (defadvice git-timemachine-mode (after toggle-evil activate)
;;   "Turn off `evil-local-mode' when enabling `git-timemachine-mode',
;;       and turn it back on when disabling `git-timemachine-mode'."
;;   (evil-local-mode (if git-timemachine-mode -1 1)))

;; GLOBAL KEYINDINGS
(global-set-key (kbd "<f5>") 'evil-write-all)

;; jump commands act only within the current buffer.
;; <C-o> (evil-jump-backward), <C-i> (evil-jump-forward)
;; are available by default.
(setq evil-jumps-cross-buffers nil)
;; (global-set-key (kbd "<f6>") 'evil-show-jumps)

(global-set-key (kbd "<f8>")  'iflipb-previous-buffer)
(global-set-key (kbd "<f9>") 'iflipb-next-buffer)
(global-set-key (kbd "C-x <left>") 'iflipb-previous-buffer)
(global-set-key (kbd "C-x <right>") 'iflipb-next-buffer)
(global-set-key (kbd "C-x <C-left>") 'iflipb-previous-buffer)
(global-set-key (kbd "C-x <C-right>") 'iflipb-next-buffer)
(global-set-key (kbd "C-<") 'iflipb-previous-buffer)
(global-set-key (kbd "C->") 'iflipb-next-buffer)

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

;; Using <C-n>, <C-p> (<M-n>, <M-p> by default) to select company candidates.
(define-key company-active-map (kbd "C-n") 'company-select-next-or-abort)
(define-key company-active-map (kbd "C-p") 'company-select-previous-or-abort)

(define-key evil-normal-state-map (kbd "q") 'avy-goto-char-timer)
(define-key evil-normal-state-map (kbd "Q") 'evil-record-macro)

(define-key evil-normal-state-map (kbd "<down>") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "<up>") 'evil-previous-visual-line)

;; avy motions for evil "g"
;; <gw> by default is evil-avy-goto-word-in-line
(define-key evil-normal-state-map "gW" 'evil-avy-goto-word-in-line)
(define-key evil-normal-state-map "gw" 'evil-avy-goto-word-1)
(define-key evil-normal-state-map "gc" 'evil-avy-goto-char)
(define-key evil-normal-state-map "gr" 'avy-resume)
(define-key evil-normal-state-map "gl" 'evil-avy-goto-line-below)
(define-key evil-normal-state-map "gL" 'evil-avy-goto-line-above)
(define-key evil-normal-state-map "g(" 'avy-goto-open-paren)
(define-key evil-normal-state-map "g)" 'avy-goto-close-paren)
(define-key evil-normal-state-map "gh" 'avy-goto-function-def)
(define-key evil-normal-state-map "gx" 'dumb-jump-hydra/body)
(define-key evil-normal-state-map "gX" 'dumb-jump-go)
(define-key evil-normal-state-map "g\\" 'counsel-semantic-or-imenu)
(define-key evil-normal-state-map "g," 'avy-goto-comma)
(define-key evil-normal-state-map "g." 'avy-goto-dot)

(define-key emmet-mode-keymap (kbd "TAB") 'emmet-expand-line) ; <C-j> and <C-return> by default

(define-key evil-motion-state-map (kbd "]h") 'diff-hl-next-hunk)
(define-key evil-motion-state-map (kbd "[h") 'diff-hl-previous-hunk)

(define-key evil-motion-state-map (kbd "]e") 'flycheck-next-error)
(define-key evil-motion-state-map (kbd "[e") 'flycheck-previous-error)

(define-key evil-motion-state-map (kbd "\\") 'ivy-resume)

;; Evilify magit
;; optional: this is the evil state that evil-magit will use
;; (setq evil-magit-state 'normal)
;; optional: disable additional bindings for yanking text
;; (setq evil-magit-use-y-for-yank nil)
(prelude-require-package 'evil-magit)
(require 'evil-magit)

;; Additional dired evilification
(evil-define-key 'normal dired-mode-map
  "gg" 'evil-goto-first-line
  "G" 'evil-goto-line
  "r" 'revert-buffer
)

;; Additional helm-grep evilification
(evil-define-key 'normal helm-grep-mode-map
  (kbd "RET") 'helm-grep-mode-jump-other-window
  (kbd "q") 'quit-window
)

;; Additional helm-ag evilification
(evil-define-key 'normal helm-ag-mode-map
  (kbd "RET") 'helm-ag-mode-jump-other-window
  (kbd "gr") 'helm-ag--update-save-results
  (kbd "q") 'quit-window
)

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

;; Disable evil-mode for some modes.
(evil-set-initial-state 'calendar-mode 'emacs)
(evil-set-initial-state 'bluetooth-mode 'emacs)

;; LEADER KEYBINDINGS

(evil-leader/set-key "v" 'er/expand-region)
(setq expand-region-contract-fast-key "V")

;; (defun ivy-with-thing-at-point (cmd)
;;   (let ((ivy-initial-inputs-alist
;;          (list
;;           (cons cmd (thing-at-point 'symbol)))))
;;     (funcall cmd)))

;; (defun counsel-ag-thing-at-point ()
;;   (interactive)
;;   (ivy-with-thing-at-point 'counsel-ag))

;; (defun counsel-projectile-ag-thing-at-point ()
;;   (interactive)
;;   (ivy-with-thing-at-point 'counsel-projectile-ag))

(defun selection-at-point ()
  (interactive)
  (if (use-region-p)
      (buffer-substring-no-properties (region-beginning) (region-end))))

(setq counsel-projectile-ag-initial-input '(selection-at-point))

;; add search capability to expand-region
(defadvice er/prepare-for-more-expansions-internal
    (around counsel-ag/prepare-for-more-expansions-internal activate)
  ad-do-it
  (let ((new-msg (concat (car ad-return-value)
                         ", / to search in project, "
                         "f to search in files, "
                         "b to search in opened buffers"))
        (new-bindings (cdr ad-return-value)))
    (cl-pushnew
     '("/" (lambda ()
             (call-interactively
              'counsel-projectile-ag)))
     new-bindings)
    (setq ad-return-value (cons new-msg new-bindings))))

(evil-leader/set-key "/" 'counsel-projectile-ag)
(evil-leader/set-key "<SPC>" 'frog-jump-buffer-same-project)

;; <C-s> isearch-forward
;; <C-r> isearch-backward
;; <C-s> <C-s> isearch-forward with last used value.
(evil-leader/set-key "*" 'isearch-forward-symbol-at-point)

(evil-leader/set-key "!" 'shell-command)
(evil-leader/set-key "'" 'shell-pop)

(defun counsel-ag-read-dir ()
  (interactive)
  (let ((current-prefix-arg 4)) ;; emulate C-u
    (call-interactively 'counsel-ag)
    )
  )

;; FILE
(evil-leader/set-key
  "fa" 'counsel-ag-read-dir
  "ff" 'projectile-find-file-in-directory
  "fr" 'counsel-recentf
  "fj" 'dired-jump
  "fs" 'save-buffer
  "fS" 'evil-write-all
  "fD" 'delete-current-buffer-file
  "fR" 'rename-current-buffer-file
  "fy" 'show-and-copy-buffer-filename
  "ft" 'neotree-toggle
  "fo" 'projectile-find-other-file
)

;; SEARCH
(evil-leader/set-key
  "sf" 'counsel-ag-read-dir
  "ss" 'swiper-thing-at-point
  "sa" 'swiper-all-thing-at-point
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
  "ba" 'counsel-ibuffer
  "bb" 'projectile-switch-to-buffer
  "bd" 'kill-this-buffer
  "bm" 'view-echo-area-messages
  "bD" (lambda () (interactive) (crux-kill-other-buffers) (kill-dired-buffers))
  "b TAB" 'switch-to-buffer-hydra/body
  "be" 'hydra-flycheck/body
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
  "rl" 'ivy-resume
)

;; text
(evil-leader/set-key
  "xa" 'align-regexp
)

;; VCS
(evil-leader/set-key
  "gs" 'magit-status
  "gd" 'magit-dispatch
  "gt" (lambda () (interactive) (git-timemachine-toggle) (hydra-git-timemachine/body))
  "gb" 'magit-blame
  "gh" 'diff-hl-diff-goto-hunk
  "gf" 'magit-log-buffer-file
)

;; ember-mode
(require 'ember-mode)
(evil-leader/set-key "e" 'ember-command-prefix)

;; Open...
(evil-leader/set-key
  "or" 'browse-at-remote
  "o0b" '0x0-upload
  "o0f" '0x0-upload-file
  "o0s" '0x0-upload-string
  "ob" 'bluetooth-list-devices
)

;; Toggle
(evil-leader/set-key
  "tz" 'zoom-hydra/body
)

;; Quit
(evil-leader/set-key
  "qq" 'save-buffers-kill-emacs
)
