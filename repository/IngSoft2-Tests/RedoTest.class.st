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
	game player: juan throw: accelerationThrownByJuan.
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
		
	redoThrownByJuan := InstantCard type: Redo new target: Everyone new.
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

	| game  deckBuilder accelerationThrownByJuan accelerationThrownByNico cancellationThrownByJuan redoThrownByNico|
	deckBuilder := DeckBuilder startBuilding.
	deckBuilder add: Acceleration new;
					add: Cancellation new;
					add: Redo new.
	deck := deckBuilder buildDeterministic.
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	accelerationThrownByJuan := PermanentCard type: Acceleration new target: Everyone new.
	game player: juan throw: accelerationThrownByJuan .
	game nextTurn.
		self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 8.
		
	accelerationThrownByNico := PermanentCard type: Acceleration new target: Everyone new.
	game player: nico throw: accelerationThrownByNico .
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 8;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 11.
		
	cancellationThrownByJuan := InstantCard type: Cancellation new target: accelerationThrownByJuan.
	game player: juan throw: cancellationThrownByJuan .
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 12;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 11.
		
	redoThrownByNico := InstantCard type: Redo new target: accelerationThrownByNico.
	game player: nico throw: redoThrownByNico .
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 12;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 18.

	
]

{ #category : #tests }
RedoTest >> testRedoRedoCard [

	| game  deckBuilder accelerationThrownByJuan redoThrownByJuan redoThrownByNico|
	deckBuilder := DeckBuilder startBuilding.
	deckBuilder add: Acceleration new;
					add: Redo new.
	deck := deckBuilder buildDeterministic.
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	accelerationThrownByJuan := PermanentCard type: Acceleration new target: Everyone new.
	game player: juan throw: accelerationThrownByJuan.
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
		
	redoThrownByJuan := InstantCard type: Redo new target: Everyone new.
	game player: juan throw: redoThrownByJuan .
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 13;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 10.
		
	redoThrownByNico := InstantCard type: Redo new target: Everyone new.
	game player: nico throw: redoThrownByNico .
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 13;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 20.
	

	
]

{ #category : #tests }
RedoTest >> testRedoRepeatCard [

	|game deckBuilder effectRouletteBuilder repeatThrownByJuan redoThrownByNico |
	deckBuilder := DeckBuilder startBuilding.
	deckBuilder add: Acceleration new;
					add: Repeat new;
					add: Redo new.
	deck := deckBuilder buildDeterministic.

	effectRouletteBuilder:= EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder add: PickUpCard new;
								add: NoEffect new;
								add: SpeedUp new.
	effectRoulette:= effectRouletteBuilder buildDeterministic. 
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	game nextTurn.
		self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7.
		
	repeatThrownByJuan := InstantCard type: Repeat new target: juan.
	game player: juan throw: repeatThrownByJuan .
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
		
	redoThrownByNico := InstantCard type: Redo new target: nico.
	game player: juan throw: redoThrownByNico .
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 14;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 13.

	
]

{ #category : #tests }
RedoTest >> testTryToThrowRedoCardBeforeNobodyThrewAnyCard [

	| game deckBuilder|
	deckBuilder := DeckBuilder startBuilding.
	deckBuilder add: Redo new.
	deck := deckBuilder buildDeterministic.
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
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
	should: [ game player: juan throw: (InstantCard type: Redo new) ]
		raise: InvalideRequest
		withMessageText: 'Nobody threw a card yet'.
		
	
]
