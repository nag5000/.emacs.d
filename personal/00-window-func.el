;; https://github.com/syl20bnr/spacemacs/blob/c7a103a772d808101d7635ec10f292ab9202d9ee/layers/%2Bdistributions/spacemacs-base/funcs.el

(defun xx/toggle-maximize-window ()
  "Maximize window"
  (interactive)
  (if (and (= 1 (length (window-list)))
           (assoc ?_ register-alist))
      (jump-to-register ?_)
    (progn
      (window-configuration-to-register ?_)
      (delete-other-windows))))

;; Interactively Resizing Windows
;; https://www.emacswiki.org/emacs/WindowResize
(defvar iresize-mode-map
  (let ((m (make-sparse-keymap)))
    (evil-define-key 'normal m (kbd "k") 'enlarge-window)
    (evil-define-key 'normal m (kbd "j") 'shrink-window)
    (evil-define-key 'normal m (kbd "<escape>") 'iresize-mode)
    (evil-define-key 'normal m (kbd "q") 'iresize-mode)
    (define-key m (kbd "C-p") 'enlarge-window)
    (define-key m (kbd "<up>") 'enlarge-window)
    (define-key m (kbd "C-n") 'shrink-window)
    (define-key m (kbd "<down>") 'shrink-window)
    (define-key m (kbd "C-c C-c") 'iresize-mode)
    m))

;;;; commented out: strange error on emacs 27
;;(define-minor-mode iresize-mode
;;  :initial-value nil
;;  :lighter " IResize"
;;  :keymap iresize-mode-map
;;  :group 'iresize

;;  (if iresize-mode
;;      (progn
;;        (message "Resize window mode enabled: [k] enlarge, [j] shrink, [q] quit.")
;;        (evil-normalize-keymaps))
;;      (message "Resize window mode disabled")))
;;
;;(provide 'iresize)
