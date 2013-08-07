;
; pen.lsp process entity by dbj 11.03.92 created
; process set of entities through string of modifying actions and do
; this N times
; Copy Move Rotate are supported actions in V1.0
;
(setq function
(lambda ( / s2c aw an al dl cl letters digits version debug 
            getword enty do_data_list do_action )
;..............................................................
; string to list of char's by DBJ
(defun s2c (pos s)
  (cond ((<= pos (strlen s)) (s2c (1+ pos) s) 
        (setq cl (cons (substr s pos 1) cl)))
      (T (setq cl '()))
   );cond
);s2c
;..............................................................
; return word of specific content and specific length or nil
(defun getword ( msg allowed alength / rezult ast getchr )
;..............................................................
(defun getchr ( / a kiki ) (setq a '(kiki 0))
(while (/= (car a) 2) (setq a (grread)))
(if (and (> (last a) 32)(< (last a) 127))
    (chr (last a)) ; return printable ascii character
    nil            ; or nil
))                 ; getchr
;
(setq ast T  rezult "")  
    (while (and (/= ast nil) (< (strlen rezult) alength ))
      (prompt (strcat "\r" msg rezult)) (setq ast (getchr))
      (if (/= ast nil) 
          (if (member ast allowed)
	      (setq rezult (strcat rezult ast))
	      (progn (prompt (strcat "\r" msg rezult "?" )) (getchr))
	  );if
      );if
    ) ; while
 rezult
); getword
;..............................................................
; process the action list
;..............................................................
(defun do_action (enty; selection to be processed
                   al ; action list ([integer] action [action] [action])
                   dl ; data list            ( list   [list  ] [list  ])
           ; moveBase ; if T then c & m will move base for r & s
                    / ntimes i cmd par loop )
(if (= 'INT (type (car al))) (setq ntimes (car al) al (cdr al))
	                     (setq ntimes 1)
);if
(setq loop 0 *error* runerr ) ; only for user info
(repeat ntimes
(setq i 0 loop (1+ loop) )
(foreach cmd al
(setq par (nth i dl) i (1+ i)) ; get param's from the list
 (cond ((= T debug)
   (prompt (strcat "\nCommand: " cmd " & two param's: "))
   (princ (car par))(princ " ")(princ (cadr par))
   (getstring "\nReturn...")))
   (if (member cmd '("C" "R" "M" "S")) ; input is asked
        (setvar "cmdecho" 1)
	(setvar "cmdecho" 0)
   );if
 (grtext -1 
   (strcat "Repetition: "(itoa loop)" of: " (itoa ntimes))
 )
(cond
    ( (= "S" cmd)
      (command ".scale"  enty "" pause pause))
    ( (= "C" cmd) 
      (command ".copy"   enty "" pause pause))
    ( (= "R" cmd) 
      (command ".rotate" enty "" pause pause))
    ( (= "M" cmd) 
      (command ".move"   enty "" pause pause))
    ; data list using
    ( (= "c" cmd) (command ".copy"   enty "" (car par)(cadr par)))
    ( (= "m" cmd) (command ".move"   enty "" (car par)(cadr par)))
    ( (= "r" cmd) (command ".rotate" enty "" (car par)(cadr par)))
    ( (= "s" cmd) (command ".scale"  enty "" (car par)(cadr par)))
    ( T (prompt "\nDon't know this command:")(princ cmd))
);cond
  (if (= "C" (strcase cmd)) (setq enty (entlast)));if
  (if (and (= moveBase T) (member cmd '("c" "m")))
      (setq basePoint (pointN (car par) (cadr par) loop))
  );if
);foreach
);repeat ntimes
(setvar "cmdecho" 0)
enty ; return
);do_action
;..............................................................
; process the data list for a given action list
; every action will have specific list of input parameters or  
; empty list if if it is typed in capital letter, which is the
; users signal to be asked every time for the input for that action 
;
(defun do_data_list
                 ( al ; action list ([integer] action [action] [action])
                 / cmd 
		    pl; param's list for one action 
                 p1 p2 rtd i)  
; 
(defun rtd (a) (/ (* a 180.0) pi))    ; radians to degrees
;
(if (= 'INT (type (car al))) (setq al (cdr al)));if
(setq i 0 dl '() *error* runerr )
(foreach cmd al 
(setq pl '() p1 nil p2 nil )
(cond
( (= "S" cmd)) 
( (= "C" cmd)) 
( (= "R" cmd))
( (= "M" cmd))
( (= "s" cmd) (prompt "\nALWAYS scale: ")
                (while (or (= nil p1) (= nil p2))
                    (setq p1 (getpoint "\nBase point : "))
		    (if p1 (setq p2 (getreal "\nScale factor: ")))
		) ; while 
    (setq pl (list p1 p2))
) 
( (= "c" cmd) (prompt "\nALWAYS copy: ")
                (while (or (= nil p1) (= nil p2))
                    (setq p1 (getpoint "\nFrom: "))
		    (if p1 (setq p2 (getpoint p1 "\nTo: ")))
		) ; while 
    (setq pl (list p1 p2))
) 
( (= "r" cmd) (prompt "\nALWAYS rotate: ")
                (while (or (= nil p1) (= nil p2))
                    (setq p1 (getpoint "\nArround which point: "))
		    (if p1 (setq p2 (getangle p1 "\nFor what angle: ")))
		) ; while 
    (setq pl (list p1 (rtd p2)))
) 
( (= "m" cmd) (prompt "\nALWAYS move: ")
                (while (or (= nil p1) (= nil p2))
                    (setq p1 (getpoint "\nFrom: "))
		    (if p1 (setq p2 (getpoint p1 "\nTo: ")))
		) ; while 
    (setq pl (list p1 p2))
) 
(T (prompt "\nDon't know this command:")(princ cmd))
);cond
(setq dl (cons pl dl)) ; update data list for this action
); foreach
(reverse dl) ; return data list
);do_data_list
;..............................................................
;
; pen begin
;
(prompt (strcat "\nProcess ENtity V1.0" ))
(prompt "\nRotate-Copy-Move-Scale-Number of times\n")
(setq   debug nil  *error* runerr
  letters '("C" "c" "M" "m" "R" "r" "S" "s")    ; legal things for input
  digits  '( "0" "1" "2" "3" "4" "5" "6" "7" "8" "9")
  version "1.0" 
       aw (getword "RrCcMmSs:" letters             4);  4 action letters
       an (getword (strcat "Number : " aw) digits  2);+ 2 digit number
)  
(prompt (strcat "\rNumber : " aw an));keep it on the screen
      (cond 
        ( (/= aw "")
	  (setq aw (s2c 1 aw) an (atoi an))
		(if (> an 1) (setq al (cons an aw))
		             (setq al aw)
                )
	  (if debug (progn (prompt "\nACTION list: ")(princ al)))
	  (setq enty (entsel "\nSelect entity: "))
	  (cond 
	    ( (/= enty nil)
	         (redraw (car enty) 3)
	         (setq dl (do_data_list al))
	             (cond ((= T debug)
	                   (prompt "\nDATA list: ")(princ dl)
	                   (getstring "\nReturn ..."))
		     )
	         (setq enty (do_action enty al dl ))
	         (command ".redraw" )
            )(T (prompt "\nNothing selected ..."))
          ) ; cond
	)
	(T (prompt "\nNo process ..."))
      );cond
) ; lambda
) ; function
