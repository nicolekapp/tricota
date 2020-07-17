Class {
	#name : #TypeOfCard,
	#superclass : #Object,
	#instVars : [
		'card',
		'target'
	],
	#category : #'IngSoft2-Model-Card'
}

{ #category : #'instance creation' }
TypeOfCard class >> card: aCard target: aPlayer [
	^ self new initializeCard: aCard target: aPlayer
]

{ #category : #comparing }
TypeOfCard >> = anObject [ 

	^ self class = anObject class .	
]

{ #category : #comparing }
TypeOfCard >> hash [
	
	^self class hash
]

{ #category : #initialization }
TypeOfCard >> initializeCard: aCard target: aPlayer [ 
	card:= aCard.
	target:= aPlayer 
]

{ #category : #playing }
TypeOfCard >> target [
	^target.
]
