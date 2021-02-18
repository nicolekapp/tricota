Class {
	#name : #DeckBuilder,
	#superclass : #Object,
	#instVars : [
		'sequenceOfCards'
	],
	#category : #'IngSoft2-Model-Cards'
}

{ #category : #'instance creation' }
DeckBuilder class >> buildingProbabilisticShuffler [
	^self new initializeBuildingProbabilisticShuffler.
]

{ #category : #'instance creation' }
DeckBuilder class >> startBuilding [
	^self new initializeStartBuilding.
]

{ #category : #'instance creation' }
DeckBuilder class >> startBuildingWith: discardedCards [
	^self new initializeStartBuildingWith: discardedCards.
]

{ #category : #building }
DeckBuilder >> add: aCard [ 
	sequenceOfCards add: (aCard initializeCard) .
]

{ #category : #building }
DeckBuilder >> add: aCard withPercentage: aPercentage [

	sequenceOfCards at: aCard put: aPercentage.
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
DeckBuilder >> buildRandomWithSize: anAmountOfCards [ 
	^ Deck source:(ProbabilitiesCardProvider with: (self createDictionaryTypeOfCardsAndProbabilities: sequenceOfCards )) withSize: anAmountOfCards.
]

{ #category : #initialization }
DeckBuilder >> createDictionaryTypeOfCardsAndProbabilities: cards [
	| minimum |
	minimum := 1.
	cards
		keysAndValuesDo: [ :key :value | 
			cards at: key put: (Interval from: minimum to: minimum + value - 1).
			minimum := minimum + value ].
	^cards.
]

{ #category : #initialization }
DeckBuilder >> initializeBuildingProbabilisticShuffler [
	sequenceOfCards := Dictionary new. 
]

{ #category : #initialization }
DeckBuilder >> initializeStartBuilding [
	sequenceOfCards := OrderedCollection new.
]

{ #category : #initialization }
DeckBuilder >> initializeStartBuildingWith: discardedCards [
	sequenceOfCards := discardedCards.
]
