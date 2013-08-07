;1left.lsp dbj created
(setq function
(lambda ( i LST )      ;  1 from i-th on right
                  (IF(OR (< i 0)(> (1+ i) (length LST)))
                     (runerr "Index out of LST boundaries in 1LEFT")
                  );IF
                (if (= 0 i)
                    (1- (length LST))
                    (1- i)
                ) ; if
))   
