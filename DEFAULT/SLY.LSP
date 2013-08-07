;---------------------------------------------------------------------
; sly select layer entity is on
;---------------------------------------------------------------------
( setq function
(lambda ( / tl )
        ;libload '( "layget" "entlst")
        (setvar "cmdecho" 0)
        (setq *error* runerr)
        (prompt "\n*sly by dbj* ")
	(setq tl (call "lib/entlst"))
        (setq l (call '("lib/layget" tl)))
        (command "layer" "s" l "")
        (prompt (strcat "\n" l " is selected layer..."))
        (princ)
) ; end of lambda function sly
) ; eof setq function
