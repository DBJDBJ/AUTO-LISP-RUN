; drawpoly.lsp dbj created
; draw the poly list with (grDraw ...)
(setq function
(lambda ( poly to col / v c)
  (setq c 0 v c)
  (repeat to
        (setq c (call '("tri/1from" c poly)))
        (grdraw (nth v poly)(nth c poly) col)
        (setq v c)
  );repeat
        (grdraw (nth v poly)(nth 0 poly) col)
));drawPoly
