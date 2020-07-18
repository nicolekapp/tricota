Class {
	#name : #Repeat,
	#superclass : #TypeOfCard,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #'as yet unclassified' }
Repeat >> applyIn: game to: aPlayer [ 
	game applyRepeatCardTo: aPlayer.
]

{ #category : #playing }
Repeat >> applyWithin: playersWithPositions playedBy: aPlayer knowing: activeCards the: lastEffect and: finishLine of: game [
	
	|actualPosition positionWithEffect|
	self assertSomeoneRolledDice: lastEffect .
	actualPosition:= (self currentPositionOfTargetIn: playersWithPositions)lockerPosition.
	positionWithEffect := lastEffect applyEffectTo: actualPosition knowing: playersWithPositions the: target and: finishLine .
	(self currentPositionOfTargetIn: playersWithPositions) moveTo: positionWithEffect knowing: finishLine .
	game lastCardPlayed: self.
]

{ #category : #playing }
Repeat >> currentPositionOfTargetIn: playersWithPositions [
	^ playersWithPositions at: target
]

{ #category : #'as yet unclassified' }
Repeat >> initialiceCard [
	^InstantCard type: self
]

{ #category : #'as yet unclassified' }
Repeat >> initialiceCardWithTarget: aTarget [
	^InstantCard type: self target: aTarget .
]
