Class {
	#name : #Redo,
	#superclass : #TypeOfCard,
	#instVars : [
		'throwedBy',
		'playersTurn'
	],
	#category : #'IngSoft2-Model-Card'
}

{ #category : #initialization }
Redo class >> initializeCard [
	^InstantCard type: self new
]

{ #category : #initialization }
Redo class >> initializeCardWithTarget: aTarget [
	^InstantCard type: self new target: aTarget .
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
