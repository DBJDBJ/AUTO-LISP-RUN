; getblok.lsp
; pick up a block
(setq function
(lambda ( / enti typ )
      (setq  enti (entget (car (entsel"\nPick up a block please ...")))
              typ (cdr (assoc 0 enti))
      )
      (if (/= typ "INSERT")
          (progn (prompt "\nThis is not a block !")
                 (setq enti nil)
          )
          (setq enti enti)
      )
) ; getblok
) ; function
