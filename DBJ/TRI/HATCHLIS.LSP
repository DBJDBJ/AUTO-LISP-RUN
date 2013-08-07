; hatchlist.lsp dbj created
(setq function
(lambda ( / i vLST)
   (setq vlst vlst10) ; global
   (command "pline")
   (while vLST
      (command (car vLST))
      (setq vLST (cdr vLST))
   );while
     (command "c" "")
     (command "hatch" "line" "0.1" "90" (entlast) "")
))
