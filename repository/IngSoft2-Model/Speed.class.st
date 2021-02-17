Class {
	#name : #Speed,
	#superclass : #PermanentCard,
	#category : #'IngSoft2-Model-Cards'
}

{ #category : #initialization }
Speed class >> initializeCard [
	^self new.
]

{ #category : #initialization }
Speed class >> initializeCardWithTarget: aTarget [
	^ self onTarget: aTarget
]

{ #category : #playing }
Speed >> = anObject [ 

	^ self class = anObject class .	
]

{ #category : #playing }
Speed >> hash [
	
	^self class hash
]

{ #category : #playing }
Speed >> numberOfLockerToMovePlayer [
	^1.
]
