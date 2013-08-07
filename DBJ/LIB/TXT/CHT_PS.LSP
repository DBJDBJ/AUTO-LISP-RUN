;;;---------------------------------------------------------------------------;
;;;
;;; process the select option.
;;;
(defun cht_ps ()
  (princ "\nsearch for which style name?  <*>: ")
  (setq sn  (strcase (getstring))
        n   -1
        sset nsset
        nsset (ssadd)
        ssl (1- (sslength sset))
        )
  (if (or (= sn "*") (null sn) (= sn ""))
    (setq nsset sset sn "*")
    (while (and sn (< n ssl))
      (setq temp (ssname sset (setq n (1+ n))))
      (if (= (cdr(assoc 7 (entget temp))) sn)
        (ssadd temp nsset)
      )
    )
  )
  (setq ssl (sslength nsset))  
  (princ "\nfound ")
  (princ ssl)
  (princ " text entities with style of ")
  (princ sn)
  (princ ". ")
  
  (setq sset nsset)
)
