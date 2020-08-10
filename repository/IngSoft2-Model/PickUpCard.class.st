Class {
	#name : #PickUpCard,
	#superclass : #Effect,
	#instVars : [
		'cardsProvider'
	],
	#category : #'IngSoft2-Model-Effects'
}

{ #category : #playing }
PickUpCard >> applyEffectTo: aPosition of: currentPlayer knowing: players the: deck and: finishline [
	( deck numberOfCards > 0 )
	ifTrue: [ currentPlayer addCard: deck handCard.  ].
	^aPosition.
	
]
