;
; laylst.lsp  05.02.92 DBJ created
; return a list of all layer names present in the 
; ss 
;
(setq function
  (lambda ( ss / lay len llst cn )
  (setq len (sslength ss) cn 0)
  (repeat len
   (setq lay (cdr (assoc 8 (entget (ssname ss cn))))
         cn  (1+ cn)) 
   (if (= (member lay llst) nil )
       (setq llst (append llst (list lay)))
   )
  ); repeat
llst ; return
  )
); laylst.lsp
