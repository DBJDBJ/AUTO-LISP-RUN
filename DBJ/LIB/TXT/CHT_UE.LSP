;;;---------------------------------------------------------------------------;
;;;
;;; undo an entry.
;;;
(defun cht_ue ()
  (if (> unctr 1)
    (progn
      (command "undo" "end")
      (command "undo" "2")
      (setq unctr (- unctr 2))
    )
    (progn
      (princ "\nnothing to undo. ")
      (setq unctr (- unctr 1))
    )
  )
)
