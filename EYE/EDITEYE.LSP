;
; editeye.lsp dbj 28.05.92 created
;...........................................................................
(setq function
(lambda ( / eyeblk tarname tarblk eyenum tarnum oldlay newpos )
; return target block ename 
(defun tarname ( tarn / tarset )
   (setq tarset  (ssget "x" (list (cons 2 "TARGET")))); all targets
   (run::calluser '("lib/getbyatt" "targetnumber" tarn tarset)) 
) ; tarname
;
  (setq  *error* run::errhandler)
  (cond
    ((= nil (run::calluser  '("lib/blk" "eyedata")))
    (prompt "\nNo EYEdata in this drawing, put some eyes first ..."))
    (T
     (setq oldlay (run::calluser  "lib/enter") eyeblk  (run::calluser '("lib/getet" "eye")))
	  (cond
            ((= nil eyeblk) (prompt "\nNo eye selected ... ") )
	    (T 
              (setq tarnum (run::calluser  '("lib/attval" eyeblk "targetnumber")) 
                    eyenum (run::calluser  '("lib/attval" eyeblk "eyenumber")) 
	            tarblk (tarname tarnum));setq
	      (command ".ddatte" eyeblk)
	      (setq 
	        newpos (getpoint 
         	       (run::calluser '("lib/sls" 10 (entget eyeblk))) 
		       "\nMove the EYE or hit RETURN ... ")
              )
	      (if (/= nil newpos)
	      (command ".move" eyeblk "" 
	       (run::calluser '("lib/sls" 10 (entget eyeblk))) newpos ) ; move
              ) ; if
	      ;(setq eyeblk (entlast))
  (run::calluser '("lib/updeyeat" 
           eyeblk
          eyenum ; do eye number if changed by some joker here 
          tarnum ; do target number if changed by some person 
	   (rtos 
	     (distance          ; to target
	       (run::calluser '("lib/sls" 10 (entget eyeblk)))
	       (run::calluser '("lib/sls" 10 (entget tarblk)))
	     )
	   ) 
	   "" ; lens length 
	   "no clipping"        ; clipping
         ))
              (prompt "\nUpdating EYE finished ...")
	      ;(prompt "\nEntering view , camera ")(princ eyeblk)
	      ;(prompt "\n                target ")(princ tarblk)
	      ;(getstring "\nReturn ...")
              (run::calluser '("lib/viewet" eyeblk tarblk))
	    )) ; T & cond
    ) ; of T
  );cond
  (run::calluser '("lib/leave" oldlay))
)) ; end of useeye 
