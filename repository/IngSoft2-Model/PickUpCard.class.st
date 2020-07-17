Class {
	#name : #PickUpCard,
	#superclass : #Effect,
	#instVars : [
		'cardsProvider'
	],
	#category : #'IngSoft2-Model-Effects'
}

{ #category : #playing }
PickUpCard >> applyEffectTo: aPosition knowing: players the: currentPlayer and: finishline aaaaaaaaaaaaaaaaaaaaaa: deck [
	currentPlayer addCard: deck handCard.
	^aPosition.
]
