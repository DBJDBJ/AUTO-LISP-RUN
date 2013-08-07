; poseyebl.lsp 22.05.92 dbj created
; position new eye onto the drawing 
;
(setq function
(lambda ( / hgt eye eyescale )
  (setq eyescale (/ (distance (getvar "extmax")(getvar "extmin")) 100)
             hgt (read (run::calluser "lib/defhgt"))
             eye (getpoint "\nNew EYE position: ")
             eye (subst (+ hgt (last eye)) (last eye) eye )
  ) ; setq
; block eye.dwg 
; attributes : eyenumber, targetnumber, distance, lens length
;              and null or cliping plane distances from target,
;              1th is front and 2nd is back clip 
(setvar "cmdecho" 0)
(setvar "attreq" 0)
(command ".insert" (strcat run::envpath "/dwg/eye") eye eyescale eyescale 0 )
(entlast) ; return ename of eye block
)
);function
