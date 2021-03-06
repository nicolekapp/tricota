Class {
	#name : #CardTest,
	#superclass : #TestCase,
	#instVars : [
		'die',
		'juan',
		'nico',
		'players',
		'effectRoulette'
	],
	#category : #'IngSoft2-Tests-Card-Test'
}

{ #category : #accessing }
CardTest >> aEffectRouletteWith100ProbabilityOf: effect [

	|  effectRouletteBuilder |
	effectRouletteBuilder:= EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder add: effect.
	^effectRouletteBuilder buildDeterministic. 
]

{ #category : #accessing }
CardTest >> finish: game [
	self play: game amountOfTurns: 5
]

{ #category : #accessing }
CardTest >> juan [
	^ self playerNamed: 'Juan'.
]

{ #category : #accessing }
CardTest >> nico [
	^ self playerNamed: 'Nico'.
]

{ #category : #tests }
CardTest >> play: anUCABoardGame amountOfTurns: anInteger [ 
	1 to: anInteger do: [ :number | anUCABoardGame nextTurn ].
]

{ #category : #accessing }
CardTest >> playerNamed: aName [

	^Player named: aName.
]

{ #category : #running }
CardTest >> setUpCard [
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
	effectRoulette := effectRouletteBuilder buildDeterministic.
]

{ #category : #running }
CardTest >> testPlayerCanNotThrowAnyCardAfterTheGameHasFinished [

	| game deck deckBuilder effectRouletteBuilder cardToCancell|
	self setUpCard.
	effectRouletteBuilder := EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder add: PickUpCard new.
	effectRoulette := effectRouletteBuilder buildDeterministic.
	
	deckBuilder:= DeckBuilder startBuilding.
	deckBuilder 	add: Acceleration;
					add: Cancellation ;
					add: Overload ;
					add: Redo ;
					add: Repeat ;
					add: Speed .
	deck:= deckBuilder buildDeterministicWithSize: 100.
	
	game:= UCABoardGame rolling: die with: players lockers: 9 laps: 2 effects: effectRoulette and: deck.
	self finish: game. 
	cardToCancell:= Acceleration initializeCard.
	
	"The game has finished, nobody can throw any card"
	self 
	should: [ game player: juan throw: Acceleration initializeCard ]
		raise: InvalidRequest
		withMessageText: 'The game has finished'.
	self 
	should: [ game player: nico throw: (Cancellation initializeCardWithTarget: cardToCancell) ]
		raise: InvalidRequest
		withMessageText: 'The game has finished'.
	self 
	should: [ game player: nico throw: (Overload initializeCardWithTarget: juan) ]
		raise: InvalidRequest
		withMessageText: 'The game has finished'.
	self 
	should: [ game player: juan throw: (Redo initializeCardWithTarget: nico) ]
		raise: InvalidRequest
		withMessageText: 'The game has finished'.
	self 
	should: [ game player: nico throw: (Repeat initializeCardWithTarget: nico) ]
		raise: InvalidRequest
		withMessageText: 'The game has finished'.
	self 
	should: [ game player: nico throw: (Speed initializeCardWithTarget: nico) ]
		raise: InvalidRequest
		withMessageText: 'The game has finished'.
	
]

{ #category : #running }
CardTest >> testPlayerCanNotThrowAnyCardIfHeDoesntHaveIt [

	| game deck deckBuilder effectRouletteBuilder cardToCancell|
	self setUpCard.
	effectRouletteBuilder := EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder add: PickUpCard new.
	effectRoulette := effectRouletteBuilder buildDeterministic.
	
	deckBuilder:= DeckBuilder startBuilding.
	deckBuilder 	add: Repeat ; 		"Juan has two repeat cards"
					add: Repeat ;
					add: Acceleration; 		"Nico has two acceleration cards"
					add: Acceleration.

	deck:= deckBuilder buildDeterministicWithSize: 100.
	
	game:= UCABoardGame rolling: die with: players lockers: 9 laps: 2 effects: effectRoulette and: deck.
	cardToCancell:= Acceleration initializeCard. 
	
	"No one can throw a card if he doesnt have it"
	self 
	should: [ game player: juan throw: Acceleration initializeCard ]
		raise: InvalidRequest
		withMessageText: 'Player doesnt have that card'.
	self 
	should: [ game player: nico throw: (Cancellation initializeCardWithTarget: cardToCancell) ]
		raise: InvalidRequest
		withMessageText: 'Player doesnt have that card'.
	self 
	should: [ game player: nico throw: (Overload initializeCardWithTarget: juan) ]
		raise: InvalidRequest
		withMessageText: 'Player doesnt have that card'.
	self 
	should: [ game player: juan throw: (Redo initializeCardWithTarget: nico) ]
		raise: InvalidRequest
		withMessageText: 'Player doesnt have that card'.
	self 
	should: [ game player: nico throw: (Repeat initializeCardWithTarget: nico) ]
		raise: InvalidRequest
		withMessageText: 'Player doesnt have that card'.


	
]
