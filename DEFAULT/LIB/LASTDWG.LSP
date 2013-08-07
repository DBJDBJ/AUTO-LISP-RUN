; current dwg name in text file
(setq function
(lambda ( / f )
        (setq f (open (strcat envpath "lastdwg.txt" ) "w"))
        (write-line (getvar "dwgname") f) ; name
        (write-line (getvar "dwgprefix") f) ; and path
        (close f)
)
) ; function
