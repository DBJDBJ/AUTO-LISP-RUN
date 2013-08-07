;ref.lsp
(setq function
(lambda ( )
   (setvar "lastpoint" (trans (getpoint "reference point: ") 0 1))
   (trans (getpoint "\nrelative/polar coordinates (with @): ") 0 1)
);lambda
);setq function
