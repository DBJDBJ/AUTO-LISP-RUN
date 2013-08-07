;
; dbj3.lsp 29.08.91 DBJ created
; I am transfering pline into set of triangles here, Pete !
;
;----------------------------------------------------------------------------
; triangulate anything which is not a closed spline
(defun plntof ( poly xmin show / i )
;----------------------------------------------------------------------------
; return list without vertex on place ind
(defun delV ( lst ind / V V2 lst2)
        (setq V2 (nth ind lst) lst2 '() )
        (foreach V lst
                (if (null (equal V V2))
                    (setq lst2 (cons V lst2))
                ) ;if
        );foreach
(reverse lst2) ;<-- keep same ordering of poly
)
; index of the first vertex of a triangle which can be cut from the poly list
(defun cut3 ( i ) ;---------------------------------------------------------
    (while (null
             (if (> (Aof3 (nth  i poly)
                          (nth (1from i poly) poly)
                          (nth (2from i poly) poly)
                    )
                    0
                 )
                 (=
                  (length
                    (lpint (nth i poly) (nth (2from i poly) poly) poly T)
                  )
                  2
                 )
                 NIL ;else
             )   ;if
           )
       (setq i (1from i poly)) ; setq
    ) ; while
(if show (grdraw (nth i poly)  (nth (2from i poly) poly) -1) );if
i ; return
) ; cut3
;   plntof begin
         ( setq trian '() i 0 )
         (while (> (length poly) 4)
                (setq    i (cut3 (1from i poly) )
                     trian (cons   (list
                                     (nth        i poly)
                                     (nth (1from i poly) poly)
                                     (nth (2from i poly) poly)
                                   ) ; list
                                   trian
                           ) ; cons
                    poly (delV poly (1from i poly) )
                       i (if (= i (length poly)) 0 i)
                ) ; setq
         ) ; while
         (setq  trian (cons (list (nth        i poly)
                                  (nth (1from i poly) poly)
                                  (nth (2from i poly) poly)
                            )
                            trian
                      ) ; cons
         ) ; setq
(princ)
) ; plntof
(defun c:p3 () (plntof vlst10 xmin T))
;
