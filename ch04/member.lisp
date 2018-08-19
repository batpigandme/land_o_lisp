(if (member 1 '(3 4 1 5))
    'one-is-in-the-list
    'one-is-not-in-the-list)

;; returns tail of calculation
(member 1 '(3 4 1 5))

;; why member doesn't return found value
(if (member nil '(3 4 nil 5))
    'nil-is-in-the-list
    'nil-is-not-in-the-list)