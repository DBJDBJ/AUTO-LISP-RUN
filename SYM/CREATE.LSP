;
; create.lsp dbj 17.01.92 created
; make the symbol external presentation
; like this :
;  .../symdir/<symname>/2d/nest.txt   names of nested symbols
;                         /data.txt      textual data
;                         /0.dwg         minimum to be showed
;                         /1.dwg         next layer
;                         /2.dwg         last layer
;                         etc...
;                       3d/0.dwg         minimum to see in 3d
;                          1.dwg         next layer
;                          2.dwg         last layer
;
(setq function
	(lambda ( / curlayer symname symset nest data laylst )
		(setvar "cmdecho" 0)
		(prompt "\nSymbol creation ")
		(setq symset (ssget)
		    syminspt (getpoint "\nInsertion point for symbol : ")
		     symname (call '("lib/getsymname"))
		     laylst  (call '("lib/laylst" symset))
		)
;
; save the symbol
; first make symbol directories
;
(if (= T (call '("lib/msymdir" symname)))
  (progn
    (setq symname (strcat (getenv "SYMDIR") "/" symname))
	;
	; now slice layers and save them one by file
	;
    (while laylst
	(setq curlayer (car laylst)
  	       tempset (call '("lib/ssss" symset (list (cons 8 curlayer))))  
  	         dname (strcat symname "/" (call '("lib/laycode" curlayer)))
	        laylst (cdr laylst)
	)
        (command "wblock" dname "" syminspt tempset "")
    ) ; while 
	;
	; save unique text data 
	;
	(command ".shell" (strcat "date >" (strcat symname "/data.txt")))
	(setq f (open (strcat symname "/data.txt") "a"))
	(write-line "#" f)
	(write-line "# symbol data text file " f)
	(write-line (strcat ":SYMBOL " symname ) f)
	(write-line (strcat ":CREATOR " (getenv "USER")) f)
	(close f)
   )
(prompt "\nNot enough disk space. Call Peter at home to free disk space. ")
);if 
) ; lambda
) ; function
