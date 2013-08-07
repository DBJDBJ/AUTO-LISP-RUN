(defun dxf (code elist)   
  (cdr (assoc code elist))
);defun
;****************************************************************
;*  NEARFAR   Tests for nearest or furthest point
;*  SYNTAX  (NEARFAR <pt><pt-list>T)......nearest point
;*          (NEARFAR <pt><pt-list>nil)....furthest point
;*          (NEARFAR <pt><pt-list>"NTH")..position of nearest
;*  <pt> must be in form (2345.00 567.78)
;*  <pt-list> mut be in form ((123.98 456.0)(789 987))
;*
;*              (setq pt-list (list pt-a pt-b pt-c '(3.40 5.67)))
;*              (NEARFAR pt-d pt-list T)  
;*        returns the nearest point to pt-d selected from pt-list
;*
;*              (NEARFAR pt-d pt-list "NTH")
;*        returns the nth position of nearest in pt-list
;*               count starts at 0
;*
;****************************************************************
(defun nearfar ( q-point pt-list test / test-d test-p tmp-d tmp-p nth-no)
  (setq test-p (car pt-list)
        test-d (distance q-point test-p)
        pt-list (cdr pt-list)
        nth-no 0
  );
  (while (> (length pt-list) 0)
         (if (if test (< (distance q-point (car pt-list)) test-d)
                      (> (distance q-point (car pt-list)) test-d)
             );if
             (setq test-p (car pt-list)
                   test-d (distance q-point test-p)
                   nth-no (1+ nth-no)
             );setq
         );if
         (setq pt-list (cdr pt-list))
  );while
  (setq q-point (cond ((and (= (type test) 'STR)
                            (= (strcase test) "NTH")) nth-no)
                      (t test-p)
                );cond
  );setq
);nearfar

(defun strip (code data)
             ;code is dxf code number, data is association list of data
  (cdr (subst (car data) (assoc code data) data))
             ;strips an ASSOC group from entity list
);defun 
;***MAIN ROUTINE
(defun C:HEAL ( / first second f-ent s-ent o-start o-end n-start obs-end
                  n-start n-end test x a-list snapmode-v blipmode-v)
   (setq SNAPMODE-V (getvar "SNAPMODE")
         BLIPMODE-V (getvar "BLIPMODE")
   );setq
   (setvar "SNAPMODE" 0)
   (setq first (entsel "\nSelect First Side of Heal : ")
         second (entsel "\nSelect Second Side of Heal : ")
         f-ent (entget (car first))	
         s-ent (entget (car second))
   );setq
   (if (not (equal (car first)(car second)))
       (if (and (= (dxf 0 f-ent) "LINE")
                (= (dxf 0 s-ent) "LINE")
           );and
           (progn
              (setq o-start (assoc 10 f-ent)
                    o-end (assoc 11 f-ent)
                    n-start (nearfar (cadr second)
                                     (list (dxf 10 f-ent)
                                           (dxf 11 f-ent))nil)
                    obs-end (nearfar (cadr second)
                                     (list (dxf 10 f-ent)
                                           (dxf 11 f-ent))T)
                    n-end (nearfar   (cadr first)
                                     (list (dxf 10 s-ent )
                                           (dxf 11 s-ent))nil)
                    test (distance (polar n-start
                                          (angle n-start obs-end)
                                          (distance n-start n-end)) n-end)
              );setq
              (if (< test 0.0001)
                  (progn
                     (setq n-start (cons 10 n-start)
                           n-end   (cons 11 n-end)
                           f-ent   (subst n-start o-start f-ent)
                           f-ent   (subst n-end o-end f-ent)
                     );setq
                     (entdel (car second))
                     (entmod f-ent)
                   );progn
                   (prompt "*INVALID*  Lines not alligned")
              );if
           );progn
           (if (and (= (dxf 0 f-ent) "ARC")
                    (= (dxf 0 s-ent) "ARC")
               );and
               (if (< (distance (dxf 10 f-ent)(dxf 10 s-ent)) 0.0001)
                   (if (< (abs (- (dxf 40 f-ent)(dxf 40 s-ent))) 0.0001)
                       (progn
                          (setq
                             o-start (polar (dxf 10 f-ent)
                                            (dxf 50 f-ent)
                                            (dxf 40 f-ent))
                             o-end   (polar (dxf 10 f-ent)
                                            (dxf 51 f-ent)
                                            (dxf 40 f-ent))
                             n-start (nearfar (cadr first)
                                              (list o-start o-end)"nth")
                             o-start (polar (dxf 10 s-ent)
                                            (dxf 50 s-ent)
                                            (dxf 40 s-ent))
                             o-end   (polar (dxf 10 s-ent)
                                            (dxf 51 s-ent)
                                            (dxf 40 s-ent))
                             n-end   (nearfar (cadr second)
                                              (list o-start o-end)"nth")
                             o-start (assoc 50 f-ent)
                             o-end   (assoc 51 f-ent)
                          );setq
                          (if (/= n-start n-end)
                              (progn
                                 (if (= n-start 0)
                                     (setq n-start (assoc 50 s-ent)
                                           n-end   (assoc 51 f-ent))
                                     (setq n-start (assoc 50 f-ent)
                                           n-end   (assoc 51 s-ent))
                                 );if
                                 (setq f-ent   (subst n-start o-start f-ent)
                                       f-ent   (subst n-end o-end f-ent)
                                 );setq
                                 (entdel (car second))
                                 (entmod f-ent)
                              );progn
                              (prompt "*INVALID*  Ambiguous side to heal")
                          );if
                       );progn
                       (prompt "*INVALID*  Arcs have different radii")
                   );if
                   (prompt "*INVALID*  Arcs not concentric")
              );if
               (prompt "*INVALID*  Not both lines or arcs")
           );if
       );if
       (if (= (dxf 0 s-ent) "ARC")
           (progn
              (setvar "BLIPMODE" 0)
              (command "circle" (dxf 10 s-ent) (dxf 40 s-ent))
              (setvar "BLIPMODE" BLIPMODE-V)
              (setq f-ent (entget (entlast))
                    a-list '((6 . "BYLAYER")
                             (8 . "BYLAYER")
                             (38 . 0)
                             (39 . 0)
                             (62 . 256)
                            );a-list
              );setq
              (while
                (> (length a-list) 0)
                (setq x (caar a-list))
                (if (assoc x s-ent)
                    (if (assoc x f-ent)
                        (setq f-ent 
                            (subst (assoc x s-ent)(assoc x f-ent) f-ent))
                        (setq f-ent
                            (reverse (cons (assoc x s-ent)(reverse f-ent))))
                    );if
                    (if (assoc x f-ent)
                        (setq f-ent
                             (subst (assoc x a-list)(assoc x f-ent) f-ent))
                    );if
                );if
                (setq a-list (cdr a-list))
              );while
              (setq f-ent (cons (assoc -1 f-ent)(strip -1 f-ent)))
              (entdel (car second))
              (entmod f-ent)
           );progn
           (prompt "*INVALID*  Same entity selected twice")
      );if
   );if
   (setvar "BLIPMODE" blipmode-v)
   (setvar "SNAPMODE" snapmode-v)
(PRINC)
)



                                                           
