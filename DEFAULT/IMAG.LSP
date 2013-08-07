;
; IMAG.lsp by Chriss Fawcet 136N. Water St. Ste.203, Kent, OH 44240 USA
; 24.02.92 DBJ prepared
; idiot proof code + no intersections case also by DBJ
(setq function (lambda ( / imag lineline linearcirc cirarc )
(setq *error* runerr)
;...........................................................
;
(defun imag ( / o1 o2 e1 e2 e3 name1 name2 return code)
(setvar "cmdecho" 0)
(setq o1 (entsel "\nL|A|C  First: ")
      o2 (entsel "\rL|A|C Second: ")
      e1 (entget (car o1))    e2 (entget (car o2))
   name1 (cdr (assoc 0 e1)) name2 (cdr (assoc 0 e2))
    code (strcat (substr name1 1 1)(substr name2 1 1)) 
  return nil
 );setq 
      (cond
        ((= code "LL")
             (setq return (lineline e1 e2))
	)
	((member code '("LA" "LC" "AL" "CL"))
             (if (= name2 "LINE")(setq e3 e1 e1 e2 e2 e3 o2 o1)) ; if
             (setq return (linearcirc e1 e2 o2)) 
	)
	((member code '("AA" "AC" "CA" "CC"))
             (setq return (cirarc e1 e2 o2))
	)
	(T (prompt "\nOnly Lines, Arcs and Circles please ..." ))
      );cond
return
) ; eofun imag
;...........................................................
; edge edge intersection 
; 
(defun lineline ( e1 e2 / l1b l1e l2b l2e )
  (setq l1b (cdr (assoc 10 e1)) l1e (cdr (assoc 11 e1))
        l2b (cdr (assoc 10 e2)) l2e (cdr (assoc 11 e2)))
	(cond
	 ( (inters l1b l1e l2b l2e nil)) ; return
         ( T (prompt "\nNo intersection...")) ; return
        );cond
) ; eofun lineline
;...........................................................
; edge and arc or circle intersection 
; 
(defun linearcirc
 ( e1 e2 o2 / r a b p q c d x1 x2 x3 x4 x5 x6 dbj
 x7 x8 x9 x10 x11 x12 x13 i j k k1 k2 k3 k4 xx1 xx2 xx3 xx4 s x y
 y1p y2p y1m y2m xp xm yp ym psel pdis xyp mdis xym )

(setq r (cdr (assoc 40 e2))   a (cadr (assoc 10 e2))
      b (caddr (assoc 10 e2)) p (cadr (assoc 10 e1))
      q (caddr (assoc 10 e1)) c (cadr (assoc 11 e1))
      d (caddr (assoc 11 e1))
) ; setq 
      (if (/= (- p c) 0)
          (progn 
	    (setq s (/ (- q d)(- p c)) x1 (+ 1 (* s s))
	         x2 (* 2 s q) x3 (* 2 a) x4 (* 2 p s s)
		 x5 (* 2 s b) x6 (* a a) x7 (* 2 s q p)
		 x8 (* 2 s p b) x9 (* q q) x10 (* 2 q b)
                x11 (* s s p p) x12 (* b b) x13 (* r r)
		  i x1 j (- (- x2 x3)(+ x4 x5)) k1 (- x6 x7)
		 k2 (+ x8 x9) k3 (- x11 x10) k4 (- x12 x13)
		  k (+ k1 k2 k3 k4) xx1 (- 0 j) xx2 (* j j)
		xx3 (* 4 i k) xx4 (* 2 i)
	   );setq
	    ; check is there intersection at all
	    ; DBJ added 06.03.92
		(cond 
		((> (- xx2 xx3) 0) 
		 (setq xp (/ (+ xx1 (sqrt (- xx2 xx3))) xx4)
		       xm (/ (- xx1 (sqrt (- xx2 xx3))) xx4)
                      y1p (- xp p) y1m (- xm p) y2p (* s y1p)
	              y2m (* s y1m) yp (+ q y2p) ym (+ q y2m)
		      dbj T );setq
		)
		(T  (setq dbj nil) ; no intersection, sorry mate !
		)
		);cond
	 );progn
	 (progn 
	   (setq xp p 
	         xm p 
		  x (abs (- a p)) dbj T
           )
	   (if (= x 0) 
	       (setq y r) 
	       (setq y (sqrt (- (* r r)(* x x))))
	   )
	   (setq yp (+ b y) ym (- b y))
         );progn
    );if
    (cond
     ( (= dbj T) (setq psel (cadr o2) xyp (list xp yp) xym (list xm ym)
	        pdis (distance psel xyp) mdis (distance psel xym));setq
                (if (< pdis mdis)
                       xyp ; return         
                       xym
                );if
     )
     ( T (prompt "\nNo intersection...")) ; return
    );cond
) ; eofun linearcirc 
;...........................................................
; arc / circle intersection 
; 
(defun cirarc ( e1 e2 o2); / a b c d e f aa bb cc dd ee ff dbj
                ;ad2 aa4 ad8 dd4 x1 x2 l m n yp ym y1p y1m
		; xm1 xp1 xm2 xyp1 xyp2 xym1 xym2 p1 p2 
		;m1 m2 psel pdis mdis xyp xym b2 xp2
                ; )
(setq c (cdr (assoc 40 e1)) a (cadr (assoc 10 e1))
      b (caddr (assoc 10 e1)) f (cdr (assoc 40 e2))
      d (cadr (assoc 10 e2)) e (caddr (assoc 10 e2))
      aa (* a a) bb (* b b) cc (* c c) dd (* d d)
      ff (* f f) e2 (* e 2) ad2 (* a d 2) b2 (* b 2)
      ee (* e e) aa4 (* aa 4) ad8 (* a d 8) dd4 (* dd 4)
      x1 (- (+ ff ad2 bb) aa cc dd ee)
      x2 (- (+ aa4 dd4) ad8)
       l (+ (* 4 (- e b)(- e b)) x2)
       m (- 0 (- (* 4 (- e b) x1)(* 2 b x2)))
       n (- (* (- cc bb) x2)(* x1 x1))
     ) ; setq
; check is there intersection at all
; DBJ added 06.03.92
    (cond
     ((> (+ (* m m)(* 4 n l)) 0)
      (setq 
          yp (/ (+ m (sqrt (+ (* m m)(* 4 n l))))(* l 2))
          ym (/ (- m (sqrt (+ (* m m)(* 4 n l))))(* l 2))
         y1p (sqrt (- cc (* (- yp b)(- yp b))))
         y1m (sqrt (- cc (* (- ym b)(- ym b))))
         xm1 (- a y1m) xp1 (- a y1p) xm2 (+ a y1m) xp2 (+ a y1p)
        xyp1 (list xm1 ym) xym1 (list xp1 yp) xyp2 (list xm2 ym)
        xym2 (list xp2 yp)
          p1 (abs (- f (distance (list d e) xyp1)))
          p2 (abs (- f (distance (list d e) xyp2)))
          m1 (abs (- f (distance (list d e) xym1)))
          m2 (abs (- f (distance (list d e) xym2)))
       );setq
          (if (< p1 p2) (setq xyp xyp1)(setq xyp xyp2))
          (if (< m1 m2) (setq xym xym1)(setq xym xym2))
          (if (= a d) (progn (setq xym xym1 xyp xym2)));if
          (setq psel (cadr o2) pdis (distance psel xyp) mdis (distance psel xym)
          );setq
       (if (< pdis mdis)
         xyp ; return
         xym
       );if
     )
     ( T (prompt "\nNo intersection...")) ; return
) ; cond 
) ; eofun cirarc
;
; function begin
 (trans (imag) 0 1)
) ; lambda
) ; of function
