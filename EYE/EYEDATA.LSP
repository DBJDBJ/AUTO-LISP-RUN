;
; eyedata.lsp dbj 26.05.92 created
; Display data from eyedata block
;...........................................................................
(setq function
(lambda ( / datablk )
  (setq  *error* run::errhandler)
  (setq datablk (run::calluser '("lib/blk" "eyedata")))
  (cond 
  ((= nil datablk) (prompt "\nBlock EYEDATA not found ..."))
  (T (command ".ddatte" datablk ) (command ".undo" "1"))
  )
  (princ); return 
)) ; end of neweye
