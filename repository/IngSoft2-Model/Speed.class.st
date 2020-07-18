Class {
	#name : #Speed,
	#superclass : #TypeOfCard,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #playing }
Speed >> effect: aPlayer [ 
	^1
]

{ #category : #'as yet unclassified' }
Speed >> initialiceCard [
	^PermanentCard type: self
]

{ #category : #'as yet unclassified' }
Speed >> initialiceCardWithTarget: aTarget [
	^PermanentCard type: self target: aTarget .
]
