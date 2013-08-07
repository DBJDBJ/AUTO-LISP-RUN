; plnlst.lsp dbj created 
; polyline to global list of vertexes  vlst10
;
(setq function
(lambda ( PLN / ENT )
; entelm.lsp dbj created
; entelm from entity list
(defun entelm ( ass entlst )(cdr (assoc ass entlst )))
;
   (SETQ    pln   (entget (car pln))
         vlst10  '()                                   ; global !
          pFlag   (entelm 70 PLN)                      ; global !
            ENT   (ENTGET (ENTNEXT (entelm -1 pln)))
   )
 (WHILE (/= (entelm 0 ent) "SEQEND")
         (if (/= 16 (entelm 70 ent))            ; not a spline c. point
            (SETQ vlst10  (cons (entelm 10 ent) vlst10) ; coords
            );setq
         );if
      (setq ENT  (ENTGET (ENTNEXT (entelm -1 ent))))
 )  ; WHILE
 'vlst10                        ; return a name of list of vertexes
)) ; plnlst
