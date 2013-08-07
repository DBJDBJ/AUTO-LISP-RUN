;
; getsq.lsp dbj created 21.05.92
; select by square center and size + "w" or "c"
;
(setq function
   (lambda ( how / cntr 
	       ur ; upper right
	       ul ; upper left 
	       ll ; lower left 
	       lr ; lower right
	       vf dd return oldmode
	       )
	   (setq oldmode (getvar "orthomode"))
	   (setvar "orthomode" 1)(setvar "cmdecho" 0)
           (setq cntr (getpoint "\nSelection center: ") done nil)
	     (command ".polygon" "4" cntr "c" pause)
	     (setq vf (cdr (assoc 10 (entget (entnext (entlast)))))
		   dd (* (distance vf cntr) (sqrt 2))
		   ur (polar cntr (run::call '("dbj/dtr"  45)) dd)
		   ul (polar cntr (run::call '("dbj/dtr" 135)) dd)
		   ll (polar cntr (run::call '("dbj/dtr" 225)) dd)
		   lr (polar cntr (run::call '("dbj/dtr" 315)) dd)
             )
	   (command ".erase" (entlast) ""  )
	   (setvar "orthomode" oldmode )
 (gc)(setq return nil) (setq how (strcase how))
 (if (or (= "W" how)(= "C" how)) (setq return (ssget how ll ur)))   
 ; return sset will be remembered as a previous by "select" command
 (if (/= nil return) (command ".select" return ""))
 return
);lambda
);function
