;2from.lsp dbj created
(setq function
(lambda ( i LST )      ;  2 from i-th on right
                  (IF(OR (< i 0)(> (1+ i) (length LST)))
                     (runErr "Index out of LST boundaries in 2FROM")
                  );IF
                (setq i (call '("tri/1from" i LST )))
                (call '("tri/1from" i LST))
))
