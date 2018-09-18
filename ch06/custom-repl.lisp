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
;; only alow certain parameters
(defparameter *allowed-commands* '(look walk pickup inventory))

(defun game-eval (sexp)
        (if (member (car sexp) *allowed-commands*)  ; checks if first word is allowed-command
            (eval sexp)                             ; use standard evaluation to execute command
            '(i do not know that command.)))

;; defun a game-print function allowing lowers and uppers
(defun tweak-text (lst caps lit)                                              ; looks at each character in list and modifies it
    (when lst
        (let ((item (car lst))                                                ; local variable item
            (rest (cdr lst)))                                                 ; local variable rest
        (cond ((eq item #\space) (cons item (tweak-text rest caps lit)))      ; check character at top of list for conditions
              ((member item '(#\! #\? #\.)) (cons item (tweak-text rest t lit)))
              ((eq item #\") (tweak-text rest caps (not lit)))                ; check for quotation mark, fallback for exceptional text
              (lit (cons item (tweak-text rest nil lit)))
              ((or caps lit) (cons (char-upcase item) (tweak-text rest nil lit)))
              (t (cons (char-downcase item) (tweak-text rest nil nil)))))))
(defun game-print (lst)
    (princ (coerce (tweak-text (coerce (string-trim "() "                   ; converts the string to a list of characters
                                                    (prin1-to-string lst))  ; converts the symbol list into a string
                                    'list)
                            t                                               ; args indented as they belong to tweak-text
                                nil)
                    'string))
(fresh-line))