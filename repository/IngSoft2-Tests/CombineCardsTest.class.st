Class {
	#name : #CombineCardsTest,
	#superclass : #TestCase,
	#instVars : [
		'die',
		'juan',
		'nico',
		'players',
		'effectRoulette',
		'deck',
		'sofi'
	],
	#category : #'IngSoft2-Tests-Card-Test'
}

{ #category : #accessing }
CombineCardsTest >> juan [
	^ self playerNamed: 'Juan'.
]

{ #category : #accessing }
CombineCardsTest >> nico [
	^ self playerNamed: 'Nico'.
]

{ #category : #running }
CombineCardsTest >> playerNamed: aName [

	^Player named: aName.
]

{ #category : #running }
CombineCardsTest >> setUp [
	| effectRouletteBuilder |
	die := Die of: 10 rolling: #(7 9 3).
	juan := self juan.
	nico := self nico.
	sofi := self sofi.
	players := OrderedCollection new.
	players
		add: juan;
		add: nico;
		add: sofi.
	effectRouletteBuilder := EffectRouletteBuilder
		buildingDeterministicRoulette.
	effectRouletteBuilder add: NoEffect new.
	effectRoulette := effectRouletteBuilder buildDeterministic
]

{ #category : #accessing }
CombineCardsTest >> sofi [
	^ self playerNamed: 'Sofi'.
]

{ #category : #tests }
CombineCardsTest >> testCombineAccelerationOverloadAndSpeedCards [
	
	| deckBuilder game accelerationThrownByJuan overloadThrownByJuan  speedThrownByNico accelerationThrownByNico speedThrownBySofi |
	deckBuilder:= DeckBuilder startBuilding.
	deckBuilder add: Acceleration ; 	"Juan has Acceleration & Overload"
					add: Overload ;			"Nico has Speed & Acceleration"
					add: Speed.				"Sofi has Overload & Speed"
	deck:= deckBuilder buildDeterministic .
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.

	accelerationThrownByJuan := Acceleration initializeCard.
	game player: juan throw: accelerationThrownByJuan .
	overloadThrownByJuan := Overload initializeCardWithTarget: nico.
	game player: juan throw: overloadThrownByJuan .
	
	game nextTurn.
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 8;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 0;
			assert: (game lapNumberOf: sofi) equals: 0;
			assert: (game lockerNumberOf: sofi) equals: 0.

	accelerationThrownByNico := Acceleration initializeCard.
	game player: nico throw: accelerationThrownByNico .
	speedThrownByNico := Speed initializeCardWithTarget: nico.
	game player: nico throw: speedThrownByNico .
	
	game nextTurn.
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 8;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 10;
			assert: (game lapNumberOf: sofi) equals: 0;
			assert: (game lockerNumberOf: sofi) equals: 0.
			
	speedThrownBySofi := Speed initializeCardWithTarget: sofi.
	game player: sofi throw: speedThrownBySofi .
	
	game nextTurn.
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 8;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 10;
			assert: (game lapNumberOf: sofi) equals: 0;
			assert: (game lockerNumberOf: sofi) equals: 6.
]

{ #category : #tests }
CombineCardsTest >> testCombineDoubleWithAccelerationAndSpeedCards [
	
	| deckBuilder game doubleThrownByNico accelerationThrownByJuan speedThrownByJuan |
	
	deckBuilder:= DeckBuilder startBuilding.
	deckBuilder add: Speed ; 	"Juan has Speed & Acceleration"
					add: Acceleration ;	"Nico has Double & Speed"
					add: Double.				"Sofi has Acceleration & Double"
	deck:= deckBuilder buildDeterministic .
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.

	accelerationThrownByJuan := Acceleration initializeCard.
	game player: juan throw: accelerationThrownByJuan .

	game nextTurn.
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 8;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 0;
			assert: (game lapNumberOf: sofi) equals: 0;
			assert: (game lockerNumberOf: sofi) equals: 0.
	
	speedThrownByJuan := Speed initializeCardWithTarget: nico.
	game player: nico throw: speedThrownByJuan .
	doubleThrownByNico := Double initializeCard.
	game player: nico throw: doubleThrownByNico .

	game nextTurn. "Nico rolled 9 and 3 (12) plus 2 (one locker for Aceleration and anotherone for Speed)"
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 8;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 14;
			assert: (game lapNumberOf: sofi) equals: 0;
			assert: (game lockerNumberOf: sofi) equals: 0.

]

{ #category : #tests }
CombineCardsTest >> testThrowDoubleAndReverseConsecutive [
	
	| deckBuilder game doubleThrownByNico reverseThrownByJuan |
	deckBuilder:= DeckBuilder startBuilding.
	deckBuilder add: Reverse; 	"Juan has Reverse & Reverse"
					add: Reverse ;	"Nico has Double & Reverse"
					add: Double.		"Sofi has Reverse & Double"
	deck:= deckBuilder buildDeterministic .
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	game nextTurn.
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 7;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 0;
			assert: (game lapNumberOf: sofi) equals: 0;
			assert: (game lockerNumberOf: sofi) equals: 0.

	doubleThrownByNico := Double initializeCard.
	game player: nico throw: doubleThrownByNico .
	reverseThrownByJuan := Reverse initializeCard.
	game player: juan throw: reverseThrownByJuan .
	
	game nextTurn.
	self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 7;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 0;
			assert: (game lapNumberOf: sofi) equals: 0;
			assert: (game lockerNumberOf: sofi) equals: 9.
]

{ #category : #tests }
CombineCardsTest >> testThrowDoubleAndSkipConsecutive [
	
	| deckBuilder game doubleThrownByJuan skipThrownByNico |
	deckBuilder:= DeckBuilder startBuilding.
	deckBuilder add: Double; 	"Juan has Double & Double"
					add: Double ;	"Nico has Skip & Double"
					add: Skip.		"Sofi has Double & Skip"
	deck:= deckBuilder buildDeterministic .
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.

	doubleThrownByJuan := Double initializeCard.
	game player: juan throw: doubleThrownByJuan .
	skipThrownByNico := Skip initializeCard.
	game player: nico throw: skipThrownByNico .
	
	game nextTurn.
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 0;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 7;
			assert: (game lapNumberOf: sofi) equals: 0;
			assert: (game lockerNumberOf: sofi) equals: 0.
]
