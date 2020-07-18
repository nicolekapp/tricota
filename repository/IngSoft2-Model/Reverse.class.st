Class {
	#name : #Reverse,
	#superclass : #TypeOfCard,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #'as yet unclassified' }
Reverse >> applyIn: game to: aTarget [ 
	game applyReverseCard.
	^self initialiceCard 
]

{ #category : #playing }
Reverse >> applyWithin: aCollection knowing: aCollection2 the: aNoEffect and: anInteger of: game [ 
	game changeCourse.
]

{ #category : #'as yet unclassified' }
Reverse >> initialiceCard [
	^InstantCard type: self.
]

{ #category : #'as yet unclassified' }
Reverse >> initialiceCardWithTarget: aTarget [
	^InstantCard type: self target: aTarget .
]
