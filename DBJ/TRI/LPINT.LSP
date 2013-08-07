; lpint.lsp 
;
; geometry calculations  25.09.91 DBJ created
; does line intersects with polygon
; and how many times
; break-out when first is encountered if "exit" is True
(setq function
(lambda ( a b polygon exit / p iP p1 p2 )
(setq p (list a b) p1 (car polygon) p2 (last polygon))
(while (and p2 polygon)
     (setq iP (INTERS a b p1 p2 T )
           p1 (car polygon) p2 (cadr polygon)
         polygon (cdr polygon) );setq
            (if ( and (= 'LIST (type iP))
                      (null (member iP p))
                ) ; and
                    (setq p (cons iP p))
            ) ; if
  (if (and exit (> (length p) 2) ) (setq polygon nil) );if
)  ; while
p  ; return list of intersections
)) ; lpint
