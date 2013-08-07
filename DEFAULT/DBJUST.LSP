;
; dbjust.lsp dbj 27.02.90 createdv for V10 text ent's
;
;(defun c:dbjust (/ olderr j e p11 p10 f en p11n p10n fn y )
(setq function
(lambda ()
        (setq *error* runerr )
        (setvar "cmdecho" 0)
        (prompt "\ntext justification by dbj")
        (setq j (strcase (getstring "\nleft/center/middle/right "))
              e (entget (car (entsel)))
            p11 (assoc 11 e)
            p10 (assoc 10 e)
              f (assoc 72 e)
             en e
        )
        (if (= (cdr f) 0) (setq p11n (cons 11 (cdr p10))))
        (if (= (cdr f) 0) (setq en (subst p11n p11 en )))
        (if (and (= j "l")(/= (cdr f) 0))
            (progn (setq p10n (cons 10 (cdr p11)))
                   (setq   en (subst p10n p10 en))
            )
        );if
        (if (= j "l")(setq fn 0))
        (if (= j "c")(setq fn 1))
        (if (= j "m")(setq fn 4))
        (if (= j "r")(setq fn 2))
        (setq fn (cons 72 fn)
              en (subst fn f en))
        (entmod en)
        (setq y (strcase (getstring "\ncorrect <y> ")))
        (if (= y "n")(entmod e))
        (setq *error* olderr)
        (princ)
);lambda
);setq function
