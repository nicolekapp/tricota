Class {
	#name : #Cancellation,
	#superclass : #TypeOfCard,
	#instVars : [
		'selectedCard'
	],
	#category : #'IngSoft2-Model-Card'
}

{ #category : #'as yet unclassified' }
Cancellation >> applyIn: game to: aCard [ 
	game applyCancellationCardTo: aCard 
]

{ #category : #playing }
Cancellation >> applyWithin: aPlayersWithPositions knowing: activeCards the: lastEffect and: finishLine of: game [
	
	game lastCardPlayed: self.
	^ self removeCardFrom: activeCards.
	
]

{ #category : #playing }
Cancellation >> assertTheCardToRemoveIs: currentCard [
	^ currentCard = card and: currentCard target = target
]

{ #category : #'as yet unclassified' }
Cancellation >> initialiceCard [
	^ InstantCard type: self
]

{ #category : #'as yet unclassified' }
Cancellation >> initialiceCardWithTarget: aTarget [
	^InstantCard type: self target: aTarget .
]

{ #category : #playing }
Cancellation >> removeCardFrom: activeCards [
	activeCards
		doWithIndex: [ :currentCard :i | 
			(self assertTheCardToRemoveIs: currentCard)
				ifTrue: [ activeCards removeAt: i.
					^ true ] ]
]
