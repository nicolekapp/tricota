Class {
	#name : #Skip,
	#superclass : #TypeOfCard,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #initialization }
Skip class >> initializeCard [
	^InstantCard type: self new
]

{ #category : #initialization }
Skip class >> initializeCardWithTarget: aTarget [
	^InstantCard type: self new target: aTarget .
]

{ #category : #playing }
Skip >> applyIn: game to: aTarget [  
	game applySkipCard.
	^self
]
