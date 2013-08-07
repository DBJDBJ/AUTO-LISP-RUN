; tail.lsp dbj created
(setq function
 (lambda (lst i)     ;  with i-th member
                  (IF(OR (< i 0)(> (1+ i) (length lst)))
                     (runErr "Index out of LST boundaries in TAIL")
                  );IF
                   (if (= i 0)
                       lst
                       (member (nth i lst) lst)
                   ) ; if
 ));tail
