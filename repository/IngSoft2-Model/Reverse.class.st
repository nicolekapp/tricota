Class {
	#name : #Reverse,
	#superclass : #TypeOfCard,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #initialization }
Reverse class >> initializeCard [
	^InstantCard type: self new
]

{ #category : #initialization }
Reverse class >> initializeCardWithTarget: aTarget [
	^InstantCard type: self new target: aTarget .
]

{ #category : #playing }
Reverse >> applyIn: game to: aTarget [ 
	game applyReverseCard.
	^self
]
