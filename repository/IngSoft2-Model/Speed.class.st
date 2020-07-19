Class {
	#name : #Speed,
	#superclass : #TypeOfCard,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #initialization }
Speed class >> initializeCard [
	^PermanentCard type: self new.
]

{ #category : #initialization }
Speed class >> initializeCardWithTarget: aTarget [
	^PermanentCard type: self new target: aTarget .
]

{ #category : #playing }
Speed >> effect: aPlayer [ 
	^1
]
