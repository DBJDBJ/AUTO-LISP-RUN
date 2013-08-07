;laycode.lsp 05.02.92 dbj created
;---- giving last word after last "-" in layer name 
;     alorithm analises string from back
;
(setq function
(lambda (lname / delim slen place) 
        (setq delim "-"   
              slen (strlen lname)
              place slen
              place (while (and (/= (substr lname place 1) delim)
                                (> place 1))
                           (setq place (- place 1) )
                    ) ; while
        ) ; setq
        (if (> place 1)
            (setq lname (substr lname (1+ place) ))
        )
lname
) ; lambda
) ; setq
;
