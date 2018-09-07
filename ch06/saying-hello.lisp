;; say-hello function to call from Lisp prompt
(defun say-hello ()
    (print "Please type your name:")  ; print message asking for name
    (let ((name (read)))              ; define local var name set to value returned by read function
        (print "Nice to meet you, ")  ; prints after user enters name
        (print name)))                ; prints read name with above

;; note: every value displayed and entered surrounded by quotation marks
(say-hello)