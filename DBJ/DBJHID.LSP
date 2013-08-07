;----------------------------------------------------------------------------
;
; dbjhid.lsp  02.10.91 DBJ created Hide common edges from 3dface's set
;
; globals
; FSET = s-set for 3d-faces storage
;---------------------------------------------------------------------------
(defun markset ( pnt ss code / ind )
 (setq ind 0)
 (repeat (sslength ss) (redraw (ssname ss ind) code)
                       (setq ind (1+ ind))
 )
 (command "circle" pnt 1)
 (prompt (strcat "\rSelection set length is " (itoa (sslength ss))))
 (command "erase" "L" "")
)
;---------------------------------------------------------------------------
; entelm from entity list
(defun entelm ( ass entlst )(cdr (assoc ass entlst )))
;----------------------------------------------------------------------------
(defun mpt (p1 p2) ; midpoint of two 3d points
 (mapcar '/ (mapcar '+ p1 p2) '(2.0 2.0 2.0) )   );mpt
;----------------------------------------------------------------------------
; Hide edge of 3dface going through given point
;
(defun hidedge ( face pnt / a b c d g f x)
   (setq    x 0.0000001 ; fuzz factor
	 face (entget face)
            a (entelm 10 face)
            b (entelm 11 face)
            c (entelm 12 face)
            d (entelm 13 face)
   );setq
   ; Store current value of the "70" flag of the 3dface
   (if (setq f (assoc 70 face)) (setq f (cdr f)) (setq f 0))
   ; Determine which edge midpoint is equal to the given point
             (setq g nil)
	     (cond ((equal pnt (mpt a b) x) (setq  g 1))
		   ((equal pnt (mpt b c) x) (setq  g 2))
		   ((equal pnt (mpt c d) x) (setq  g 4))
		   ((equal pnt (mpt d a) x) (setq  g 8))
             )
       (if g
	(progn
	 (setq face (subst (cons 70 (+ f g)) (assoc 70 face) face))
	 (entmod face)
	)
       ); if g
(/= g nil) ; return signal
) ; hidedge
;----------------------------------------------------------------------------
; compare two 3dfaces for common edge and make them invisible
(defun compare ( f1 f2 / a b c d ts) ; a b c d are mid points of edges
		 (setq f1 (entget f1)
			a (mpt (entelm 10 f1)(entelm 11 f1))
			b (mpt (entelm 11 f1)(entelm 12 f1))
			c (mpt (entelm 12 f1)(entelm 13 f1))
			d (mpt (entelm 13 f1)(entelm 10 f1))
		 ) ; setq
                 (if (hidedge f2 a) T
                     (if (hidedge f2 b) T
                         (if (hidedge f2 c) T
                             (if (hidedge f2 d) T NIL );if
			 );if
		     );if
		 );if
) ; compare
;----------------------------------------------------------------------------
; make invisible 3dface edges which are common with another 3dface
; find them with (ssget <point>) function ...
;
(defun DoFace ( f0 / nf0 ts ind a b c d )
                 (setq nf0 f0
                       f0 (entget f0)
                        ; mid points of all edges
                        a (mpt (entelm 10 f0)(entelm 11 f0))
                        b (mpt (entelm 11 f0)(entelm 12 f0))
                        c nil d nil
		 ) ; setq
                 (if (equal (entelm 12 f0)(entelm 13 f0))
                     (setq c (mpt (entelm 12 f0)(entelm 10 f0))
                     ) ; triangle
                     (setq c (mpt (entelm 12 f0)(entelm 13 f0))
                           d (mpt (entelm 13 f0)(entelm 10 f0))
                     ) ; square
                 );if
     ; all adjacent faces
     (if a (progn
           (setq ts (ssget a))
           (markset a ts 3)
           (if (> (sslength ts) 1)
               (progn  (hidedge (ssname ts 0) a)
                       (hidedge (ssname ts 1) a)
               )
           );if
           )
     );if a
     (if b (progn
           (setq ts (ssget b))
           (markset b ts 3)
           (if (> (sslength ts) 1)
               (progn  (hidedge (ssname ts 0) b)
                       (hidedge (ssname ts 1) b)
               )
           );if
           )
     );if b
     (if c (progn
           (setq ts (ssget c))
           (markset c ts 3)
           (if (> (sslength ts) 1)
               (progn  (hidedge (ssname ts 0) c)
                       (hidedge (ssname ts 1) c)
               )
           );if
           )
     );if c
     (if d (progn
           (setq ts (ssget d))
           (markset d ts 3)
           (if (> (sslength ts) 1)
               (progn  (hidedge (ssname ts 0) d)
                       (hidedge (ssname ts 1) d)
               )
           );if
           )
     );if d
     (setq ts nil)
) ; DoFace
;----------------------------------------------------------------------------
(defun DBJhid ( / i2 L done )
;----------------------------------------------------------------------------
  ( prompt "\r*DBJHID* Hide common edges of 3dFaces                  ")
  ( if (= 0 (sslength fset)) (trierr "FSET does not exist ?"))
  ;
  (setq i2 0)
  (repeat (sslength fset)
                  (doFace (ssname fset i2))
                  (setq i2 (1+ i2))
  );while
(princ)
) ; end DBJhid
;
(defun c:hideFace ()
	; pick-up only 3dfaces on layer 3dface ...
        (setq fset (ssget "X" (list (cons 0 "3DFACE")(cons 8 "3DFACE")) )
        (if (= nil fset)
	    (prompt "\nNo 3dfaces on layer '3DFACE' ? ")
            (dbjhid)
        )
        (princ)
);hideFace
