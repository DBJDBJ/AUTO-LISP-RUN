;...........................................................................
; perspective view from "eye" to "target"
; 25.03.92 DBJ created
; 27.05.92 DBJ improved
;
(setq function
 (lambda ( eyeblok tarblok  / oldlay )
  (if (= nil eyeblok)(run::errhandler "Entering, viewet eyeblok=nil ))
  (if (= nil tarblok)(run::errhandler "Entering, viewet tarblok=nil ))
  (defun sls ( ind ent ) (cdr (assoc ind ent)))
  (setvar "cmdecho" 0)
  (command 
     ".dview" 
     "" ; select nothing
    "PO" ; options POints
   (sls 10 (entget tarblok)) ; target point
   (sls 10 (entget eyeblok)) ; eye point
   "ZOOM" 1 
	    "DI" (distance
                  (sls 10 (entget tarblok)) ; target point
                  (sls 10 (entget eyeblok)) ; eye point
	         )
	    "ZOOM" (run::calluser '("lib/attval" eyeblok "lens")) ; current lens length 
	    ""
   ) ; dview
  (command ".view" "s" "last") ; save it 
)); of function
