Class {
	#name : #InstantCard,
	#superclass : #Object,
	#instVars : [
		'type',
		'target'
	],
	#category : #'IngSoft2-Model-Card'
}

{ #category : #'as yet unclassified' }
InstantCard class >> type: aType [ 
	^ self new initializeType: aType target: NoTarget new.
]

{ #category : #'instance creation' }
InstantCard class >> type: aType target: aPlayer [ 
	^ self new initializeType: aType target: aPlayer 
]

{ #category : #'as yet unclassified' }
InstantCard >> applyIn: game [
	
	| lastCardPlayed |
	lastCardPlayed := type applyIn: game to: target.
	game lastCardPlayed: lastCardPlayed.

]

{ #category : #'as yet unclassified' }
InstantCard >> applyWithin: aPlayersWithPositions playedBy: aPlayer knowing: activeCards the: lastEffect and: finishLine of: game [

	type applyWithin: aPlayersWithPositions playedBy: aPlayer knowing: activeCards the: lastEffect and: finishLine of: game.
	game lastCardPlayed: self.
]

{ #category : #inicialization }
InstantCard >> initializeType: aType target: aTarget [ 
	type := aType .
	target := aTarget.
]

{ #category : #inicialization }
InstantCard >> isSameType: aCard [ 
	^ type = aCard type .
]

{ #category : #'as yet unclassified' }
InstantCard >> thrownBy: aPlayer inTheTurnOf: playerTurn [
	"This card can be played in any moment"
]

{ #category : #'as yet unclassified' }
InstantCard >> type [
	^ type
]
