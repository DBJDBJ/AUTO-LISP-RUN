
;...........................................................................
; getet.lsp dbj created 27.05.92
; select eye or target from inside the window or by number
(setq function
(lambda ( what / getbyatt etget sls to ) 
;...........................................................................
(defun sls ( ind ent ) (cdr (assoc ind ent)))
;...........................................................................
; return ent. name of block named "EYE" or "TARGET"
; ask by its index number 1..n or select by window
; 31.04.92 DBJ created
(defun etget ( what / return done i datatag bloktag)
(setq return nil
        what (strcase what)
     datatag (if (= "EYE" what) "lasteye" "lastarget")
     bloktag (if (= "EYE" what) "eyenumber" "targetnumber")
          to (if (= "EYE" what) (call "lib/lasteyen") (call "lib/lasttarn"))
ans (getint 
     (strcat "\nSelect the " what  " by number [1.."to "] or hit RETURN :"))
);setq
(cond
   ((/= nil ans)   ; asked by number
    (setq ans (itoa ans))
    (cond
        ( (> ans (run::calluser '("lib/attval" (call '("lib/blk" "eyedata")) datatag)))
          (prompt (strcat "\n" what " number too big ...")) 
        )
	( T
	  (setq return (ssget "x" (list(cons 2 what))) )
          ( IF (= (SSlength return) 1) 
	     (SETQ  return (SSNAME return 0))    
	     (SETQ  return (run::calluser '("lib/getbyatt" bloktag ans return)))
	  );if
	)
    );cond for asked by number
   )
   (T              ; will pick up from the drawing
     (setq p1 (getpoint "\nWindow selection first corner :")
           return (ssget "w" p1 (getcorner p1 "\nSecond corner:") )
			     i 0 done nil );setq
          ( if (/= nil return)
	       (repeat (sslength return)
	          (if (= what (sls 2 (entget (ssname return i))))
		      (setq done (ssname return i) )
		  ) ;if
	          (setq i (1+ i))
	       );repeat
	  );if
          ( if (/= nil done) (setq return done )
	       (prompt (strcat "\nNo " what " found in the window ..."))
	  );if
   ) ; cond for asked by window pick
);cond
(if (/= nil return) (redraw return -3))
return
) ; etget
;................................................
    (setq what (strcase what))
    (cond
      ((= "EYE" what) (setq name "EYE" atrtag "eyenumber"))
      ((= "TARGET" what) (setq name "TARGET" atrtag "targetnumber"))
      (T (*error* "\nWrong first parameter in GETET.lsp ... "))
    ) ; cond
(etget what)
)); lambda function
