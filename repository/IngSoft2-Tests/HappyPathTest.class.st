Class {
	#name : #HappyPathTest,
	#superclass : #TestCase,
	#instVars : [
		'juan',
		'nico',
		'players',
		'die',
		'effectRoulette',
		'effects',
		'noEffect',
		'cards',
		'sofi',
		'deck'
	],
	#category : #'IngSoft2-Tests-HappyPath-Test'
}

{ #category : #accessing }
HappyPathTest >> juan [
	^ self playerNamed: 'Juan'.
]

{ #category : #accessing }
HappyPathTest >> nico [
	^ self playerNamed: 'Nico'.
]

{ #category : #running }
HappyPathTest >> playerNamed: aName [

	^Player named: aName.
]

{ #category : #running }
HappyPathTest >> setUp [
	|effectRouletteBuilder deckBuilder|
	deckBuilder:= DeckBuilder startBuilding.
	deckBuilder add: Acceleration  ;
					add: Cancellation ;
					add: Speed ;
					add: Overload ;
					add: Repeat ;
					add: Acceleration  ;
					add: Double ;
					add: Redo ;
					add: Skip ;
					add: Reverse ;
					add: Double .
	deck:= deckBuilder buildDeterministic .
	effectRouletteBuilder := EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder add: SpeedUp new;
								add: (MoonWalk maxBackwards: 5 aNumberOfLockersSequence: #(3));
								add: NoEffect new;
								add: PickUpCard new;
								add: PickUpCard new;
								add: AtomicBomb new;
								add: WormHole new;
								add: NoEffect new;
								add: PickUpCard new;
								add: PickUpCard new;
								add: PickUpCard new;
								add: SpeedUp new;
								add: AtomicBomb new;
								add: NoEffect new;
								add: NoEffect new;
								add: SpeedUp new;
								add: SpeedUp new;
								add: NoEffect new;
								add: NoEffect new;
								add: NoEffect new;
								add: NoEffect new.
	effectRoulette:= effectRouletteBuilder buildDeterministic.
	
	die := Die of: 10 rolling: #(7 9 10 4 5 7 8 3 9 10 10 2 8 4 5 10 7 9 8 5 10 9 7).
	juan := self juan.
	nico := self nico.
	sofi:= self sofi.
	players := OrderedCollection new.
	players
		add: juan;
		add: nico;
		add: sofi.

]

{ #category : #accessing }
HappyPathTest >> sofi [
	^ self playerNamed: 'Sofi'.
]
