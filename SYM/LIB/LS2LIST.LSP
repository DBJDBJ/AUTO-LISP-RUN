;
; ls2list.lsp put result of a ls in a list
; only file names are in , no path in front of them ...
; 07.02.92 DBJ created
;
(setq function
	(lambda ( wildcard / flist f line )
	(command ".shell" (strcat "ls -t " wildcard " > temp "))
        (setq f (open "temp" "r") flist '() line (read-line f)
	      line (call '("lib/rightcut" line "/")))
(if (= f nil)
    (prompt "\n Bad parameter to 'ls' command ...")
    (progn
        (while (/= nil line)
               (setq flist (append flist (list line))
                     line  (read-line f)
		     line  (if (/= nil line) (call '("lib/rightcut" line "/")))
		     )
        );while
        (command ".shell" "rm temp")
        flist ; return  
    );progn
); if
); lambda
); function
