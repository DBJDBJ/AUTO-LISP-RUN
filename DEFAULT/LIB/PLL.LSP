; pll.lsp
; parralell lines
(setq function
(lambda ( pnt1 pnt2 / pnt3 pnt4 )
        (setq
          pnt3 (polar pnt1 (- (angle pnt1 pnt2) (call '("lib/dtr" 90))) d)
          pnt4 (polar pnt2 (- (angle pnt1 pnt2) (call '("lib/dtr" 90))) d)
        )
          (command "line" pnt1 pnt2 "")
          (command "line" pnt3 pnt4 "")
 pnt3 ; return
)
) ; function
;
