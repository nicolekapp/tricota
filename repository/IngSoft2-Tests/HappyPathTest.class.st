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

|effectRouletteBuilder  pickUpCards |
	pickUpCards := OrderedCollection new.
	pickUpCards add: Redo new.
	deck:= OrderedCollection new.
	deck
	add: Acceleration  new;
	add: Cancellation new;
	add: Speed new;
	add: Overload new;
	add: Repeat new.
	effectRouletteBuilder := EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder add: SpeedUp new;
	add: (MoonWalk maxBackwards: 5 aNumberOfLockersSequence: #(3));
	add: NoEffect new;
	add: NoEffect new;
	add: (PickUpCard withSequence: pickUpCards);
	add: AtomicBomb new;
	add: WormHole new;
	add: NoEffect new;
	add: NoEffect new;
	add: NoEffect new;
	add: NoEffect new;
	add: SpeedUp new.
	effectRoulette:= effectRouletteBuilder buildDeterministic.

	die := Die of: 10 rolling: #(7 9 10 4 5 7 8 3 9 10 10 2).
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
