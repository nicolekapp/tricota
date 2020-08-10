Class {
	#name : #SequentialCardProvider,
	#superclass : #Object,
	#instVars : [
		'sequenceOfCards',
		'amountOfCards'
	],
	#category : #'IngSoft2-Model-Card'
}

{ #category : #initialization }
SequentialCardProvider class >> providing: aSequenceOfCards [
	aSequenceOfCards size < 1
		ifTrue: [ InstanceCreationFailed
				signal: 'Not enough cards' ].
	^ self new initializeProviding: aSequenceOfCards 
]

{ #category : #'as yet unclassified' }
SequentialCardProvider >> amountOfCards [
	^amountOfCards.
]

{ #category : #initialization }
SequentialCardProvider >> initializeProviding: aSequenceOfCards [ 
	
 sequenceOfCards := (CircularIterator cyclingOver: aSequenceOfCards ).
 amountOfCards := aSequenceOfCards size.
]

{ #category : #providing }
SequentialCardProvider >> nextCard [
	| next |
	next := sequenceOfCards current.
	sequenceOfCards next.
	^ next.
]
