;rightcut.lsp 13.02.92 DBJ created
;     return last word after last delim in string
;     algorithm analises string from back
;
(setq function
(lambda (string delim / slen place) 
        (setq slen (strlen string)
              place slen
              place (while (and (/= (substr string place 1) delim)
                                (> place 1))
                           (setq place (- place 1) )
                    ) ; while
        ) ; setq
        (if (> place 1)
            (setq string (substr string (1+ place) ))
        )
string
) ; rightcut
) ; function 
