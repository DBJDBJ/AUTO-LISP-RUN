; blname.lsp
; extract block name from his list
;
(setq function
(lambda ( blst / name )
        (if (= (type blst) 'list)
            (setq name (cdr (assoc 2 blst)))
            (setq name " ") ; else
        )
  (strcase name T)
); blname
); function
