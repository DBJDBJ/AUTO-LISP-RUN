;
; list.lsp dbj 20.05.92 created
; lists processing
(setq function
   (lambda ()
	(setq *error* runerr)
	(defun ldif ( l1 l2 / dif e1 e2 ) ; 2 lists diference
	  (setq dif '())
	  (foreach e1 l1 (if (= nil (member e1 dif))
	                     (setq dif (append dif '(e1)) )
                         )
          )
	) ; ldif
   ) ; lambda 
) ; function
