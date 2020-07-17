Class {
	#name : #Overload,
	#superclass : #TypeOfCard,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #playing }
Overload >> effect: aPlayer [ 
	^ -2.
]

{ #category : #'as yet unclassified' }
Overload >> initialiceCard [
	^PermanentCard type: self
]
