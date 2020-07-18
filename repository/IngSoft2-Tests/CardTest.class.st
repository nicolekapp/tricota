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
	self play: game amountOfTurns: 4
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

{ #category : #tests }
CardTest >> testPlayerCanNotThrowCardAfterTheGameHasFinished [

	| game deck deckBuilder effectRouletteBuilder sofi cardToCancell|
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
	
	sofi := (self playerNamed: 'Sofi').
	players add: sofi.
	
	game:= UCABoardGame rolling: die with: players lockers: 8 laps: 2 effects: effectRoulette and: deck.
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
	
	
]
