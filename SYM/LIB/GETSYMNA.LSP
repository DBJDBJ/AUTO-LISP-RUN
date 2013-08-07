;
; getsymname.lsp  03.02.92 DBJ created
; return a proper and unique name for the symbol
;
(setq function
  (lambda ( / name done )
	  (setq done nil)
  (while (= done nil)
	 (setq name (getstring "\nSymbol name (max 8 char) : "))
	 (if (findfile (strcat (getenv "SYMDIR") "/" name))
	     (prompt "\nSorry this name is already in use ...")
	     (setq done T)
         );if
  ) ; while 
 (substr name 1 8)
  )
); getsymname.lsp
