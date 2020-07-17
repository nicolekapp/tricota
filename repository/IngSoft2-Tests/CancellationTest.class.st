Class {
	#name : #CancellationTest,
	#superclass : #CardTest,
	#instVars : [
		'deck'
	],
	#category : #'IngSoft2-Tests-Card-Test'
}

{ #category : #running }
CancellationTest >> setUp [

	self setUpCard.


]

{ #category : #tests }
CancellationTest >> testCancellationAfterTwoSpeedCardSelectingOne [

	| game deckBuilder speedThrownByJuan speedThrownByNico cancellationThrownByJuan|
	deckBuilder := DeckBuilder startBuilding.
	deckBuilder add: Speed new;
					add: Cancellation new.
	deck := deckBuilder buildDeterministic.
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	speedThrownByJuan := PermanentCard type: Speed new target: nico.
	game player: juan throw: speedThrownByJuan .
	
	game nextTurn.
		self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7.
	
	speedThrownByNico := PermanentCard type: Speed new target: nico.
	game player: nico throw: speedThrownByNico .
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 11.
		
	cancellationThrownByJuan := InstantCard type: Cancellation new target: speedThrownByNico.
	game player: juan throw: cancellationThrownByJuan .
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 10;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 11.
		
	game nextTurn.
		self 
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 10;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 19.

	
]

{ #category : #tests }
CancellationTest >> testCancellationOfAccelerationCard [

	| game deckBuilder accelerationThrownByJuan cancellationThrownByNico|
	deckBuilder := DeckBuilder startBuilding.
	deckBuilder add: Acceleration new;
					add: Cancellation new.
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
		
	cancellationThrownByNico := InstantCard type: Cancellation new target: accelerationThrownByJuan.
	game player: juan throw: cancellationThrownByNico .
	
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 11;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 10.
	

	
]
