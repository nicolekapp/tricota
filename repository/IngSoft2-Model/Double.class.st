Class {
	#name : #Double,
	#superclass : #TypeOfCard,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #initialization }
Double class >> initializeCard [
	^InstantCard type: self new.
]

{ #category : #initialization }
Double class >> initializeCardWithTarget: aTarget [
	^InstantCard type: self new target: aTarget .
]

{ #category : #playing }
Double >> applyIn: game to: noTarget [ 
	game applyDoubleCard.
	^self.
]

{ #category : #playing }
Double >> thrownBy: aPlayer inTheTurnOf: playerTurn [
	"This card can be played in any moment"
]
