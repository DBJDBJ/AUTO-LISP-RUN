;newdwg.lsp
;go to external block
; 08/05/91 dbj
(setq function
(lambda ( olddwg / f qe )
(setq qe (strcase
      (getstring
        (strcat "\nGoing out, quit or <e>nd " (getvar "dwgname") " dwg: ")
      )
         )
)
        (if (= qe "")  (setq qe "e"))
        (if (/= qe "q")(setq qe "e"))
  (if (/= olddwg "")
      ( progn
        (call "lib/lastdwg") ; leave trace about last dwg
        (call '("lib/tmpscr" qe olddwg)) ; do the script
      ):progn
  );if 
  ( princ )
);newdwg
);function
