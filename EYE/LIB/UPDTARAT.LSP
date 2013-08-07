; updtarat.lsp dbj created 22.05.92
; update all atributes in block target
; if null string sent do nothing
(setq function
  (lambda  ( tarblk eyenumber targetnumber )
(if (/= 0 (ascii targetnumber))
  (call '("lib/attupd" tarblk "targetnumber" targetnumber)))
(if (/= 0 (ascii eyenumber))
  ;add new eye number to a string of eye numbers
  (run::calluser '("lib/attupd" tarblk "eyes" 
           (strcat (run::calluser '("lib/attval" tarblk "eyes"))
	           " " eyenumber
	   )
         )
  )
);if
));function
