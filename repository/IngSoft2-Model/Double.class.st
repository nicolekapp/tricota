Class {
	#name : #Double,
	#superclass : #TypeOfCard,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #'as yet unclassified' }
Double >> applyIn: game to: noTarget [ 
	game applyDoubleCard
]

{ #category : #playing }
Double >> applyWithin: playersWithPositions knowing: activeCards  the: lastEffect and: finishLine of: game [
	game doubleNextPlayer.
]

{ #category : #'as yet unclassified' }
Double >> initialiceCard [
	^InstantCard type: self.
]

{ #category : #'as yet unclassified' }
Double >> initialiceCardWithTarget: aTarget [
	^InstantCard type: self target: aTarget .
]
