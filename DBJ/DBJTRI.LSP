;
;             08.01.92 DBJ translated into RUN system 
; dbjtri.lsp  25.09.91 DBJ created
;
(setq function 
(lambda ( / plst pln Vmin)
  ( SETQ *ERROR* runerr )
  ( SETVAR "CMDECHO"  0 )
                                              ; GLOBALS 
        (setq quad  '()                       ; list of quad's
              trian '()                       ; list of triang's
              fset (ssadd)                    ; s-set for faces
             vlst10 '()                       ; list of vertices
              pFlag -1)                       ; polyline flag
  ( prompt "\n*DBJTRI* Conversion of Polylines to faces ")
  ( SETQ  pln (call "tri/getpln")             ; get poly line list name
         plst (call '("tri/plnlst" pln))      ; make vLst10 from pline
         Vmin (call "tri/pxmin")              ; index of V with Xmin in it
         xmin (car (nth Vmin vLst10))         ; xmin of Vlst10
  ) ; setq
  ; Order the polygon in the right way by DBJ !
  (if (< (call '("tri/aof3"                                    ; if
		 (nth (call '("tri/1left" Vmin vLst10)) vLst10); area
                 (nth        Vmin         vLst10)              ; of leftmost
                 (nth (call '("tri/1from" Vmin vLst10)) vLst10); triangle
                )
         )                                                     ; is less
       0)                                                      ; than 0
      (setq vLst10 (reverse vLst10)) ; then reverse the polyline  !
  )
	(call '("tri/layon" "3dface"))   ; and on this layer
        (call '("tri/sp3tof" xmin ))     ; do the glorious thing
        (call "tri/make3or4")            ; make set of faces ...
(princ)
) ; end DBJTRI lambda
) ; end Function setq
