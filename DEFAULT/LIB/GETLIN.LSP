; getlin.lsp
; function to pickup just lines
(setq function
( lambda ( / cont l )
        (setq cont nil)
        (while (not cont)
               (setq l (entget (car (entsel) )))
               (if (= (cdr (assoc 0 l)) "LINE")
                   (setq cont t)
                   (prompt "\n Only lines please...")
               ) ;if
        ) ; while
        l ; line ent as a result
)
)
