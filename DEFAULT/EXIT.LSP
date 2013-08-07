;
;          dbj 31.01.92 will do only scripts on $HOME path
;          dbj 17.01.92 exit.scr feature added
; exit.lsp dbj 15.11.91 created
; 			happens uppon run.lsp exiting
(setq function
   (lambda ()
	(setq *error* runerr)
	(if (= nil home)(runerr "HOME not defined upon EXIT.lsp entering."))
	 (setvar "cmdecho" 0)
         (prompt "\nExiting, type run to enter again ...")
         (command ".menu" "acad")
	 (runcall '("doscr" (strcat home "/exit.scr")))
	 (graphscr)
   ) ; lambda 
) ; function
