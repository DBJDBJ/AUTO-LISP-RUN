; pxmin.lsp dbj created
;return vertex index with poly's xMIN index in it
(setq function
(lambda ( / c L xmin ind )
(if (null vLst10) (runErr "in pBox VLst10 is NIL"))
      (setq     L (length vLst10)
             xmin (caar VLst10)
                c 0
              ind c
      ); setq
    (repeat L  (if (< (car (nth c vLst10)) xmin  )
                   (setq xmin (car (nth c vLst10))
                          ind c
                   )
               );if
          (setq c (1+ c))
    )  ; repeat
ind    ; return
))     ; pXmin
