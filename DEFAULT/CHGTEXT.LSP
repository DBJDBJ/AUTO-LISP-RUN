;-----------------------------------------------------------------------------|
;defun c:chgtext
(setq function
(lambda ( / p l n e os as ns st s nsl osl sl si chf chm olderr)
   (setq *error* runerr chm 0)
   (setq p (ssget))                  ; select objects
   (if p (progn                      ; if any objects selected
      (while (= 0 (setq osl (strlen (setq os (getstring t "\nold string: ")))))
            (princ "null input invalid")
      )
      (setq nsl (strlen (setq ns (getstring t "\nnew string: "))))
      (setq l 0 n (sslength p))
      (while (< l n)                 ; for each selected object...
         (if (= "text"               ; look for text entity type (group 0)
                (cdr (assoc 0 (setq e (entget (ssname p l))))))
            (progn
               (setq chf nil si 1)
               (setq s (cdr (setq as (assoc 1 e))))
               (while (= osl (setq sl (strlen
                             (setq st (substr s si osl)))))
                  (if (= st os)
                      (progn
                        (setq s (strcat (substr s 1 (1- si)) ns
                                        (substr s (+ si osl))))
                        (setq chf t) ; found old string
                        (setq si (+ si nsl))
                      )
                      (setq si (1+ si))
                  )
               )
               (if chf (progn        ; substitute new string for old
                  (setq e (subst (cons 1 s) as e))
                  (entmod e)         ; modify the text entity
                  (setq chm (1+ chm))
               ))
            )
         )
         (setq l (1+ l))
      )
   ))
   (princ "changed ")(princ chm)(princ " text lines.")(terpri)(princ)
) ; lambda chgtext
) ; setq function
