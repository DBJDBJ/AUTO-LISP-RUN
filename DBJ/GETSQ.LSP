;
; getsq.lsp dbj created 26.02.92
;
(setq function
   (lambda ( / cntr 
	       ur ; upper right
	       ul ; upper left 
	       ll ; lower left 
	       lr ; lower right
	       vf dd
	       )
	   (setq oldmode (getvar "orthomode"))
	   (setvar "orthomode" 1)(setvar "cmdecho" 0)
      (setq cntr (getpoint "\nCenter: ") done nil)
	     (command ".polygon" "4" cntr "c" pause)
	     (setq vf (cdr (assoc 10 (entget (entnext (entlast)))))
		   dd (* (distance vf cntr) (sqrt 2))
		   ur (polar cntr (runcall '("dbj/dtr"  45)) dd)
		   ul (polar cntr (runcall '("dbj/dtr" 135)) dd)
		   ll (polar cntr (runcall '("dbj/dtr" 225)) dd)
		   lr (polar cntr (runcall '("dbj/dtr" 315)) dd)
             )
	   (command ".erase" (entlast))
	   (setvar "orthomode" oldmode )
 (list ur ul ll lr) ; return vertices list
);lambda
);function
