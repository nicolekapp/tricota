Class {
	#name : #Acceleration,
	#superclass : #TypeOfCard,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #aplly }
Acceleration >> applyToaaaa: aGame [ 
	aGame applyAccellerationCard.
]

{ #category : #playing }
Acceleration >> applyWithin: aPlayersWithPositions knowing: activeCards the: lastEffect and: finishLine of: game [
	game assertItsPlayersTurn.
	game savePermanentCard: self.
	game lastCardPlayed: self.
]

{ #category : #playing }
Acceleration >> effect: aPlayer [ 
	^1.
]
