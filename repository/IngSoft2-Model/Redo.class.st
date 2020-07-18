Class {
	#name : #Redo,
	#superclass : #TypeOfCard,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #'as yet unclassified' }
Redo >> applyIn: game to: aTarget [ 
	game applyRedoCardTo: aTarget 
]

{ #category : #playing }
Redo >> applyWithin: aPlayersWithPositions knowing: activeCards the: lastEffect and: finishLine of: game [
	
	|lastCard|
	self assertSomeoneThrewCard: game lastCardPlayed .
	lastCard := (game lastCardPlayed) class card: card target: target .
	lastCard applyWithin: aPlayersWithPositions knowing: activeCards the: lastEffect and: finishLine of: game
]

{ #category : #'as yet unclassified' }
Redo >> initialiceCard [
	^InstantCard type: self.
]

{ #category : #'as yet unclassified' }
Redo >> initialiceCardWithTarget: aTarget [
	^InstantCard type: self target: aTarget .
]
