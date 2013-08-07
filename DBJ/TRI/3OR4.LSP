; 3or4.lsp dbj created
; update triangles or quad's GLOBAL lists
(setq function
(lambda (spline shape / tl )
        (if (< (length spline) 3)
            (runerr "in 3or4 length of spline is < 3")
        );if
        (setq tl '()
              tl (cons (nth 0 spline) tl)
              tl (cons (nth 1 spline) tl)
              tl (cons (nth 2 spline) tl)
        );setq
        (if (= "4" shape)
            (progn
                (setq tl (cons (nth 3 spline) tl))
                ;(call '("tri/drawPoly" spline 4 1))
                (setq quad (cons tl quad))
            )
            (progn
                ;(call '("tri/drawPoly" spline 3 2))
                (setq trian (cons tl trian))
            )
        );if
     (princ "\r")(princ (length quad)) (princ " Quad's and ")
                 (princ (length trian))(princ " Triangles made so far ...")
(princ)
))
