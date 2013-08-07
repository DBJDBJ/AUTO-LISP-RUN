; function to reset system variables
; calling example : (moder)
; mlst is global var. !
(setq function
(lambda ()
   (repeat (length mlst)
      (setvar (caar mlst) (cadar mlst))
      (setq mlst (cdr mlst))
   )
)
)
