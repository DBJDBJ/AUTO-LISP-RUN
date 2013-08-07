;............................................................................
; get value of a atr in blok if not found return nil ...
; 25.03.92 DBJ created
(setq function
(lambda       ( blknam      ; block ename
                atrstr      ; atr's tag  
                / ss atrlst )
      (setq ss (run::calluser '("lib/aname" blknam atrstr))) ; att. enty name
      (if (/= ss nil)
         (progn
          (setq atrlst (entget ss))
           (setq ss (cdr (assoc 1 atrlst)))  ; return
         )
      )
   ss 
))
;
