; attupd.lsp dbj created 22.05.92
;............................................................................
; update atr in a given blok , if not found return nil ...
; 31/05/91 dbj created
;
(setq function
(lambda ( blknam      ; block name
          atrstr      ; atr's tag  string
          newval      ; new value  string
          / ss atrlst )
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
      (setq ss (run::calluser '("lib/aname" blknam atrstr))) ; attr. enty name
      (if (/= ss nil)
         (progn
          (setq atrlst (entget ss))
          (entmod (subst (cons 1 newval) (assoc 1 atrlst) atrlst))
	  (entupd ss)
	  (entupd blknam)
         )
      )
      ss ; return att's ename
));
