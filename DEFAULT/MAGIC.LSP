;
; magic.lsp
;
(defun magic ( inpar / local )
(if (null inpar) 
    (prompt "\nNo input par's ...")
    (progn
    (prompt "\nInput param is: ")(print inpar)
    )
)
(princ)
) ; magic
