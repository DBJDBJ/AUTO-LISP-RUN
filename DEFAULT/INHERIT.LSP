;
; inherit.lsp DBJ created 19.03.92
;
(setq function
(lambda ( / will toEnt fromEnt )
(setq *error* runerr)
(prompt "\nInherit v1.0")
  ( setq toEnt (Entsel "\nSelect Inheritor  :"))
  (cond
     ( (= nil toEnt)(prompt "\nInheritor not selected ... "))
     ( T ; otherwise
       ( setq fromEnt (Entsel "\nSelect Bequeather :"))
         (cond
            ((= nil fromEnt)(prompt "\nBequeather not selected ... "))
            ( T ; otherwise
	      (setq will T)
            (while (/= nil will)
            (initget "C c L l T t H h ?")
            (setq will (getkword "\nInherit C,L,T,H or ?: "))
              (cond 
                 ( (= nil will) (progn "\nIt is done ..."))
                 (T 
                    (setq will (strcase will))
                    (cond ((= "?" will)
		           (textscr)
                           (prompt "\nC = Color")
                           (prompt "\nL = Layer")
                           (prompt "\nT = Line type")
                           (prompt "\nH = Thicknes")
                           (getstring "\n...")
			   (graphscr)
                          )
                          (T (inherit will (car fromEnt)(car toEnt)))
                    );cond
                 )
              ) ; cond
            ); while will
            ); T
         )
     )
   );cond
  (princ) 
 ) ; lambda
)  ; function

(defun inherit ( what from to / sub option value inheritor )
(defun sub ( ass lst )(cdr (assoc ass lst )))
       (setq from (entget from) inheritor to to (entget to)
            option "ILLEGALL" value nil )
         (cond
	   ((= "C" what ); color
	     (if (/= nil (sub 62 from))
	         (setq option "C" value (sub 62 from))
	         (setq option "C" value (asklayer "C" (sub 8 from)))
	     )
	   ) 
	   ((= "L" what) ; layer
	         (setq option "LA" value (sub 8 from))
	   )
	   ((= "T" what ) ; linetype
	     (if (/= nil (sub 6 from))
	         (setq option "LT" value (sub 6 from))
	         (setq option "LT" value (asklayer "T" (sub 8 from)))
	     )
	   )
	   ((= "H" what ) ; thickness
	     (if (/= nil (sub 39 from))
	         (setq option "T" value (sub 39 from)))
	   )
	   (T (prompt 
	       (strcat "\nUnknown option " what " in inherit function..."))
	   )
	 );cond
    (prompt (strcat "\nOption= " Option "  Value= "))(princ value)
    (if (/= "ILLEGALL" option) 
        (command ".change" inheritor "" "p" option value "" ))
) ; inherit 

(defun asklayer ( what name / return laylst )
     (setq laylst (layerlst name) return nil)     
     (if (/= nil laylst)
         (cond
	   ((= "C" what ) ; color
	         (setq return (nth 2 laylst))
	   ) 
	   ((= "T" what ) ; linetype
	         (setq return (nth 1 laylst))
	   )
	   (T (prompt 
	       (strcat "\nUnknown option " what " in asklayer function..."))
	   )
	 ));cond & if
) ; asklayer

; return layer list in format (name ltype color frozen? )
; or nil 
(defun layerlst ( name / c d f ln lt ly n x return )
(defun fld (num lst) (cdr (assoc num lst)))
   (setq name (strcase name)  
          x (tblnext "layer" T))        ; get first layer
   (if (/= name (fld 2 x))
    (setq x  (tblsearch "layer" name))  ; get first layer
   )
   (if (/= x nil)
      (setq ly (fld  2 x)               ; layer name
            ln (fld  6 x)               ; linetype name
            c  (fld 62 x)               ; color number
            f  (logand (fld 70 x) 1)    ; "frozen" flag
          ; lt (tblsearch "ltype" ln)   ; linetype table entry
          ; d  (fld  3 lt)              ; linetype prose description
        return (list ly ln c f)
      )
      (setq return nil)
   );if
return
) ; layer
