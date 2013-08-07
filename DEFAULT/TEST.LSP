
; rename all N layer names to 1,2,3,4,...,N 
; DBJ
(defun newlays ( / oldname x newname fld )

(defun fld (num lst) (cdr (assoc num lst)))

   (setq newname 1  
          x (tblnext "layer" T))        ; get first layer
   (while (/= x nil)
      (setq oldname (fld  2 x)          ; layer name
            newname (1+ newname))
      (if (/= "0" oldname)
          (command ".rename" "layer" oldname (itoa newname))
      ) ; if
      (setq x (tblnext "layer" nil))    ; get next layer
   );while
return
) ; layer
