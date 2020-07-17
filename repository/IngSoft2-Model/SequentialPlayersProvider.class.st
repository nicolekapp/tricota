"
I represent a sequence of players
I am given a sequence of players when created.

 
"
Class {
	#name : #SequentialPlayersProvider,
	#superclass : #Object,
	#instVars : [
		'sequence',
		'specialTurns'
	],
	#category : #'IngSoft2-Model-Game'
}

{ #category : #'as yet unclassified' }
SequentialPlayersProvider class >> enoughPlayers: aSequence [

	aSequence size < 2
		ifTrue: [ InstanceCreationFailed
				signal: 'Not enough players. Need at least 2 players' ].
]

{ #category : #'instance creation' }
SequentialPlayersProvider class >> providing: aSequence [

	self enoughPlayers: aSequence.

	^ self new initializeProviding: aSequence
]

{ #category : #providing }
SequentialPlayersProvider >> assertItsAReguarTurn [
	^ specialTurns isEmpty
]

{ #category : #playing }
SequentialPlayersProvider >> changeCourse [
	sequence changeCourse.
]

{ #category : #'as yet unclassified' }
SequentialPlayersProvider >> double: aPlayer [ 
	specialTurns add: aPlayer;
					add: aPlayer.
]

{ #category : #initialization }
SequentialPlayersProvider >> initializeProviding: aSequence [

	sequence := (CircularIterator cyclingOver: aSequence ).
	specialTurns := OrderedCollection new.
]

{ #category : #providing }
SequentialPlayersProvider >> nextPlayer [
	| nextPlayer |
"	self assertItsAReguarTurn
		ifTrue: [ nextPlayer := self regularTurn ]
		ifFalse: [ nextPlayer := self specialTurn ]."
	nextPlayer := sequence current.
	sequence next.
	^ nextPlayer
]

{ #category : #providing }
SequentialPlayersProvider >> nextPlayerWithoutChanging [
	| nextPlayer |
"	self assertItsAReguarTurn
		ifTrue: [ nextPlayer := self regularTurn ]
		ifFalse: [ nextPlayer := self specialTurn ]."
	nextPlayer := sequence current.
	sequence next.
	^ nextPlayer
]

{ #category : #providing }
SequentialPlayersProvider >> regularTurn [
	| nextPlayer |
	nextPlayer := sequence current.
	sequence next.
	^ nextPlayer
]

{ #category : #providing }
SequentialPlayersProvider >> specialTurn [
	| nextPlayer |
	nextPlayer := specialTurns at: 1.
	specialTurns removeAt: 1.
	^ nextPlayer
]
