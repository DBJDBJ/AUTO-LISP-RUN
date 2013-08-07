;;;---------------------------------------------------------------------------;
;;;
;;; change the text of an entity.
;;;
(defun cht_te ()
  (setq sslen (sslength sset))
  (initget "globally individually retype")
  (setq ans (getkword 
    "\nsearch and replace text.  individually/retype/<globally>:"))
  (setq cht_ot (getvar "texteval"))
  (setvar "texteval" 1)
  (cond 
    ((= ans "individually")
      (if (= (getvar "popups") 1)
        (progn
          (initget "yes no")
          (setq ans (getkword "\nedit text in dialogue? <yes>:"))
        )
        (setq ans "no")
      )
  
      (while (> sslen 0)
        (redraw (setq sn (ssname sset (setq sslen (1- sslen)))) 3)
        (setq ss (ssadd))
        (ssadd (ssname sset sslen) ss)
        (if (= ans "no") 
          (chgtext ss)
          (command "ddedit" sn "")
        )
        (redraw sn 1)
      )
    )
    ((= ans "retype")
      (while (> sslen 0)
        (setq ent (entget(ssname sset (setq sslen (1- sslen)))))
        (redraw (cdr(assoc -1 ent)) 3)
        (prompt (strcat "\nold text: " (cdr(assoc 1 ent))))
        (setq nt (getstring  t "\nnew text: "))
        (redraw (cdr(assoc -1 ent)) 1)
        (if (> (strlen nt) 0)
          (entmod (subst (cons 1 nt) (assoc 1 ent) ent))
        )
      )
    )
    (t
      (chgtext sset)                  ; change 'em all
    )
  )
  (setvar "texteval" cht_ot)
)

(defun chgtext (objs / last_o tot_o ent o_str n_str st s_temp 
                       n_slen o_slen si chf chm cont ans)
  (if (null objs)
    (setq objs (ssget))               ; select objects if running standalone
  )
  (setq chm 0)
  (if objs 
    (progn                   ; if any objects selected
      (if (= (type objs) 'ename) 
        (progn
          (setq ent (entget objs))
          (princ (strcat "\nexisting string: " (cdr (assoc 1 ent))))
        )
        (if (= (sslength objs) 1)
          (progn
            (setq ent (entget (ssname objs 0)))
            (princ (strcat "\nexisting string: " (cdr (assoc 1 ent))))
          )
        )
      )
      (setq o_str (getstring "\nmatch string   : " t))
      (setq o_slen (strlen o_str))
      (if (/= o_slen 0)
        (progn
          (setq n_str (getstring "\nnew string     : " t))
          (setq n_slen (strlen n_str))
          (setq last_o 0 
                tot_o  (if (= (type objs) 'ename)
                         1
                         (sslength objs)
                       )
          )
          (while (< last_o tot_o)     ; for each selected object...
            (if (= "text"             ; look for text entity type (group 0)
                   (cdr (assoc 0 (setq ent (entget (ssname objs last_o))))))
              (progn
                (setq chf nil si 1)
                (setq s_temp (cdr (assoc 1 ent)))
                (while (= o_slen (strlen (setq st (substr s_temp si o_slen))))
                  (if (= st o_str)
                    (progn
                      (setq s_temp (strcat 
                                     (if (> si 1)
                                       (substr s_temp 1 (1- si)) 
                                       ""
                                     )
                                     n_str
                                     (substr s_temp (+ si o_slen))
                                   )
                      )
                      (setq chf t)    ; found old string
                      (setq si (+ si n_slen))
                    )
                    (setq si (1+ si))
                  )
                )
                (if chf 
                  (progn              ; substitute new string for old
                    ; modify the text entity
                    (entmod (subst (cons 1 s_temp) (assoc 1 ent) ent))
                    (setq chm (1+ chm))
                  )
                )
              )
            )
            (setq last_o (1+ last_o))
          )
        )
        ;; else go on to the next line...
      )
    )
  )
  (if (/= (type objs) 'ename)
    (if (/= (sslength objs) 1)        ; print total lines changed
      (princ (strcat "changed "
                     (rtos chm 2 0)
                     " text lines."
             )
      )
    )
  )
  (terpri)
)
