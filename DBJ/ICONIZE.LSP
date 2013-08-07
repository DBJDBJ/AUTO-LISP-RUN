;.....................................................................
; iconize.lsp  write *.icon from *.dwg
; 24.02.92 DBJ created
; 25.02.92 DBJ "binary" output list format
(setq function   (lambda ( / rez color xmin ymin xmax ymax xstep ystep
                             row col a b grdrawbox iconstr word conlist 
			     fname )
(setq *error* runerr word 16)
(initget "64 48 32 16")
(setq rez (getkword "\nMake icon in what rezolution 64 <48> 32 16: ")
      rez (if (= rez nil ) 48 (atoi rez))
        a (getpoint "\nLower left corner of icon: ")
	b (getcorner a "\nUpper right corner of icon: ")
    color -1 ; for temporary graphics 
     xmin (car a) ymin (cadr a)
     xmax (car b) ymax (cadr b)
    xstep (/ (-  xmax xmin) rez)
    ystep (/ (-  ymax ymin) rez)
      row 0 col 0 iconlist '() iconstr '()
  )
  (prompt "\nPlease wait, icon making ... ")
  (call '("lib/layon" "iconshow")) ; set layer , make if not exist
  (repeat (* rez rez)
     (setq a (list (+ xmin (* col xstep)) (+ ymin (* row ystep)))
           b (list (+ xmin (* (1+ col) xstep)) (+ ymin (* (1+ row) ystep)))
	 col (1+ col)
     )
   (grdraw a b color )  ; move 
   (grdraw a b color )  ; cursor
     (if (ssget "c" a b)
         (progn
            (grdraw a b color )  ; leave trace 
	    (setq iconstr (cons 1 iconstr ))
         )
	    (setq iconstr (cons 0 iconstr ))
     ) ; if
     (if (and (= (length iconstr) word)(< col rez))
         (setq iconlist (cons iconstr iconlist)
               iconstr  '())
     ) ; if 
     (if (= col rez) 
       (progn
	 (setq iconlist (cons iconstr iconlist))
         (setq col 0 row (1+ row) iconstr '() )
       )
     ) ; if
  );of repeat

  ; call to pete's icon out fantastic routine!!!!
  (setq fname "")
  (while (not(setq fname (getstring "\nEnter filename :"))))
  (prompt "\nNow writing icon file...")
  (call '("lib/iconout" iconlist fname))
  (princ)
                ) ; lambda
) ; of function iconize
