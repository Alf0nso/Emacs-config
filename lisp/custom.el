;;; Emacs custom functions

;; Remove parentheses
(defun flatten (L)
  "Converts a list to single level."
  (if (null L)
      nil
    (if (atom (first L))
	(cons (first L) (flatten (rest L)))
      (append (flatten (first L)) (flatten (rest L))))))

;; Print text to source blocks in org mode
(defun org_babel_print (txt lsize)
  "printing text in a 
   source org buffer"
  (setq input (s-split " " txt))
  (print input))

;;(org_babel_print
;; "hey hey hey, this a test to
;;  see if works" 3)
