;function to restore system on error and make nil all from dbjatom
;which is actualy a list of functions not finished at the moment of error
;
(setq function
(lambda (s / f)
       (if (/= s "function cancelled") (princ (strcat "\nerror: " s)))
       (if dbjatom
           (foreach f dbjatom (set f nil))
       )
       (setq dbjatom '()) (gc) ; garbage colection
       (setq *error* olderr)(princ)
)
)
