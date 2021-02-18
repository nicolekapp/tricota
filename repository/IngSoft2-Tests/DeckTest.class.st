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
DeckTest >> cardsWithProbabilities [

	| acceleration speed cancellation overload redo repeat deckBuilder |
	acceleration:= Acceleration initializeCard.
	speed:= Speed initializeCard.
	cancellation:= Cancellation initializeCard.
	overload:= Overload initializeCard.
	redo:= Redo initializeCard.
	repeat:= Repeat initializeCard.
	deckBuilder:= DeckBuilder buildingProbabilisticShuffler.
	
	deckBuilder add: acceleration withPercentage:10.
	deckBuilder add: speed withPercentage:20.
	deckBuilder add: cancellation withPercentage:20.
	deckBuilder add: overload withPercentage:10.
	deckBuilder add: redo  withPercentage:10.
	deckBuilder add: repeat withPercentage:30.
	
	^deckBuilder buildRandomWithSize: 100.

]

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
	self assert:( juan assertHasCard: (Overload initializeCardWithTarget: Everyone new)).
	self assert:( juan assertHasCard: (Overload initializeCardWithTarget: Everyone new)).
	self assert: nico numberOfCards equals:2.
	self assert:( nico assertHasCard: (Acceleration  initializeCard)).
	self assert:( nico assertHasCard: (Acceleration  initializeCard)).
	
	
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
	self assert:( juan assertHasCard: (Overload initializeCardWithTarget: Everyone new)).
	self assert:( juan assertHasCard: (Overload initializeCardWithTarget: Everyone new)).
	self assert: nico numberOfCards equals:2.
	self assert:( nico assertHasCard: (Acceleration  initializeCard)).
	self assert:( nico assertHasCard: (Speed initializeCardWithTarget: nico)).
	
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
	self assert:( juan assertHasCard: (Overload initializeCardWithTarget: Everyone new)).
	self assert:( juan assertHasCard: (Overload initializeCardWithTarget: Everyone new)).
	self assert: nico numberOfCards equals:2.
	self assert:( nico assertHasCard: (Acceleration  initializeCard)).
	self assert:( nico assertHasCard: (Speed initializeCardWithTarget: nico)).
	
	self assert: deck numberOfCards equals: 0.
	
	
]

{ #category : #tests }
DeckTest >> testInitializeGameRandomDealingCards [
	
	|cardTypesToBeUsed deckBuilder |
	deckBuilder:= self cardsWithProbabilities.
	cardTypesToBeUsed:= OrderedCollection new.
	cardTypesToBeUsed 
		add: Acceleration;
		add: Speed;
		add: Cancellation;
		add: Overload ; 
		add: Redo ;
		add: Repeat .
	1 to: 100 do: [ :iteration | self assert: (cardTypesToBeUsed includes: deckBuilder handCard class) ].

]
