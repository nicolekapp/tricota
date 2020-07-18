Class {
	#name : #CardTest,
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

{ #category : #accessing }
CardTest >> aEffectRouletteWith100ProbabilityOf: effect [

	|  effectRouletteBuilder |
	effectRouletteBuilder:= EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder add: effect.
	^effectRouletteBuilder buildDeterministic. 
]

{ #category : #accessing }
CardTest >> finish: game [
	self play: game amountOfTurns: 5
]

{ #category : #accessing }
CardTest >> juan [
	^ self playerNamed: 'Juan'.
]

{ #category : #accessing }
CardTest >> nico [
	^ self playerNamed: 'Nico'.
]

{ #category : #tests }
CardTest >> play: anUCABoardGame amountOfTurns: anInteger [ 
	1 to: anInteger do: [ :number | anUCABoardGame nextTurn ].
]

{ #category : #accessing }
CardTest >> playerNamed: aName [

	^Player named: aName.
]

{ #category : #running }
CardTest >> setUpCard [
	| effectRouletteBuilder |
	die := Die of: 10 rolling: #(7 9 3).
	juan := self juan.
	nico := self nico.
	players := OrderedCollection new.
	players
		add: juan;
		add: nico.
	effectRouletteBuilder := EffectRouletteBuilder
		buildingDeterministicRoulette.
	effectRouletteBuilder add: NoEffect new.
	effectRoulette := effectRouletteBuilder buildDeterministic
]

{ #category : #running }
CardTest >> testPlayerCanNotThrowAnyCardAfterTheGameHasFinished [

	| game deck deckBuilder effectRouletteBuilder cardToCancell|
	self setUpCard.
	effectRouletteBuilder := EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder add: PickUpCard new.
	effectRoulette := effectRouletteBuilder buildDeterministic.
	
	deckBuilder:= DeckBuilder startBuilding.
	deckBuilder 	add: Acceleration new;
					add: Cancellation new;
					add: Double new;
					add: Overload new;
					add: Redo new;
					add: Repeat new;
					add: Reverse new;
					add: Skip new;
					add: Speed new.
	deck:= deckBuilder buildDeterministic .
	
	game:= UCABoardGame rolling: die with: players lockers: 9 laps: 2 effects: effectRoulette and: deck.
	self finish: game.
	cardToCancell:= PermanentCard type: Acceleration new target: Everyone new.
	
	self 
	should: [ game player: juan throw: (PermanentCard type: Acceleration new target: Everyone new) ]
		raise: InvalideRequest
		withMessageText: 'The game has finished'.
	self 
	should: [ game player: nico throw: (InstantCard type: Cancellation new target: cardToCancell) ]
		raise: InvalideRequest
		withMessageText: 'The game has finished'.
	self 
	should: [ game player: juan throw: (InstantCard type: Double new) ]
		raise: InvalideRequest
		withMessageText: 'The game has finished'.
	self 
	should: [ game player: nico throw: (PermanentCard type: Overload new target: juan) ]
		raise: InvalideRequest
		withMessageText: 'The game has finished'.
	self 
	should: [ game player: juan throw: (InstantCard type: Redo new target: nico) ]
		raise: InvalideRequest
		withMessageText: 'The game has finished'.
	self 
	should: [ game player: nico throw: (InstantCard type: Repeat new target: nico) ]
		raise: InvalideRequest
		withMessageText: 'The game has finished'.
	self 
	should: [ game player: juan throw: (InstantCard type: Reverse new) ]
		raise: InvalideRequest
		withMessageText: 'The game has finished'.
	self 
	should: [ game player: nico throw: (InstantCard type: Skip new) ]
		raise: InvalideRequest
		withMessageText: 'The game has finished'.
	self 
	should: [ game player: nico throw: (PermanentCard type: Speed new target: nico) ]
		raise: InvalideRequest
		withMessageText: 'The game has finished'.
	
]
