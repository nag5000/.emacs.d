;; https://github.com/hinrik/total-lines
(prelude-require-package 'total-lines)
(global-total-lines-mode)

(setq-default mode-line-format
              '("%e"
                mode-line-front-space
                mode-line-mule-info
                mode-line-client
                ;; mode-line-remote

                ;; mode-line-modified
                ;; Custom readonly & modified status:
                (:eval
                 (cond (buffer-read-only
                        (propertize "R" 'face 'mode-line-read-only-face))
                       ((buffer-modified-p)
                        (propertize "×" 'face 'mode-line-modified-face))
                       (t " ")))
                " "

                ;; mode-line-frame-identification

                (:propertize (:eval (shorten-directory default-directory 20))
                             face mode-line-folder-face)
                (:propertize "%b"
                             face mode-line-filename-face)
                ;; mode-line-buffer-identification

                "  "

                ;; mode-line-position
                ;; the below will look like e.g. "263/947:10"
                (10
                   "%l"
                   "/"
                   (:eval (format "%d" total-lines))
                   (:eval (propertize (format ":%d" (1+ (current-column))) 'face
                               (if (>= (current-column) 80)
                                   'mode-line-80col-face
                                 'mode-line-position-face)))
                 )

                " "

                ;; evil-mode-line-tag
                smartrep-mode-line-string
                ;; (vc-mode vc-mode)
                ;; " "
                mode-line-modes mode-line-misc-info mode-line-end-spaces
                ))

(setq evil-mode-line-format nil)

(diminish 'vi-tilde-fringe-mode)
(diminish 'yas-minor-mode)
(diminish 'company-mode)
(diminish 'helm-mode)
(diminish 'editorconfig-mode)
(diminish 'whitespace-mode)
(diminish 'projectile-mode)
(diminish 'smartparens-mode)
(diminish 'prelude-mode)
(diminish 'which-key-mode)
(diminish 'beacon-mode)
(diminish 'highlight-thing-mode)
(diminish 'emmet-mode)

(eval-after-load "hi-lock"
  '(diminish 'hi-lock-mode))

(with-eval-after-load "ember-mode"
  (diminish 'ember-mode "ember"))

(setq flycheck-mode-line-prefix "F")

(prelude-require-package 'flycheck-color-mode-line)
(prelude-require-package 'flycheck-indicator)
(with-eval-after-load "flycheck"
  (add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode)
  (add-hook 'flycheck-mode-hook 'flycheck-indicator-mode)
)

;; Taken from https://gist.github.com/pragdave/4adb3ba2a87b250f2e87e66ca261104c
(defun shorten-directory (dir max-length)
  "Show up to `max-length' characters of a directory name `dir'."
  (let ((path (reverse (split-string (abbreviate-file-name dir) "/")))
        (output ""))
    (when (and path (equal "" (car path)))
      (setq path (cdr path)))
    (while (and path (< (length output) (- max-length 4)))
      (setq output (concat (car path) "/" output))
      (setq path (cdr path)))
    (when path
      (setq output (concat "…/" output)))
    output))

(make-face 'mode-line-read-only-face)
(make-face 'mode-line-modified-face)
(make-face 'mode-line-folder-face)
(make-face 'mode-line-filename-face)
(make-face 'mode-line-position-face)
(make-face 'mode-line-80col-face)

(set-face-attribute 'mode-line-read-only-face nil
                    :inherit 'mode-line-face
                    :foreground "#00638a")

(set-face-attribute 'mode-line-modified-face nil
                    :inherit 'mode-line-face
                    :foreground "#FF0000")

(set-face-attribute 'mode-line-folder-face nil
                    :inherit 'mode-line-face)

(set-face-attribute 'mode-line-filename-face nil
                    :inherit 'mode-line-face
                    :foreground "#00638a"
                    :weight 'bold)

(set-face-attribute 'mode-line-position-face nil
                    :inherit 'mode-line-face)

(set-face-attribute 'mode-line-80col-face nil
                    :inherit 'mode-line-position-face
                    :foreground "black" :background "#eab700")
