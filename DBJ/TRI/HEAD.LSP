; head.lsp dbj created
(setq function
 (lambda (lst i / i2) ; WITH i-th member
                  (IF(OR (< i 0)(> (1+ i) (length lst)))
                     (runErr "Index out of LST boundaries in HEAD")
                  );IF
                  (if (= (1+ i) (length lst))
                      lst
                       (setq i2 (- (length lst) (1+ i))
                            lst (reverse lst)
                            lst (member (nth i2 lst) lst)
                            lst (reverse lst)
                       )
                  ) ; if
 ));head
