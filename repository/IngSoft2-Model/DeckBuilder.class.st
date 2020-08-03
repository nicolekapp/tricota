Class {
	#name : #DeckBuilder,
	#superclass : #Object,
	#instVars : [
		'sequenceOfCards'
	],
	#category : #'IngSoft2-Model-Card'
}

{ #category : #'instance creation' }
DeckBuilder class >> startBuilding [
	^self new initializeStartBuilding.
]

{ #category : #initialization }
DeckBuilder class >> startBuildingWithSize: anInteger [ 
	self shouldBeImplemented.
]

{ #category : #building }
DeckBuilder >> add: aTypeCard [  
	sequenceOfCards add: (aTypeCard initializeCard) .
]

{ #category : #building }
DeckBuilder >> buildDeterministic [
	^ Deck source:(SequentialCardProvider providing: sequenceOfCards).
]

{ #category : #building }
DeckBuilder >> buildDeterministicWithSize: anAmountOfCards [ 
	^ Deck source:(SequentialCardProvider providing: sequenceOfCards) withSize: anAmountOfCards.
]

{ #category : #building }
DeckBuilder >> buildRandom [
	^ Deck source:(RandomCardProvider providing: sequenceOfCards).
]

{ #category : #building }
DeckBuilder >> buildRandomWithSize: anAmountOfCards [ 
	^ Deck source:(RandomCardProvider providing: sequenceOfCards) withSize: anAmountOfCards.
]

{ #category : #initialization }
DeckBuilder >> initializeStartBuilding [
	sequenceOfCards := OrderedCollection new.
]
