Class {
	#name : #Skip,
	#superclass : #IstantTypeCard,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #playing }
Skip >> applyIn: game to: aTarget [  
	game applySkipCard.
	^self
]

{ #category : #playing }
Skip >> thrownBy: aPlayer inTheTurnOf: playerTurn [
	"This card can be played in any moment"
]
