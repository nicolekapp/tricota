Class {
	#name : #Redo,
	#superclass : #TypeOfCard,
	#category : #'IngSoft2-Model-Card'
}

{ #category : #initialization }
Redo class >> initializeCard [
	^InstantCard type: self new
]

{ #category : #initialization }
Redo class >> initializeCardWithTarget: aTarget [
	^InstantCard type: self new target: aTarget .
]

{ #category : #playing }
Redo >> applyIn: game to: aTarget [ 
	^game applyRedoCardTo: aTarget 
	
]
