; ptext.lsp dbj created
; point and text on given coords, mainly for control purposes
(setq function
        (lambda ( p t )
               (command "POINT" p )
               (command "TEXT"  p "" ""  (strcat " " t) )
 )) ; ptext
