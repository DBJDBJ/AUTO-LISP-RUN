; getpln.lsp dbj created
; pick it up if it is a poly line
(setq function
(lambda ( / ent )
; entelm from entity list
(defun entelm ( ass entlst )(cdr (assoc ass entlst )))
;
  ( SETQ ent (entsel "\n Select one polyline: ")
         ent (if (eq (entelm 0 (entget (car ent))) "POLYLINE")
		 ent nil ) ; if
  )
  (if (= nill ent)(runErr "Entity is not a PolyLine"))
  ent ; return
))
