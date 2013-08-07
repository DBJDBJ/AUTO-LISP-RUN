; midout.lsp dbj created
; first half of LST cutted along a-b line
(setq function
(lambda ( a b LST / t)
        (if (> a b) (setq t a a b b t))
        (append (call '("tri/head" LST a))(call '("tri/tail" LST b)) )
)) ; midout
