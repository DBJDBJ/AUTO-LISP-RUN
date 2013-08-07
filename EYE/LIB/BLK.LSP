; blk.lsp dbj created 22.05.92
; give entity name for given blok name if exist
; 31.05.91 DBJ CREATED
(setq function 
(lambda ( namestr  / ss )
      ( setq ss nil ss (ssget "X" (list(cons 2 namestr))) )
      ( if (/= ss nil) (setq  ss (ssname ss 0))    )
ss ; return
));
;
