"
I'm Uca Board Game!
I am given a die or dice, a board and a collection of players when created.

"
Class {
	#name : #UCABoardGame,
	#superclass : #Object,
	#instVars : [
		'dice',
		'sequenceOfPlayers',
		'winner',
		'laps',
		'effectRoulette',
		'playersWithPositions',
		'lastEffect',
		'finishLine',
		'activeCards',
		'lastCardPlayed',
		'deck'
	],
	#category : #'IngSoft2-Model-Game'
}

{ #category : #'instance creation' }
UCABoardGame class >> rolling: aDie with: aGroupOfPlayers lockers: aNumberOfLockers laps: aNumberOfLaps effects: effectRoulette and: cards [

	^self new initializeRolling: aDie with: aGroupOfPlayers lockers: aNumberOfLockers laps: aNumberOfLaps effects: effectRoulette and: cards.
]

{ #category : #'as yet unclassified' }
UCABoardGame class >> rolling: aDie with: players lockers: numberOfLockers laps: numberOfLaps effects: anEffectRoulette andDeterministic: sequenceOfCards [ 
	^self new initializeRolling: aDie with: players lockers: numberOfLockers  laps: numberOfLaps  effects: anEffectRoulette andDeterministic: sequenceOfCards.
]

{ #category : #playing }
UCABoardGame >> amountOfLockersThatActiveCardsMove: currentPlayer [
|amountOfLockers|
	amountOfLockers:=0.
	(activeCards isEmpty)
	ifFalse:[amountOfLockers:= (activeCards sum:[ :card | card effect: currentPlayer ])].
	^amountOfLockers.
]

{ #category : #'as yet unclassified' }
UCABoardGame >> applyCancellationCardTo: aCard [ 
	activeCards remove: aCard 
	
]

{ #category : #playing }
UCABoardGame >> applyEffectTo: positionAfterRollingDice of: currentPlayer [

	lastEffect := effectRoulette spin.
	
	^lastEffect applyEffectTo: positionAfterRollingDice	knowing: playersWithPositions the: currentPlayer and: finishLine aaaaaaaaaaaaaaaaaaaaaa: deck
]

{ #category : #'as yet unclassified' }
UCABoardGame >> applyRedoCardTo: target [ 

	| cardRedoed |
	self assertSomeoneThrewCard.
	cardRedoed := lastCardPlayed type initialiceCardWithTarget: target.
	cardRedoed applyIn: self

]

{ #category : #'as yet unclassified' }
UCABoardGame >> applyRepeatCardTo: target [ 
	|actualPosition positionWithEffect|
	self assertSomeoneRolledDice: lastEffect .
	actualPosition:= (playersWithPositions at: target)lockerPosition.
	positionWithEffect := lastEffect applyEffectTo: actualPosition knowing: playersWithPositions the: target and: finishLine aaaaaaaaaaaaaaaaaaaaaa: deck.
	(playersWithPositions at: target) moveTo: positionWithEffect knowing: finishLine .

]

{ #category : #'as yet unclassified' }
UCABoardGame >> applyReverseCard [
	self changeCourse .
]

{ #category : #'as yet unclassified' }
UCABoardGame >> applySkipCard [
	self skipTurn.
]

{ #category : #'as yet unclassified' }
UCABoardGame >> assertItsPlayersTurn: aPlayer [ 
	(aPlayer = sequenceOfPlayers nextPlayerWithoutChangingCurrent )
		ifFalse: [ InvalideRequest signal: 'It is not your turn' ]
]

{ #category : #assertions }
UCABoardGame >> assertSomeoneRolledDice: lastEffect [ 
	(lastEffect = 'No effect yet')
		ifTrue: [ InvalideRequest signal: 'Nobody rolled the dice yet' ]
]

{ #category : #playing }
UCABoardGame >> assertSomeoneThrewCard [
	(lastCardPlayed = 'No card has been played yet')
		ifTrue: [ InvalideRequest signal: 'Nobody threw a card yet' ]
]

{ #category : #playing }
UCABoardGame >> assertSomeoneThrewCard: lastCardPlayed [  
	(lastCardPlayed = 'No card has been played yet')
		ifTrue: [ InvalideRequest signal: 'Nobody threw a card yet' ]
]

{ #category : #assertions }
UCABoardGame >> assertTheGameHasFinished [
	(self hasFinished)
		ifFalse: [ InvalideRequest signal: 'The game has not finished yet' ]
]

{ #category : #assertions }
UCABoardGame >> assertTheGameHasNotFinished [
	(self hasFinished)
		ifTrue: [ InvalideRequest signal: 'The game has finished' ]
]

{ #category : #assertions }
UCABoardGame >> assertTheWinnerIs: aPlayer [
	
	((self currentPositionOf: aPlayer) lapNumber == laps)
	ifTrue:[winner:= aPlayer ].
	
	
	
]

{ #category : #playing }
UCABoardGame >> changeCourse [
	sequenceOfPlayers changeCourse.
	sequenceOfPlayers nextPlayer .
	sequenceOfPlayers nextPlayer .
]

{ #category : #position }
UCABoardGame >> currentPositionOf: aPlayer [ 

	^playersWithPositions at: aPlayer.

]

{ #category : #playing }
UCABoardGame >> doubleNextPlayer [
	sequenceOfPlayers double: sequenceOfPlayers nextPlayer .
]

{ #category : #playing }
UCABoardGame >> following: index lowerThan: sizeOfCards [.

	(index = sizeOfCards ) ifTrue:[^1] ifFalse:[^(index +1)].

]

{ #category : #assertions }
UCABoardGame >> hasFinished [
	
	^ (playersWithPositions values) detect: [ :position | position lapNumber = laps]  				
		ifFound: [true] 				
		ifNone: [false].
	
	
]

{ #category : #initialization }
UCABoardGame >> initializeDictionaryOfPositions: aGroupOfPlayers [

	|players|
	players := Dictionary new.
	aGroupOfPlayers do: [ :player | players at: player put: (CurrentPosition startingAtZero)].
	^ players
]

{ #category : #initialization }
UCABoardGame >> initializeRolling: aDice with: aGroupOfPlayers lockers: aNumberOfLockers laps: aNumberOfLaps effects: anEffectRoulette and: aDeck [
	dice:= aDice.
	playersWithPositions:= self initializeDictionaryOfPositions: aGroupOfPlayers.
	sequenceOfPlayers:= (SequentialPlayersProvider providing: aGroupOfPlayers).
	finishLine:= aNumberOfLockers.
	laps:= aNumberOfLaps.
	effectRoulette:= anEffectRoulette.
	activeCards := OrderedCollection new.
	winner := 'No Winner'.
	lastEffect := 'No effect yet'.
	lastCardPlayed:= 'No card has been played yet'.
	deck := aDeck.
	deck dealTwoCardsToEachPlayerFrom: aGroupOfPlayers  
]

{ #category : #position }
UCABoardGame >> lapNumberOf: aPlayer [ 
	^ (self currentPositionOf: aPlayer) lapNumber.
]

{ #category : #cards }
UCABoardGame >> lastCardPlayed [
	^ lastCardPlayed
]

{ #category : #cards }
UCABoardGame >> lastCardPlayed: aCard [
	lastCardPlayed := aCard
]

{ #category : #position }
UCABoardGame >> lockerNumberOf: aPlayer [ 
	^ (self currentPositionOf: aPlayer) lockerPosition.
]

{ #category : #playing }
UCABoardGame >> nextTurn [

	| currentPlayer positionAfterRollingDice positionAfterCards positionAfterEffectAndCards currentPlayerPosition |
	self assertTheGameHasNotFinished.
	currentPlayer := sequenceOfPlayers nextPlayer.
	currentPlayerPosition:= playersWithPositions at: currentPlayer.
	positionAfterRollingDice := (self currentPositionOf: currentPlayer)lockerPosition + dice roll.
	positionAfterCards := (self amountOfLockersThatActiveCardsMove: currentPlayer)+ positionAfterRollingDice .
	positionAfterEffectAndCards := self applyEffectTo: positionAfterCards of: currentPlayer.
	currentPlayerPosition moveTo: positionAfterEffectAndCards knowing: finishLine.
	self assertTheWinnerIs: currentPlayer
]

{ #category : #playing }
UCABoardGame >> player: aPlayer throw: card [

	self assertTheGameHasNotFinished.
	aPlayer assertHasCard: card.
	card thrownBy: aPlayer inTheTurnOf: sequenceOfPlayers nextPlayerWithoutChangingCurrent .
	"card applyWithin: playersWithPositions playedBy: aPlayer knowing: activeCards the: lastEffect and: finishLine of: self."
	card applyIn: self.
	aPlayer cardPlayed: card.
	
]

{ #category : #playing }
UCABoardGame >> players [
	^ playersWithPositions keys
]

{ #category : #position }
UCABoardGame >> playersPositions [
	
	^ PositionTable filledWith: playersWithPositions.
]

{ #category : #cards }
UCABoardGame >> savePermanentCard: aCard [

	activeCards add: aCard
]

{ #category : #playing }
UCABoardGame >> skipTurn [
	sequenceOfPlayers nextPlayer.
]

{ #category : #playing }
UCABoardGame >> winner [

	self assertTheGameHasFinished.
	^ winner 
]
