;
;
; dbjnew.lsp 01.02.90 dbj  new drawing called from drawing editor
;
(setq function
(lambda ();  /  nf qe msg )
  (setq *error* runerr) (setvar "cmdecho" 0)
  (prompt "\rGo to next exsisting drawing ") 
  (initget "Q q E e")
  (setq qe 
    (getkword (strcat "\nThis is "(getvar "dwgname")" Quit or <E>nd it: "  ))
  )
        (if (= qe nil)  (setq qe "E"))
	(setq qe (strcase qe))
	(if (= qe "E")
	  (setq msg (strcat "\nEND  <" (getvar "dwgname") "> ") )
	  (setq msg (strcat "\nQUIT <" (getvar "dwgname") "> ") )
        )
	  (setq msg (strcat msg " hit RETURN for the same or type new name: "))
        (setq nf (getstring nil msg ))
  (if (= nf  "") (setq nf (getvar "dwgname")))
  (if (/= nf "")
      ( progn
        (call "lib/lastdwg") ; leave trace about current drawing
        (call '("lib/tmpscr" qe nf)) ; do the script
      );progn
  );if 
  "exit" ; force exit out of the run.lsp to make script execution possible
);end of lambda
);end of setq function
