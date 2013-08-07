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
(DEFUN attupd ( BLKNAM      ; BLOCK NAME
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
		(T (prompt "\nIllegal value type in attupd function...")
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
(defun attval ( blknam      ; block name
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
          (SETQ SS (attupd SS ATRSTR NEWVAL))
          (PROMPT (STRCAT "\nBLOCK " BLKSTR " NOT FOUND ..."))
      )
      (IF (= SS NIL)
          (PROMPT (STRCAT "\nATRRIBUTE TAG " ATRSTR " NOT FOUND ..."))
      )
)
