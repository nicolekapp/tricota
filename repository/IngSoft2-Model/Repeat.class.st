Class {
	#name : #Repeat,
	#superclass : #TypeOfCard,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #initialization }
Repeat class >> initializeCard [
	^InstantCard type: self new.
]

{ #category : #initialization }
Repeat class >> initializeCardWithTarget: aTarget [
	^InstantCard type: self new target: aTarget .
]

{ #category : #playing }
Repeat >> applyIn: game to: aPlayer [ 
	game applyRepeatCardTo: aPlayer.
	^self
]

{ #category : #playing }
Repeat >> thrownBy: aPlayer inTheTurnOf: playerTurn [
	"This card can be played in any moment"
]
