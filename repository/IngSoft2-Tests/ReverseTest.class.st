Class {
	#name : #ReverseTest,
	#superclass : #CardTest,
	#instVars : [
		'deck',
		'sofi',
		'pablo'
	],
	#category : #'IngSoft2-Tests-Card-Test'
}

{ #category : #running }
ReverseTest >> setUp [
	| deckBuilder |
	self setUpCard.
	sofi := (Player named: 'Sofi').
	pablo := (Player named: 'Pablo').
	players add: sofi;
			add: pablo.
	deckBuilder := DeckBuilder startBuilding.
	deckBuilder add: Reverse .
	deck := deckBuilder buildDeterministic
]

{ #category : #tests }
ReverseTest >> testReverseCard [

	| game reverseThrownByJuan |

	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.
	
	game nextTurn.
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 7;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 0;
			assert: (game lapNumberOf: sofi) equals: 0;
			assert: (game lockerNumberOf: sofi) equals: 0;
			assert: (game lapNumberOf: pablo) equals: 0;
			assert: (game lockerNumberOf: pablo) equals: 0.		
	game nextTurn.
		self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 7;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 9;
			assert: (game lapNumberOf: sofi) equals: 0;
			assert: (game lockerNumberOf: sofi) equals: 0;
			assert: (game lapNumberOf: pablo) equals: 0;
			assert: (game lockerNumberOf: pablo) equals: 0.
			
	reverseThrownByJuan := Reverse initializeCard .
	game player: juan throw: reverseThrownByJuan .
	
	game nextTurn.
	self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 10;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 9;
			assert: (game lapNumberOf: sofi) equals: 0;
			assert: (game lockerNumberOf: sofi) equals: 0;
			assert: (game lapNumberOf: pablo) equals: 0;
			assert: (game lockerNumberOf: pablo) equals: 0.
	game nextTurn.
	self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 10;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 9;
			assert: (game lapNumberOf: sofi) equals: 0;
			assert: (game lockerNumberOf: sofi) equals: 0;
			assert: (game lapNumberOf: pablo) equals: 0;
			assert: (game lockerNumberOf: pablo) equals: 7.
	game nextTurn.
	self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 10;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 9;
			assert: (game lapNumberOf: sofi) equals: 0;
			assert: (game lockerNumberOf: sofi) equals: 9;
			assert: (game lapNumberOf: pablo) equals: 0;
			assert: (game lockerNumberOf: pablo) equals: 7.
	game nextTurn .
	self
			assert: (game lapNumberOf: juan) equals: 0;
			assert: (game lockerNumberOf: juan) equals: 10;
			assert: (game lapNumberOf: nico) equals: 0;
			assert: (game lockerNumberOf: nico) equals: 12;
			assert: (game lapNumberOf: sofi) equals: 0;
			assert: (game lockerNumberOf: sofi) equals: 9;
			assert: (game lapNumberOf: pablo) equals: 0;
			assert: (game lockerNumberOf: pablo) equals: 7.
]
