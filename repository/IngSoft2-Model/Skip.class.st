Class {
	#name : #Skip,
	#superclass : #TypeOfCard,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #playing }
Skip >> applyWithin: playersWithPositions knowing: activeCards  the: lastEffect and: finishLine of: game [
	game skipTurn.
	
]
