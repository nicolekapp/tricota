Class {
	#name : #UcaBoardGameWithCardsTest,
	#superclass : #TestCase,
	#instVars : [
		'die',
		'juan',
		'nico',
		'players',
		'effectRoulette'
	],
	#category : #'IngSoft2-Tests-Card-Test'
}

{ #category : #tests }
UcaBoardGameWithCardsTest >> aEffectRouletteWith100ProbabilityOf: effect [

	|  effectRouletteBuilder |
	effectRouletteBuilder:= EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder add: effect.
	^effectRouletteBuilder buildDeterministic. 
]

{ #category : #accessing }
UcaBoardGameWithCardsTest >> finish: game [
	self play: game amountOfTurns: 4
]

{ #category : #accessing }
UcaBoardGameWithCardsTest >> juan [
	^ self playerNamed: 'Juan'.
]

{ #category : #accessing }
UcaBoardGameWithCardsTest >> nico [
	^ self playerNamed: 'Nico'.
]

{ #category : #tests }
UcaBoardGameWithCardsTest >> play: anUCABoardGame amountOfTurns: anInteger [ 
	1 to: anInteger do: [ :number | anUCABoardGame nextTurn ].
]

{ #category : #running }
UcaBoardGameWithCardsTest >> playerNamed: aName [

	^Player named: aName.
]

{ #category : #running }
UcaBoardGameWithCardsTest >> setUp [
|effectRouletteBuilder|
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

]

{ #category : #tests }
UcaBoardGameWithCardsTest >> testAccelerationCardInvalidArgumentsInInicializationMessage [

	| game cards|
"	cards:= OrderedCollection new.
	cards add: Acceleration new.
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette andDeterministic: cards.
	
	self 
	should: [ game player: juan throw: (Acceleration card: Speed new target: NullObject new ) ]
		raise: InstanceCreationFailed 
		withMessageText: 'Invalid Arguments in message'.
		
	self 
	should: [ game player: juan throw: (Acceleration card: NullObject new target: nico ) ]
		raise: InstanceCreationFailed 
		withMessageText: 'Invalid Arguments in message'.
		
	self 
	should: [ game player: juan throw: (Acceleration card: Speed new target: nico ) ]
		raise: InstanceCreationFailed 
		withMessageText: 'Invalid Arguments in message'.
	"
]

{ #category : #tests }
UcaBoardGameWithCardsTest >> testDoubleCard [

	| game cards|
	cards:= OrderedCollection new.
	cards add: Double new.
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette andDeterministic: cards.
	
	game nextTurn.
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 7.		
	game player: juan throw: (Double card: NullObject new target: NullObject new ).
	game nextTurn.
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 7;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 9.
	game nextTurn.
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 7;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 12.
	game nextTurn.
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 14;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 12.

	
]

{ #category : #tests }
UcaBoardGameWithCardsTest >> testRedoAccelerationCard [

	| game  cards|
	cards:= OrderedCollection new.
	cards 
	add: Acceleration new;
	add: Redo new.
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette andDeterministic: cards.
	
	game player: juan throw: (Acceleration card: NullObject new target: NullObject new).
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
		
	game player: juan throw: (Redo card: NullObject new target: NullObject new ).
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 13;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 10.
	

	
]

{ #category : #tests }
UcaBoardGameWithCardsTest >> testRedoCancellationCard [

	| game cards|
	cards:= OrderedCollection new.
	cards 
	add: Acceleration new;
	add: Cancellation new;
	add: Redo new.
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette andDeterministic: cards.
	
	game player: juan throw: (Acceleration card: NullObject new target: NullObject new).
	game nextTurn.
		self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 8.
		
	game player: nico throw: (Acceleration card: NullObject new target: NullObject new).
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 8;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 11.
		
	game player: juan throw: (Cancellation card: Acceleration new target: NullObject new).
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 12;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 11.
		
	"game player: nico throw: (Redo ofCard:(Cancellation selectCard: Acceleration new))."
	game player: nico throw: (Redo card: Acceleration new target: NullObject new).
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 12;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 18.

	
]

{ #category : #tests }
UcaBoardGameWithCardsTest >> testRedoRedoCard [

	| game cards|
	cards:= OrderedCollection new.
	cards 
	add: Acceleration new;
	add: Redo new.
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette andDeterministic: cards.
	
	game player: juan throw: (Acceleration card: NullObject new target: NullObject new).
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
		
	game player: juan throw:(Redo card: NullObject new target: NullObject new).
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 13;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 10.
		
	game player: nico throw:(Redo card: NullObject new target: NullObject new).
	game nextTurn.
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 13;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 20.
	

	
]

{ #category : #tests }
UcaBoardGameWithCardsTest >> testRedoRepeatCard [

	|game  cards effectRouletteBuilder|
	cards:= OrderedCollection new.
	cards 
	add: Acceleration new;
	add: Repeat new;
	add: Redo new.
	effectRouletteBuilder:= EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder add: (PickUpCard withRandom: cards);
	add: NoEffect new;
	add: SpeedUp new.
	effectRoulette:= effectRouletteBuilder buildDeterministic. 
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette andDeterministic: cards.
	game nextTurn.
		self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 7.
		
game player: juan throw: (Repeat card: NullObject new target: juan).
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
		
	game player: nico throw: (Redo card: NullObject new target:nico).
	self
		assert: (game lapNumberOf: juan) equals: 0;
		assert: (game lockerNumberOf: juan) equals: 14;
		assert: (game lapNumberOf: nico) equals: 0;
		assert: (game lockerNumberOf: nico) equals: 13.

	
]

{ #category : #tests }
UcaBoardGameWithCardsTest >> testThrowDoubleCardPlayTurnAndThrowAgainDoubleCard [

	| game cards|
	cards:= OrderedCollection new.
	cards add: Double new.
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette andDeterministic: cards.
	
	game nextTurn.
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 7.		
	game player: juan throw: (Double card: NullObject new target: NullObject new ).
	game nextTurn.
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 7;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 9.
	game player: nico throw: (Double card: NullObject new target: NullObject new ).
	game nextTurn.
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 7;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 12.
	game nextTurn.
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 7;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 19.
	game nextTurn.
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 16;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 19.
]

{ #category : #tests }
UcaBoardGameWithCardsTest >> testThrowMoreThanOneDoubleCardInTheSameTurn [

	| game cards|
	cards:= OrderedCollection new.
	cards add: Double new.
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette andDeterministic: cards.
	
	game nextTurn.
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 7.		
	game player: juan throw: (Double card: NullObject new target: NullObject new ).
	game player: nico throw: (Double card: NullObject new target: NullObject new ).
	game nextTurn.
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 7;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 9.
	game nextTurn.
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 7;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 12.
	game nextTurn.
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 7;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 19.
	game nextTurn.
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 16;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 19.
]

{ #category : #tests }
UcaBoardGameWithCardsTest >> testTryToThrowRedoCardBeforeNobodyThrewAnyCard [

	| game cards |
	
	cards:= OrderedCollection new.
	cards 
	add: Redo new.
	
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: cards.
	
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
	should: [ game player: juan throw: (Redo card: NullObject new target: NullObject new ) ]
		raise: InvalideRequest
		withMessageText: 'Nobody threw a card yet'.
		
	
]
