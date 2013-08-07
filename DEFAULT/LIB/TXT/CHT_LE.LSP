;;;---------------------------------------------------------------------------;
;;;
;;; change the location of an text entity from sset
;;;
(defun cht_le ()
  (setq sslen (sslength sset)
        style ""
        hgt   ""
        rot   ""
        txt   ""
  )
  (command "change" sset "" "")
  (while (> sslen 0)
    (setq ent (entget(ssname sset (setq sslen (1- sslen))))
          opt (list (cadr (assoc 11 ent))
                    (caddr (assoc 11 ent))
                    (cadddr (assoc 11 ent)))
    )
    (prompt "\nnew text location: ")
    (command pause)
    (if (null loc)
      (setq loc opt)
    )
    (command style hgt rot txt)
  )
  (command)
)
