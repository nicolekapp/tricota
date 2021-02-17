Class {
	#name : #Deck,
	#superclass : #Object,
	#instVars : [
		'cardProvider',
		'cardsLeft'
	],
	#category : #'IngSoft2-Model-Cards'
}

{ #category : #'instance creation' }
Deck class >> source: aCardProvider [
	^ self new initializeSource: aCardProvider.
]

{ #category : #'instance creation' }
Deck class >> source: aCardProvider withSize: anAmountOfCards [ 

	^ self new initializeSource: aCardProvider withSize: anAmountOfCards.
]

{ #category : #deal }
Deck >> dealTwoCardsToEachPlayerFrom: aGruopOfPLayers [

	aGruopOfPLayers do: [ :player | 
			player addCard: self handCard .
			player addCard: self handCard ]
]

{ #category : #deal }
Deck >> handCard [
	cardsLeft > 0
	ifTrue: [ cardsLeft:= cardsLeft - 1.
				^ cardProvider nextCard ].
]

{ #category : #initialization }
Deck >> initializeSource: aCardProvider [ 

	cardProvider:= aCardProvider.
]

{ #category : #initialization }
Deck >> initializeSource: aCardProvider withSize: anAmountOfCards [ 

	cardProvider:= aCardProvider.
	cardsLeft := anAmountOfCards.
]

{ #category : #'as yet unclassified' }
Deck >> numberOfCards [
	cardsLeft
	ifNil: [ cardsLeft:=  cardProvider amountOfCards].
	 ^cardsLeft.
]
