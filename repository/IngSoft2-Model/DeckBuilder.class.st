Class {
	#name : #DeckBuilder,
	#superclass : #Object,
	#instVars : [
		'sequenceOfCards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
DeckBuilder class >> startBuilding [
	^self new initializeStartBuilding.
]

{ #category : #'as yet unclassified' }
DeckBuilder >> add: aTypeCard [  
	sequenceOfCards add: (aTypeCard initialiceCard) .
]

{ #category : #'as yet unclassified' }
DeckBuilder >> buildDeterministic [
	^ Deck source:(SequencialCardProvider providing: sequenceOfCards).
]

{ #category : #'as yet unclassified' }
DeckBuilder >> buildRandom [
	^ Deck source:(RandomCardProvider providing: sequenceOfCards).
]

{ #category : #initialization }
DeckBuilder >> initializeStartBuilding [
	sequenceOfCards := OrderedCollection new.
]
