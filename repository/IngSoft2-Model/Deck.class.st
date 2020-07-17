Class {
	#name : #Deck,
	#superclass : #Object,
	#instVars : [
		'cardProvider'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
Deck class >> source: aCardProvider [

	^ self new initializeSource: aCardProvider.
]

{ #category : #cards }
Deck >> dealTwoCardsToEachPlayerFrom: aGruopOfPLayers [

	aGruopOfPLayers do: [ :player | 
			player addCard: self handCard .
			player addCard: self handCard ]
]

{ #category : #'as yet unclassified' }
Deck >> handCard [
	^ cardProvider nextCard.
]

{ #category : #initialization }
Deck >> initializeSource: aCardProvider [ 

	cardProvider:= aCardProvider.
]
