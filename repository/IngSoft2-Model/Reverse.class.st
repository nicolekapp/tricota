Class {
	#name : #Reverse,
	#superclass : #IstantTypeCard,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #playing }
Reverse >> applyIn: game to: aTarget [ 
	game applyReverseCard.
	^self
]

{ #category : #playing }
Reverse >> thrownBy: aPlayer inTheTurnOf: playerTurn [
	"This card can be played in any moment"
]
