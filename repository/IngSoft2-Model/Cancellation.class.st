Class {
	#name : #Cancellation,
	#superclass : #InstantCard,
	#instVars : [
		'selectedCard'
	],
	#category : #'IngSoft2-Model-Cards'
}

{ #category : #initialization }
Cancellation class >> initializeCard [
	^self new.
]

{ #category : #initialization }
Cancellation class >> initializeCardWithTarget: aTarget [
	^ self onTarget: aTarget
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
