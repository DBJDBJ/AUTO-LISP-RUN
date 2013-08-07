; updeyeat.lsp dbj created 22.05.92
; update all atributes in block eye
; if null string sent do nothing
(setq function
  (lambda  ( eyeblk eyenumber targetnumber totarget lens clip )
(if (/= 0 (ascii eyenumber))
  (run::calluser '("lib/attupd" eyeblk "eyenumber" eyenumber)))
(if (/= 0 (ascii targetnumber))
  (run::calluser '("lib/attupd" eyeblk "targetnumber" targetnumber)))
(if (/= 0 (ascii totarget))
  (run::calluser '("lib/attupd" eyeblk "totarget" totarget)))
(if (/= 0 (ascii lens))
  (run::calluser '("lib/attupd" eyeblk "lens" lens)))
(if (/= 0 (ascii clip))
  (run::calluser '("lib/attupd" eyeblk "clip" clip)))
));function
