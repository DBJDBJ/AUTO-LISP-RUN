; midin.lsp dbj created
; second half of LST cutted along a-b line
(setq function
(lambda ( a b LST)
        (if (> a b) (setq t a a b b t))
        (reverse (call '("tri/tail" (call '("tri/head" LST b)) a)))
)) ; midin
