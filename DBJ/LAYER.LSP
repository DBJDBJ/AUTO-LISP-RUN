;
; layer.lsp 20.02.92 DBJ created
; 
(setq function
(lambda ( / ListLayThawed LaySetByEnt LayFrzByEnt LayChgByEnt 1ans 2ans )
;.......................................................................
(defun ListLayThawed (/ LayTab LayList Element Return)
  (prompt"\nGrouping all thawed layers.  Please wait ...")
  (setq LayList (quote ())
        LayList (append LayList (list (getvar "clayer") ) ) )
  (tblnext "layer" T)
  (while (setq LayTab (tblnext "layer" ) )
 	 (if(and (/= (cdr(assoc 2  LayTab)) (nth 0 LayList))
	         (=  (cdr(assoc 70 LayTab)) 64)) ; and
          (setq LayList (append LayList (list (cdr (assoc 2 LayTab)))))
	);if
  );while
  (setq Return "")
  (foreach Element LayList
     (setq Return (strcat Return Element ","))
  );foreach
  (setq Return (substr Return 1 (- (strlen Return ) 1)) )
  (prompt" done.")
  Return  
 );ListLayThawed
;.......................................................................
(defun LaySetByEnt(/ Entity)
 (setq Entity (entsel"\nSet new current layer.  Choose entity: "))
 (if Entity
    (command "layer" "s" (cdr (assoc 8 (entget (car Entity )))) "")
 )
)
;.......................................................................
(defun LayFrzByEnt( / LaySet LayerStr which )
(Prompt "\nFreeze layer.  Choose entity[s] : ")
(setq LayerStr "" LaySet (ssget) which 0 )
(repeat (sslength LaySet ) 
   (setq LayerStr (strcat LayerStr 
                       (cdr (assoc 8 (entget (ssname LaySet which)))) 
		       ",");strcat
      which (1+ which));setq
);repeat
(if(/= LayerStr "") 
 (progn (setq LayerStr(substr LayerStr 1(-(strlen LayerStr)1)))
       (command ".layer" "f" LayerStr "" )
 );progn
);if
);LayFrzByEnt
;.......................................................................
(defun LayChgByEnt( / EntSet )
(prompt"\nChange entity(s) to CURRENT layer.")
(setq EntSet (ssget))
(if EntSet
  (command "chprop" (eval EntSet) "" "la" (getvar "clayer") "" )
)
(setq EntSet nil)(gc)
);eofun
;.......................................................................
(setvar "cmdecho" 0)
(initget "F f S s C c G g" )
(setq 1ans 
(getstring"\nFreeze, set, change entity(s) to current or group layers? (F/S/C/G): ")
)
(setq 1ans (strcase 1ans))
(cond
 	((= 1ans "F")(LayFrzByEnt))
 	((= 1ans "S")(LaySetByEnt))
 	((= 1ans "C")(LayChgByEnt))
 	((= 1ans "G")
	 (if(NOT LayGroup)(setq LayGroup (ListLayThawed)))
         (setq 2ans  (getstring"\nFreeze, thaw or redefine group? (F/T/R): ")
 	       2ans (strcase 2ans))
 		(cond
 			((= 2ans "F")(command "layer" "f" LayGroup "" ))
 			((= 2ans "T")(command "layer" "t" LayGroup ""))
 			((= 2ans "R")(setq LayGroup (ListLayThawed)))
 	 		(nil T)
		);cond
 	); "G"
 	(nil T)
) ; cond
 (princ)
) ; LAmbda
) ; function
