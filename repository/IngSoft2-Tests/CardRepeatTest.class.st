Class {
	#name : #CardRepeatTest,
	#superclass : #TestCase,
	#instVars : [
		'die',
		'juan',
		'nico',
		'players',
		'cards'
	],
	#category : #'IngSoft2-Tests-Card-Test'
}

{ #category : #tests }
CardRepeatTest >> aEffectRouletteWith100ProbabilityOf: effect [

	|  effectRouletteBuilder |
	effectRouletteBuilder:= EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder add: effect.
	^effectRouletteBuilder buildDeterministic. 
]

{ #category : #playing }
CardRepeatTest >> buildEffectRouletteWhereSecondEffectIs: anEffect [
| effectRouletteBuilder|
	effectRouletteBuilder:= EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder 
				add: (PickUpCard withRandom: cards);
				add: anEffect;
				add: NoEffect new.
	^effectRouletteBuilder buildDeterministic. 
]

{ #category : #accessing }
CardRepeatTest >> finish: game [
	self play: game amountOfTurns: 4
]

{ #category : #accessing }
CardRepeatTest >> juan [
	^ self playerNamed: 'Juan'.
]

{ #category : #accessing }
CardRepeatTest >> nico [
	^ self playerNamed: 'Nico'.
]

{ #category : #tests }
CardRepeatTest >> play: anUCABoardGame amountOfTurns: anInteger [ 
	1 to: anInteger do: [ :number | anUCABoardGame nextTurn ].
]

{ #category : #running }
CardRepeatTest >> playerNamed: aName [

	^Player named: aName.
]

{ #category : #running }
CardRepeatTest >> setUp [
		die := Die of: 10 rolling: #(7 9 3).
	juan := self juan.
	nico := self nico.
	players := OrderedCollection new.
	players
		add: juan;
		add: nico.
	cards:= OrderedCollection new.
	cards 
	add: Repeat new.

]

{ #category : #tests }
CardRepeatTest >> testRepeatAtomicBomb [

	| game effectRoulette |
	effectRoulette:= self buildEffectRouletteWhereSecondEffectIs: AtomicBomb new.
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: cards.
	
	game nextTurn.
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 0;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.
	game player: juan throw: (Repeat card: NullObject new target: juan).
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 0;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.

	
	
]

{ #category : #tests }
CardRepeatTest >> testRepeatMoonWalk [

	| game effectRoulette |
	effectRoulette:= self buildEffectRouletteWhereSecondEffectIs:(MoonWalk maxBackwards: 5 aNumberOfLockersSequence: #(2)).
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: cards.
	
	game nextTurn.
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 5;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 9.
	game player: juan throw: (Repeat card: NullObject new target: juan).
	
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 5;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 7.

	
	
]

{ #category : #tests }
CardRepeatTest >> testRepeatNoEffect [

	| game effectRoulette|
	effectRoulette:= self buildEffectRouletteWhereSecondEffectIs: NoEffect  new.
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: cards.
	
	game nextTurn.
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 9.
	game player: juan throw: (Repeat card: NullObject new target: nico).
	
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 9.

	
	
]

{ #category : #tests }
CardRepeatTest >> testRepeatPickUpCard [

	| game effectRoulette  |
	effectRoulette:= self buildEffectRouletteWhereSecondEffectIs: NoEffect  new.
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: cards.
	
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: juan numberOfCards equals: 3.
		
	game player: juan throw: (Repeat card: NullObject target: juan).
	self
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: juan numberOfCards equals: 3.
	

	
	
]

{ #category : #tests }
CardRepeatTest >> testRepeatSpeedUp [

	| game effectRoulette |
	effectRoulette:= self buildEffectRouletteWhereSecondEffectIs: SpeedUp  new.
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: cards.
	
	game nextTurn.
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 13.
	game player: juan throw: (Repeat card: NullObject new target: juan).
	
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 11;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 13.

	
	
]

{ #category : #tests }
CardRepeatTest >> testRepeatWormHole [

	| game effectRoulette|
	effectRoulette:= self buildEffectRouletteWhereSecondEffectIs: WormHole new.
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: cards.
	
	game nextTurn.
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 5.
		
	game player: juan throw: (Repeat card: NullObject new target: nico).
	
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 1.

	
	
]

{ #category : #tests }
CardRepeatTest >> testTryToThrowRepeatCardBeforeNobodyRolledDice [

	| game effectRoulette |
	effectRoulette:= self buildEffectRouletteWhereSecondEffectIs: NoEffect new.
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: cards.
	self 
	should: [ game player: juan throw: (Repeat card: NullObject new target: juan) ]
		raise: InvalideRequest
		withMessageText: 'Nobody rolled the dice yet'.
		
	
]
