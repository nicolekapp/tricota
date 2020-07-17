Class {
	#name : #Target,
	#superclass : #Object,
	#instVars : [
		'target'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Target class >> everyone [
	^ self new initializeWith: Everyone new
]

{ #category : #'instance creation' }
Target class >> none [
	^ self new initializeWith: NoTarget new.
]

{ #category : #'as yet unclassified' }
Target class >> player: aPlayer [ 
	^ self new initializeWith: aPlayer 
]

{ #category : #initialization }
Target >> initializeWith: aTarget [ 
	target := aTarget 
]

{ #category : #'as yet unclassified' }
Target >> is: aPlayer [ 
	^target = aPlayer 
]
