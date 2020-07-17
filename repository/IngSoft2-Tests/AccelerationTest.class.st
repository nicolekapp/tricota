Class {
	#name : #AccelerationTest,
	#superclass : #CardTest,
	#instVars : [
		'deck'
	],
	#category : #'IngSoft2-Tests-Card-Test'
}

{ #category : #running }
AccelerationTest >> setUp [
	|deckBuilder|
	self setUpCard.
	deckBuilder:= DeckBuilder startBuilding.
	deckBuilder add: Acceleration new.
	deck:= deckBuilder buildDeterministic .

]

{ #category : #tests }
AccelerationTest >> testAccelerationCardApplysToEveryone [

	| game accelerationThrownByJuan |

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
			
	game nextTurn.
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 12;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 10.
	game nextTurn.
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 12;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 18.
	
	
]

{ #category : #tests }
AccelerationTest >> testCantThrowAccelerationCardIfItsNotYourTurn [

	| game accelerationThrownByJuan accelerationThrownByNico|

	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	accelerationThrownByJuan := PermanentCard type: Acceleration new target: Everyone new.
	accelerationThrownByNico := PermanentCard type: Acceleration new target: Everyone new.
	
	self
		should: [ game player: nico throw: accelerationThrownByNico ]
		raise: InvalideRequest 
		withMessageText: 'It is not your turn'.
	
	game nextTurn.

	self
		should: [ game player: juan throw: accelerationThrownByJuan ]
		raise: InvalideRequest 
		withMessageText: 'It is not your turn'.
]

{ #category : #tests }
AccelerationTest >> testThrowMoreThanOneAccelerationCard [

	| game firstAccelerationThrownByJuan secondAccelerationThrownByJuan accelerationThrownByNico|

	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	firstAccelerationThrownByJuan := PermanentCard type: Acceleration new target: Everyone new.
	game player: juan throw: firstAccelerationThrownByJuan .
	game nextTurn.
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 8.		
					
	accelerationThrownByNico := PermanentCard type: Acceleration new target: Everyone new.
	game player: nico throw: accelerationThrownByNico.
	game nextTurn.
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 8;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 11.
			
	secondAccelerationThrownByJuan := PermanentCard type: Acceleration new target: Everyone new.
	game player: juan throw: secondAccelerationThrownByJuan .
	game nextTurn.
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 14;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 11.
	game nextTurn.
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 14;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 21.
	
	
]
