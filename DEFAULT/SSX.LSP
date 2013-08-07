;
;ssx.lsp
;
(setq function
(lambda ( )
(setq *error* runerr t1 t f2 'f1 )
(while t1
  (initget "block color entity layer ltype style thickness")
  (setq t1 (getkword "\n>>block name/color/entity/layer/ltype/style/thickness: "))
  (setq t2
     (cond
        ((eq t1 "block")      2)   ((eq t1 "color")     62)
        ((eq t1 "entity")     0)   ((eq t1 "layer")      8)
        ((eq t1 "ltype")      6)   ((eq t1 "style")      7)
        ((eq t1 "thickness") 39)))
  (initget 1)
  (setq t3
     (cond
        ((= t2  2)  (getstring "\n>>block name: "))
        ((= t2 62)  (initget "?")
                    (while
                       (or (eq (setq t3 (getint "\n>>color number/<?>: ")) "?")
                           (null t3)
                           (> t3 256)
                           (< t3 0))
                           (textscr)
          (princ "\n                                                     ")
          (princ "\n                 color number   |   standard meaning ")
          (princ "\n                ________________|____________________")
          (princ "\n                                |                    ")
          (princ "\n                       0        |      <byblock>     ")
          (princ "\n                       1        |      red           ")
          (princ "\n                       2        |      yellow        ")
          (princ "\n                       3        |      green         ")
          (princ "\n                       4        |      cyan          ")
          (princ "\n                       5        |      blue          ")
          (princ "\n                       6        |      magenta       ")
          (princ "\n                       7        |      white         ")
          (princ "\n                    8...255     |      -varies-      ")
          (princ "\n                      256       |      <bylayer>     ")
          (princ "\n                                               \n\n\n")
                          (initget "?")) t3)
        ((= t2  0)  (getstring "\n>>entity type: "))
        ((= t2  8)  (getstring "\n>>layer name: "))
        ((= t2  6)  (getstring "\n>>linetype name: "))
        ((= t2  7)  (getstring "\n>>text style name: "))
        ((= t2 39)  (getreal   "\n>>thickness: "))
        (t          nil)))
  (if t3 (setq f1 (cons (cons t2 t3) f1)))
)
(setq f2 (ssget "x" (eval f2)))
(if (and f1 f2) f2 (progn (princ "\n0 found.") (prin1)))
);lambda
);setq function
