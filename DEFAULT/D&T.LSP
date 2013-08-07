;-----------------------------------------------------
; Routine to echo date to screen
;-----------------------------------------------------
(setq function 
( lambda ( / return )
    (setq return (strcat "Date : " (call '("lib/getdate"))
                         "  Time : " (call '("lib/gettime")))
    )
    ( prompt (strcat "\n" return ))
 (princ)
) ; lambada
) ; result
