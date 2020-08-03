Class {
	#name : #SequentialCardProvider,
	#superclass : #Object,
	#instVars : [
		'sequenceOfCards'
	],
	#category : #'IngSoft2-Model-Card'
}

{ #category : #'intance creation' }
SequentialCardProvider class >> providing: aSequenceOfCards [ 
	^self new initializeProviding: aSequenceOfCards.
]

{ #category : #initialization }
SequentialCardProvider class >> providing: aCollection withSize: anInteger [ 
	self shouldBeImplemented.
]

{ #category : #initialization }
SequentialCardProvider >> initializeProviding: aSequenceOfCards [ 
	
 sequenceOfCards := (CircularIterator cyclingOver: aSequenceOfCards ).
]

{ #category : #providing }
SequentialCardProvider >> nextCard [
	| next |
	next := sequenceOfCards current.
	sequenceOfCards next.
	^ next.
]
