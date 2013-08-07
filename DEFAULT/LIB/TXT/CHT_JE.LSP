;;;---------------------------------------------------------------------------;
;;;
;;; change the justification of an entry.
;;;
(defun cht_je ()
  (if (getvar "dimclrd")
    (initget (strcat "tleft tcenter tright "
                     "mleft mcenter mright "
                     "bleft bcenter bright "
                     "aligned center fit left middle right ?"))
    (initget "aligned center fit left middle right ?")
  )
  (setq sslen (sslength sset))
  (setq justp (getkword (strcat "\njustification point(s) - "
              "aligned/center/fit/left/middle/right/<?>: ")))
  (cond
    ((= justp "left")    (setq justp 0 justq 0) )
    ((= justp "center")  (setq justp 1 justq 0) )
    ((= justp "right")   (setq justp 2 justq 0) )
    ((= justp "aligned") (setq justp 3 justq 0) )
    ((= justp "fit")     (setq justp 5 justq 0) )
    ((= justp "tleft")   (setq justp 0 justq 3) )
    ((= justp "tcenter") (setq justp 1 justq 3) )
    ((= justp "tright")  (setq justp 2 justq 3) )
    ((= justp "mleft")   (setq justp 0 justq 2) )
    ((= justp "middle")  (setq justp 1 justq 2) )
    ((= justp "mcenter") (setq justp 1 justq 2) )
    ((= justp "mright")  (setq justp 2 justq 2) )
    ((= justp "bleft")   (setq justp 0 justq 1) )
    ((= justp "bcenter") (setq justp 1 justq 1) )
    ((= justp "bright")  (setq justp 2 justq 1) )
    ((= justp "?")       (setq justp nil)       )
    (t                   (setq justp nil)       )
  )   
  (if justp
    (justpt) ; process them...
    (justpn) ; list options...
  )
  (command)
)
