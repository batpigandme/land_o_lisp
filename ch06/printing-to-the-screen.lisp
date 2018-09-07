;; the print function
(print "foo")

;; print vs prin1
(progn (print "this")  ; each gets a new line
        (print "is")
        (print "a")
        (print "test"))
        
(progn (prin1 "this")  ; all on the same line
        (prin1 "is")
        (prin1 "a")
        (prin1 "test"))