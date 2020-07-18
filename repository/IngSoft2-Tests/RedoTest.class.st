Class {
	#name : #RedoTest,
	#superclass : #CardTest,
	#instVars : [
		'deck'
	],
	#category : #'IngSoft2-Tests-Card-Test'
}

{ #category : #running }
RedoTest >> setUp [

	self setUpCard.


]

{ #category : #tests }
RedoTest >> testRedoAccelerationCard [

	| game  deckBuilder accelerationThrownByJuan redoThrownByJuan|
	deckBuilder := DeckBuilder startBuilding.
	deckBuilder add: Acceleration new;
					add: Redo new.
	deck := deckBuilder buildDeterministic.
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	accelerationThrownByJuan := PermanentCard type: Acceleration new target: Everyone new.
	game player: juan throw: accelerationThrownByJuan .
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 8.

	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 8;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 10.
		
	redoThrownByJuan := InstantCard type: Redo new.
	game player: juan throw: redoThrownByJuan .
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 13;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 10.
	

	
]

{ #category : #tests }
RedoTest >> testRedoCancellationCard [

	| game cards|
	cards:= OrderedCollection new.
	cards 
	add: Acceleration new;
	add: Cancellation new;
	add: Redo new.
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette andDeterministic: cards.
	
	game player: juan throw: (Acceleration card: NullObject new target: NullObject new).
	game nextTurn.
		self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 8.
		
	game player: nico throw: (Acceleration card: NullObject new target: NullObject new).
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 8;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 11.
		
	game player: juan throw: (Cancellation card: Acceleration new target: NullObject new).
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 12;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 11.
		
	"game player: nico throw: (Redo ofCard:(Cancellation selectCard: Acceleration new))."
	game player: nico throw: (Redo card: Acceleration new target: NullObject new).
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 12;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 18.

	
]

{ #category : #tests }
RedoTest >> testRedoRedoCard [

	| game cards|
	cards:= OrderedCollection new.
	cards 
	add: Acceleration new;
	add: Redo new.
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette andDeterministic: cards.
	
	game player: juan throw: (Acceleration card: NullObject new target: NullObject new).
	game nextTurn.
		self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 8.

	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 8;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 10.
		
	game player: juan throw:(Redo card: NullObject new target: NullObject new).
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 13;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 10.
		
	game player: nico throw:(Redo card: NullObject new target: NullObject new).
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 13;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 20.
	

	
]

{ #category : #tests }
RedoTest >> testRedoRepeatCard [

	|game  cards effectRouletteBuilder|
	cards:= OrderedCollection new.
	cards 
	add: Acceleration new;
	add: Repeat new;
	add: Redo new.
	effectRouletteBuilder:= EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder add: (PickUpCard withRandom: cards);
	add: NoEffect new;
	add: SpeedUp new.
	effectRoulette:= effectRouletteBuilder buildDeterministic. 
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette andDeterministic: cards.
	game nextTurn.
		self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7.
		
game player: juan throw: (Repeat card: NullObject new target: juan).
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 9.
		
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 14;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 9.
		
	game player: nico throw: (Redo card: NullObject new target:nico).
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 14;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 13.

	
]

{ #category : #tests }
RedoTest >> testTryToThrowRedoCardBeforeNobodyThrewAnyCard [

	| game cards |
	
	cards:= OrderedCollection new.
	cards 
	add: Redo new.
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: cards.
	
	game nextTurn.
		self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7.
	
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 9.

	self 
	should: [ game player: juan throw: (Redo card: NullObject new target: NullObject new ) ]
		raise: InvalideRequest
		withMessageText: 'Nobody threw a card yet'.
		
	
]
