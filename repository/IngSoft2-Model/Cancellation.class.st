Class {
	#name : #Cancellation,
	#superclass : #TypeOfCard,
	#instVars : [
		'selectedCard'
	],
	#category : #'IngSoft2-Model-Card'
}

{ #category : #initialization }
Cancellation class >> initializeCard [
	^InstantCard type: self new.
]

{ #category : #initialization }
Cancellation class >> initializeCardWithTarget: aTarget [
	^InstantCard type: self new target: aTarget .
]

{ #category : #playing }
Cancellation >> applyIn: game to: aCard [ 
	game applyCancellationCardTo: aCard.
	^self 
]

{ #category : #playing }
Cancellation >> thrownBy: aPlayer inTheTurnOf: playerTurn [
	"This card can be played in any moment"
]
