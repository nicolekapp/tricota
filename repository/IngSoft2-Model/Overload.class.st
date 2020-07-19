Class {
	#name : #Overload,
	#superclass : #TypeOfCard,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #initialization }
Overload class >> initializeCard [
	^PermanentCard type: self new.
]

{ #category : #initialization }
Overload class >> initializeCardWithTarget: aTarget [
	^PermanentCard type: self new target: aTarget .
]

{ #category : #playing }
Overload >> effect: aPlayer [ 
	^ -2.
]
