; lpintest.lsp dbj created
;
; Polygon is ordered positively if it's vertices are
; ordered anti-clockwise
; Polygon is a list of 3d points
; If pline has 4 vertices, list will have 4 3d points
; 3d point is a list of three reals
; (car polygon) is a first polygon vertex
;
(setq function
(lambda ( p1 p2 polygon xmin / pt )

; lpint.lsp 
;
; geometry calculations  25.09.91 DBJ created
; does line intersects with polygon
; and how many times
; break-out when first is encountered if "exit" is True
(defun lpint ( a b polygon exit / p iP p1 p2 )
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
) ; lpint
;
; pinp.lsp dbj created
; is point in the polygon ?
; counting intersections method
(defun pinp ( p polygon xmin / in c )
  (setq in (lpint p (list (1- xmin) (cadr p) 0.0) polygon NIL)
         c (- (length in) 2)      ; discard beginning and end
         c (/ c 2.0)  )           ; setq
(and (/= 0.0 c) (/= c (fix c)))   ; return
) ; pinp
; midp.lsp
; mid point of two 3D points
(defun midp (p1 p2)
(list   (/ (+(car p1)  (car p2))  2.0)
        (/ (+(cadr p1) (cadr p2)) 2.0)
        (/ (+(last p1) (last p2)) 2.0)  )
);midp
;
;
;
  (if (> p1 p2) (setq pt p1 p1 p2 p2 pt ) )
  (if (or (= p1 p2)(= p2 (call '("tri/1from" p1 polygon))) )
              NIL ; edge or point sent
          (progn  ; else
                  ( setq p1 (nth p1 polygon)
                         p2 (nth p2 polygon)
                  )
                  (if (=  (length (lpint p1 p2 polygon T) ) 2)
                          (if (pinp (midp p1 p2) polygon xmin)  
                              T   ; no inters. and inside of polygon
                          )       ; if
                              NIL ; intersection/s found
                  ) ; if
          ) ; progn
  ) ;if
)) ; lpintest
