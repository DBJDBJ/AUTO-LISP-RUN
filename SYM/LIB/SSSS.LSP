;  
; ssss.lsp Selection Set Sub Set 06.02.92 DBJ created
; syntax for using same as a (ssget "x" ....)
; returns SSet or nil
;
(setq function
(lambda ( ss clist / ent )
(setq len (sslength ss) cn 0 sstemp (ssadd))
(repeat len
  (setq ent (entget (ssname ss cn)) pass T)
   (foreach elem clist
     (setq with (car elem) what (strcase (cdr elem))
           pass (and (= what (cdr (assoc with ent)) ) pass) ; and
     ) ; setq  
   ); foreach
     (if pass
       (setq sstemp (ssadd (ssname ss cn) sstemp))
     )
  (setq cn (1+ cn))
);repeat
(if (> (sslength sstemp) 0)
     sstemp ; return 
     nil    
)
);lambda
);function
