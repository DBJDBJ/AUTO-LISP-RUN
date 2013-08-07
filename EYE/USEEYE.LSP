;
; useeye.lsp dbj 28.05.92 created
;...........................................................................
(setq function
(lambda ( / eyeblk tarname tarblk oldlay )
; return target block ename 
(defun tarname ( tarn / tarset )
   (setq tarset  (ssget "x" (list (cons 2 "TARGET")))); all targets
   (run::calluser '("lib/getbyatt" "targetnumber" tarn tarset)) 
) ; tarname
;
  (setq  *error* run::errhandler)
  (cond
    ((= nil (run::calluser '("lib/blk" "eyedata")))
    (prompt "\nNo tardata in this drawing, put some eyes first ..."))
    (T
     (setq oldlay (run::calluser "lib/enter") eyeblk  (run::calluser '("lib/getet" "eye")))
	  (cond
            ((= nil eyeblk) (prompt "\nNo eye selected ... ") )
	    (T 
              (setq tarblk (run::calluser '("lib/attval" eyeblk "targetnumber")) 
	            tarblk (tarname tarblk));setq
              (run::calluser '("lib/viewet" eyeblk tarblk))
	    )) ; T & cond
    ) ; of T
  );cond
  (run::calluser '("lib/leave" oldlay))
)) ; end of useeye 
