;;;
;;; verify and sort out non-text entities from the selection set.
;;;
(defun cht_ve ()
  (setq ssl   (sslength sset)
        nsset (ssadd))
  (if (> ssl 25)
    (princ "\nverifying the selected entities -- please wait. ")
  )
  (while (> ssl 0)
    (setq temp (ssname sset (setq ssl (1- ssl))))
    (if (= (cdr(assoc 0 (entget temp))) "text")
      (ssadd temp nsset)
    )
  )
  (setq ssl (sslength nsset)
        sset nsset
        unctr 0
  )
  (print ssl)
  (princ "text entities found. ")
)
