Class {
	#name : #Overload,
	#superclass : #PermanentCard,
	#category : #'IngSoft2-Model-Cards'
}

{ #category : #initialization }
Overload class >> initializeCard [
	^self new.
]

{ #category : #initialization }
Overload class >> initializeCardWithTarget: aTarget [
	^ self onTarget: aTarget
]

{ #category : #playing }
Overload >> = anObject [ 

	^ self class = anObject class .	
]

{ #category : #playing }
Overload >> hash [
	
	^self class hash
]

{ #category : #playing }
Overload >> numberOfLockerToMovePlayer [
	^ -2
]
