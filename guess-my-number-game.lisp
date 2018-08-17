;;; Define big and small variables
(defparameter *small* 1)
(defparameter *big* 100)

;;; Define the guess-my-number function
(defun guess-my-number ()
    (ash (+ *small* *big*) -1))

;;; Define the smaller and bigger functions
(defun smaller ()
    (setf *big* (1- (guess-my-number)))
    (guess-my-number))

(defun bigger ()
    (setf *small* (1+ (guess-my-number)))
    (guess-my-number))

;;; Define the start-over function
(defun start-over ()
    (defparameter *small* 1)
    (defparameter *big* 100)
    (guess-my-number))
