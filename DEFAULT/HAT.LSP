;
; hat.lsp dbj created
; m:hp is acad.mnu global which is used here
;
(setq function
(lambda ( / ent p)
 (setvar "cmdecho" 0)
 (cond
 ((/= nil m:hp)
 (prompt (strcat "\nPATTERN: " m:hp " , select vertices for hatching area : "))
        (setq p (getpoint "\nFirst point: " ) )
        (command ".pline")
        (while (/= nil p) 
               (command p)
               (setq p (getpoint "\nNext point: " ) )
        ) 
        (command "c" ) ; finish polyline with close
                (setq ent (entlast)) 
                (setvar "cmdecho" 1)
                (command ".hatch" m:hp pause pause ent "")
                (entdel ent)
                "Done..."
)
(T (prompt "\nDefine hatch pattern from acad.mnu -> options..."))
)
);lambda
);function
