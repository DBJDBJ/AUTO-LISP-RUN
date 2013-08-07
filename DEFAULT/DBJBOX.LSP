;-----------------------------------------------------------------------------|
;defun c:dbjbox
(setq function
(lambda ( )
        ; (libload '( "modes" "moder") )
        (setq olderr *error* *error* dbjerr )
        (call '("lib/modes" '("cmdecho" "blipmode") ) )
        (setvar "cmdecho" 0)(setvar "blipmode" 0 )
        (prompt "\nbox by dbj")
        (setq t1 (getpoint  "\nfirst corner :")
              t3 (getcorner t1 "\nsecond :")
        )
                        (if (< (car t3) (car t1))
                                (setq t2 t1 t1 t3 t3 t2)
                        )
                        (setq t2 (list (car t1) (cadr t3))
                              t4 (list (car t3) (cadr t1))
                        )
                        (command "pline" t1 t2 t3 t4 "c")
        (call "lib/moder" )
        (princ)
); lambda
);setq function
