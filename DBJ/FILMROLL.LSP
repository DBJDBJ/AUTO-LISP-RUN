;filmroll.lsp 16.12.91 DBJ created
; put a film where it belongs ...
(setq function
(lambda ( / n )
 (setq *error* runerr)
    (setq n
        (call '("lib/getstr" "Film file name: " (getvar "dwgname")))
    )
	(command "filmroll" ( strcat "c:/cad/shade/" n ) )
)
) ; eof function
