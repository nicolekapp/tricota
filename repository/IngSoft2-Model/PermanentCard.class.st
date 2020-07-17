Class {
	#name : #PermanentCard,
	#superclass : #Object,
	#instVars : [
		'card',
		'target',
		'type'
	],
	#category : #'IngSoft2-Model-Card'
}

{ #category : #'instance creation' }
PermanentCard class >> type: aType [  
	^ self type: aType target: NoTarget new.
]

{ #category : #'instance creation' }
PermanentCard class >> type: aType target: aTarget [ 
	^ self new initializeType: aType target: aTarget
]

{ #category : #'as yet unclassified' }
PermanentCard >> applyIn: game [ 
	
	game savePermanentCard: self.
	game lastCardPlayed: self.
]

{ #category : #playing }
PermanentCard >> applyWithin: aPlayersWithPositions playedBy: aPlayer knowing: activeCards the: lastEffect and: finishLine of: game [

	game assertItsPlayersTurn: aPlayer.
	game savePermanentCard: self.
	game lastCardPlayed: self.
]

{ #category : #'as yet unclassified' }
PermanentCard >> effect: aPlayer [ 
	
	|lockers|
	lockers := 0.
	(target is: aPlayer) 
		ifTrue:[lockers:=type effect: aPlayer].
	^lockers
]

{ #category : #inicialization }
PermanentCard >> initializeType: aType target: aTarget [ 
	type := aType .
	target := aTarget.
]

{ #category : #'as yet unclassified' }
PermanentCard >> isSameType: aCard [ 
	^ type = aCard type .
]

{ #category : #'as yet unclassified' }
PermanentCard >> thrownBy: aPlayer inTheTurnOf: playerTurn [ 
	aPlayer = playerTurn 
		ifFalse: [ InvalideRequest signal: 'It is not your turn' ]
]

{ #category : #'as yet unclassified' }
PermanentCard >> type [
	^ type
]
