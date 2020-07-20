Class {
	#name : #SkipTest,
	#superclass : #CardTest,
	#instVars : [
		'deck',
		'sofi'
	],
	#category : #'IngSoft2-Tests-Card-Test'
}

{ #category : #running }
SkipTest >> setUp [
	| deckBuilder |
	self setUpCard.
	sofi := (Player named: 'Sofi').
	players add: sofi.
	deckBuilder := DeckBuilder startBuilding.
	deckBuilder add: Skip .
	deck := deckBuilder buildDeterministic

]

{ #category : #tests }
SkipTest >> testSkipCard [

	| game skipThrownBySofi |

	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	game nextTurn."Nico rolled 7"
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 7;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 0;
			assert: (game lapNumberOf: sofi) equals: 0;
			assert: (game lockerNumberOf: sofi) equals: 0.
					
	skipThrownBySofi := Skip initializeCard .
	game player: sofi throw: skipThrownBySofi .

	game nextTurn."Sofi threw skip card, its her turn and rolled 9"
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 7;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 0;
			assert: (game lapNumberOf: sofi) equals: 0;
			assert: (game lockerNumberOf: sofi) equals: 9.
]

{ #category : #tests }
SkipTest >> testThrowTwoSkipCardConsecutive [

	| game skipThrownByJuan skipThrownBySofi|

	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	game nextTurn."Juan rolled 7"
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 7;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 0;
			assert: (game lapNumberOf: sofi) equals: 0;
			assert: (game lockerNumberOf: sofi) equals: 0.
	
	skipThrownBySofi := Skip initializeCard .
	game player: sofi throw: skipThrownBySofi .			
	skipThrownByJuan := Skip initializeCard .
	game player: juan throw: skipThrownByJuan .

	game nextTurn."Two skip cards were throwed, its juans turn and rolled 9"
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 16;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 0;
			assert: (game lapNumberOf: sofi) equals: 0;
			assert: (game lockerNumberOf: sofi) equals: 0.
	
]
