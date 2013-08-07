;
;11.11.91 test.lsp dbj created
;
(setq function   (lambda ( )
                        (textscr)
                        (prompt "\ncurrent memory state :")
                        (mem)
                        (getstring "\nreturn ...")
                        (princ)
			(setq NiceBigGlobal "I am nasty global!")  
                ) ; lambda
) ; of function
