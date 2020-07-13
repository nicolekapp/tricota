Class {
	#name : #Double,
	#superclass : #Card,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #playing }
Double >> applyWithin: playersWithPositions knowing: activeCards  the: lastEffect and: finishLine of: game [
	game doubleNextPlayer.
]
