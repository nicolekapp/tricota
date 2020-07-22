Class {
	#name : #Double,
	#superclass : #IstantTypeCard,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #playing }
Double >> applyIn: game to: noTarget [ 
	game applyDoubleCard.
	^self.
]

{ #category : #playing }
Double >> thrownBy: aPlayer inTheTurnOf: playerTurn [
	"This card can be played in any moment"
]
