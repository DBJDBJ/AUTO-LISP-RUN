;---------------------------------------------------------------------
; dbjswap.lsp 12.03.91 dbj created
; swap entity sets
;
(setq function
(lambda ( / p1 p2 s1 s2 )
        (setq *error* runerr)
        (prompt "\ndbj*swap entities ")
        (prompt "\nfirst group ")(setq s1 (ssget))
        (prompt "\nsecond group ")(setq s2 (ssget) p1 (getpoint "\nfrom :")
              p2 (getpoint p1 "  to   :"))
        (command "move" s1 "" p1 p2)
        (command "move" s2 "" p2 p1)
        (setq s1 nil s2 nil)
) ; lambda swap
);setq function
