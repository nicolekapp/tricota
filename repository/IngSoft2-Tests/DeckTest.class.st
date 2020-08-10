Class {
	#name : #DeckTest,
	#superclass : #TestCase,
	#instVars : [
		'die',
		'juan',
		'nico',
		'players',
		'effectRoulette'
	],
	#category : #'IngSoft2-Tests-Deck-Tests'
}

{ #category : #accessing }
DeckTest >> juan [
	^ self playerNamed: 'Juan'.
]

{ #category : #accessing }
DeckTest >> nico [
	^ self playerNamed: 'Nico'.
]

{ #category : #accessing }
DeckTest >> playerNamed: aName [

	^Player named: aName.
]

{ #category : #running }
DeckTest >> setUp [
	| effectRouletteBuilder |
	die := Die of: 10 rolling: #(7 9 3).
	juan := self juan.
	nico := self nico.
	players := OrderedCollection new.
	players
		add: juan;
		add: nico.
	effectRouletteBuilder := EffectRouletteBuilder
		buildingDeterministicRoulette.
	effectRouletteBuilder add: NoEffect new.
	effectRoulette := effectRouletteBuilder buildDeterministic

]

{ #category : #tests }
DeckTest >> testInitializeGameDeterministicDealingCards [
	|game deck deckBuilder |
	deckBuilder:= DeckBuilder startBuilding.
	deckBuilder add: Overload;
					add: Overload;
					add: Acceleration ;
					add: Speed .
	deck:= deckBuilder buildDeterministicWithSize: 100.
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.

	self assert: juan numberOfCards equals: 2.
	self assert:( juan assertHasCard: (PermanentCard type: Overload new)).
	self assert:( juan assertHasCard: (PermanentCard type: Overload new)).
	self assert: nico numberOfCards equals:2.
	self assert:( nico assertHasCard: (PermanentCard type: Acceleration new)).
	self assert:( nico assertHasCard: (PermanentCard type: Speed new)).
	
	
]

{ #category : #tests }
DeckTest >> testInitializeGameDeterministicDeckWithSize [
	|game deck deckBuilder|
	deckBuilder:= DeckBuilder startBuilding.
	deckBuilder add: Overload;
					add: Overload;
					add: Acceleration;
					add: Speed .

	deck:= deckBuilder buildDeterministicWithSize: 6.
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.

	self assert: juan numberOfCards equals: 2.
	self assert:( juan assertHasCard: (PermanentCard type: Overload new)).
	self assert:( juan assertHasCard: (PermanentCard type: Overload new)).
	self assert: nico numberOfCards equals:2.
	self assert:( nico assertHasCard: (PermanentCard type: Acceleration new)).
	self assert:( nico assertHasCard: (PermanentCard type: Speed new)).
	
	self assert: deck numberOfCards equals: 2.
	
	
]

{ #category : #tests }
DeckTest >> testInitializeGameDeterministicDeckWithSizeSixTwoCardsLeftAfterDealingFirstHand [
	|game deck deckBuilder|
	deckBuilder:= DeckBuilder startBuilding.
	deckBuilder add: Overload;
					add: Overload;
					add: Acceleration;
					add: Speed .

	deck:= deckBuilder buildDeterministicWithSize: 6.
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.

	self assert: juan numberOfCards equals: 2.
	self assert:( juan assertHasCard: (PermanentCard type: Overload new)).
	self assert:( juan assertHasCard: (PermanentCard type: Overload new)).
	self assert: nico numberOfCards equals:2.
	self assert:( nico assertHasCard: (PermanentCard type: Acceleration new)).
	self assert:( nico assertHasCard: (PermanentCard type: Speed new)).
	
	self assert: deck numberOfCards equals: 2.
	
	
]

{ #category : #tests }
DeckTest >> testInitializeGameDeterministicDeckWithSizeSixZeroCardsLeftAfterFirstHand [
	|game deck deckBuilder|
	deckBuilder:= DeckBuilder startBuilding.
	deckBuilder add: Overload;
					add: Overload;
					add: Acceleration;
					add: Speed .

	deck:= deckBuilder buildDeterministicWithSize: 4.
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.

	self assert: juan numberOfCards equals: 2.
	self assert:( juan assertHasCard: (PermanentCard type: Overload new)).
	self assert:( juan assertHasCard: (PermanentCard type: Overload new)).
	self assert: nico numberOfCards equals:2.
	self assert:( nico assertHasCard: (PermanentCard type: Acceleration new)).
	self assert:( nico assertHasCard: (PermanentCard type: Speed new)).
	
	self assert: deck numberOfCards equals: 0.
	
	
]

{ #category : #tests }
DeckTest >> testInitializeGameRandomDealingCards [

	|deck deckBuilder game |
	deckBuilder:= DeckBuilder startBuilding.
	deckBuilder 	add: Overload ;
					add: Speed .
	deck:= deckBuilder buildRandomWithSize: 100.
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.

	self assert: juan numberOfCards equals: 2.
	self assert: nico numberOfCards equals:2.
	
	
]
