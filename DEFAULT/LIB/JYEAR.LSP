
;       jyear  --  transform julian date to a list containing
;                  (year month day).
;                  usualy input is "date" variable
(setq function
(lambda (td)
        (setq j (fix td))
        (setq j (- j 1721119.0))
        (setq y (fix (/ (1- (* 4 j)) 146097.0)))
        (setq j (- (* j 4.0) 1.0 (* 146097.0 y)))
        (setq d (fix (/ j 4.0)))
        (setq j (fix (/ (+ (* 4.0 d) 3.0) 1461.0)))
        (setq d (- (+ (* 4.0 d) 3.0) (* 1461.0 j)))
        (setq d (fix (/ (+ d 4.0) 4.0)))
        (setq m (fix (/ (- (* 5.0 d) 3) 153.0)))
        (setq d (- (* 5.0 d) 3.0 (* 153.0 m)))
        (setq d (fix (/ (+ d 5.0) 5.0)))
        (setq y (+ (* 100.0 y) j))
        (if (< m 10.0)
           (setq m (+ m 3))
           (progn
              (setq m (- m 9))
              (setq y (1+ y))
           )
        )
        (list y m d)
)
)
