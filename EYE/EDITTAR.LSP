;
; edittar.lsp dbj 02.06.92 created
;...........................................................................
(setq function
(lambda ( / tarblk eyenum tarnum oldlay newpos )
;
  (setq  *error* run::errhandler)
  (cond
    ((= nil (run::calluser '("lib/blk" "eyedata")))
    (prompt "\nNo EYEdata in this drawing, put some eyes first ..."))
    (T
     (setq oldlay (run::calluser "lib/enter") tarblk  (run::calluser '("lib/getet" "target")))
	  (cond
            ((= nil tarblk) (prompt "\nNo target selected ... ") )
	    (T (setq 
	        newpos (getpoint 
         	       (run::calluser '("lib/sls" 10 (entget tarblk))) 
		       "\nMove the TARGET or hit RETURN ... "))
	      (if (/= nil newpos)
	      (command ".move" tarblk "" 
	       (run::calluser '("lib/sls" 10 (entget tarblk))) newpos ) ; move
              ) ; if
	    )) ; T & cond
    ) ; of T
  );cond
  (run::calluser '("lib/leave" oldlay))
)) ; end of usetar 
