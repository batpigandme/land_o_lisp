;; say-hello function to call from Lisp prompt
(defun say-hello ()
    (print "Please type your name:")  ; print message asking for name
    (let ((name (read)))              ; define local var name set to value returned by read function
        (print "Nice to meet you, ")  ; prints after user enters name
        (print name)))                ; prints read name with above

;; note: every value displayed and entered surrounded by quotation marks
(say-hello)

;; use princ for humans
(princ '3)
;; can have arbitrary bits of text, unlike print
(progn (princ "This sentence will be interrupted")
        (princ #\newline)
        (princ "by an annoying newline character."))

;; define saying hello without ugly quotes
(defun say-hello ()
    (princ "Please type your name:")
    (let ((name (read-line)))           ; read-line captures all text until enter key pressed
        (princ "Nice to meet you, ")
        (princ name)))

;; note with read-line you can enter any name w/ spaces, etc.