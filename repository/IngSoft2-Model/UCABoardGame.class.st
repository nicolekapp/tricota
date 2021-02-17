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
		'typeLastCardPlayed',
		'deck',
		'timesToRoll',
		'discardDeck',
		'deckBuilder'
	],
	#category : #'IngSoft2-Model-Game'
}

{ #category : #'instance creation' }
UCABoardGame class >> assertLapsGreaterThanZero: aNumberOfLaps [

	aNumberOfLaps > 0
		ifFalse: [ InstanceCreationFailed signal: 'Need at least one lap' ]
]

{ #category : #'instance creation' }
UCABoardGame class >> assertLockersGreaterThanZero: aNumberOfLockers [

	aNumberOfLockers > 0
		ifFalse: [ InstanceCreationFailed signal: 'Need at least one locker' ]
]

{ #category : #playing }
UCABoardGame class >> rolling: aDie with: aGroupOfPlayers lockers: aNumberOfLockers laps: aNumberOfLaps effects: effectRoulette a: deck and: discardDeck [
	self assertLockersGreaterThanZero: aNumberOfLockers .
	self assertLapsGreaterThanZero: aNumberOfLaps .
	^self new initializeRolling: aDie with: aGroupOfPlayers lockers: aNumberOfLockers laps: aNumberOfLaps effects: effectRoulette a: deck and: discardDeck.
]

{ #category : #'instance creation' }
UCABoardGame class >> rolling: aDie with: aGroupOfPlayers lockers: aNumberOfLockers laps: aNumberOfLaps effects: effectRoulette and: deck [
	self assertLockersGreaterThanZero: aNumberOfLockers .
	self assertLapsGreaterThanZero: aNumberOfLaps .
	^self new initializeRolling: aDie with: aGroupOfPlayers lockers: aNumberOfLockers laps: aNumberOfLaps effects: effectRoulette and: deck.
]

{ #category : #playing }
UCABoardGame >> amountOfLockersThatActiveCardsMove: currentPlayer [
|amountOfLockers|
	amountOfLockers:=0.
	(activeCards isEmpty)
	ifFalse:[amountOfLockers:= (activeCards sum:[ :card | card effect: currentPlayer ])].
	^amountOfLockers.
]

{ #category : #cards }
UCABoardGame >> applyCancellationCardTo: aCard [ 
	activeCards detect: [ :card | card = card ] 
					ifFound: [ activeCards remove: aCard ] 
					ifNone:  [ InvalidRequest signal: 'Target isnt an active permanent card' ] 
	
]

{ #category : #playing }
UCABoardGame >> applyEffectTo: positionAfterRollingDice of: currentPlayer [
	lastEffect := effectRoulette spin.
	^ lastEffect applyEffectTo: positionAfterRollingDice of: currentPlayer knowing: playersWithPositions the: deck and: finishLine
]

{ #category : #cards }
UCABoardGame >> applyRedoCardTo: target thrownBy: throwedBy inTheTurnOf: playersTurn [ 

	| cardRedoed |
	self assertSomeoneThrewCard.
	cardRedoed := typeLastCardPlayed class initializeCardWithTarget: target.
	cardRedoed thrownBy: throwedBy  inTheTurnOf: playersTurn .
	cardRedoed applyIn: self.
	^ typeLastCardPlayed


]

{ #category : #cards }
UCABoardGame >> applyRepeatCardTo: target [
	| actualPosition positionWithEffect |
	self assertSomeoneRolledDice.
	actualPosition := (playersWithPositions at: target) lockerPosition.
	positionWithEffect := lastEffect applyEffectTo: actualPosition of: target knowing: playersWithPositions the: deck and: finishLine.
	(playersWithPositions at: target) moveTo: positionWithEffect knowing: finishLine
]

{ #category : #assertions }
UCABoardGame >> assertSomeoneRolledDice [
	(lastEffect = 'No effect yet')
		ifTrue: [ InvalidRequest signal: 'Nobody rolled the dice yet' ]
]

{ #category : #assertions }
UCABoardGame >> assertSomeoneThrewCard [
	(typeLastCardPlayed = 'No card has been played yet')
		ifTrue: [ InvalidRequest signal: 'Nobody threw a card yet' ]
]

{ #category : #assertions }
UCABoardGame >> assertTheGameHasFinished [
	(self hasFinished)
		ifFalse: [ InvalidRequest signal: 'The game has not finished yet' ]
]

{ #category : #assertions }
UCABoardGame >> assertTheGameHasNotFinished [
	(self hasFinished)
		ifTrue: [ InvalidRequest signal: 'The game has finished' ]
]

{ #category : #assertions }
UCABoardGame >> assertTheWinnerIs: aPlayer [
	
	self hasFinished
			ifTrue:[winner:= aPlayer ].
	
	
	
]

{ #category : #'as yet unclassified' }
UCABoardGame >> currentPlayerTurn [ 

	^ sequenceOfPlayers nextPlayerWithoutChangingCurrent 
]

{ #category : #position }
UCABoardGame >> currentPositionOf: aPlayer [ 

	^playersWithPositions at: aPlayer.

]

{ #category : #'as yet unclassified' }
UCABoardGame >> discardDeckSize [
	^ discardDeck size.
]

{ #category : #assertions }
UCABoardGame >> hasFinished [
	
	^ (playersWithPositions values) detect: [ :position | position lapNumber >= laps]  				
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
UCABoardGame >> initializeRolling: aDice with: aGroupOfPlayers lockers: aNumberOfLockers laps: aNumberOfLaps effects: anEffectRoulette a: mainDeck and: backupDeck [
	dice:= aDice.
	timesToRoll := 1.
	playersWithPositions:= self initializeDictionaryOfPositions: aGroupOfPlayers.
	sequenceOfPlayers:= (SequentialPlayersProvider providing: aGroupOfPlayers).
	finishLine:= aNumberOfLockers.
	laps:= aNumberOfLaps.
	effectRoulette:= anEffectRoulette.
	activeCards := OrderedCollection new.
	winner := 'No Winner'.
	lastEffect := 'No effect yet'.
	typeLastCardPlayed:= 'No card has been played yet'.
	deck := mainDeck.
	deck dealTwoCardsToEachPlayerFrom: aGroupOfPlayers.
	discardDeck := backupDeck.


]

{ #category : #initialization }
UCABoardGame >> initializeRolling: aDice with: aGroupOfPlayers lockers: aNumberOfLockers laps: aNumberOfLaps effects: anEffectRoulette and: aDeck [
	dice:= aDice.
	timesToRoll := 1.
	playersWithPositions:= self initializeDictionaryOfPositions: aGroupOfPlayers.
	sequenceOfPlayers:= (SequentialPlayersProvider providing: aGroupOfPlayers).
	finishLine:= aNumberOfLockers.
	laps:= aNumberOfLaps.
	effectRoulette:= anEffectRoulette.
	activeCards := OrderedCollection new.
	winner := 'No Winner'.
	lastEffect := 'No effect yet'.
	typeLastCardPlayed:= 'No card has been played yet'.
	deck := aDeck.
	deck dealTwoCardsToEachPlayerFrom: aGroupOfPlayers.
	discardDeck := OrderedCollection new.


]

{ #category : #position }
UCABoardGame >> lapNumberOf: aPlayer [ 
	^ (self currentPositionOf: aPlayer) lapNumber.
]

{ #category : #position }
UCABoardGame >> lockerNumberOf: aPlayer [ 
	^ (self currentPositionOf: aPlayer) lockerPosition.
]

{ #category : #playing }
UCABoardGame >> nextTurn [
	| currentPlayer positionAfterEffectAndCards currentPlayerPosition |
	self assertTheGameHasNotFinished.
	currentPlayer := sequenceOfPlayers nextPlayer.
	currentPlayerPosition := self currentPositionOf: currentPlayer.
	positionAfterEffectAndCards := self rollDiceApplyEffectsAndCardsTo: currentPlayer thatsIn: currentPlayerPosition.
	currentPlayerPosition moveTo: positionAfterEffectAndCards knowing: finishLine.
	self assertTheWinnerIs: currentPlayer
]

{ #category : #playing }
UCABoardGame >> numberOfCardsInDeck [
	^deck numberOfCards.
]

{ #category : #playing }
UCABoardGame >> player: aPlayer throw: card [
	self assertTheGameHasNotFinished.
	aPlayer assertHasCard: card.
	card thrownBy: aPlayer inTheTurnOf: self currentPlayerTurn.
	card applyIn: self.
	aPlayer cardPlayed: card.
	discardDeck add: card.
]

{ #category : #position }
UCABoardGame >> playersPositionsTable [
	
	^ PositionTable filledWith: playersWithPositions.
]

{ #category : #playing }
UCABoardGame >> rollDiceApplyEffectsAndCardsTo: currentPlayer thatsIn: currentPlayerPosition [ 
	| positionAfterRollingDice positionAfterCards positionAfterEffectAndCards |
	positionAfterRollingDice := currentPlayerPosition lockerPosition + dice roll.
	positionAfterCards := (self amountOfLockersThatActiveCardsMove: currentPlayer) + positionAfterRollingDice.
	positionAfterEffectAndCards := self applyEffectTo: positionAfterCards of: currentPlayer.
	^ positionAfterEffectAndCards
]

{ #category : #cards }
UCABoardGame >> savePermanentCard: aCard [

	activeCards add: aCard
]

{ #category : #'as yet unclassified' }
UCABoardGame >> shuffleDiscardDeck [

 discardDeck isEmpty
ifTrue: [ InvalidRequest
				signal: 'Cannot shuffle empty deck'  ].
deckBuilder:= DeckBuilder startBuildingWith: discardDeck shuffle.
deck:= deckBuilder buildDeterministicWithSize: discardDeck size.
discardDeck:= OrderedCollection new.

 
]

{ #category : #cards }
UCABoardGame >> typeLastCardPlayed: aCard [
	typeLastCardPlayed := aCard
]

{ #category : #playing }
UCABoardGame >> winner [

	self assertTheGameHasFinished.
	^ winner 
]
