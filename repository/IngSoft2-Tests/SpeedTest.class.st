Class {
	#name : #SpeedTest,
	#superclass : #CardTest,
	#instVars : [
		'deck'
	],
	#category : #'IngSoft2-Tests-Card-Test'
}

{ #category : #running }
SpeedTest >> setUp [
	| deckBuilder |
	self setUpCard.
	deckBuilder := DeckBuilder startBuilding.
	deckBuilder add: Speed .
	deck := deckBuilder buildDeterministic

]

{ #category : #tests }
SpeedTest >> testCantThrowSpeedCardIfItsNotYourTurn [

	| game speedThrownByJuan speedThrownByNico|

	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	speedThrownByJuan := Speed initializeCardWithTarget: juan.
	speedThrownByNico := Speed initializeCardWithTarget: nico.
	
	self
		should: [ game player: nico throw: speedThrownByNico ]
		raise: InvalidRequest 
		withMessageText: 'It is not your turn'.
	
	game nextTurn.

	self
		should: [ game player: juan throw: speedThrownByJuan ]
		raise: InvalidRequest 
		withMessageText: 'It is not your turn'.
		


	
	
]

{ #category : #tests }
SpeedTest >> testPlayerChangesLapBecauseOfTheExtraLockersOfSpeedCard [

	| game speedThrownByNico speedThrownByJuan  |
	
	game:= UCABoardGame rolling: die with: players lockers: 10 laps: 2 effects: effectRoulette and: deck.
	
	speedThrownByJuan := PermanentCard type: Speed new target: nico.
	game player: juan throw: speedThrownByJuan .
	game nextTurn.
		self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.

	speedThrownByNico := PermanentCard type: Speed new target: nico.
	game player: nico throw: speedThrownByNico .
	
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 1;
		assert: (game lockerNumberOf: nico) equals: 1.
]

{ #category : #tests }
SpeedTest >> testSpeedCardOnlyApllyToItsTarget [

	| game speedThrownByNico |
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
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
		assert: (game lockerNumberOf: nico) equals: 10.
	
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 10;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 10.


	
	
]

{ #category : #tests }
SpeedTest >> testThrowMoreThanOneSpeedCard [ 

	| game speedThrownByNico firstSpeedThrownByJuan secondSpeedThrownByJuan |
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	firstSpeedThrownByJuan := PermanentCard type: Speed new target: juan.
	game player: juan throw: firstSpeedThrownByJuan .
	game nextTurn.
		self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 8;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.

	speedThrownByNico := PermanentCard type: Speed new target: nico.
	game player: nico throw: speedThrownByNico .
	
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 8;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 10.
	
	secondSpeedThrownByJuan := PermanentCard type: Speed new target: juan.
	game player: juan throw: secondSpeedThrownByJuan .
	game nextTurn.
		self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 13;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 10.
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 13;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 18.


	
	
]
