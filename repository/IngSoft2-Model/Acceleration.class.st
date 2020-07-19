Class {
	#name : #Acceleration,
	#superclass : #TypeOfCard,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #initialization }
Acceleration class >> initializeCard [
	^PermanentCard type: self new target: Everyone new.
]

{ #category : #initialization }
Acceleration class >> initializeCardWithTarget: aTarget [
	^PermanentCard type: self new target: aTarget .
]

{ #category : #playing }
Acceleration >> effect: aPlayer [ 
	^1.
]
