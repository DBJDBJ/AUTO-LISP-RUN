(defun c:markList (/ i vLST)
   (setq vlst vlst10)
   (setq i 0) ; <-- count from 0 as (NTH ...) function does !
   (while vLST
      (ptext (car vLST) (itoa i))
      (setq i (1+ i) vLST (cdr vLST))
   );while
);mark_vList
;
