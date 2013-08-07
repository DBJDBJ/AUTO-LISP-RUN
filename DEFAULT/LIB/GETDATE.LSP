;getdate.lsp
;Subroutine to extract date from the system
(setq function
(lambda ( / cdate year month day )
   (setq cdate (rtos (getvar "cdate") 2 0)
         year (atoi (substr cdate 1 4))
         month (atoi (substr cdate 5 2))
         day (atoi (substr cdate 7 2))
   )
         (strcat  (itoa day) "/" (itoa month) "/" (itoa year))
);close lambda 
);close setq
