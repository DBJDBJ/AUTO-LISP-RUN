;;;---------------------------------------------------------------------------;
;;;
;;; the option loop -> copy it and change options for your new comm's
;;;
(defun cht_ol ()
  (setq opt t)
  (while (and opt (> ssl 0))
    (setq unctr (1+ unctr))
    (command "undo" "group")
    (initget "location justification style height rotation width text undo")
    (setq opt (getkword 
      "\nheight/justification/location/rotation/style/text/undo/width: "))
    (if opt
      (cond
        ((= opt "undo")
          (cht_ue)                    ; undo the previous command.
        )
        ((= opt "location")
          (cht_le)                    ; change the location.
        )
        ((= opt "justification")
          (cht_je)                    ; change the justification.
        )
        ((= opt "style")    (cht_pe "style"    "style name"      7) )
        ((= opt "height")   (cht_pe "height"   "height"         40) )
        ((= opt "rotation") (cht_pe "rotation" "rotation angle" 50) )
        ((= opt "width")    (cht_pe "width"    "width factor"   41) )
        ((= opt "text")
          (cht_te)                    ; change the text.
        )
      )
      (setq opt nil)
    )
    (command "undo" "end")
  )
)
