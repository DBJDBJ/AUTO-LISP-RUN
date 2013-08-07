;
; neweoldt.lsp dbj 27.05.92 created
; new eye old target pairing
;...........................................................................
(setq function
(lambda ( / tarblk eyeblk eyedata oldlay )
  (setq  *error* run::errhandler oldlay (run::calluser "lib/enter"))
  (setq eyedata (run::calluser '("lib/blk" "eyedata")))
  (if (= nil eyedata) (progn
      (command ".insert" (strcat envpath "dwg\\eyedata") "0,0,0" 1 1 0 )
      (setq eyedata (run::calluser '("lib/blk" "eyedata")))
  ))
  (setq eyeblk (run::calluser "lib/poseyebl")) ;ename
  (setq tarblk (run::calluser '("lib/getet" "target"))) 
  (prompt "\nUpdating EYE-TARGET database, please wait ...")
  (run::calluser '("lib/updeyeda" eyedata
           (itoa (1+ (read (run::calluser "lib/lasteyen"))))
          ""                      ; don't update last target num. 
          (strcat "EYE" 
           (itoa (1+ (read (run::calluser "lib/lasteyen"))))
	  ) ; what was last
	  ""                      ; don't touch default height
	  ""                      ; don't touch default lens length
  ))
  (prompt "\nUpdating GLOBAL data finished ...")
  (run::calluser '("lib/updeyeat" 
           eyeblk
          (run::calluser "lib/lasteyen") ; last eye
          (run::calluser "lib/lasttarn") ; last target
	   (rtos 
	     (distance          ; to target
	       (run::calluser '("lib/sls" 10 (entget eyeblk)))
	       (run::calluser '("lib/sls" 10 (entget tarblk)))
	     )
	   ) 
	   (run::calluser "lib/deflens") ; lens length 
	   "no clipping"        ; clipping
         ))
  (prompt "\nUpdating EYE finished ...")
  (run::calluser '("lib/updtarat" tarblk
         (run::calluser "lib/lasteyen")
         (run::calluser "lib/lasttarn") 
         ))
  (prompt "\nUpdating TARGET finished ...")
(grdraw
  (run::calluser '("lib/sls" 10 (entget eyeblk)))
  (run::calluser '("lib/sls" 10 (entget tarblk)))
  1
)
(run::calluser '("lib/leave" oldlay))
eyeblk ; return ename of last "eye"
)) ; end of neweoldt
