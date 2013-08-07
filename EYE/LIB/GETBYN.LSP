; getbyn.lsp dbj created 26.05.92
; send a "eye" or "target" string and integer
; return eye or target ename with that number
; or nil if not exist
; needs block eyedata to work
(setq function
  (lambda ( what num / found ss name atrtag next)
    (setq what (strcase what))
    (cond
      ((= "EYE" what) (setq name "EYE" atrtag "eyenumber"))
      ((= "TARGET" what) (setq name "TARGET" atrtag "targetnumber"))
      (T (*error* "\nWrong first parameter in GETBYN.lsp ... "))
    ) ; cond
      ( setq ss nil ss (ssget "X" (list(cons 2 name))) )
    (cond
      ((/= ss nil)
       (setq next 0 found nil name (ssname ss next))
       (while (and (= nil found)(/= nil name)) 
          (setq found (= (itoa num)(run::call '("lib/attval" name atrtag)))
          ) ; setq found
;         (prompt (strcat "\n"(itoa next) " : " 
;                       (itoa num) " =?= "
;           (call '("lib/attval" name atrtag)) " -> "
;  ))(princ found)
          (if (= nil found)
              (setq name (ssname ss next) next (1+ next))
          ) ; if
       ) ; while
      )
      (T (prompt (strcat "\nNO " name "in this drawing ?")))
    ) ; cond
;    (prompt "\n Result : ")
    (if (= nil found) nil name ) ; return 
  ) ; end of
)   ; function 
