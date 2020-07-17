Class {
	#name : #Redo,
	#superclass : #TypeOfCard,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #playing }
Redo >> applyWithin: aPlayersWithPositions knowing: activeCards the: lastEffect and: finishLine of: game [
	
	|lastCard|
	self assertSomeoneThrewCard: game lastCardPlayed .
	lastCard := (game lastCardPlayed) class card: card target: target .
	lastCard applyWithin: aPlayersWithPositions knowing: activeCards the: lastEffect and: finishLine of: game
]

{ #category : #playing }
Redo >> assertSomeoneThrewCard: lastCardPlayed [  
	(lastCardPlayed = 'No card has been played yet')
		ifTrue: [ InvalideRequest signal: 'Nobody threw a card yet' ]
]
