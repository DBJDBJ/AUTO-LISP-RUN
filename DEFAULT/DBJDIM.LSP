; defun c:dbjdim
(setq function
(lambda ( / s )
        (setq *error* runerr )
        (setvar "cmdecho" 0)
        (prompt "\nSet dimmensioning variables ")
        (setq s 1)
        (initget 7)
        (setq s (getreal "for which scale   1 : ") s (/ s 50.0))
        (call '("dimset" s)) ; s goes to dimset
        (princ)
) ; lambda
) ; setq function
