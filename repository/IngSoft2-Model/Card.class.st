Class {
	#name : #Card,
	#superclass : #Object,
	#instVars : [
		'card',
		'target',
		'type'
	],
	#category : #'IngSoft2-Model-Card'
}

{ #category : #'instance creation' }
Card class >> type: aType [  
	^ self type: aType target: Target none.
]

{ #category : #'instance creation' }
Card class >> type: aType target: aTarget [ 
	^ self new initializeType: aType target: aTarget
]

{ #category : #playing }
Card >> applyWithin: aPlayersWithPositions knowing: activeCards the: lastEffect and: finishLine of: game [
	^ type applyWithin: aPlayersWithPositions knowing: activeCards the: lastEffect and: finishLine of: game
]

{ #category : #inicialization }
Card >> initializeType: aType target: aTarget [ 
	type := aType .
	target := aTarget.
]

{ #category : #'as yet unclassified' }
Card >> isSameType: aCard [ 
	^ type = aCard type .
]

{ #category : #'as yet unclassified' }
Card >> type [
	^ type
]
