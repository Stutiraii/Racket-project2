#lang racket/gui
(require (planet jphelps/guiml))

( define A (set "P" "I" "Z" "Z" "A"))
(define B ( set "B" "U" "R" "G" "E" "R"))
  ( define C (set "S" "U" "S" "H" "I"))
     (define D ( set " P" "E" "A" "R"))


( define food '( A B C D))
(define A1 '("A" "B" "C" "D" "E" "F" "G" "H" "I" "J"))
(define A2 '("K" "L" "M" "N" "O" "P" "Q" "R" "S" "T"))
(define A3 '("U" "V" "W" "X" "Y" "Z"))

(define score 0)

(define guesser (λ (s x)
                  (cond
                    ((> score 5) "game over")
                    ((set-member? s x) "yess")
                    ( #t (set! score (+ score 1) )))))


;;Window Setup
(define frame (new frame%
                    (label "Hangman")
                    (width 600)
                    (height 600)))



(define row1 ;In this row, it contains the Word.
  (new vertical-panel%
       [parent frame]
      ))

(define row2 ;In this row, it contains the Word Length, guesses and Words guessed.
  (new vertical-panel%
       [parent frame]
     ))

(define row3 ;In this row, it contains the Progress of the user.
  (new vertical-panel%
       [parent frame]
       [stretchable-height #f]))

(define row4 ;In this row, it contains the first 10 Letters of the alphabet.
  (new horizontal-panel%
       [parent frame]
       [stretchable-height #f]))

(define row5 ;In this row, it contains the next 10 Letters of the alphabet.
  (new horizontal-panel%
       [parent frame]
       [stretchable-height #f]))

(define row6 ;In this row, it contains the last few Letters of the alphabet.
  (new horizontal-panel%
       [parent frame]
       [stretchable-height #f]))




(send frame show #t) ;Shows constant message

( define panel ( new vertical-panel% (parent frame)))

(define title (new message%
                   (label "WELCOME TO THE GAME!")
                   (parent row1)
                   [vert-margin 60]
                   [horiz-margin 240]	
                   ))


(new editor-canvas%
     (parent row1)
     (label "WELCOME")
     (vert-margin 1)
     (horiz-margin 1)
     )
(define StartGame (new button%
                       [parent row2]
                       [label "Start Game"]
                       ; Callback procedure for a button click:
                       (callback (lambda (button event)
                                   (delete-children row1)
                                   (delete-children row2)
                                   (ButtonMakerRow4 A1)
                                   (ButtonMakerRow5 A2)
                                   (ButtonMakerRow6 A3)
                                   (Word)
                                   (WordLength)
                                   (GuessesLeft)
                                   (WrongGuesses)
                                   (Progress)
                                   ))))



;;Game interface
(define Word (λ ()
               (new message% ;;Displays the word
                  (label "-")
                  (parent row1))))

(define WordLength (λ ()
                     (new message%
                          (label "Word Length: ")
                          (parent row2))))

(define GuessesLeft (λ ()(new message%
                   (label "Guesses left: ")
                   (parent row2))))

(define WrongGuesses (λ ()(new message%
                   (label "Wrong Letters Guessed: ")
                   (parent row2))))

(define Progress (λ ()(new message% ;;Displays the progress of the user. When they win or lose, this message will be updated to "You win" or "You lose". 
                  (label "Make a Guess.")
                  (parent row3))))




(define ButtonMakerRow4 (λ (x) 
                      (cond 
                        ((empty? x) "") 
                        (#t (new button% 
                                 [parent row4] 
                                 [label (first x)]) (ButtonMakerRow4 (rest x))))))

(define ButtonMakerRow5 (λ (x) 
                      (cond 
                        ((empty? x) "") 
                        (#t (new button% 
                                 [parent row5] 
                                 [label (first x)]) (ButtonMakerRow5 (rest x))))))

(define ButtonMakerRow6 (λ (x) 
                      (cond 
                        ((empty? x) "") 
                        (#t (new button% 
                                 [parent row6] 
                                 [label (first x)]) (ButtonMakerRow6 (rest x))))))