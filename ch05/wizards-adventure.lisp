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
