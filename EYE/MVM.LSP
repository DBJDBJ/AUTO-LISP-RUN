;
; mvm.lsp dbj 01.06.92 created
; m odel
; v iews
; m aker
;...........................................................................
(setq function
(lambda ( / sw  ; sheet width
            sh  ; sheet height
	    lm rm tm bm ; left right top & bottom margin
	    hd vd ; horiz. & vert. distance between vwind's
	    vw vh ; Vport width & height
	    xn yn ; how meny horizontaly and verticaly
	    vp return
	    seeval input makeval vframes grbox 
        )
(defun makeval ()   ; defaults or not
   (setq
     vw (- sw (+ lm (* hd (1- xn)) rm))  vw (/ vw xn ); vport width
     vh (- sh (+ tm (* vd (1- yn)) bm))  vh (/ vh yn ); vport height
   )
) ; makeval
(defun input ()
 (setq
     sw ( getreal "\nSheet width  <817.0>: ")
     sh ( getreal "\rSheet height <570.0>: ")
     lm ( getreal "\rLeft  margin <040.0>: ")
     rm ( getreal "\rRight margin <020.0>: ")
     tm ( getreal "\rTop   margin <010.0>: ")
     bm ( getreal "\rBott. margin <010.0>: ")
     hd ( getreal "\rHor. distance<005.0>: ")
     vd ( getreal "\rVer. distance<005.0>: ")
     xn ( getint  "\rHow meny columns <2>: ") 
     yn ( getint  "\rHow meny rows    <2>: ")
     sw (if (= nil sw) 817.0 sw ) sh (if (= nil sh) 570.0 sh)
     lm (if (= nil lm) 40.0 lm ) rm (if (= nil rm) 20.0 rm )
     tm (if (= nil tm) 10.0 tm ) bm (if (= nil bm) 10.0 bm )
     hd (if (= nil hd) 5.0 hd )  vd (if (= nil vd) 5.0 vd )
     xn (if (= nil xn) 2 xn )    yn (if (= nil yn) 2 yn )
 )
 ;(print sw) (print sh)(print lm)
 ;(print rm) (print tm)(print bm)
 ;(print hd) (print vd)(print xn)(print yn)
 ;(getstring "\nEXITING makeval ...")
) ; input

(defun seeval ()
 ( prompt "\nMODEL VIEW MAKER v1.0 by you know who ...")
 ( prompt 
    (strcat "\nYour AutoCad can display "
      (itoa (getvar "maxactvp")) " model views at once "))
 ( prompt "\nYou can create more, but only this much will be active ")
 ( prompt (strcat "\nYour current mview number is " (itoa (getvar "cvport"))))
 ( prompt "\n------------------------------------------------")
 ( prompt (strcat "\nSheet width  " (rtos sw ) " drw units  "))
 ( prompt (strcat "\nSheet height  " (rtos sh ) " drw units  "))
 ( prompt (strcat "\nLeft  margin " (rtos lm ) " drw units  "))
 ( prompt (strcat "\nRight margin " (rtos rm ) " drw units  "))
 ( prompt (strcat "\nTop   margin " (rtos tm ) " drw units  "))
 ( prompt (strcat "\nBott. margin " (rtos bm ) " drw units  "))
 ( prompt (strcat "\nHor. distan. " (rtos hd ) " drw units  "))
 ( prompt (strcat "\nVer. distan. " (rtos vd ) " drw units  "))
 ( prompt "\n------------------------------------------------")
 ( prompt (strcat "\nVports per row " (rtos xn)))
 ( prompt (strcat "\nVports per col " (rtos yn)))
 ( prompt "\n------------------------------------------------")
 ( prompt (strcat "\nVport width  " (rtos vw ) " drw units  "))
 ( prompt (strcat "\nVport height " (rtos vh ) " drw units  "))
 ( prompt "\n------------------------------------------------")
)
;
(defun grbox ( ll ur  c / lr ul )
(setq lr (list (car ur)(cadr ll)) ul (list (car ll)(cadr ur)))
(grdraw ll lr c) (grdraw lr ur c) (grdraw ur ul c) (grdraw ul ll c) 
) ; grbox
(defun vframes ( sw sh lm bm xn yn hd vd vw vh / x1 y1 x2 y2 col row return )
  (prompt "\nVFRAMES begin ...")
  ; draw the paper as a pline
  (command ".pline" (list 0 0) (list sw 0)(list sw sh) (list 0 sh) "C" ) 
  ; draw the frames
  (setq return '() ) ; frames  diagonals list
  (setq row 0)
  (repeat yn 
    (setq col 0)
    (repeat xn 
      (setq x1 (+ lm (* col (+ vw hd)))
            y1 (+ bm (* row (+ vh vd)))
	    x2 (+ x1 vw)
	    y2 (+ y1 vh)
        return (cons (list (list x1 y1)(list x2 y2)) return)
	   col (1+ col) )
	    (grbox (list x1 y1) (list x2 y2) 2)  
    ) ; repeat 
    (setq row (1+ row))
  ) ; repeat
  return
) ; vframes
;
; mvm begin
;
;  (setq  *error* run::errhandler)
  (if (= 1 (getvar "tilemode"))(setvar "tilemode" 0))
  ; defaults
  (setq sw 817.0 sh 570.0 lm 40.0 rm 20.0 tm 10.0 bm 10.0
     hd 5.0 vd 5.0 xn 2  yn 2 )
  (textscr)(makeval)(seeval) 
  (if (= "Y" (strcase (getstring "\nChange something Y/N ? ")))
     (progn (input)(makeval))
  )
  (prompt (strcat "\nYou requested " (rtos (* xn yn)) " mviews "))
  (prompt "\nEach Vport width  is ")(princ vw)
  (prompt " and height is ")(princ vh)
  (getstring "\nHit RETURN to make MViews ...")
  (cond
    ((< vw 0 ) 
     ( prompt "\nVport width is less than zero")
    )
    ((< vh 0 ) 
     ( prompt "\nVport height is less than zero")
    )
    ((< vw hd) 
     ( prompt "\nVport width is less than horizontal distance")
    )
    ((< vh vd) 
     ( prompt "\nVport height is less than vertical distance")
    )
    (T
    (setq return (vframes sw sh lm bm xn yn hd vd vw vh ))
     (command ".pspace")
    (foreach vp return
       (command ".mview" (car vp) (cadr vp))
    )(command ".zoom" "extents")
  );T
  );cond
  
  (princ); return 
)) ; end of neweye
