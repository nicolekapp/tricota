Class {
	#name : #Double,
	#superclass : #TypeOfCard,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #playing }
Double >> applyWithin: playersWithPositions knowing: activeCards  the: lastEffect and: finishLine of: game [
	game doubleNextPlayer.
]

{ #category : #'as yet unclassified' }
Double >> initialiceCard [
	^InstantCard type: self.
]
