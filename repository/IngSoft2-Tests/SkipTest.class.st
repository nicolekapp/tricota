Class {
	#name : #SkipTest,
	#superclass : #CardTest,
	#instVars : [
		'deck'
	],
	#category : #'IngSoft2-Tests-Card-Test'
}

{ #category : #running }
SkipTest >> setUp [
	| deckBuilder |
	self setUpCard.
	deckBuilder := DeckBuilder startBuilding.
	deckBuilder add: Skip new.
	deck := deckBuilder buildDeterministic

]

{ #category : #tests }
SkipTest >> testSkipCard [

	| game skipThrownByJuan|

	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	game nextTurn.
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 7.		
					
	skipThrownByJuan := InstantCard type: Skip new.
	game player: juan throw: skipThrownByJuan .

	game nextTurn.
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 16;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 0.
	
]
