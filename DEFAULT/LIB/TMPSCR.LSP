; tmpscr.lsp
; script for going to next dwg
(setq function
(lambda ( act dwgfile / f)
        (setq f (open (strcat envpath "tmp.scr") "w"))
        (if (= (strcase act T) "e")
                (write-line ".end"  f)
                (progn (write-line ".quit" f) (write-line "y"    f))
        )
        (write-line "2" f)
        (write-line dwgfile f)
        (close f)
        (command ".script" (strcat envpath "tmp")) ; call it !
	"EXIT" ; to make script possible
);tmpscr
);function
