Class {
	#name : #OverloadTest,
	#superclass : #CardTest,
	#instVars : [
		'deck'
	],
	#category : #'IngSoft2-Tests-Card-Test'
}

{ #category : #running }
OverloadTest >> setUp [
	| deckBuilder |
	self setUpCard.
	deckBuilder := DeckBuilder startBuilding.
	deckBuilder add: Overload .
	deck := deckBuilder buildDeterministic
]

{ #category : #tests }
OverloadTest >> testCantThrowOverloadCardIfItsNotYourTurn [

	| game overloadThrownByJuan overloadThrownByNico|

	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	overloadThrownByJuan := Overload initializeCardWithTarget: nico.
	overloadThrownByNico := Overload initializeCardWithTarget: juan.
	
	self
		should: [ game player: nico throw: overloadThrownByNico ]
		raise: InvalidRequest 
		withMessageText: 'It is not your turn'.
	
	game nextTurn.

	self
		should: [ game player: juan throw: overloadThrownByJuan ]
		raise: InvalidRequest 
		withMessageText: 'It is not your turn'.

	
	
]

{ #category : #tests }
OverloadTest >> testMoveBackwardsAsResultOfOverloadCards [

	| game firstOverloadThrownByNico secondOverloadThrownByNico |
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.

	game nextTurn.
		self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7.
		
	firstOverloadThrownByNico := Overload initializeCardWithTarget:  juan.
	game player: nico throw: firstOverloadThrownByNico .
	secondOverloadThrownByNico := Overload initializeCardWithTarget:  juan.
	game player: nico throw: secondOverloadThrownByNico .
	
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 9.
		
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 6;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 9.
	

	
	
]

{ #category : #tests }
OverloadTest >> testOverloadCardOnlyApllyToItsTarget [

	| game overloadThrownByNico|
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	game nextTurn.
		self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7.
		
	overloadThrownByNico := Overload initializeCardWithTarget:  juan.
	game player: nico throw: overloadThrownByNico .
	
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 9.
		
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 8;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 9.
	

	
	
]

{ #category : #tests }
OverloadTest >> testPlayerInLapOneMovesBackwardsAndChangesLapToZero [

	| game firstOverloadThrownByNico secondOverloadThrownByNico |
	die := Die of: 10 rolling: #(7 2 1).
	game:= UCABoardGame rolling: die with: players lockers: 6 laps: 2 effects: effectRoulette and: deck.

	game nextTurn.
		self
		assert: (game lapNumberOf: juan) equals: 1;
		assert: (game lockerNumberOf: juan) equals: 1;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.
		
	firstOverloadThrownByNico := Overload initializeCardWithTarget:  juan.
	game player: nico throw: firstOverloadThrownByNico  .
	secondOverloadThrownByNico := Overload initializeCardWithTarget:  juan.
	game player: nico throw: secondOverloadThrownByNico .
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 1;
		assert: (game lockerNumberOf: juan) equals: 1;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 2.
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 4;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 2.
	

	

	
	
]

{ #category : #tests }
OverloadTest >> testStayInLockerAndLapZeroIfResultOfDiceAndOverloadCardIsNegative [

	| game firstOverloadThrownByJuan secondOverloadThrownByJuan |
	die := Die of: 10 rolling: #(7 2).
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.

	firstOverloadThrownByJuan := Overload initializeCardWithTarget:  nico.
	game player: juan throw: firstOverloadThrownByJuan .
	secondOverloadThrownByJuan := Overload initializeCardWithTarget:  nico.
	game player: juan throw: secondOverloadThrownByJuan .
	game nextTurn.
		self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.
	
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.

	

	
	
]

{ #category : #tests }
OverloadTest >> testThrowMoreThanOneOverloadCard [

	| game overloadThrownByJuan firstOverloadThrownByNico secondOverloadThrownByNico |
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	overloadThrownByJuan := Overload initializeCardWithTarget:  nico.
	game player: juan throw: overloadThrownByJuan .
	game nextTurn.
		self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7.
		
	firstOverloadThrownByNico := Overload initializeCardWithTarget:  juan.
	game player: nico throw: firstOverloadThrownByNico .
	secondOverloadThrownByNico := Overload initializeCardWithTarget:  juan.
	game player: nico throw: secondOverloadThrownByNico .
	
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 7.
		
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 6;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 7.
	

	
	
]
