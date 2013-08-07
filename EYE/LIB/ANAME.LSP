;
; aname.lsp 22.05.92 dbj created as a recursive
;............................................................................
; give att's ename if atr's tag exist in given block
; if not found return nil ...
; 31/05/91
; atrtag must be in capitals, this is AutoCad's "feature"
(setq function
(lambda ( name atrtag / return sls )
(defun sls ( ind ent ) (cdr (assoc ind ent)))
(setq atrtag (strcase atrtag))
 (if (/= nil name)
     (if (/= "SEQEND" (sls 0 (entget name)))
         (if (= "ATTRIB" (sls 0 (entget name)))
	     (if (= atrtag (sls 2 (entget name)))
	         (setq return (sls -1 (entget name)))
	         (setq return (call '("lib/aname" (entnext name) atrtag)))
              ) ; if
	         (setq return (call '("lib/aname" (entnext name) atrtag)))
         ) ; if
     ) ; if
 ) ; if
 return
 )
) ; aname
;
