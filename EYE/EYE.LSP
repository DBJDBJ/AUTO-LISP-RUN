
; dbjpp.lsp 24.02.92 DBJ created
;
(setq function 
(lambda ( /  eye sls cmnd eyeuse eyeseed eyemove oldlay )
(DEFUN SLS ( IND ENT ) (CDR (ASSOC IND ENT)))
;...........................................................................
; 27.03.92 DBJ created
(defun eyemove (  eyeblok / from to ) 
  (setq  *error* run::errhandler  from (sls 10 (entget eyeblok))); setq
  (setvar "cmdecho" 0)(command ".ddatte" eyeblok)
  (setq to  (sls 10 (entget eyeblok)))
  (command ".move" eyeblok "" from to ) 
  eyeblok ; return eye ename
) ; eyemove
;...........................................................................
(defun eyeseed ( / lens hgt eye tar dist eyescale eyeblk )
  (setq  *error* run::errhandler
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
(run::calluser '("dbj/layon" "eye")) ; force layer "eye" and set it
(setvar "pdsize" (/ (distance (getvar "extmax")(getvar "extmin")) 100))
(setvar "pdmode"  99)
(setq  *error* run::errhandler)  (setvar "cmdecho" 0) (setvar "attdia"  0)
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
(run::calluser '("dbj/layon" oldlay)) 
(command ".layer" "f" "eye" "")
(prompt "\n'LAST' view saved ...")(princ)
) ; lambda
) ; function
;
