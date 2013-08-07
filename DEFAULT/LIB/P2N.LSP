;
;---- giving last word after "/" in #path
;     alorithm analises string from back ... dbj mart1991
;
;p2n = #path to name
;
(setq function
(lambda (#path / slash slen place) ; p2n = #path to name
        (setq slash (chr 47) ; "/"
              slen (strlen #path)
              place slen
              place (while (and (/= (substr #path place 1) slash)
                                (> place 1))
                           (setq place (- place 1) )
                    ) ; while
        ) ; setq
        (if (> place 1)
            (setq #path (substr #path (1+ place) ))
        )
#path
) ; p2n lambda
) ; setq
;
