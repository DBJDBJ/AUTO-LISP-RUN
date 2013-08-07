;
; TIMEIT.LSP 18.04.92 DBJ created
;To start the program, type dbjTIME then enter a comment.
;The result of the test is added to the file TIMEIT.	
;The time placed in the file represents time to do a	
;13 ZOOM 5.123 , and why 5.123 is my secret ...
;									
(setq function (lambda ( / dbjtime )
(defun DBJTIME ()
    (setvar "cmdecho" 0)
    (prompt "\nTIME performance of display driver V1.0 by DBJ")
    (prompt "\n... be sure that dwg size iz more than 1 MB !")
    (setq cmnt (getstring T (strcat "\nComment: " (getvar "dwgname") " ")))
    (setq fd (open "timeit" "a"))
    (command "time" "reset" "on" "")

    (command "redraw") ; this will force every clever ADI to 
    (command "redraw") ; perform regen after first zoom
    (command "redraw")

    (prompt "\nZOOM ONE ...")
    (command ".zoom" "5.123")
    (setvar "userr1" (getvar "tdusrtimer"))
    (command ".zoom" "p")
    (setvar "userr2" (- (getvar "tdusrtimer") (getvar "userr1")))
    (setvar "userr3" (getvar "userr2"))

    (prompt "\nZOOM TWO ...")
    (command ".zoom" "5.123")
    (setvar "userr1" (getvar "tdusrtimer"))
    (command ".zoom" "p")
    (setvar "userr2" (- (getvar "tdusrtimer") (getvar "userr1")))
    (setvar "userr3" (+ (getvar "userr2") (getvar "userr3")))

    (prompt "\nZOOM THREE ...")
    (command ".zoom" "5.123")
    (setvar "userr1" (getvar "tdusrtimer"))
    (command ".zoom" "p")
    (setvar "userr2" (- (getvar "tdusrtimer") (getvar "userr1")))
    (setvar "userr3" (+ (getvar "userr2") (getvar "userr3")))

    (prompt "\nZOOM FOUR ...")
    (command ".zoom" "5.123")
    (setvar "userr1" (getvar "tdusrtimer"))
    (command ".zoom" "p")
    (setvar "userr2" (- (getvar "tdusrtimer") (getvar "userr1")))
    (setvar "userr3" (+ (getvar "userr2") (getvar "userr3")))

    (prompt "\nZOOM FIVE ...")
    (command ".zoom" "5.123")
    (setvar "userr1" (getvar "tdusrtimer"))
    (command ".zoom" "p")
    (setvar "userr2" (- (getvar "tdusrtimer") (getvar "userr1")))
    (setvar "userr3" (+ (getvar "userr2") (getvar "userr3")))

    (prompt "\nZOOM SIX  ...")
    (command ".zoom" "5.123")
    (setvar "userr1" (getvar "tdusrtimer"))
    (command ".zoom" "p")
    (setvar "userr2" (- (getvar "tdusrtimer") (getvar "userr1")))
    (setvar "userr3" (+ (getvar "userr2") (getvar "userr3")))

    (prompt "\nZOOM SEVEN...")
    (command ".zoom" "5.123")
    (setvar "userr1" (getvar "tdusrtimer"))
    (command ".zoom" "p")
    (setvar "userr2" (- (getvar "tdusrtimer") (getvar "userr1")))
    (setvar "userr3" (+ (getvar "userr2") (getvar "userr3")))

    (prompt "\nZOOM EIGHT...")
    (command ".zoom" "5.123")
    (setvar "userr1" (getvar "tdusrtimer"))
    (command ".zoom" "p")
    (setvar "userr2" (- (getvar "tdusrtimer") (getvar "userr1")))
    (setvar "userr3" (+ (getvar "userr2") (getvar "userr3")))

    (prompt "\nZOOM ELEVEN..")
    (command ".zoom" "5.123")
    (setvar "userr1" (getvar "tdusrtimer"))
    (command ".zoom" "p")
    (setvar "userr2" (- (getvar "tdusrtimer") (getvar "userr1")))
    (setvar "userr3" (+ (getvar "userr2") (getvar "userr3")))

    (prompt "\nZOOM THIRTEEN")
    (command ".zoom" "5.123")
    (setvar "userr1" (getvar "tdusrtimer"))
    (command ".zoom" "p")
    (setvar "userr2" (- (getvar "tdusrtimer") (getvar "userr1")))
    (setvar "userr3" (+ (getvar "userr2") (getvar "userr3")))

    (princ ( * 8640.0 (getvar "userr3")) fd) ; time in seconds
    (princ (strcat " - [" (getvar "dwgname") "] " cmnt) fd)
    (princ "\n" fd)
    (close fd)
    (command "resume")
    (prompt "\nTiming finished. Read the file 'timeit' for rezult ")
    (princ)
)
; lambda begin
(dbjtime)
(princ)
))
