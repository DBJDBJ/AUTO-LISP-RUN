;
; usetar.lsp dbj 27.05.92 created
;...........................................................................
(setq function
(lambda ( / tarblk eyeset eyedata e oldlay )
  (setq  *error* run::errhandler
         oldlay (run::calluser "lib/enter")
        eyedata (run::calluser '("lib/blk" "eyedata"))
        tarblk  (run::calluser '("lib/getet" "target")))
  (cond
    ((= nil eyedata)
    (prompt "\nNo eyedata in this drawing, put some eyes first ..."))
    ((= nil tarblk) (prompt "\nNo target selected ... ") )
    (T
      (setq eyedata (run::calluser '("lib/attval" tarblk "eyes")) ; string of int's
            eyedata (run::calluser '("dbj/linepars" eyedata " ")) ; list of strings
            eyedata (cdr eyedata) ; first is not used as a eye number
            eyeset  (ssget "x" (list (cons 2 "EYE"))); all eyes
	    ;now substitute eye numbers with enames of blocks
	    eyedata (foreach e eyedata ; to list of integers 
	               (setq 
		         eyedata (subst 
			          (run::calluser '("lib/getbyatt" "eyenumber" e eyeset)) 
				  e 
				  eyedata)
		       )	
                    ) ; foreach
      );setq
        (foreach e eyedata
        );foreach
        (foreach e eyedata
          (grdraw (run::calluser '("lib/sls" 10 (entget e)))
                  (run::calluser '("lib/sls" 10 (entget tarblk))) 1)
	   (getstring "\nHit Return for the view ...")
           ;let's see the perspectives
           (run::calluser '("lib/viewet" e tarblk) )
        );foreach
    ) ; of T
  );cond
  (run::calluser '("lib/leave" oldlay))
)) ; end of usetar 
