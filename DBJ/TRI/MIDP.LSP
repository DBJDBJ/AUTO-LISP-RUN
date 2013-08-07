; midp.lsp
; mid point of two 3D points
(setq function
(lambda (p1 p2)
(list   (/ (+(car p1)  (car p2))  2.0)
        (/ (+(cadr p1) (cadr p2)) 2.0)
        (/ (+(last p1) (last p2)) 2.0)  )
));midp
