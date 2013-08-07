;;;---------------------------------------------------------------------------;
;;;
;;; change one text entity.
;;;
(defun cht_p1 ()
  (setq temp (ssname sset 0))
  (setq ow (cdr(assoc fld (entget temp))))
  (if (= opt "rotation")
    (setq ow (/ (* ow 180.0) pi))
  )
  (redraw (cdr(assoc -1 (entget temp))) 3)
  (initget 0)
  (if (= opt "style")
    (setq nw (getstring (strcat "\nnew " prmpt ". <"
                              ow ">: ")))
    (setq nw (getreal (strcat "\nnew " prmpt ". <"
                              (rtos ow 2) ">: ")))
  )
  (if (or (= nw "") (= nw nil))
    (setq nw ow)
  )
  (redraw (cdr(assoc -1 (entget temp))) 1)
  (if (= opt "rotation")
    (setq nw (* (/ nw 180.0) pi))
  )
  (if (= opt "style")
    (if (null (tblsearch "style" nw))
      (princ (strcat "\nstyle " nw " not found. "))
      
      (entmod (subst (cons fld nw)
                     (assoc fld (setq ent (entget temp)))
                     ent
              )
      )
    )
    (entmod (subst (cons fld nw)
                   (assoc fld (setq ent (entget temp)))
                   ent
            )
    )
  )
)
