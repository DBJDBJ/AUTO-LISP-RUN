; layon.lsp dbj created
; go on requested layer , make it if it does not exist
; in default color
(setq function
(lambda ( lname )
  (tblnext "layer" T)
  (if (= nil (tblsearch "layer" lname ))
      (command "layer" "make" lname "")
  )
  (command "layer" "thaw" lname "set" lname "")
))
