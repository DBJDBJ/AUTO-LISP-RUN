;
; dbjprl.lsp 01.02.90 dbj  created
(setq function
(lambda ( / a c d e f1 f2 pnt1 pnt2 pnt3 pnt4 newwdt )
;
(defun newwdt ( / w )   ; new width ?
   (setq #wllwdt 150) ; default wall width
   (setq w (getdist (strcat "\ndistance <" (rtos #wllwdt) ">: ")))
   (if (= w nil)(setq w #wllwdt)(setq #wllwdt w))
   w
)
; dbjprl begin
        (setq *error* runerr)
        (graphscr)
        (prompt "\n*dbjprl by dbj*")
        (setvar "cmdecho" 0)
        (setvar "osmode" 0)
        (command "fillet" "r" 0)
        (setq  f1 nil f2 nil c 0 pnt4 nil
               d (newwdt)
            pnt1 (getpoint "\nfirst point: ")
            pnt2 pnt1
        )
        (while (/= pnt2 nil)
                (if (/= pnt3 nil)(setq f1 pnt3))
                (if (> c 1)(setq f1 (polar pnt3 a d)))
                (setq pnt2 (getpoint "\nnext point: " pnt1 ))
         (if (/= pnt2 nil)
             (progn
                (setq c (+ c 1)
                   pnt3 (call '("lib/pll" pnt1 pnt2))
                      a (angle pnt1 pnt2)
                     f2 (polar pnt2 (- a (call '("lib/dtr" 90)))  d )
                   pnt1 pnt2
                )
                (if (/= f1 nil)(command "fillet" f1 f2))
             ) ; progn
         ) ; if
        ) ; while
        (setq error *olderr*)
  ( princ )
);dbjprl lambda end
);setq function
