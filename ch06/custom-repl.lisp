;; setting up a custom REPL
(defun game-repl ()
    (loop (print (eval (read)))))  ; reads a command, evals, then prints
;; enter game-repl with (game-repl)    
;; hit ctrl-C and type :a to exist infinite loop

;; redefine game-repl with better exit
(defun game-repl ()
    (let ((cmd (game-read)))                ; capture command typed using local var, cmd
        (unless (eq (car cmd) 'quit)        ; continue running unless user types quit
            (game-print (game-eval cmd))    ; otherwise function evals and prints
            (game-repl))))                  ; loops back until quit

;; defune custom read fynctuinm game-read
(defun game-read ()
    (let ((cmd (read-from-string
                    (concatenate 'string "(" (read-line) ")"))))
        (flet ((quote-it (x)
                    (list 'quote x)))
            (cons (car cmd) (mapcar #'quote-it (cdr cmd))))))

;; defun game eval