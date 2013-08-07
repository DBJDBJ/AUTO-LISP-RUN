; enter.lsp DBJ created 27.05.92
(setq function 
(lambda ( / oldlay eyedata dvb height lens ss)
(prompt "\nDBJ EYE V2.0 system, please wait ...")
(setvar "cmdecho" 0)
(setvar "regenmode" 1)
(if (= 0 (getvar "worlducs")) (command ".ucs" "w"))
(if (= 0 (getvar "tilemode")) (command ".mspace"))
(setq oldlay (getvar "clayer"))
(if (= "EYE" oldlay)(setq oldlay "0"))
(runcall '("dbj/layon" "eye")) ; force layer "eye" and set it
(setq eyedata (run::calluser '("lib/blk" "eyedata")))
(setq     dvb (run::calluser '("lib/blk" "dviewblock")))
  (cond
    ((and (= nil eyedata) (/= nil (ssget "x" (list(cons 2 "eye"))))) 
    (textscr)
     (prompt "\nOld type EYE block's are found,they will be erased")
      (command ".erase" (ssget "x" (list(cons 8 "eye"))) "");erasing
     (prompt "\nPlease re-enter this drawing and purge block: EYE")
     (prompt "\nBefore starting EYE application again ...        ")
    )
    ((= nil eyedata) 
      (if (/= nil dvb) (command ".erase" dvb ""))
      (command ".insert" (strcat envpath "dwg\\dviewbl") "0,0,0" 1 1 0 )
      (command ".rename" "block" "dviewbl" "dviewblock")
      (command ".insert" (strcat envpath "dwg\\eyedata") "0,0,0" 1 1 0 )
      (setq eyedata (run::calluser '("lib/blk" "eyedata")))
      (textscr)
      (prompt "\nYou are using EYE V2.0 in this drawing first time")
      (prompt "\nEye-Target pairs inserted will use some default values")
      (prompt "\nYou can change now, or use this values for every Eye-Target")
      (prompt "\nin this drawing; just hit RETURN if you will use defaults :")
      (setq height (getreal (strcat "\nType new height or use " 
                               (run::calluser "lib/defhgt") " : " ))
            height (if (= nil height) (run::calluser "lib/defhgt")(rtos height))
            lens   (getreal (strcat "\nType new lens length or use " 
                               (run::calluser "lib/deflens") " : " ))
            lens   (if (= nil lens  ) (run::calluser "lib/deflens")(rtos lens))
     )
      (prompt "\nUpdating EYE-TARGET database, please wait ...")
      (run::calluser '("lib/updeyeda" eyedata "" "" "" height lens ))
    )
  );cond
(setvar "pdsize" (/ (distance (getvar "extmax")(getvar "extmin")) 100))
(setvar "pdmode" 3) 
(setq  *error* runerr)  (setvar "cmdecho" 0) (setvar "attdia"  0)
(if (/= 0 (getvar "viewmode"))(command ".plan" ""))
oldlay ; return
))
