;;;---------------------------------------------------------------------------;
;;;
;;; process individual request.
;;;
(defun cht_pi ()
  (setq sslen (sslength sset))
  (while (> sslen 0)
    (setq temp (ssname sset (setq sslen (1- sslen))))
    (setq ow (cdr(assoc fld (entget temp))))
    (if (= typ "rotation")
      (setq ow (/ (* ow 180.0) pi))
    )
    (initget 0)
    (redraw (cdr(assoc -1 (entget temp))) 3)
    (if (= typ "style")
      (progn
        (setq nw (getstring (strcat "\nnew "
                                   prmpt
                                   ". <"
                                   ow ">: ")))
      )
      (progn
        (setq nw (getreal (strcat "\nnew "
                                   prmpt
                                   ". <"
                                (rtos ow 2) ">: ")))
      )
    )
    (if (or (= nw "") (= nw nil))
      (setq nw ow)
    )
    (if (= typ "rotation")
      (setq nw (* (/ nw 180.0) pi))
    )
    (entmod (subst (cons fld nw)
                   (assoc fld (setq ent (entget temp)))
                   ent
            )
    )
    (redraw (cdr(assoc -1 (entget temp))) 1)
  )
)
