
:
; getlayer.lsp DBJ created 20.03.92
; return list of lists in format (name lt-number color frozen)
; off all present layers           
(defun layertab ( / c d f ln lt ly n x return )
(defun fld (num lst) (cdr (assoc num lst)))
   ; (tblset "layer")
   (setq x  (tblnext "layer" T)         ; get first layer
      return '() )
   (while x
      (setq ly (fld  2 x)               ; layer name
            ln (fld  6 x)               ; linetype name
            c  (fld 62 x)               ; color number
            f  (logand (fld 70 x) 1)    ; "frozen" flag
          ; lt (tblsearch "ltype" ln)   ; linetype table entry
          ; d  (fld  3 lt)              ; linetype prose description
      )
      (setq return (cons (list ly ln c f) return)
                x  (tblnext "layer" nil))       
    ) ; while 
return
) ; layer
