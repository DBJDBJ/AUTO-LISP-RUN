; sp3tof.lsp dbj created
; convert closed pline into set of triangles and/or quad's
; 01.09.91 DBJ created
; 26.09.91 DBJ recursive version
(setq function
(lambda ( xmin )
       (setq trian '() quad '() ) ; global resulting lists  
       (call '("tri/sp3" vlst10 xmin))
) ; sp3tof
)
