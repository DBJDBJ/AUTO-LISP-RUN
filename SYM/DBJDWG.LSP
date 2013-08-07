;
; 23.05.91 dbj created
;
; sls == sub list second from acad dbase list
(defun sls ( ind ent ) (cdr (assoc ind ent)))
;
; entity name of blok if exist
; its name as a string is provided
; 31.05.91 dbj created
;
(defun blk ( namestr  / ss )
      ( setq ss nil ss (ssget "x" (list(cons 2 namestr))) )
      ( if (/= ss nil) (setq  ss (ssname ss 0))    )
ss ; return
)
;
; atrib's entity name from block
; if not found return nil ...
; input block ent. name and atrib's tag as a string
; 31/05/91 dbj
;
(defun aname ( blknam atrtag / enm ent etyp return found )
   (setq enm  (entnext blknam )                      ; next name
         ent  (entget  enm)                          ; ent list
         etyp (sls 0 ent)                            ; and type
         return nil found  nil
   )
 (while
   (or (/= etyp "seqend") (/= t found))
   (if (
      and (= etyp "attrib") (= atrtag (sls 2 ent))   ; type and tag ok !
       )
       (setq return (sls -1 ent) found t)            ; return atr's name
   )
   (setq enm  (entnext enm)                          ; next name
         ent  (entget  enm)                          ; ent list
         etyp (sls 0 ent)                            ; and type
   )
 )                                                   ;while
 return
)
;
; update atr ref. by tag in blok ref. by its enty name
; if not found return nil ...
; 31/05/91 dbj created
;
(defun atrupd ( blknam      ; block name
                atrstr      ; atr's tag  as a string
                newval      ; new value  as a string
                / ss atrlst )
      (setq ss (aname blknam atrstr))  ; attr enty name
      (if (/= ss nil)
          (entmod
            (subst (cons 1 newval)
                   (assoc 1 (setq atrlst (entget ss)))
                   atrlst
            )
          )
      )
      ss ; return
);
;
; update atribute in a block
; if block or atribute not found return nil ...
; 31/05/91 dbj created
;
(defun blkupd ( blkstr      ; block name string
                atrstr      ; atr's tag  string
                newval      ; new value  string
                / ss )
      (setq ss (blk blkstr ))  ; enty name from block string name
      (if (/= ss nil)
          (setq ss (atrupd ss atrstr newval)) ; update the attribute
          (prompt (strcat "\nblock " blkstr " not found ..."))
      )
      (if (= ss nil)
          (prompt (strcat "\natrribute tag " atrstr " not found ..."))
      )
)
;
; (trace sls blk aname atrupd blkupd)
