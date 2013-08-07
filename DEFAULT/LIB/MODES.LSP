; function to store system variables
; parameter 'a' is a list of var's to be stored !
; calling example : (modes '("cmdecho" "blipmode"))
; mlst is global var. !
(setq function
(lambda (a)
   (setq mlst '())
   (repeat (length a)
      (setq mlst (append mlst (list (list (car a) (getvar (car a))))))
      (setq a (cdr a)))
)
)
