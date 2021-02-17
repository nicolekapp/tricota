Class {
	#name : #Card,
	#superclass : #Object,
	#instVars : [
		'target'
	],
	#category : #'IngSoft2-Model-Cards'
}

{ #category : #'instance creation' }
Card class >> onTarget: aTarget [
	^ self new initializeOnTarget: aTarget
]

{ #category : #playing }
Card >> = anObject [ 

	^ self class = anObject class .	
]

{ #category : #playing }
Card >> applyIn: game [
	Error signal: 'This message should be override'.
]

{ #category : #playing }
Card >> hash [
	
	^self class hash
]

{ #category : #inicialization }
Card >> initializeOnTarget: aTarget [ 
	target := aTarget.
]

{ #category : #playing }
Card >> isSameType: aCard [ 
	^ self class = aCard class.
]

{ #category : #playing }
Card >> thrownBy: aPlayer inTheTurnOf: playerTurn [
	self subclassResponsibility
]
