;
;-------------------------------- go to last drawing -------------------------|
; 09/05/91 dbj
(setq function
(lambda ( / name dwglast f qe )
;lib fun's -> lastdwg.lsp tmpscr.lsp
(setq *error* runerr
  dwglast (strcat envpath "lastdwg.txt")
        f (open dwglast "r"))
(if (= f nil)
(prompt (strcat "\nNo " dwglast " file ..."))
(progn
  (setq name (read-line f) prefix (read-line f)
  qe (getstring (strcat "\nLast dwg was " name ", Quit or <E>nd : "))
          qe (strcase qe)
  ) ; setq
        ( close f)
        (if (= qe "")  (setq qe "E"))
        (if (/= qe "Q")(setq qe "E"))
        (call "lib/lastdwg")             ; remember current dwg
        (call '("lib/tmpscr" qe name))   ; do the script
);progn
);if
  "exit"   
); lambda
); setq function
