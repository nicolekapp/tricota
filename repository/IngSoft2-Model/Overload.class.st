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

{ #category : #'as yet unclassified' }
Overload >> initialiceCardWithTarget: aTarget [
	^PermanentCard type: self target: aTarget .
]
