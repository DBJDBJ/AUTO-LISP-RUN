;1from.lsp dbj created
(setq function
(lambda ( i LST )      ;  1 from i-th on right
                  (IF(OR (< i 0)(> (1+ i) (length LST)))
                     (runerr "Index out of LST boundaries in 1FROM")
                  );IF
                (if (null (nth (1+ i) LST))
                    0
                    (1+ i)
                ) ; if
);1FROM lmbda
);function  

