Class {
	#name : #Skip,
	#superclass : #TypeOfCard,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #'as yet unclassified' }
Skip >> applyIn: game to: aTarget [  
	game applySkipCard.
	^self initialiceCard 
]

{ #category : #playing }
Skip >> applyWithin: playersWithPositions knowing: activeCards  the: lastEffect and: finishLine of: game [
	game skipTurn.
	
]

{ #category : #'as yet unclassified' }
Skip >> initialiceCard [
	^InstantCard type: self
]

{ #category : #'as yet unclassified' }
Skip >> initialiceCardWithTarget: aTarget [
	^InstantCard type: self target: aTarget .
]
