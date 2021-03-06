"
I'm Dice! I'm a group of die.
When rolling me i roll every die in the group and return the sum of all the results.
"
Class {
	#name : #Dice,
	#superclass : #Object,
	#instVars : [
		'dice'
	],
	#category : #'IngSoft2-Model-Dice'
}

{ #category : #'instance creation' }
Dice class >> withAll: aDiceSet [
	
	^ self new initializeWithAll: aDiceSet
]

{ #category : #composing }
Dice >> + aDie [

	^ Dice withAll: { self . aDie }
]

{ #category : #initialization }
Dice >> initializeWithAll: aDiceSet [
	
	dice := aDiceSet
]

{ #category : #rolling }
Dice >> roll [
	
	^ dice sumNumbers: #roll
]
