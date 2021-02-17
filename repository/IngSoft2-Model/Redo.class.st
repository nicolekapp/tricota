Class {
	#name : #Redo,
	#superclass : #InstantCard,
	#instVars : [
		'throwedBy',
		'playersTurn'
	],
	#category : #'IngSoft2-Model-Cards'
}

{ #category : #initialization }
Redo class >> initializeCard [
	^self new.
]

{ #category : #initialization }
Redo class >> initializeCardWithTarget: aTarget [
	^ self onTarget: aTarget
]

{ #category : #playing }
Redo >> applyIn: game to: aTarget [ 
	^game applyRedoCardTo: aTarget thrownBy: throwedBy inTheTurnOf: playersTurn 
	
]

{ #category : #playing }
Redo >> thrownBy: aPlayer inTheTurnOf: playerTurn [
	throwedBy:= aPlayer.
	playersTurn := playerTurn 
	
]
