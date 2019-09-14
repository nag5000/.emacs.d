(setq
 ;; scroll N lines to screen edge
 scroll-margin 2

 ;; only 'jump' when moving this far off the screen
 scroll-conservatively 10000

 ;; ensure when we move outside the screen we always recenter
 ;; (less hassle than attempting to make all jumping commands call recenter)
 scroll-conservatively scroll-margin

 ;; keyboard scroll one line at a time
 scroll-step 1
 ;; mouse scroll N lines
 mouse-wheel-scroll-amount '(6 ((shift) . 1))
 ;; don't accelerate scrolling
 mouse-wheel-progressive-speed nil

 ;; preserve line/column (nicer page up/down)
 scroll-preserve-screen-position t
 ;; Move the cursor to top/bottom even if the screen is viewing top/bottom (for page up/down)
 scroll-error-top-bottom t

 ;; center after going to the next error
 next-error-recenter (quote (4))

 ;; Always redraw immediately when scrolling,
 ;; more responsive and doesn't hang!
 ;; http://emacs.stackexchange.com/a/31427/2418
 fast-but-imprecise-scrolling nil
 jit-lock-defer-time 0

 )
