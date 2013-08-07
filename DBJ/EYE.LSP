
; dbjpp.lsp 24.02.92 DBJ created
;
(setq function 
(lambda ( /  eye sls cmnd eyeuse eyeseed eyemove oldlay )
(DEFUN SLS ( IND ENT ) (CDR (ASSOC IND ENT)))
;...........................................................................
; return ent. name of block from sset  if it has atribute
; asked by tag and particular value in it
; 31.04.92 DBJ created
  (defun getbyatrval ( atrtag numstr index sset )
   ( if (> index (sslength sset))
     nil
     (if (= numstr (atrval (ssname sset index) atrtag))
         (ssname sset index)
	 (getbyatrval atrtag numstr (1+ index) sset)
     ) ;if
   )
  ) ; getbyatrval
;...........................................................................
; return ent. name of block named "EYE"
; ask by its index number 1..n or select by window
; 31.04.92 DBJ created
(defun eyeget ( / return done i)
(setq return nil)
(setq ans (getint "\nSelect the eye by numer or press RETURN :"))
(cond
   ((/= nil ans)   ; asked by number
    (setq ans (itoa ans))
    (cond
        ( (> ans (atrval (blk "eyedata") "lasteye"))
          (prompt "\nEye number too big ...") 
        )
	( T
	  (setq return (SSGET "X" (LIST(CONS 2 "EYE" ))) )
          ( IF (= (SSlength return) 1) 
	     (SETQ  return (SSNAME return 0))    
	     (SETQ  return (getbyatrval "eyenumber" ans 0 return))    
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
	          (if (= "EYE" (sls 2 (entget (ssname return i))))
		      (setq done (ssname return i) )
		  ) ;if
	          (setq i (1+ i))
	       );repeat
	  );if
          ( if (/= nil done) (setq return done )
	       (prompt "\nNo eye in this window ...")
	  );if
   ) ; cond for asked by window pick
);cond
(if (/= nil return) (redraw return -3))
return
) ; eyeget
;...........................................................................
; perspective view from data in attr. of a block "eye"
; 25.03.92 DBJ created
(defun eyeuse (  eyeblok / eye dist lens tar )
    (setq  *error* runerr  
              eye (sls 10 (entget eyeblok))
             dist (atrval eyeblok "EYE1TAG")
	     lens (atrval eyeblok "EYE2TAG")
	     tar  (atrval eyeblok "EYE4TAG")
	     tar  (runcall '("dbj/linepars" tar ","))
	     tar  (list (atof (car tar)) (atof (cadr tar)) (atof (last tar)))
    ); setq
  (setvar "cmdecho" 0)
  (command ".dview" "" "PO" tar eye "ZOOM" 1 "DI" dist "ZOOM" lens "")
  (command ".view" "s" "last")
) ; eyeuse
;...........................................................................
; 27.03.92 DBJ created
(defun eyemove (  eyeblok / from to ) 
  (setq  *error* runerr  from (sls 10 (entget eyeblok))); setq
  (setvar "cmdecho" 0)(command ".ddatte" eyeblok)
  (setq to  (sls 10 (entget eyeblok)))
  (command ".move" eyeblok "" from to ) 
  eyeblok ; return eye ename
) ; eyemove
;...........................................................................
(defun eyeseed ( / lens hgt eye tar dist eyescale eyeblk )
  (setq  *error* runerr
         eyescale (/ (distance (getvar "extmax")(getvar "extmin")) 100)
         lens 30 hgt 1700.0
         eye  (getpoint "\nNew viewing position: ")
         eye  (subst (+ hgt (last eye)) (last eye) eye )
  ) ; setq
	 ; block eye.dwg to be in acad/support
	 ; attributes : eye, target, distance and lens length 
         (command ".insert" "eye" eye eyescale eyescale 0 )
  (setq eyeblk (entlast)
          tar  (getpoint eye "\nTarget position: ")
	  tar  (subst hgt (last tar) tar )
          dist (distance eye tar)
  ); setq 
  (atrupd eyeblk "EYE1TAG" (rtos DIST))
  (atrupd eyeblk "EYE2TAG" (itoa LENS))
  (atrupd eyeblk "EYE3TAG" (rtos (last eye) ))
  (atrupd eyeblk "EYE4TAG" (strcat (rtos (car TAR)) "," (rtos (cadr tar)) ","
			     (rtos (last tar))))
  (command ".point" tar )
  (command ".line" tar eye "" )
  eyeblk ; reurn ename of last "eye"
) ; end of eyeseed
;
; eye begin
;
(setq oldlay (getvar "clayer"))
(if (= "EYE" oldlay)(setq oldlay "0"))
(runcall '("dbj/layon" "eye")) ; force layer "eye" and set it
(setvar "pdsize" (/ (distance (getvar "extmax")(getvar "extmin")) 100))
(setvar "pdmode"  99)
(setq  *error* runerr)  (setvar "cmdecho" 0) (setvar "attdia"  0)
(setq cmnd T)
(while (/= "Q" cmnd)
(initget 1 "N C L Q")
(setq cmnd (strcase (getkword "\n[N]ew eye,[C]hange eye,[L]ook or [Q]uit: ")))
      (if (/= 0 (getvar "viewmode")) (command ".plan" "w"))
      (if (/= 1 (getvar "worlducs")) (command ".plan" "w"))
(cond
  ((= "Q" cmnd) (prompt "\nEYE finished ..."))
  ((= "N" cmnd) (eyeuse (eyeseed)) )
  ((= "C" cmnd) (eyeuse (eyemove (eyeget))))
  ((= "L" cmnd) (eyeuse (eyeget )) )
  ( T nil)
) ; cond
) ; while
(runcall '("dbj/layon" oldlay)) 
(command ".layer" "f" "eye" "")
(prompt "\n'LAST' view saved ...")(princ)
) ; lambda
) ; function
;
;............................................................................
;
; CREATE OR UPDATE "DWG" BLOCK ATR'S
; 25.03.91 DBJ CREATED
;
;
; SLS == Sub List Second FROM ACAD DBASE LIST
;
(DEFUN SLS ( IND ENT ) (CDR (ASSOC IND ENT)))
;
;............................................................................
; GIVE ENTITY NAME FOR GIVEN BLOK IF EXIST
; 31.05.91 DBJ CREATED
;
(DEFUN BLK ( NAMESTR  / SS )
      ( SETQ SS NIL SS (SSGET "X" (LIST(CONS 2 NAMESTR))) )
      ( IF (/= SS NIL) (SETQ  SS (SSNAME SS 0))    )
SS ; RETURN
);
;
;............................................................................
; GIVE ENTYNAME FROM ATRLIST IF ATR GIVEN BY TAG EXISTS IN GIVEN BLOCK
; IF NOT FOUND RETURN NIL ...
; 31/05/91
;
(DEFUN ANAME ( NAME ATRTAG / RETURN )
 (if (/= nil name)
     (if (/= "SEQUEND" (sls 0 (entget name)))
         (if (= "ATTRIB" (sls 0 (entget name)))
	     (if (= atrtag (sls 2 (entget name)))
	         (setq return (sls -1 (entget name)))
	         (setq return (aname (entnext name) atrtag))
              ) ; if
	         (setq return (aname (entnext name) atrtag))
         ) ; if
     ) ; if
 ) ; if
 return
) ; aname
;
;............................................................................
; UPDATE ATR REF. BY TAG IN BLOK REF. BY ITS ENTY NAME
; IF NOT FOUND RETURN NIL ...
; 31/05/91 DBJ CREATED
;
(DEFUN ATRUPD ( BLKNAM      ; BLOCK NAME
                ATRSTR      ; ATR'S TAG  STRING
                NEWVAL      ; NEW VALUE  STRING
                / SS ATRLST )
      (if (/= 'STR (type newval))
          (cond ((= 'INT (type newval))
	         (setq newval (itoa newval))
                )
		((= 'REAL (type newval))
		 (setq newval (rtos newval))
                )
		(T (prompt "\nIllegal value type in atrupd function...")
		   (exit)
		)
          ) ; cond
      ) ; if
      (SETQ SS (ANAME BLKNAM ATRSTR)) ; attr. ENTY NAME
      (IF (/= SS NIL)
         (progn
          (setq atrlst (entget ss))
          (ENTMOD (SUBST (CONS 1 NEWVAL) (ASSOC 1 ATRLST) ATRLST))
	  (entupd ss)
	  (entupd blknam)
         )
      )
      SS ; RETURN
);
;............................................................................
; GET VALUE of a ATR IN BLOK REF. BY ITS ENTY NAME
; IF NOT FOUND RETURN NIL ...
; 25.03.92 DBJ CREATED
;
(DEFUN ATRval ( BLKNAM      ; BLOCK NAME
                ATRSTR      ; ATR'S TAG  STRING
                / SS ATRLST )
      (SETQ SS (ANAME BLKNAM ATRSTR)) ; attr. ENTY NAME
      (IF (/= SS NIL)
         (progn
          (setq atrlst (entget ss))
           (setq ss (cdr (ASSOC 1 ATRLST)))  ; return
         )
      )
   ss 
);
;
;............................................................................
; UPDATE ATR REF. BY TAG IN BLOK REFFERENCED BY ITS STRING NAME
; IF NOT FOUND RETURN NIL ...
; 31/05/91 DBJ CREATED
;
(DEFUN BLKUPD ( BLKSTR      ; BLOCK NAME STRING
                ATRSTR      ; ATR'S TAG  STRING
                NEWVAL      ; NEW VALUE  STRING
                / SS )
      (SETQ SS (BLK BLKSTR ))                     ; ENTY NAME
      (IF (/= SS NIL)
          (SETQ SS (ATRUPD SS ATRSTR NEWVAL))
          (PROMPT (STRCAT "\nBLOCK " BLKSTR " NOT FOUND ..."))
      )
      (IF (= SS NIL)
          (PROMPT (STRCAT "\nATRRIBUTE TAG " ATRSTR " NOT FOUND ..."))
      )
)
