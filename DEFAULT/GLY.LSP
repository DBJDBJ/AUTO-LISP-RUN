;------- go on layer where last ent. is on ---------------------------|
;
(setq function
(lambda ( / a1 a2 n index b1 b2 b3 d1 d2 olderr )
        ;(libload '( "modes" "moder" ) )
        (setq *error* runerr )
        (call '("lib/modes" '("cmdecho" "blipmode")) )
        (graphscr)
        (setvar "cmdecho" 0)
        (prompt "\ngo to layer ent is on by dbj")
        (prompt "\nselect entities to go on another layer") (setq a1 (ssget))
        (prompt "\nselect etity on target layer")
        (setq a2 (entsel)
               n (sslength a1)
           index 0
              b2 (entget (car a2))
              d2 (assoc 8 b2)
        )
        (repeat n
                (setq b1 (entget (ssname a1 index))
                      d1 (assoc 8 b1)
                      b3 (subst d2 d1 b1)
                )
                (entmod b3)
                (setq index (1+ index))
        )
        (call "lib/moder")
        (princ)
) ; lambda
) ; setq function
