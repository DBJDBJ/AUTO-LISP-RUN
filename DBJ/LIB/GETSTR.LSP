
;GETSTR.LSP 16.12.91 DBJ taken from shade.lsp and improved
;                   Since this is used only for object names, it limits
;                   the name length to 8 characters.
; Input:  a     - The prompt string
;         b     - The default string
;
(setq function
 (lambda ( a b / c d)
        (setq c nil d T)
;       Display default value, if necessary
        (cond
           ((null b)
              (setq a (strcat "\n" a ": ")))
           (T
              (setq a (strcat "\n" a " <" b ">: ")))
        )
        (while d
           (setq c (getstring a))
           (if (or (not (or (null c) (= c ""))) b)
              (setq d nil)
           )
        )
;       A null answer causes default to be returned
        (substr (if (= c "") b c) 1 8)
) ; eof lambda
) ; eof function
