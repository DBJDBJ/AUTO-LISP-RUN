; leave.lsp DBJ created 27.05.92
;
(setq function (lambda ( oldlay )
(run::call '("dbj/layon" oldlay)) 
(command ".layer" "f" "eye" "")
(prompt "\n'LAST' view saved ...")(princ)
))
