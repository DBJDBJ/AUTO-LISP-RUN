; make3or4.lsp dbj created
; make FSET sset from triangles and quad's GLOBAL lists trian & quad
(setq function
(lambda ( / elm wcs ucs)
(setq fset (ssadd) wcs 0 ucs 1)
; make triangles
        (while trian
                (setq elm (car trian) trian (cdr trian))
                (command "3dface"
                        (trans (car elm)  ucs wcs)
			(trans (cadr elm) ucs wcs)
			(trans (last elm) ucs wcs)
                        ""
                        ""
                );command
                (setq fset (ssadd (entlast) fset))
        );while
; make quadrilaterals
       (while quad
         (setq elm (car quad) quad (cdr quad))
                (command "3dface"
                        (trans (car   elm) ucs wcs)
			(trans (cadr  elm) ucs wcs)
			(trans (caddr elm) ucs wcs)
			(trans (last  elm) ucs wcs)
                        ""
                );command
                (setq fset (ssadd (entlast) fset))
        );while
fset ; return
)) ; make3or4
