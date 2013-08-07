;;;---------------------------------------------------------------------------;
;;;
;;; change all of the text entities in the selection set sset
;;;
(defun cht_pa ()
  (setq sslen (sslength sset))
  (setq cht_oh (getvar "texteval"))
  (setvar "highlight" 0)
  (while (> sslen 0)
    (setq temp (ssname sset (setq sslen (1- sslen))))
    (entmod (subst (cons fld nw)
                   (assoc fld (setq ent (entget temp)))
                   ent
            )
    )
    
  )
  (setvar "highlight" 1)
)
