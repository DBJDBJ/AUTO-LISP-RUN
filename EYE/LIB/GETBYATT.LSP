;...........................................................................
; return ent. name of block from sset  if it has atribute
; asked by tag and specified value in it
; 31.04.92 DBJ created
; 27.05.92 DBJ improved
(setq function
 (lambda ( atttag attval sset) 
  (defun getbyatt ( atttag attval sset index )
   ( if (> index (sslength sset))
     nil
     (if (= attval (run::calluser '("lib/attval" (ssname sset index) atttag)))
         (ssname sset index)
	 (getbyatt atttag attval sset (1+ index))
     ) ;if
   )
  ) ; getbyatt
(getbyatt atttag attval sset 0)
));function
