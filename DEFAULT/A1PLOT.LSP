; a1plot.lsp
; mar 1992 DBJ improved 
; may 1991
; function without c: prefix
; plot scale as argument
; prepare script regarding dwgname
; and desired scale and plot with it
; feb. 1991
; new pen-color setup after bs-1192 part 5
; new origin at 0,0 for new frame !
;
;
(setq function
(lambda ( / scl scr dwg scl )
        (setvar "cmdecho" 0)
        (setq *error* runerr )
( prompt "\rdbjplot to file extents onto a1 paper     v3.3 10.12.91")
(setq scl "f")
( prompt (strcat "\nplot scale <" scl "> or 1:"))
(setq scl ( getstring ))
;
        (prompt "\nNow creating a plt file")
        (setq dwg (call '("lib/p2n" (getvar "dwgname"))); path to name
              scr (open (strcat dwg ".scr") "w") ; new script file
        )
        ; making a script for plotting
        (write-line "exit" scr)
        (write-line "plot" scr)
        (write-line "extents" scr)
        (write-line "yes-change-things" scr)
        (write-line "yes-change-above-parameters" scr)
;
; new setup
;
        (write-line "1 0 50" scr)  ; color 1/red   to be pen 1 -> 0.25 blk
        (write-line "2 0 50" scr)  ; color 2/yell. to be pen 2 -> 0.35 blk
        (write-line "3 0 40" scr)  ; color 3/green to be pen 3 -> 0.50 blk
        (write-line "4 0 40" scr)  ; color 4/cyan  to be pen 4 -> 0.70 blk
        (write-line "1 0 40" scr)  ; color 5/blue  to be pen 1 -> 0.25 blk
        (write-line "2 0 50" scr)  ; color 6/mage. to be pen 2 -> 0.35 blk
        (write-line "3 0 40" scr)  ; color 7/white to be pen 3 -> 0.50 blk
        (write-line "1 0 40" scr)  ; color 8/grey  to be pen 1 -> 0.25 blk
;
        (write-line "x-it"   scr)
        (write-line "yes-file" scr)
        (write-line "milimeters" scr)
; old origin        (write-line "20,20"  scr)
        (write-line "5,0"  scr)
        (write-line "a1" scr)
        (write-line "no-rotate" scr)
        (write-line "0.25" scr)
        (write-line "no-adjust-boundaries" scr)
        (write-line "no-remove-hidden-lines" scr)
;------ scale ---------------
        (if (= "" scl) (setq scl "f")) ; default is fit
        (if (= "f" scl)
            (write-line  scl scr)
            (write-line  (strcat "1=" scl) scr)
        )
;------ fname ---------------
        (write-line (strcat "c:\\plt\\" dwg) scr)
        (write-line "y-for-dwg-size" scr)
        (write-line "run" scr)
        (close scr)
        (command ".zoom" "e" )
        (command ".script" dwg )
        (command ".shell" (strcat "del " dwg ".scr" ) )
        (setvar "cmdecho" 0)
        (princ)
) ; lambda
) ; function
