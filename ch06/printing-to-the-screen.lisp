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

;; read and print a number
(defun add-five ()
        (print "please enter a number:")
        (let ((num (read)))
                (print "When I add five I get")
                (print (+ num 5))))
(add-five)

;; printing values
(print '3)      ; an integer
(print '3.4)    ; a float
(print 'foo)    ; a symbol
(print '"foo")  ; a string
(print '#\a)    ; a character

;; add vertical pipe for case sensitivity
(print '|CaseSensitiveSymbol|)