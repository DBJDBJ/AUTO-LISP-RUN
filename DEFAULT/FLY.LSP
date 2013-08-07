;---------------------------------------------------------------------;
; fly freeze lay entity is on
;---------------------------------------------------------------------;
(setq function
(lambda (  / l ll b1 )
        (setvar "cmdecho" 0)
        (setq *error* runerr)
        (prompt "\n*fly with dbj* ")
        (setq l (ssget) n (sslength l) index 0 ll () )
  (repeat n
        (setq b1 (cdr (assoc 8 (entget (ssname l index))))
           index (1+ index))
           (if (not (member b1 ll))
               (setq ll (append ll (list b1)))
           )
  ) ; of repeat
    (setq l nil)
    (foreach l ll
                (grtext -2 (strcat "freezing: " l) )
                (command "layer" "f" l "")
     )
        (setq *error* olderr)
        (princ)
) ; end of lambda
) ; end of setq function
