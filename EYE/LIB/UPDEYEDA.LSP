; updeyeda.lsp dbj created 22.05.92
; update all atributes in block eyedata
; if new data is null string do nothing
(setq function
  (lambda  ( eyeblk lasteye lastarget lastvisit defhgt deflens )
  (if (/= 0 (ascii deflens))
      (run::calluser '("lib/attupd" eyeblk "deflens" deflens)))
  (if (/= 0 (ascii defhgt))
      (run::calluser '("lib/attupd" eyeblk "defhgt" defhgt)))
  (if (/= 0 (ascii lastvisit))
      (run::calluser '("lib/attupd" eyeblk "lastvisit" lastvisit)))
  (if (/= 0 (ascii lastarget))
      (run::calluser '("lib/attupd" eyeblk "lastarget" lastarget)))
  (if (/= 0 (ascii lasteye))
      (run::calluser '("lib/attupd" eyeblk "lasteye" lasteye)))
));function
