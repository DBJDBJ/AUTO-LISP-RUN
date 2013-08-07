;;;---------------------------------------------------------------------------;
;;;
;;; list the options.
;;;
(defun justpn ()
  (if (getvar "dimclrd") (textpage))
  (princ "\nalignment options: ")
  (princ "\n\t tleft   tcenter   tright ")
  (princ "\n\t mleft   mcenter   mright ")
  (princ "\n\t bleft   bcenter   bright ")
  (princ "\n\t  left    center    right")
  (princ "\n\taligned   middle    fit")
  (if (not (getvar "dimclrd")) (textscr))
  (princ "\n\npress any key to return to your drawing. ")
  (grread)
  (princ "\r                                           ")
  (graphscr)
)
