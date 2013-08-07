; sls.lsp
; sls == Sub List Second from acad dbase list
(setq function 
(lambda  ( ind ent ) (cdr (assoc ind ent)))
)
;
; or (defun sls ( ind ent ) (cdr (assoc ind ent)))
;
