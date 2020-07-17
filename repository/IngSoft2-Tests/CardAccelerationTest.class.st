Class {
	#name : #CardAccelerationTest,
	#superclass : #TestCase,
	#instVars : [
		'die',
		'juan',
		'nico',
		'players',
		'effectRoulette',
		'deck'
	],
	#category : #'IngSoft2-Tests-Card-Test'
}

{ #category : #tests }
CardAccelerationTest >> aEffectRouletteWith100ProbabilityOf: effect [

	|  effectRouletteBuilder |
	effectRouletteBuilder:= EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder add: effect.
	^effectRouletteBuilder buildDeterministic. 
]

{ #category : #accessing }
CardAccelerationTest >> juan [
	^ self playerNamed: 'Juan'.
]

{ #category : #accessing }
CardAccelerationTest >> nico [
	^ self playerNamed: 'Nico'.
]

{ #category : #running }
CardAccelerationTest >> playerNamed: aName [

	^Player named: aName.
]

{ #category : #running }
CardAccelerationTest >> setUp [
|effectRouletteBuilder deckBuilder|
	die := Die of: 10 rolling: #(7 9 3).
	juan := self juan.
	nico := self nico.
	players := OrderedCollection new.
	players
		add: juan;
		add: nico.
	effectRouletteBuilder:= EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder add: NoEffect  new.
	effectRoulette:= effectRouletteBuilder buildDeterministic. 
	deckBuilder:= DeckBuilder startBuilding.
	deckBuilder add: Acceleration new.
	deck:= deckBuilder buildDeterministic .

]

{ #category : #tests }
CardAccelerationTest >> testAccelerationCardApplysToEveryone [

	| game accelerationThrownByJuan |

	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	accelerationThrownByJuan := Card type: Acceleration new target: Target none.
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
CardAccelerationTest >> testCantThrowAccelerationCardIfItsNotYourTurn [

	| game accelerationThrownByJuan accelerationThrownByNico|

	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	accelerationThrownByJuan := Card type: Acceleration new target: Target none.
	accelerationThrownByNico := Card type: Acceleration new target: Target none.
	
	self
		should: [ game player: juan throw: accelerationThrownByNico ]
		raise: InvalideRequest 
		withMessageText: 'It is not your turn'.
	
	game nextTurn.

	self
		should: [ game player: juan throw: accelerationThrownByJuan ]
		raise: InvalideRequest 
		withMessageText: 'It is not your turn'.
]

{ #category : #tests }
CardAccelerationTest >> testThrowMoreThanOneAccelerationCard [

	| game firstAccelerationThrownByJuan secondAccelerationThrownByJuan accelerationThrownByNico|

	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	firstAccelerationThrownByJuan := Card type: Acceleration new target: Target none.
	game player: juan throw: firstAccelerationThrownByJuan .
	game nextTurn.
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 8.		
					
	accelerationThrownByNico := Card type: Acceleration new target: Target none.
	game player: nico throw: accelerationThrownByNico.
	game nextTurn.
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 8;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 11.
			
	secondAccelerationThrownByJuan := Card type: Acceleration new target: Target none.
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
