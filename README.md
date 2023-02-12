# Racket-project2
A train-line program in Dr racket


#lang racket/gui

(require (planet jphelps/guiml))

(define NorthernLine (list "Edgware" "Burnt Oak" "Colindale" "Hendon Central" "Brent Cross" "Golders Greens" "Hampstead" "Belsize Park" "Chalk Farm"))

(struct journey-info (station new-train next-station-time disability-friendly toilets))


 




;This is the first window that will be shown to the user once the program is run.


(define frame ( new frame%
                    (label "ROUTEMASTER")
                    (width 500)
                    (height 500)))
                    
                    
(send frame show #t)

(define text ( new message%
                   ( label "NORTHERN LINE")
                   (parent frame)
))



; An input in the form of a drop down box is given to the user to select their starting location and destination.


( define start (new choice%
                    (label " START ") (parent frame)
               (choices (list "Edgware" "Burnt Oak" "Colindale" "Hendon Central" "Brent Cross" "Golders Greens" "Hampstead" "Belsize Park" "Chalk Farm"))))
               
               
( define end ( new choice%
                   ( label " END ") (parent frame)
                   ( choices (list "Edgware" "Burnt Oak" "Colindale" "Hendon Central" "Brent Cross" "Golders Greens" "Hampstead" "Belsize Park" "Chalk Farm")
)))

                             
; This is the second window that will be shown to display the journey.


( define frame2 ( new frame%
                      (label "RESULTS")
                      (width 300)
                      (height 400)))



( define button ( new button% ( parent frame)
                      ( label "GO")
                      (min-width 10)
                      (min-height 10)
                      ( callback (λ( button event)
                                              (delete-children frame2) 

                                   ( send frame2 show #t) ;once the button is pressed, the second screen is displayed.
                                   (if (< (send start get-selection)(send end get-selection))
                                       (newMessages (routeFinder (send start get-string-selection) (send end get-string-selection) NorthernLine))
                                       (newMessages (routeFinder (send start get-string-selection) (send end get-string-selection) (reverse NorthernLine)))))))) ;The users inputs are taken from the input fields and put through the routeFinder function and then displayed on frame2.

; This function is used to display the route to frame2
(define newMessages (λ (x) 
                      (cond
                        ((empty? x) "") 
                        ((new message% 
                                 [parent frame2] 
                                 [label (first x)]) (newMessages (rest x)))))) 

; This function is used to find the route between our starting station to our destination station.
(define routeFinder (λ (f t l)
                      (cond
              ((reverse (member t (reverse (member f l))))))))
