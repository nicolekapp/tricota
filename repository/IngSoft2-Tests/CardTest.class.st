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
CardTest >> juan [
	^ self playerNamed: 'Juan'.
]

{ #category : #accessing }
CardTest >> nico [
	^ self playerNamed: 'Nico'.
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
