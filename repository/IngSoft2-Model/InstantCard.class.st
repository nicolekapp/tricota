Class {
	#name : #InstantCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model-Cards'
}

{ #category : #playing }
InstantCard >> applyIn: game [
	
	|typeLastCard|
	typeLastCard := self applyIn: game to: target.
	game typeLastCardPlayed: typeLastCard .

]

{ #category : #playing }
InstantCard >> applyIn: game to: aTarget [

	self subclassResponsibility

]
