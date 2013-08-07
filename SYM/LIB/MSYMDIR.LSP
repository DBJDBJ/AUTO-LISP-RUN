; msymdir.lsp 06.02.92 dbj created
;
(setq function
  (lambda ( symname )
	  (setvar "cmdecho" 0)
 (if (findfile (strcat (getenv "SYMDIR") "/" symname))
     nil ; it already exist, something is wrong ...
     (progn
	  (command ".shell" (strcat "mkdir " (getenv "SYMDIR") "/" symname))
	 (if (findfile (strcat (getenv "SYMDIR") "/" symname))
	     T   ; it is created
	     nil ; or not, maybe file system is full ?
         ) ; if
      );progn
 );if
  ); lambda
); function
