;; alist defining nodes
(defparameter *nodes* '((living-room (you are in the living-room.
                            a wizard is snoring loudly on the couch.))
                        (garden (you are in a beautiful garden.
                            there is a well in front of you.))
                        (attic (you are in the attic.
                            there is a giant welding torch in the corner.))))

(assoc 'garden *nodes*)

;; describe-location function
(defun describe-location (location nodes)
    (cadr (assoc location nodes)))

(describe-location 'living-room *nodes*)

;; describing the paths
(defparameter *edges* '((living-room (garden west door)
                                    (attic upstairs ladder))
                        (garden (living-room east door))
                        (attic (living-room downstairs ladder))))

;; describe path singular
(defun describe-path (edge)
    `(there is a ,(caddr edge) going ,(cadr edge) from here.))

(describe-path '(garden west door))

;; describe paths plural
(defun describe-paths (location edges)
    (apply #'append (mapcar #'describe-path (cdr (assoc location edges)))))

(describe-paths 'living-room *edges*)

;; finding the relevant edges
(cdr (assoc 'living-room *edges*))

;; converting the edges to descriptions
(mapcar #'describe-path '((GARDEN WEST DOOR) (ATTIC UPSTAIRS LADDER)))

;; listing visible objects
(defparameter *objects* '(whiskey bucket frog chain))

;; add object-location alist
(defparameter *object-locations* '((whiskey living-room)
                                    (bucket living-room)
                                    (chain garden)
                                    (frog garden)))

;; function listing objects at a location
(defun objects-at (loc objs obj-locs)
    (labels ((at-loc-p (obj)
            (eq (cadr (assoc obj obj-locs)) loc)))
    (remove-if-not #'at-loc-p objs)))

(objects-at 'living-room *objects* *object-locations*)

;; describing visible objects
(defun describe-objects (loc objs obj-loc)
    (labels ((describe-obj (obj)
                `(you see a ,obj on the floor.)))
        (apply #'append (mapcar #'describe-obj (objects-at loc objs obj-loc)))))

(describe-objects 'living-room *objects* *object-locations*)

;; variable to track player's current position
;; initialised to living room, where players begin
(defparameter *location* 'living-room)

;; look function to call all of our descriptor functions
;; uses global variable names, not FP style
(defun look ()
    (append (describe-location *location* *nodes*)
            (describe-paths *location* *edges*)
            (describe-objects *location* *objects* *object-locations*)))

(look)

;; walk function take direction and lets us walk there
;; if function checks to see if next variable is nil
;; look retrieves description of new locaiton
(defun walk (direction)
    (let ((next (find direction
                    (cdr (assoc *location* *edges*))
                    :key #'cadr)))
    (if next
        (progn (setf *location* (car next))
                (look))
        '(you cannot got that way.))))

(walk 'west)

;; command to pick up objects
;; uses member function to see if object present
;; if object at current loc push new item to object-locations list
(defun pickup (object)
    (cond ((member object
                    (objects-at *location* *objects* *object-locations*))
            (push (list object 'body) *object-locations*)
            `(you are now carrying the ,object))
        (t '(you cannot get that.))))

(walk 'east)
(pickup 'whiskey)

;; create function that lets players see inventory of carried objs
(defun inventory ()
    (cons 'items- (objects-at 'body *objects* *object-locations*)))

(inventory)
