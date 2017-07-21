; model the eigenmodes in a 2D square cavity

(set! geometry-lattice (make lattice (size 1.0 1.0 no-size)))

(set! geometry (list
		(make block (center 0 0 0) (size 1 1 no-size) (material air))
))

(set-param! resolution 100)

(define-param fcen 1) ; pulse center frequency
(define-param df 2)  ; pulse width (in frequency)

(set! sources (list
               (make source
                 (src (make gaussian-src (frequency fcen) (fwidth df)))
                 (component Ex) (center 0.25 0.25) )));

(run-sources+ 2000 
	(at-beginning output-epsilon)
	(after-sources (harminv Ex (vector3 0.25 0.25) fcen df)))

(run-until (/ 1 fcen) (at-every (/ 1 fcen 20) output-efield-x))
