;;
;;  Author   : PJK
;;  Function :
;;  Synopsys :
;;  
;;  Date     :
;;  Mods :-

(setq function
(lambda ( data filename /  )
 (setq ysize ( length data))
 (if (and (/= ysize 16)(/= ysize 64)(/= ysize 144)(/= ysize 256))
  (progn
   (princ "incorrect grid size : y dir")
   (exit)
  )
 )

 (if (= ysize 256 ) (setq cols 4))
 (if (= ysize 144) (setq cols 3))
 (if (= ysize 64 ) (setq cols 2))
 (if (= ysize 16 ) (setq cols 1))


 ; check xgrid setting
 (if (/= (setq xsize (length (car data))) 16)
  (progn
   (princ "icon has wrong number of bits ")
   (exit)
  )
 )

 ; open the called file
 (setq fp (open filename "w"))
 (if (= fp nil)
  (progn
   (princ (strcat "could not open file " filename))
   (exit)
  )
 )

 ; write the header to the file
 (setq line (strcat "/* Format_version=1, Width=" (itoa (* cols 16)) ", Height="
             (itoa(* cols 16)) ", Depth=1, Valid_bits_per_item=16"))
 (write-line line fp)
 (write-line "*/" fp)

 ; process each set of pixels
 (setq line "\t")
 (setq colnum 1)
 (foreach pixset data
  (setq hexnum "")
  (setq bitval 8 )
  (setq hex 0)
  (foreach bit pixset
   (setq hex (+ hex (* bit bitval)))
   (if (= bitval 1)
    (progn
     (setq bitval 8)
     (if (< hex 10)
      (setq hex (itoa hex))
      (setq hex (chr (+ hex 55)))
     )
     (setq hexnum (strcat hexnum hex ))
     (setq hex 0)
    )
    (setq bitval (/ bitval 2))
   )
  ) ; foreach bit

  (setq line (strcat line "0x" hexnum ","))

  ; If end of colum line
  (if (= colnum cols)
   (progn
    (write-line line fp)
    (setq line "\t")
    (setq colnum 1)
   )
   (setq colnum (1+ colnum))
  )
 ) ; foreach pixset
       

 ; close open file
 (close fp)

 (princ)
) ; lambda
) ; setq function
