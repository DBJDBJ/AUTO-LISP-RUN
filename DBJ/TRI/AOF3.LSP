;aof3.lsp dbj created
;  area of triangle -> positive if ordered anti-clockwise
(setq function
(lambda ( p1 p2 p3 / x1 x2 x3 y1 y2 y3 )
  (setq x1 (car p1)  x2 (car p2)  x3 (car p3)
        y1 (cadr p1) y2 (cadr p2) y3 (cadr p3) 
        a  (/
             (+
               (*
                 (- x1 x3)(- y2 y3)
               )
               (*
                 (- x2 x3)(- y3 y1)
               )
             )
            2.0)
  );setq
a ; return area
))
