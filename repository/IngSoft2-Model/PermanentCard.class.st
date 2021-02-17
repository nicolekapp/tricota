Class {
	#name : #PermanentCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model-Cards'
}

{ #category : #playing }
PermanentCard >> = anObject [ 

	^ self class = anObject class .	
]

{ #category : #playing }
PermanentCard >> applyIn: game [ 
	
	game savePermanentCard: self.
	game typeLastCardPlayed: self.
]

{ #category : #playing }
PermanentCard >> effect: aPlayer [ 
	
	|lockers|
	lockers := 0.
	(target is: aPlayer) 
		ifTrue:[lockers:=self numberOfLockerToMovePlayer].
	^lockers
]

{ #category : #playing }
PermanentCard >> hash [
	
	^self class hash
]

{ #category : #playing }
PermanentCard >> numberOfLockerToMovePlayer [
	self subclassResponsibility
]

{ #category : #playing }
PermanentCard >> thrownBy: aPlayer inTheTurnOf: playerTurn [ 
	aPlayer = playerTurn 
		ifFalse: [ InvalidRequest signal: 'It is not your turn' ]
]
