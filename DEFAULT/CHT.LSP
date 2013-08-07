;;;   chtext.lsp
;;;   copyright (c) 1990 by autodesk, inc.
;;;---------------------------------------------------------------------------;
;;; 14.11.91 dbj prepared for aj system
;;;---------------------------------------------------------------------------;

(setq function
(lambda ( / al cht_ve cht_ol cht_ue cht_le cht_je justpt justpn cht_te
           chgtext cht_pe cht_pa cht_p1 cht_sp cht_pl cht_pi
           cht_ps chtxt cht_er  sset opt ssl nsset temp unctr sslen style
           hgt rot txt ent cht_oc loc loc1 justp justq orthom
         )
;;;---------------------------------------------------------------------------;
;;;---------------------------------------------------------------------------;
   (if (= "not" (load (strcat envpath "chtlib") "not"))
       (runerr "Can't find chtlib.lsp for cht.lsp")
   )
;;;---------------------------------------------------------------------------;
;;;---------------------------------------------------------------------------;

  (if *error*                         ; set our new error handler
    (setq cht_oe *error* *error* cht_er) 
    (setq *error* cht_er) 
  )

  ;; set undo groups and ends with (eval(read u:g)) or (eval(read u:e))
  (setq u:g "(command \"undo\" \"group\")"
        u:e "(command \"undo\" \"end\")"
  )
  
  (setq cht_oc (getvar "cmdecho"))
  (setq cht_oh (getvar "highlight")) 
  (setvar "cmdecho" 0)
  
  (eval(read u:g))

  (setq pt_ver "1.00")                ; reset this local if you make a change.
  (princ (strcat "\rchange text, version " pt_ver ", (c) 1990 by autodesk, inc. "))
  (setq pt_ver "1.10")                ; reset this local if you make a change.
  (princ (strcat "\rchange text, version " pt_ver ", (c) 1991 by dbj "))
  (prompt "\nselect text to change. ")
  (setq sset (ssget))
  (if (null sset) 
    (progn
      (princ "\nerror: nothing selected.")
      (exit) ; <- look Peter exit function !
    )
  )
  ;; verify the entity set.
  (cht_ve)
  ;; this is the main option loop.
  (cht_ol)

  (if cht_oe (setq *error* cht_oe))   ; reset old error function if error
  (eval(read u:e))
  (if cht_ot (setvar "texteval" cht_ot)) 
  (setvar "highlight" 1)
  (if cht_oc (setvar "cmdecho" 0)) ; reset command echoing
  (princ)
) ; lambda
) ; setq function
