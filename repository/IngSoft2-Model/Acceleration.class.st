Class {
	#name : #Acceleration,
	#superclass : #TypeOfCard,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #aplly }
Acceleration >> applyToaaaa: aGame [ 
	aGame applyAccellerationCard.
]

{ #category : #playing }
Acceleration >> effect: aPlayer [ 
	^1.
]

{ #category : #'as yet unclassified' }
Acceleration >> initialiceCard [
	^PermanentCard type: self.
]
