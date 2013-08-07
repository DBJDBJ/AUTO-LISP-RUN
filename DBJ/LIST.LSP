;
; list.lsp dbj 20.05.92 created
; lists processing
(setq function
   (lambda ()
	(setq *error* runerr)
	(defun ldif ( l1 l2 / dif e1 e2 ) ; 2 lists diference
	  (setq dif '())
	  (foreach e1 l1 (if (= nil (member e1 l2))
	                     (setq dif (cons e1 dif ))
                         )
          )
	  (foreach e2 l2 (if (= nil (member e2 l1))
	                     (setq dif (cons e2 dif ))
                         )
          )
	  (reverse dif) ; return in original order
	) ; ldif
	(defun lcom ( l1 l2 / com e1 e2 ) ; 2 lists commons
	  (setq com '())
	  (foreach e1 l1 (if (member e1 l2)
	                     (setq com (cons e1 com ))
                         )
          )
	  (reverse com) ; return in original order
	) ; lcom
;
; main
;
(textscr)
(setq l1 '("A" "B" "C" "D") l2 '("C" "D" "E" "F"))
         (prompt "\nList1      : ")(prin1 l1 )
         (prompt "\nList2      : ")(prin1 l2 )
         (prompt "\nDifference : ")(prin1 (ldif l1 l2))
         (prompt "\nCommons    : ")(prin1 (lcom l1 l2))
   ) ; lambda 
) ; function
