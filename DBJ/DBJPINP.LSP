;
; val.lsp dbj created
; val from entity list
(defun val ( ass entlst )(cdr (assoc ass entlst )))
;
;................................................................
;3d point is a list of three reals
;polugon is represented as a list of 3d points
;
;aof3.lsp dbj created
;  area of triangle -> positive if ordered clockwise
(defun aof3 ( p1 p2 p3 / x1 x2 x3 y1 y2 y3 a)
  (setq x1 (car p1)  x2 (car p2)  x3 (car p3)
        y1 (cadr p1) y2 (cadr p2) y3 (cadr p3) 
        a    (+
               (*
                 (- x1 x3)(- y2 y3)
               )
               (*
                 (- x2 x3)(- y3 y1)
               )
             )
  );setq
(/ a 2.0) ; return area
)
;
;  Angle between lines p1-p2 and p2-p3
;
(defun incangle ( p1 p2 p3 / rtd midp a )
; rtd.lsp
(defun rtd (a) (/ (* a 180.0) pi))    ; radians to degrees

; mid point of two 3D points
(defun midp (p1 p2)
(list   (/ (+(car p1)  (car p2))  2.0) (/ (+(cadr p1) (cadr p2)) 2.0)
        (/ (+(last p1) (last p2)) 2.0)  ));midp

    (grdraw p1 p2 1) (grdraw p1 p3 1)
    (grdraw (midp p1 p2) (midp p1 p3) 2)
    (setq a (- (angle p1 p2) (angle p1 p3)))
;   (prompt (strcat "\r" (rtos (/ SumA pi)) " radians ") )
;   (command ".text" "j" "a" (midp p1 p2) (midp p1 p3) (rtos a) )
    a ; return angle value
) ;angle
;
; Return TRUE if pnt is inside polygon. Angle summation method
; Points on the edges are outside ...
;
(defun PinPoly ( pnt poly / SumA  b c p parea )
   (setq p 0 SumA 0.000 parea 0.000 )
   (repeat (1- (length poly))
    (setq
      b (nth p poly) c (nth (1+ p) poly)
     parea (+ parea (* -1 (aof3 b pnt c)) )
      SumA (+ SumA (incangle pnt c b))
      p (1+ p)
    )
   ) ; repeat
    (setq ; last to first
      b (last poly) c (car poly)
     parea (+ parea (aof3 pnt b c))
      SumA (+ SumA (incangle pnt c b))
    )
   (prompt "\n-------------")
   (prompt (strcat (rtos (/ SumA pi)) " radians is the magical number ") )
   (prompt (strcat "\nArea of this polygon is : " (rtos parea)))
   (IF (= SumA 0.00000000 )
       nil ; Point not in polygon
       T   ; return
   )
) ; PinPoly

;1left.lsp dbj created
(defun 1left ( i LST )      ;  1 from i-th on left
  (IF(OR (< i 0)(> (1+ i) (length LST)))
     (runerr "Index out of LST boundaries in 1LEFT")
  );IF
                (if (= 0 i)
                    (1- (length LST))
                    (1- i)
                ) ; if
)   
;1rght.lsp dbj created 1991
(defun 1rght ( i polygon )      ;  1 from i-th on right
     (IF(OR (< i 0)(> (1+ i) (length polygon)))
     (runerr "Index out of polygon boundaries in 1FROM"));IF
 (if (null (nth (1+ i) polygon))
     0
     (1+ i)
 ) ; if
);1FROM 

;
; plnlst.lsp dbj created Polyline to list of vertexes
;
(defun plnlst ( PLN / ENT polygon )
   (SETQ    pln   (entget (car pln))
         polygon  '()            
            ENT   (ENTGET (ENTNEXT (val -1 pln)))
   )
 (WHILE (/= (val 0 ent) "SEQEND")
         (if (/= 16 (val 70 ent))            ; not a spline c. point
            (SETQ polygon  (cons (val 10 ent) polygon) ; coords
            );setq
         );if
      (setq ENT  (ENTGET (ENTNEXT (val -1 ent))))
 )  ; WHILE
 polygon  ; return a list of vertexes
) ; plnlst

; pxmin.lsp dbj created
;return index of a vertex with poly's xMIN 
(defun pxmin ( polygon / c L xmin ind )
  (setq L (length polygon ) xmin (caar polygon) c 0 ind c ); setq
    (repeat L  
      (if (< (car (nth c polygon)) xmin  )
          (setq xmin (car (nth c polygon)) ind c ));if
      (setq c (1+ c))
    )  ; repeat
ind    ; return index 
)      ; pXmin

(defun c:pinp ( / polygon point ent done xmin Vmin)
  ( SETQ *ERROR* runerr )
  ( SETVAR "CMDECHO"  0 )
  ( prompt "\n*DBJ will tell you is this point inside the polygon*  ")
  ( while (= nil point)
  ( setq point ( getpoint "\nSelect point position ..." ))
  )
(setq done nil)
(while (= done nil)
  ( SETQ ent (entsel "\n Select one polyline: ")
         ent (if (eq (val 0 (entget (car ent))) "POLYLINE")
		 ent nil ) ; if
  )
  (if (= nil ent)(prompt "\nEntity is not a PolyLine, try again...")
                 (setq done T))
)
  ( SETQ  polygon (plnlst ent)         ; make polygon list
         Vmin (pxmin polygon)          ; index of V with Xmin in it
         xmin (car (nth Vmin polygon)) ; xmin  
  ) ; setq
;  Order the polygon in the right way by DBJ !
;  anti-clockwise that is positive 
  (if (> (aof3 (nth (1left Vmin polygon) polygon); area
               (nth        Vmin          polygon); of leftmost
               (nth (1rght Vmin polygon) polygon); triangle
         )                                       ; is less
       0)                                        ; than 0
      (setq polygon (reverse polygon)) ; then reverse the polyline  !
  )
; mark poly vertices 
(setq vmin 1)
 (foreach ent polygon
  (call '("tri\\ptext" ent (itoa vmin))) (setq vmin (1+ vmin))
 )
   (if ( = T (pinpoly point polygon))
       (prompt "\nThis is definitely INSIDE the polygon !")
       (prompt "\nThis is definitely OUTSIDE the polygon !")
   )
(princ)
) ; end c:pinp
