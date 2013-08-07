;
; square.lsp dbj created 26.02.92
;
(setq function
   (lambda ( / cntr )
	   (setq oldmode (getvar "orthomode"))
	   (setvar "orthomode" 1)
      (setq cntr (getpoint "\nCenter: ") done nil)
      (while (= done nil)
	     (setq code (grread T))
	     (if (= 5 (car code))
		 (progn
	          (setq a  (cadr code)
			D2 (* (distance a cntr)(sqrt 2))
			ur (polar a (runcall '("dbj/dtr"  45)) D2) 
			ul (polar a (runcall '("dbj/dtr" 135)) D2) 
			ll (polar a (runcall '("dbj/dtr" 225)) D2) 
			lr (polar a (runcall '("dbj/dtr" 315)) D2) 
			)
                  (grdraw ur ul -1) 
                  (grdraw ul ll -1) 
                  (grdraw ll lr -1) 
                  (grdraw lr ur -1) 
                  (grdraw ur ul -1) 
                  (grdraw ul ll -1) 
                  (grdraw ll lr -1) 
                  (grdraw lr ur -1) 
		  ))
	     (setq done (= 3 (car code)))
      )
	   (setvar "orthomode" oldmode )
);lambda
);function
