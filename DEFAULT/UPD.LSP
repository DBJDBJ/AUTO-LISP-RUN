;-----------------------------------------------------------------------------|
; dbjupd.lsp 31.07.91 update the external block if exists
; command : upd
;
(setq function
(lambda ( / b1 olderr )
        ; link local fun's
        ;"modes" " "moder" " "getblok" " "blname" "updblk"
        (setq olderr *error* *error* dbjerr )
        (call '("lib/modes" '("cmdecho" "blipmode") ))
        (setvar "cmdecho" 0)(setvar "blipmode" 0 )
        (prompt "\nupdate the block wich has file presentation ")
        (setq b1 (call "lib/getblok"))
(if (/= b1 nil)
(progn
        (setq b1 (call '("lib/blname" b1) ) )
        (if (eq nil (findfile (strcat b1 ".dwg")))
         (prompt (strcat "\nsorry block: " b1 " has no external presentation ..."))
         (call '("lib/updblk" b1 b1) )
        ) ; if
);progn
);if
        (setq *error* olderr)
        (call "lib/moder")
        (prin1)
); dbjupd lambda
); setq function

