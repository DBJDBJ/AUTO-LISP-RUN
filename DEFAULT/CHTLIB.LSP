; chtlib.lsp
; library functions for cht.lsp
(load (strcat envpath "lib/txt/cht_ve"))
(load (strcat envpath "lib/txt/cht_ol"))
(load (strcat envpath "lib/txt/cht_ue"))
(load (strcat envpath "lib/txt/cht_le"))
(load (strcat envpath "lib/txt/cht_je"))
(load (strcat envpath "lib/txt/justpt"))
(load (strcat envpath "lib/txt/justpn"))
(load (strcat envpath "lib/txt/cht_te"))
(load (strcat envpath "lib/txt/cht_pe"))
(load (strcat envpath "lib/txt/cht_pa"))
(load (strcat envpath "lib/txt/cht_p1"))
(load (strcat envpath "lib/txt/cht_sp"))
(load (strcat envpath "lib/txt/cht_pl"))
(load (strcat envpath "lib/txt/cht_pi"))
(load (strcat envpath "lib/txt/cht_ps"))
  ;;
  ;; internal error handler defined locally
  ;;
  (defun cht_er (s)                   ; if an error (such as ctrl-c) occurs
                                      ; while this command is active...
    (if (/= s "function cancelled")
      (if (= s "quit / exit abort")
        (princ)
        (princ (strcat "\nerror: " s))
      )
    )
    (eval(read u:e))
    (if cht_oe                        ; if an old error routine exists
      (setq *error* cht_oe)           ; then, reset it 
    )
    (if cht_oc (setvar "cmdecho" cht_oc)) ; reset command echoing
    (if cht_ot (setvar "texteval" cht_ot)) 
    (setvar "highlight" 1)
    (princ)
  ) ; eofun cht_er

