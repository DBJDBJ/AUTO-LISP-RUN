; postarbl.lsp 22.05.92 dbj created
; position new target onto the drawing 
;
(setq function
(lambda ( eyepos / hgt tar tarscale )
  (setq tarscale (/ (distance (getvar "extmax")(getvar "extmin")) 100)
             hgt (read (run::calluser "lib/defhgt"))
             tar (getpoint "\nNew TARGET position: " eyepos )
             tar (subst (+ hgt (last tar)) (last tar) tar )
  ) ; setq
; block tar.dwg 
; attributes : targetnumber and list of eyes 
(setvar "cmdecho" 0)
(setvar "attreq" 0)
(command ".insert" (strcat envpath "dwg\\target") tar tarscale tarscale 0 )
(entlast) ; return ename of tar block
)
);function
