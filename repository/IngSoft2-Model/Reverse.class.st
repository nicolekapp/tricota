Class {
	#name : #Reverse,
	#superclass : #TypeOfCard,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #playing }
Reverse >> applyWithin: aCollection knowing: aCollection2 the: aNoEffect and: anInteger of: game [ 
	game changeCourse.
]
