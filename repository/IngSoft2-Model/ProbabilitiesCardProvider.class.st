Class {
	#name : #ProbabilitiesCardProvider,
	#superclass : #Object,
	#instVars : [
		'sequence',
		'dictionary',
		'randomValue'
	],
	#category : #'IngSoft2-Model-Card'
}

{ #category : #'instance creation' }
ProbabilitiesCardProvider class >> with: aDictionaryOfCards [
 ^self new initializeWith: aDictionaryOfCards.
]

{ #category : #initialization }
ProbabilitiesCardProvider >> initializeWith: aDictionaryOfEffects [ 
	dictionary:= aDictionaryOfEffects.
	randomValue := Random new.
]

{ #category : #providing }
ProbabilitiesCardProvider >> nextCard [

	^ self searchForCardAt: (randomValue nextInt: 100).
]

{ #category : #accessing }
ProbabilitiesCardProvider >> searchForCardAt: randValue [
	dictionary
		keysAndValuesDo: [ :key :value | 
			(value includes: randValue)
				ifTrue: [ ^ key ] ]
]
