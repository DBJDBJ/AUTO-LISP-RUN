; dimset.lsp DBj created 1991
;
(setq function
(lambda ( s )
        (setvar "cmdecho" 0)
        (command "dim" "dimblk" "dot" "exit")
;................... dim vars for 1:50 * crnt scale ......................
        (setvar "dimscale" 1 )        ;
        (setvar "dimtsz" 0 )          ; no ticks please !
        (setvar "dimasz" (* s  50.0)) ; dot size in drawing units
        (setvar "dimtxt" (* s 100.0)) ; text height
        (setvar "dimcen" (* s 100.0)) ; center marker for radius etc.
        (setvar "pdsize" (* s 100.0)) ; size of point entity
        (setvar "pdmode" 3)           ; shape of point entity { 3='x' }
        (setvar "dimtvp" 1 )          ; from text to dim lin.
        (setvar "dimexo" (* s  10.0)) ; from end of ext. line to object
        (setvar "dimaso"   1)         ; assoc. dimens. on
        (setvar "dimse1"   0)         ; left ext. line on
        (setvar "dimse2"   0)         ; rigt ext. line on
        (setvar "dimtix"   1)         ; text allways in
        (setvar "dimtih"   0)         ; allways horiz text off
        (setvar "dimrnd"   1)         ; round to 0 or 1
        (setvar "dimzin"  12)         ; no leading or trailing zeros !
        (princ)
) ; eof dimset lambda
);setq
