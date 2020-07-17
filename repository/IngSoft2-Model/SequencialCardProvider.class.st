Class {
	#name : #SequencialCardProvider,
	#superclass : #Object,
	#instVars : [
		'sequence'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #providing }
SequencialCardProvider class >> providing: aSequenceOfCards [
	aSequenceOfCards  size < 1
		ifTrue: [ InstanceCreationFailed
				signal: 'Not enough cards, there must be one at least' ].
	^ self new initializeProviding: aSequenceOfCards 
]

{ #category : #initialization }
SequencialCardProvider >> initializeProviding: aSequenceOfCards [ 

	sequence := (CircularIterator cyclingOver: aSequenceOfCards ).
]

{ #category : #providing }
SequencialCardProvider >> nextCard [

	| next |
	next := sequence current.
	sequence next.
	^ next
]
