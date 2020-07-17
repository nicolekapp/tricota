Class {
	#name : #Target,
	#superclass : #Object,
	#instVars : [
		'target'
	],
	#category : #'IngSoft2-Tests-Card-Test'
}

{ #category : #'instance creation' }
Target class >> none [
	^ self new initializeWith: NoTarget new.
]

{ #category : #initialization }
Target >> initializeWith: aTarget [ 
	target := aTarget 
]
