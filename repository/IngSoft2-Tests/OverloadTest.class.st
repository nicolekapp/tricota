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
		raise: InvalideRequest 
		withMessageText: 'It is not your turn'.
	
	game nextTurn.

	self
		should: [ game player: juan throw: overloadThrownByJuan ]
		raise: InvalideRequest 
		withMessageText: 'It is not your turn'.

	
	
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
