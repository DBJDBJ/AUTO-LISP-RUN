; pinp.lsp dbj created
; is point in the polygon ?
; counting intersections method
(setq function
(lambda ( p polygon xmin / in c )
  (setq in (call '("tri/lpint" p 
		    (list (1- xmin) (cadr p) 0.0)
		    polygon NIL
		  )
            )
         c (- (length in) 2)      ; discard beginning and end
         c (/ c 2.0)  )           ; setq
(and (/= 0.0 c) (/= c (fix c)))   ; return
)) ; pinp
