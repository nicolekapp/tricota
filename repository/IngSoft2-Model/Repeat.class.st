Class {
	#name : #Repeat,
	#superclass : #InstantCard,
	#category : #'IngSoft2-Model-Cards'
}

{ #category : #initialization }
Repeat class >> initializeCard [
	^self new.
]

{ #category : #initialization }
Repeat class >> initializeCardWithTarget: aTarget [
	^ self onTarget: aTarget
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
