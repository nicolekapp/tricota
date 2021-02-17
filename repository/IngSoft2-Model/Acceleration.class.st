Class {
	#name : #Acceleration,
	#superclass : #PermanentCard,
	#category : #'IngSoft2-Model-Cards'
}

{ #category : #initialization }
Acceleration class >> initializeCard [
	^ self onTarget: Everyone new
]

{ #category : #initialization }
Acceleration class >> initializeCardWithTarget: aTarget [
	^ self onTarget: aTarget
]

{ #category : #playing }
Acceleration >> = anObject [ 

	^ self class = anObject class .	
]

{ #category : #playing }
Acceleration >> hash [
	
	^self class hash
]

{ #category : #playing }
Acceleration >> numberOfLockerToMovePlayer [
	^1.
]
