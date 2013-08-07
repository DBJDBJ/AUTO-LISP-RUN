; update external block
; 20/08/91 dbj
(setq function
(lambda ( extnam memnam )
              (command "insert" (strcat memnam "=" extnam))
              (command)
);updblk
);function
