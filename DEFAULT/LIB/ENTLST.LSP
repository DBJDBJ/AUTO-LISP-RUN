;entlst.lsp
(setq function
(lambda ( ) 
  (entget (car (entsel "pick up an entity: ")))) ; end of function entlst
) ; function
;
