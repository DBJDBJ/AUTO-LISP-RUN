; sp3.lsp dbj created
; main function for polygon triangulation
; 'spline' is a list of points which are lists of 3 reals
; they are poly vertices of a poly ordered clockwise
; recursive version which cuts poly on two until one of the halfs 
; is not a triangle or a quadrilateral...
;
(setq function
(lambda ( spline xmin / lin pp1 pp2 tmp)
;
   (if (= 4 (length spline))
       (call '("tri/3or4" spline "4"))
       (if (= 3 (length spline))
           (call '("tri/3or4" spline "3"))
           (if (> (length spline) 2)
           (progn
                 ;(princ "\nPoly=")(princ (length spline))
                 (setq lin (call '("tri/cutfirst" 0 spline xmin))
                       pp1 (call '("tri/midout" (car lin) (cadr lin) spline)) 
                       pp2 (call '("tri/midin"  (car lin) (cadr lin) spline))
                 )
                 (if (< (length pp2)(length pp1))  ; sort them by
                     (setq tmp pp1                 ; number of vertices
                           pp1 pp2
                           pp2 tmp
                     );setq
                 );if
                 ;(princ "  PP1=")(princ (length pp1))
                 ;(princ "  PP2=")(princ (length pp2))
                         (call '("tri/sp3" pp1 xmin))
                         (call '("tri/sp3" pp2 xmin))
           );progn
           );if
       );if
   );if
)) ; sp3
