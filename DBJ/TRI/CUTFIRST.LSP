;cutfirst.lsp dbj created
; index of the second vertex of FIRST possible
; cut from first vertex the spline list
(setq function
(lambda ( from spline xmin / to p)
        (setq to (/ (length spline) 2) p nil) ; mid of the list
        (while  (null (call '("tri/lpintest" from to spline xmin)) )
          (setq to (call '("tri/1from" to spline)))
          (if (= to from)
              (setq from (call '("tri/1left" from spline))
		    to   (call '("tri/2from" from spline)))
          );if
        ) ; while
(list from to) ; return
))    ; cutFirst
