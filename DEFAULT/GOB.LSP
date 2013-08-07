;
; GOB.LSP DBJ created
; 10.02.92 last amendment
;
(setq function
(lambda ( / b1 bn bn2 newdwg )
        (setq *error* runerr )
        (call '("lib/modes" '("cmdecho" "blipmode")) )
        (setvar "cmdecho" 0)(setvar "blipmode" 0 )
        (prompt "\nTravel to external block with dbj")
        (setq b1 ( call "lib/getblok" ))
(if (/= b1 nil)
(progn
        (setq bn (strcat (call '("lib/blname" b1)) ".dwg")
             bn2 (call '("lib/blname" b1))
        )
        (if (eq nil (findfile bn))
         (prompt (strcat "\nSorry block: " bn2 " has no external presentation ..."))
         (call '("lib/newdwg" bn2))
        ) ; if
);progn
);if
        (call "lib/moder")
        "exit"
); lambda
) ; setq function
