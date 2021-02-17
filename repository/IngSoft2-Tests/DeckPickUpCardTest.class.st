Class {
	#name : #DeckPickUpCardTest,
	#superclass : #TestCase,
	#instVars : [
		'die',
		'juan',
		'nico',
		'players',
		'effectRoulette',
		'deck',
		'discardDeck'
	],
	#category : #'IngSoft2-Tests-Deck-Tests'
}

{ #category : #tests }
DeckPickUpCardTest >> aEffectRouletteWith100ProbabilityOf: effect [

	|  effectRouletteBuilder |
	effectRouletteBuilder:= EffectRouletteBuilder buildingDeterministicRoulette.
	effectRouletteBuilder add: effect.
	^effectRouletteBuilder buildDeterministic. 
]

{ #category : #juan }
DeckPickUpCardTest >> juan [
	^ self playerNamed: 'Juan'.
]

{ #category : #nico }
DeckPickUpCardTest >> nico [
	^ self playerNamed: 'Nico'.
]

{ #category : #'as yet unclassified' }
DeckPickUpCardTest >> playerNamed: aName [

	^Player named: aName.
]

{ #category : #running }
DeckPickUpCardTest >> setUp [

	die := Die of: 10 rolling: #(7 9 3).
	juan := self juan.
	nico := self nico.
	players := OrderedCollection new.
	players
		add: juan;
		add: nico.

]

{ #category : #tests }
DeckPickUpCardTest >> testDeterministicDeckWithSizeAndPlayerPickUpCardEffectDeckTurnsEmptyAndNoCardWasThrown [

	| game deckBuilder |

	deckBuilder:= DeckBuilder startBuilding.
	deckBuilder add: Acceleration;
					add: Speed;
					add: Acceleration;
					add: Speed;
					add: Repeat;
					add: Overload.
					
	deck:= deckBuilder buildDeterministicWithSize: 6.
	
	effectRoulette:= self aEffectRouletteWith100ProbabilityOf: (PickUpCard new).
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.

	self assert: juan numberOfCards equals: 2;
		assert: (juan assertHasCard: Acceleration initializeCard );
		assert: (juan assertHasCard: Speed initializeCard );
	 	assert: nico numberOfCards equals: 2;
		assert: (juan assertHasCard: Acceleration initializeCard );
		assert: (juan assertHasCard: Speed initializeCard ).
	
	
	game nextTurn. "The effect of this turn was PickUpCard. The card juan picked up was Repeat"
	self assert: juan numberOfCards equals: 3.
	self assert: (juan assertHasCard: Repeat initializeCard ).

	game nextTurn. "The effect of this turn was PickUpCard. The card nico picked up was Overload"
	self assert: nico numberOfCards equals: 3.
	self assert: (nico assertHasCard: Overload initializeCard ).
	
	self assert: deck numberOfCards equals: 0.	
	self
		should: [ game shuffleDiscardDeck ]
		raise: InvalidRequest 
		withMessageText: 'Cannot shuffle empty deck'.
		
	game nextTurn. "The effect of this turn was PickUpCard. Deck and DiscardDeck are empty. Juan is not able to pick up another card" 
	self assert: juan numberOfCards equals: 3.
	self assert: deck numberOfCards equals: 0.

]

{ #category : #tests }
DeckPickUpCardTest >> testDeterministicDeckWithSizeAndPlayerPickUpCardEffectDeckTurnsEmptyAndNoCardWasThrownUntilPlayerThrowsCardCanPickUpAgain [

	| game deckBuilder accelerationThrownByNico |

	deckBuilder:= DeckBuilder startBuilding.
	deckBuilder add: Acceleration;
					add: Speed;
					add: Acceleration;
					add: Speed;
					add: Overload;
					add: Repeat.
					
	deck:= deckBuilder buildDeterministicWithSize: 6.

	effectRoulette:= self aEffectRouletteWith100ProbabilityOf: (PickUpCard new).
	game:= UCABoardGame rolling: die with: players lockers: 60 laps: 2 effects: effectRoulette and: deck.

	self assert: juan numberOfCards equals: 2;
		assert: (juan assertHasCard: Acceleration initializeCard );
		assert: (juan assertHasCard: Speed initializeCard );
	 	assert: nico numberOfCards equals: 2;
		assert: (juan assertHasCard: Acceleration initializeCard );
		assert: (juan assertHasCard: Speed initializeCard ).
	
	
	game nextTurn. "The effect of this turn was PickUpCard. The card juan picked up was Repeat"
	self assert: juan numberOfCards equals: 3.
	self assert: (juan assertHasCard: Overload initializeCard ).

	game nextTurn. "The effect of this turn was PickUpCard. The card nico picked up was Overload"
	self assert: nico numberOfCards equals: 3.
	self assert: (nico assertHasCard: Repeat initializeCard ).
	
	game nextTurn. "The effect of this turn was PickUpCard. Deck and DiscardDeck are empty. Juan is not able to pick up another card" 
	self assert: juan numberOfCards equals: 3.
	self assert: deck numberOfCards equals: 0.	"Deck and discard deck are both empty"
		
	self
		should: [ game shuffleDiscardDeck ]
		raise: InvalidRequest 
		withMessageText: 'Cannot shuffle empty deck'.
		
	accelerationThrownByNico := Acceleration   initializeCard. 
	game player: nico throw: accelerationThrownByNico.
	self assert: nico numberOfCards equals: 2.
	
	game shuffleDiscardDeck.
	self assert: game numberOfCardsInDeck equals: 1.
	
	game nextTurn. "The effect of this turn was PickUpCard . Can pick up card, deck is not empty." 
	self assert: nico numberOfCards equals: 3.
	self assert: game numberOfCardsInDeck equals: 0.	


]
