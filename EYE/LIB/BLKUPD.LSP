; blkupd.lsp dbj created 22.05.92 
;............................................................................
; update atr ref. by tag in blok refferenced by its string name
; if not found return nil ...
; 31/05/91 dbj created
;
(setq function
(lambda      (  blkstr      ; block name string
                atrstr      ; atr's tag  string
                newval      ; new value  string
                / ss )
      (setq ss (blk blkstr ))                     ; enty name
      (if (/= ss nil)
          (setq ss (run::calluser '("lib/attupd" ss atrstr newval)))
          (prompt (strcat "\Nblock " blkstr " not found ..."))
      )
      (if (= ss nil)
          (prompt (strcat "\Natrribute tag " atrstr " not found ..."))
      )
))
