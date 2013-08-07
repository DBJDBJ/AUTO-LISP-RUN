;
;  name.lsp dbj created
;  gives a prefix and a name of curent drawing
;
(setq function
(lambda ( )
(prompt "\rdrawing path is : ")
(prompt (getvar "dwgprefix"))
(prompt "\ndrawing name is : ")
(prompt (getvar "dwgname"))
(graphscr)
; text on status line in coord. part
(grtext -2 (strcat "drawing: " (getvar "dwgname")) )
; text on screen
(grtext -1 (strcat "drawing: " (getvar "dwgname")) )
(princ)
) ; lambda
) ; setq function
