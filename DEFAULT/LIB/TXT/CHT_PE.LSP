;;;---------------------------------------------------------------------------;
;;;
;;; main procedure for manipulating text entities
;;; arguments:
;;;   typ   -- type of operation to perform
;;;   prmpt -- partial prompt string to insert in standard prompt line
;;;   fld   -- assoc field to be changed
;;; globals:
;;;   sset  -- the selection set of text entities
;;;
(defun cht_pe (typ prmpt fld / temp ow nw ent tw sty w hw lw 
                              sslen n sn ssl)
  (if (= (sslength sset) 1)           ; special case if there is only
                                      ; one entity selected
    ;; process one entity.
    (cht_p1)
    ;; else
    (progn
      ;; set prompt string.
      (cht_sp)
      (if (= nw "list")
        ;; process list request.
        (cht_pl)
        (if (= nw "individual")
          ;; process individual request.
          (cht_pi)
          (if (= nw "select")
            ;; process select request.
            (cht_ps)
            ;; else
            (progn
              (if (= typ "rotation")
                (setq nw (* (/ nw 180.0) pi))
              )
              (if (= (type nw) 'str)
                (if (not (tblsearch "style" nw))
                  (progn
                    (princ (strcat "\nstyle " nw " not found. "))
                  )
                  (cht_pa)
                )
                (cht_pa)
              )
            )
          )
        )
      )
    )
  )
)
