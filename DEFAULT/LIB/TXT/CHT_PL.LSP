;;;---------------------------------------------------------------------------;
;;;
;;; process list request.
;;;
(defun cht_pl ()
  (setq unctr (1- unctr))
  (setq sslen (sslength sset))
  (setq tw 0)
  (while (> sslen 0)
    (setq temp (ssname sset (setq sslen (1- sslen))))
    (if (= typ "style")
      (progn
        (if (= tw 0)
          (setq tw (list (cdr(assoc fld (entget temp)))))
          (progn
            (setq sty (cdr(assoc fld (entget temp))))
            (if (not (member sty tw))
              (setq tw (append tw (list sty)))
            )
          )
        )
      )
      (progn
        (setq tw (+ tw (setq w (cdr(assoc fld (entget temp))))))
        (if (= (sslength sset) (1+ sslen)) (setq lw w hw w))
        (if (< hw w) (setq hw w))
        (if (> lw w) (setq lw w))
      )
    )
  )
  (if (= typ "rotation")
    (setq tw (* (/ tw pi) 180.0)
          lw (* (/ lw pi) 180.0)
          hw (* (/ hw pi) 180.0))
  )
  (if (= typ "style")
    (progn
      (princ (strcat "\n"
                     typ
                     "(s) -- "))
      (princ tw)
    )
    (princ (strcat "\n"
                     typ
                     " -- min: "
                     (rtos lw 2)
                     "\t max: "
                     (rtos hw 2)
                     "\t avg: "
                     (rtos (/ tw (sslength sset)) 2) ))
  )
)
