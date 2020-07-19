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
	deckBuilder add: Acceleration ;
					add: Redo .
	deck := deckBuilder buildDeterministic.
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	accelerationThrownByJuan := Acceleration initializeCard .
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
		
	redoThrownByJuan := Redo initializeCardWithTarget: Everyone new.
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
	deckBuilder add: Acceleration ;
					add: Cancellation ;
					add: Redo .
	deck := deckBuilder buildDeterministic.
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	accelerationThrownByJuan := Acceleration initializeCard .
	game player: juan throw: accelerationThrownByJuan .
	game nextTurn.
		self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 8.
		
	accelerationThrownByNico := Acceleration initializeCard .
	game player: nico throw: accelerationThrownByNico .
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 8;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 11.
		
	cancellationThrownByJuan := Cancellation initializeCardWithTarget: accelerationThrownByJuan.
	game player: juan throw: cancellationThrownByJuan .
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 12;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 11.
		
	redoThrownByNico := Redo initializeCardWithTarget: accelerationThrownByNico.
	game player: nico throw: redoThrownByNico .
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 12;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 18.

	
]

{ #category : #tests }
RedoTest >> testRedoDoubleCard [

	| game deckBuilder doubleThrownByJuan redoThrownByNico|
	deckBuilder := DeckBuilder startBuilding.
	deckBuilder add: Double ;
					add: Redo .
	deck := deckBuilder buildDeterministic.

	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	doubleThrownByJuan := Double initializeCard .
	game player: juan throw: doubleThrownByJuan.

	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 16;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.
	
	redoThrownByNico := Redo initializeCard .
	game player: nico throw: redoThrownByNico .
	
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 16;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 10.
	
]

{ #category : #tests }
RedoTest >> testRedoOverloadCard [

	| game  deckBuilder overloadThrownByJuan redoThrownByNico|
	deckBuilder := DeckBuilder startBuilding.
	deckBuilder add: Overload ;
					add: Redo .
	deck := deckBuilder buildDeterministic.
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	overloadThrownByJuan := Overload initializeCardWithTarget: nico.
	game player: juan throw: overloadThrownByJuan.
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.

	redoThrownByNico := Redo initializeCardWithTarget: juan.
	game player: nico throw: redoThrownByNico .
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 7.
		
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 8;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 7.
	

	
]

{ #category : #tests }
RedoTest >> testRedoRedoCard [

	| game  deckBuilder accelerationThrownByJuan redoThrownByJuan redoThrownByNico|
	deckBuilder := DeckBuilder startBuilding.
	deckBuilder add: Acceleration ;
					add: Redo .
	deck := deckBuilder buildDeterministic.
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	accelerationThrownByJuan := Acceleration initializeCardWithTarget: Everyone new.
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
		
	redoThrownByJuan := Redo initializeCardWithTarget: Everyone new.
	game player: juan throw: redoThrownByJuan .
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 13;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 10.
		
	redoThrownByNico := Redo initializeCardWithTarget: Everyone new.
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
	deckBuilder add: Acceleration ;
					add: Repeat ;
					add: Redo .
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
		
	repeatThrownByJuan := Repeat initializeCardWithTarget: juan.
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
		
	redoThrownByNico := Redo initializeCardWithTarget: nico.
	game player: juan throw: redoThrownByNico .
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 14;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 13.

	
]

{ #category : #tests }
RedoTest >> testRedoSkipCard [

	| game sofi deckBuilder reverseThrownBySofi redoThrownByNico|
	deckBuilder := DeckBuilder startBuilding.
	deckBuilder add: Reverse ;
					add: Redo .
	deck := deckBuilder buildDeterministic.
	sofi := self playerNamed: 'Sofi'.
	players add: sofi.
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.

	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0;
		assert: (game lapNumberOf: sofi) equals: 0;
		assert: (game lockerNumberOf: sofi) equals: 0.
	
	reverseThrownBySofi := Reverse initializeCard .
	game player: sofi throw: reverseThrownBySofi.
	
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0;
		assert: (game lapNumberOf: sofi) equals: 0;
		assert: (game lockerNumberOf: sofi) equals: 9.
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 3;
		assert: (game lapNumberOf: sofi) equals: 0;
		assert: (game lockerNumberOf: sofi) equals: 9.
	redoThrownByNico := Redo initializeCard .
	game player: nico throw: redoThrownByNico .
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 3;
		assert: (game lapNumberOf: sofi) equals: 0;
		assert: (game lockerNumberOf: sofi) equals: 16.
]

{ #category : #tests }
RedoTest >> testRedoSpeedCard [

	| game  deckBuilder speedThrownByJuan redoThrownByNico|
	deckBuilder := DeckBuilder startBuilding.
	deckBuilder add: Speed ;
					add: Redo .
	deck := deckBuilder buildDeterministic.
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	speedThrownByJuan := Speed initializeCardWithTarget: juan.
	game player: juan throw: speedThrownByJuan.
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 8;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.

	redoThrownByNico := Redo initializeCardWithTarget: nico.
	game player: nico throw: redoThrownByNico .
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 8;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 10.
		
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 12;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 10.
	

	
]

{ #category : #tests }
RedoTest >> testTryToThrowRedoCardBeforeNobodyThrewAnyCard [

	| game deckBuilder|
	deckBuilder := DeckBuilder startBuilding.
	deckBuilder add: Redo .
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
	should: [ game player: juan throw: Redo initializeCard ]
		raise: InvalideRequest
		withMessageText: 'Nobody threw a card yet'.
		
	
]
