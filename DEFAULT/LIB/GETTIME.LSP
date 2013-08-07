;gettime.lsp
;Subroutine to extract the time from the system
(setq function
(lambda ( / ctime minute hour second )
   (setq ctime (rtos (getvar "cdate") 2 6)
         minute (atoi (substr ctime 12 2))
         hour (atoi (substr ctime 10 2))
         second (atoi (substr ctime 14 2))
   )
         (strcat  (itoa hour) ":" (itoa minute) ":" (itoa second))
);close lambda
); close function 
