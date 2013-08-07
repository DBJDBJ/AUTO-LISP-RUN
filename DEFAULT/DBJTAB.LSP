
;dbjtab.lsp dbj created
;           tablet configuration by help slide of it
(setq function
(lambda ()
        (setq *error* runerr)
        (setvar "cmdecho" 1 )
        (command ".vslide" (strcat envpath "sld/tabconfg"))
        (setq   c1 25 r1 9 c2 11 r2 9 c3 9 r3 13 c4 25 r4 7)
        (command ".tablet" "cfg" 4 "y" c1 r1 c2 r2 c3 r3 c4 r4 "y")
        (redraw)
        (setvar "cmdecho" 0 )
 );lambda
);setq function
