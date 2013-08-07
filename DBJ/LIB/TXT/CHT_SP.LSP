;;;---------------------------------------------------------------------------;
;;;
;;; set the prompt string for cht command
;;;
(defun cht_sp ()
  (if (= typ "style")
    (progn
      (initget "individual list new select ")
      (setq nw (getkword (strcat "\nindividual/list/select style/<new "
                                 prmpt
                                 " for all text entities>: ")))
      (if (or (= nw "") (= nw nil) (= nw "enter"))
        (setq nw (getstring (strcat "\nnew "
                                    prmpt
                                    " for all text entities: ")))
      )
    )
    (progn
      (initget "list individual" 1)
      (setq nw (getreal (strcat "\nindividual/list/<new "
                                 prmpt
                                 " for all text entities>: ")))
    )
  )
)
