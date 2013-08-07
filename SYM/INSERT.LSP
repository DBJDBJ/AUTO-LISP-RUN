;
; insert.lsp dbj 17.01.92 created
; insert the symbol external presentation
; as a block , regarding present layer names
;
(setq function
	(lambda ( / tempset name done fname flist fullname )
		(setvar "cmdecho" 0)
		(prompt "\nSymbol insertion ")
	  (setq done nil)
  (while (= done nil)
	 (setq name (getstring "\nSymbol name (max 8 char) : "))
	 (if (findfile (strcat (getenv "SYMDIR") "/" name))
	     (setq done T)
	     (prompt "\nSorry this symbol does not exist..")
         );if
  ) ; while 
  (setq inspnt (getpoint "\nInsertion point :")
      fullname (strcat (getenv "SYMDIR") "/" name)
         flist (call '("lib/ls2list" (strcat fullname "/*.dwg")))
	 tempset (ssadd) ; preparation
  )
		(while flist 
		   (prompt (strcat "\nInserting " (car flist))) 
		   (setq fname (strcat fullname "/" (car flist)) 
		         flist (cdr flist))
		       (command ".insert" fname inspnt 1.0 1.0 0.0)
		       (setq tempset (ssadd (entlast) tempset))
		) ; while
		(command ".block" name inspnt tempset "")
		(command ".insert" name inspnt 1.0 1.0 0.0 )
        ); lambda
);function
