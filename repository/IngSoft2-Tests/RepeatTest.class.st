Class {
	#name : #RepeatTest,
	#superclass : #CardTest,
	#instVars : [
		'deck'
	],
	#category : #'IngSoft2-Tests-Card-Test'
}

{ #category : #playing }
RepeatTest >> buildEffectRouletteWhereSecondEffectIs: anEffect [
| effectRouletteBuilder|
	effectRouletteBuilder:= EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder 
				add: PickUpCard new;
				add: anEffect;
				add: NoEffect new.
	^effectRouletteBuilder buildDeterministic. 
]

{ #category : #running }
RepeatTest >> setUp [
	| deckBuilder |
	self setUpCard.
	deckBuilder := DeckBuilder startBuilding.
	deckBuilder add: Repeat.
	deck := deckBuilder buildDeterministic
]

{ #category : #tests }
RepeatTest >> testRepeatAtomicBomb [

	| game repeatThrownByJuan|
	effectRoulette:= self buildEffectRouletteWhereSecondEffectIs: AtomicBomb new.
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	game nextTurn.
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 0;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.
		
	repeatThrownByJuan := Repeat initializeCardWithTarget: juan.
	game player: juan throw: repeatThrownByJuan .

	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 0;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 0.

	
	
]

{ #category : #tests }
RepeatTest >> testRepeatMoonWalk [

	| game repeatThrownByJuan|
	effectRoulette:= self buildEffectRouletteWhereSecondEffectIs:(MoonWalk maxBackwards: 5 aNumberOfLockersSequence: #(2)).
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	game nextTurn.
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 5;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 9.

	repeatThrownByJuan := Repeat initializeCardWithTarget: juan.
	game player: juan throw: repeatThrownByJuan .
	
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 5;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 7.

	
	
]

{ #category : #tests }
RepeatTest >> testRepeatNoEffect [

	| game repeatThrownByJuan|
	effectRoulette:= self buildEffectRouletteWhereSecondEffectIs: NoEffect  new.
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	game nextTurn.
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 9.

	repeatThrownByJuan := Repeat initializeCardWithTarget: nico.
	game player: juan throw: repeatThrownByJuan .
	
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 9.

	
	
]

{ #category : #tests }
RepeatTest >> testRepeatPickUpCard [

	| game repeatThrownByJuan  |
	effectRoulette:= self buildEffectRouletteWhereSecondEffectIs: NoEffect  new.
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: juan numberOfCards equals: 3.

	repeatThrownByJuan := Repeat initializeCardWithTarget: juan.
	game player: juan throw: repeatThrownByJuan .
	
	self
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: juan numberOfCards equals: 3.
	

	
	
]

{ #category : #tests }
RepeatTest >> testRepeatSpeedUp [

	| game repeatThrownByJuan |
	effectRoulette:= self buildEffectRouletteWhereSecondEffectIs: SpeedUp  new.
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	game nextTurn.
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 13.

	repeatThrownByJuan := Repeat initializeCardWithTarget: juan.
	game player: juan throw: repeatThrownByJuan .
	
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 11;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 13.

	
	
]

{ #category : #tests }
RepeatTest >> testRepeatWormHole [

	| game repeatThrownByJuan|
	effectRoulette:= self buildEffectRouletteWhereSecondEffectIs: WormHole new.
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	game nextTurn.
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 5.
		
	repeatThrownByJuan := Repeat initializeCardWithTarget: nico.
	game player: juan throw: repeatThrownByJuan .
	
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 1.

	
	
]

{ #category : #tests }
RepeatTest >> testTryToThrowRepeatCardBeforeNobodyRolledDice [

	| game repeatThrownByJuan |

	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	repeatThrownByJuan := Repeat initializeCardWithTarget: juan.

	self 
	should: [ game player: juan throw: repeatThrownByJuan ]
		raise: InvalidRequest
		withMessageText: 'Nobody rolled the dice yet'.
		
	
]
