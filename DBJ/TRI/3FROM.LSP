;3from.lsp dbj created
(setq function
(lambda ( i LST )      ;  2 from i-th on right
                  (IF(OR (< i 0)(> (1+ i) (length LST)))
                     (runerr "Index out of LST boundaries in 3from")
                  );IF
                (setq i (call '("tri/2from" i LST )))
                (call '("tri/1from" i LST))
));3from
