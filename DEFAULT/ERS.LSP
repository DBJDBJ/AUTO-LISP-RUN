;
;ers.lsp dbj created
;        returns intersection point of two non overlaping lines
(setq function
(lambda ( )
        (setvar "cmdecho" 0)
        (prompt "\n*ers by dbj* pick two lines :")
        (setq l1 (call "lib/getlin") l2 (call "lib/getlin"))
        (trans (inters (cdr (assoc 10 l1)) (cdr (assoc 11 l1))
                       (cdr (assoc 10 l2)) (cdr (assoc 11 l2)) nil )
         0  1 ) ; from wcs to ucs
 );lambda
);setq function
