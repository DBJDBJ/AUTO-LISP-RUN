; pline from list of points
(setq function
(lambda (p / dl)(load (strcat dbjpath "drawpoly"))
        (setq dl (length p) )
        (command "pline")
        (repeat dl
           (command (car p))
           (setq  p (cdr p))
        )
        (command "c")
(entlast) ; returns the name of poly-line
)
)
