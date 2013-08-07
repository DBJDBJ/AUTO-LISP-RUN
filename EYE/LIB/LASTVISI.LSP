; lastvisit.lsp dbj created 22.05.92
; needs block eyedata to work
(setq function
  (lambda ()
    (run::calluser '("lib/attval" 
              (run::calluser '("lib/blk" "eyedata"))
	      "lastvisit")
    )
  )
)
