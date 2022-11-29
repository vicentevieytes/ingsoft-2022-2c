!classDefinition: #FootballGameTest category: 'ISW1-2022-2C-2doParcial'!
TestCase subclass: #FootballGameTest
	instanceVariableNames: 'gamex rollingResults'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-2doParcial'!

!FootballGameTest methodsFor: 'tests' stamp: 'VV 11/28/2022 19:27:53'!
test01gameStartsWithDefenderOfTeam1OnCorrectPosition
	
	|game|
	
	game _ FootballGame withTeam1: 'equipo1' team2: 'equipo2' usingDice: self.
	
	self assert: (game defenderOf: 'equipo1' isAt: 2@10).! !

!FootballGameTest methodsFor: 'tests' stamp: 'VV 11/28/2022 19:27:53'!
test02gameStartsWithMidfieldOfTeam1OnCorrectPosition
	
	|game|
	
	game _ FootballGame withTeam1: 'equipo1' team2: 'equipo2' usingDice: self.
	
	self assert: (game midfieldOf: 'equipo1' isAt: 5@10).! !

!FootballGameTest methodsFor: 'tests' stamp: 'VV 11/28/2022 19:27:53'!
test03gameStartsWithForwardOfTeam1OnCorrectPosition
	
	|game|
	
	game _ FootballGame withTeam1: 'equipo1' team2: 'equipo2' usingDice: self.
	
	self assert: (game forwardOf: 'equipo1' isAt: 10@10).! !

!FootballGameTest methodsFor: 'tests' stamp: 'VV 11/28/2022 19:27:53'!
test04gameStartsWithTeam2OnCorrectPosition
	
	|game|
	
	game _ FootballGame withTeam1: 'equipo1' team2: 'equipo2' usingDice: self.
	
	self assert: (game forwardOf: 'equipo2' isAt: 11@10).
	self assert: (game midfieldOf: 'equipo2' isAt: 15@10).
	self assert: (game defenderOf: 'equipo2' isAt: 19@10).! !

!FootballGameTest methodsFor: 'tests' stamp: 'VV 11/28/2022 19:27:53'!
test05startingGameWithSameTeamNameRaisesError
	
	self should: [FootballGame withTeam1: 'equipo1' team2: 'equipo1' usingDice: self.]
		raise: Error - MessageNotUnderstood
		withExceptionDo:
			[:anError| self assert: anError messageText equals: FootballGame sameTeamNameErrorMessage] 
	! !

!FootballGameTest methodsFor: 'tests' stamp: 'VV 11/28/2022 19:27:53'!
test06startingGameWithEmptyTeamName1RaisesError
	
	self should: [FootballGame withTeam1: '' team2: 'equipo1' usingDice: self.]
		raise: Error - MessageNotUnderstood
		withExceptionDo:
			[:anError| self assert: anError messageText equals: FootballGame emptyTeamNameErrorMessage ] 
	! !

!FootballGameTest methodsFor: 'tests' stamp: 'VV 11/28/2022 19:27:53'!
test07startingGameWithEmptyTeamName2RaisesError
	
	self should: [FootballGame withTeam1: 'equipo1' team2: '' usingDice: self.]
		raise: Error - MessageNotUnderstood
		withExceptionDo:
			[:anError| self assert: anError messageText equals: FootballGame emptyTeamNameErrorMessage ] 
	! !

!FootballGameTest methodsFor: 'tests' stamp: 'VV 11/28/2022 19:27:53'!
test08startingGameWithNonStringTeamNameRaiseserror
	
	self should: [FootballGame withTeam1: Object new team2: 'equipo2' usingDice: self.]
		raise: Error - MessageNotUnderstood
		withExceptionDo:
			[:anError| self assert: anError messageText equals: FootballGame teamNamesMustBeStringsErrorMessage ] 
	! !

!FootballGameTest methodsFor: 'tests' stamp: 'VV 11/28/2022 18:12:34'!
test09gameStartsWithBallOnCorrectPosition

	|game|
	game _ self createGame.
	
	self assert: (game ballPositionIs: 10@10)! !

!FootballGameTest methodsFor: 'tests' stamp: 'VV 11/28/2022 19:09:28'!
test10gameStartsWithBallOnCorrectPositionAndPlayer

	|game|
	game _ self createGame.
	
	self assert: ((game ballPositionIs: 10@10) and: [game hasBallForwardOf: self team1 ])! !

!FootballGameTest methodsFor: 'tests' stamp: 'VV 11/28/2022 20:00:23'!
test11forwardMovesCorrectlyOnFirstTurnAndRetainsTheBallRolling10BothTimes
|game|
	game _ self createGame.
	self diceRolls: #(10 10).
	
	game moveForwardTo: 15@15.
	self assert: (game forwardOf: self team1 isAt: 15@15).
	self assert: ((game ballPositionIs: 15@15) and: (game hasBallForwardOf: self team1))




	! !

!FootballGameTest methodsFor: 'tests' stamp: 'VV 11/28/2022 20:05:14'!
test12forwardMovesCorrectlyAndRetainsTheBallRollingLessThan10BothTimes
|game|
	game _ self createGame.
	self diceRolls: #(5 5).
	
	game moveForwardTo: 20@20.
	self assert: (game forwardOf: self team1 isAt: 15@15).
	self assert: ((game ballPositionIs: 15@15) and: (game hasBallForwardOf: self team1))




	! !

!FootballGameTest methodsFor: 'tests' stamp: 'VV 11/28/2022 20:23:48'!
test13midfieldCanMoveCorrectlyOnFirstTurnRolling10BothTimes
	|game|
	
	game _ self createGame.
	self diceRolls: #(10 10).
	
	game moveMidfieldTo: 15@15.
	self assert: (game midfieldOf: self team1 isAt: 15@15).
	self assert: ((game ballPositionIs: 10@10) and: (game hasBallForwardOf: self team1))




	! !

!FootballGameTest methodsFor: 'tests' stamp: 'VV 11/28/2022 20:25:09'!
test14midfieldCanMoveCorrectlyOnFirstTurnRollingLessThan10
	|game|
	
	game _ self createGame.
	self diceRolls: #(5 5).
	
	game moveMidfieldTo: 15@20.
	self assert: (game midfieldOf: self team1 isAt: 10@15).
	self assert: ((game ballPositionIs: 10@10) and: (game hasBallForwardOf: self team1))




	! !

!FootballGameTest methodsFor: 'tests' stamp: 'VV 11/28/2022 20:27:03'!
test15defenderCanMoveCorrectlyOnFirstTurnRolling10BothTimes
	|game|
	
	game _ self createGame.
	self diceRolls: #(10 10).
	
	game moveDefenderTo: 15@20.
	self assert: (game defenderOf: self team1 isAt: 15@20).
	self assert: ((game ballPositionIs: 10@10) and: (game hasBallForwardOf: self team1))




	! !

!FootballGameTest methodsFor: 'tests' stamp: 'VV 11/28/2022 20:27:57'!
test16defenderCanMoveCorrectlyOnFirstTurnRollingLessThan10
	|game|
	
	game _ self createGame.
	self diceRolls: #(5 5).
	
	game moveDefenderTo: 12@20.
	self assert: (game defenderOf: self team1 isAt: 7@15).
	self assert: ((game ballPositionIs: 10@10) and: (game hasBallForwardOf: self team1))




	! !

!FootballGameTest methodsFor: 'tests' stamp: 'VV 11/28/2022 20:36:58'!
test17forwardCannotMoveToOutOfBoundsPosition

	|game|
	game _ self createGame.
	self diceRolls: #(10 10).
	
	self should: [game moveForwardTo: 21@20] raise: Error withExceptionDo:
	[:anError| self assert: anError messageText equals: FootballGame outOfBoundsErrorMessage.
			self assert: (game forwardOf: self team1 isAt: 10@10)]! !

!FootballGameTest methodsFor: 'tests' stamp: 'VV 11/28/2022 20:37:52'!
test18midfieldCannotMoveToOutOfBoundsPosition

	|game|
	game _ self createGame.
	self diceRolls: #(10 10).
	
	self should: [game moveMidfieldTo: 21@20] raise: Error withExceptionDo:
	[:anError| self assert: anError messageText equals: FootballGame outOfBoundsErrorMessage.
			self assert: (game forwardOf: self team1 isAt: 10@10)]! !

!FootballGameTest methodsFor: 'tests' stamp: 'VV 11/28/2022 20:38:05'!
test19defenderCannotMoveToOutOfBoundsPosition

	|game|
	game _ self createGame.
	self diceRolls: #(10 10).
	
	self should: [game moveDefenderTo: 21@20] raise: Error withExceptionDo:
	[:anError| self assert: anError messageText equals: FootballGame outOfBoundsErrorMessage.
			self assert: (game forwardOf: self team1 isAt: 10@10)]! !

!FootballGameTest methodsFor: 'tests' stamp: 'VV 11/28/2022 20:49:36'!
test20forwardCanKickTheBallOnFirstTurn

	|game|
	game _ self createGame.
	self diceRolls: #(10 10).
	
	game forwardKicksTo: 10@5.
	self assert: (game ballPositionIs: 10@5).
	! !

!FootballGameTest methodsFor: 'tests' stamp: 'VV 11/28/2022 20:53:12'!
test21forwardKicksTheBallToHisMidfieldAndHeThenControllsIt

	|game|
	game _ self createGame.
	self diceRolls: #(10 10).
	
	game forwardKicksTo: 5@10.
	self assert: (game hasBallMidfieldOf: self team1).
	! !

!FootballGameTest methodsFor: 'tests' stamp: 'VV 11/28/2022 21:23:33'!
test22forwardKicksTheBallToHisDefenderAndHeThenControllsIt

	|game|
	game _ self createGame.
	self diceRolls: #(10 10).
	
	game forwardKicksTo: 2@10.
	self assert: (game hasBallDefenderOf: self team1).
	! !

!FootballGameTest methodsFor: 'tests' stamp: 'VV 11/28/2022 21:29:50'!
test23team1PlaysThenTeam2Plays

	|game|
	game _ self createGame.
	self diceRolls: #(10 10 10 10).
	
	game moveDefenderTo: 8@8.
	game moveMidfieldTo:  12@12.
	
	self assert: (game midfieldOf: self team2 isAt: 12@12)! !

!FootballGameTest methodsFor: 'tests' stamp: 'VV 11/28/2022 21:35:17'!
test24team1kicksBallToAdversaryAndThenTheyControllIt

	|game|
	game _ self createGame.
	self diceRolls: #(10 10 10 10).
	
	game forwardKicksTo: 11@10.
	
	self assert: (game hasBallForwardOf: self team2)! !

!FootballGameTest methodsFor: 'tests' stamp: 'VV 11/28/2022 21:36:49'!
test25ballDisputedBetweenForwardsStaysWithOriginalController

	|game|
	game _ self createGame.
	self diceRolls: #(10 10 10 10).
	
	game moveMidfieldTo: 12@12.
	game moveForwardTo: 10@10.
	
	self assert: (game hasBallForwardOf: self team1)! !

!FootballGameTest methodsFor: 'tests' stamp: 'VV 11/28/2022 21:56:04'!
test26ForwardLosesDisputeAgainstMidfieldWhenRollingMoreThan5

	|game|
	game _ self createGame.
	self diceRolls: #(10 10 10 10 6).
	
	game moveForwardTo: 12@12.
	game moveMidfieldTo: 12@12.
	
	self assert: (game hasBallMidfieldOf: self team1)! !

!FootballGameTest methodsFor: 'tests' stamp: 'VV 11/28/2022 21:56:09'!
test27ForwardWinsDisputeAgainstMidfieldWhenRollingLessThan5

	|game|
	game _ self createGame.
	self diceRolls: #(10 10 10 10 5).
	
	game moveForwardTo: 12@12.
	game moveMidfieldTo: 12@12.
	
	self assert: (game hasBallForwardOf: self team1)! !


!FootballGameTest methodsFor: 'auxiliary' stamp: 'VV 11/28/2022 19:27:53'!
createGame
	
	
	^ FootballGame withTeam1: self team1 team2: self team2 usingDice: self.! !

!FootballGameTest methodsFor: 'auxiliary' stamp: 'VV 11/28/2022 19:13:21'!
setUp

	gamex _ self createGame ! !

!FootballGameTest methodsFor: 'auxiliary' stamp: 'VV 11/28/2022 18:04:33'!
team1

	^'equipo1'.! !

!FootballGameTest methodsFor: 'auxiliary' stamp: 'VV 11/28/2022 18:04:38'!
team2

	^'equipo2'.! !


!FootballGameTest methodsFor: 'dice' stamp: 'VV 11/28/2022 19:25:23'!
diceRolls: aRollingResults
	
	rollingResults _ ReadStream on: aRollingResults ! !

!FootballGameTest methodsFor: 'dice' stamp: 'VV 11/28/2022 19:56:44'!
roll
	^rollingResults next.! !


!classDefinition: #Ball category: 'ISW1-2022-2C-2doParcial'!
Object subclass: #Ball
	instanceVariableNames: 'position game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-2doParcial'!

!Ball methodsFor: 'as yet unclassified' stamp: 'VV 11/28/2022 18:32:54'!
initializeAt: aPosition

	position := aPosition! !

!Ball methodsFor: 'as yet unclassified' stamp: 'VV 11/28/2022 18:08:55'!
isAt: aPosition

	^position = aPosition! !

!Ball methodsFor: 'as yet unclassified' stamp: 'VV 11/28/2022 19:43:32'!
position

^position copy! !


!Ball methodsFor: 'moving' stamp: 'VV 11/28/2022 19:59:57'!
moveTo: endPosition 
	position _ endPosition .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Ball class' category: 'ISW1-2022-2C-2doParcial'!
Ball class
	instanceVariableNames: ''!

!Ball class methodsFor: 'as yet unclassified' stamp: 'VV 11/28/2022 21:58:40'!
disputedBy: aCollectionOfPlayers at: aPosition 
	|player1 player2|
	
	aCollectionOfPlayers ifEmpty: [^BallNotControlledByPlayer at: aPosition].
	player1 _ aCollectionOfPlayers first.
	(aCollectionOfPlayers size = 1) ifTrue: [^BallControlledByPlayer at: player1 position by: player1].
	player2 _ aCollectionOfPlayers second.
	^ player1 disputeWith: player2.
	
! !


!classDefinition: #BallControlledByPlayer category: 'ISW1-2022-2C-2doParcial'!
Ball subclass: #BallControlledByPlayer
	instanceVariableNames: 'player'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-2doParcial'!

!BallControlledByPlayer methodsFor: 'as yet unclassified' stamp: 'VV 11/28/2022 18:33:38'!
initializeAt: aPosition controlledBy: aPlayer

	position := aPosition.
	player := aPlayer

! !


!BallControlledByPlayer methodsFor: 'accessing' stamp: 'VV 11/28/2022 19:04:24'!
isControlledBy: aPlayer

	^player = aPlayer 
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BallControlledByPlayer class' category: 'ISW1-2022-2C-2doParcial'!
BallControlledByPlayer class
	instanceVariableNames: ''!

!BallControlledByPlayer class methodsFor: 'as yet unclassified' stamp: 'VV 11/28/2022 18:33:11'!
at: aPosition by: aPlayer

	^self new initializeAt: aPosition controlledBy: aPlayer.! !


!classDefinition: #BallNotControlledByPlayer category: 'ISW1-2022-2C-2doParcial'!
Ball subclass: #BallNotControlledByPlayer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-2doParcial'!

!BallNotControlledByPlayer methodsFor: 'accessing' stamp: 'VV 11/28/2022 19:03:01'!
isControlledBy: aString 
	
	
	^false. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BallNotControlledByPlayer class' category: 'ISW1-2022-2C-2doParcial'!
BallNotControlledByPlayer class
	instanceVariableNames: ''!

!BallNotControlledByPlayer class methodsFor: 'as yet unclassified' stamp: 'VV 11/28/2022 18:30:55'!
at: aPosition

	^self new initializeAt: aPosition.! !


!classDefinition: #FootballGame category: 'ISW1-2022-2C-2doParcial'!
Object subclass: #FootballGame
	instanceVariableNames: 'teamName1 teamName2 teams ball dice teamCurrentlyPlaying'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-2doParcial'!

!FootballGame methodsFor: 'initialization' stamp: 'VV 11/28/2022 18:50:57'!
createTeam1

	^ OrderedCollection with: (Defender at: 2@10 onTeam: teamName1 onGame: self)
										with: (Midfield at: 5@10 onTeam: teamName1 onGame: self)
										with: (Forward at: 10@10 onTeam: teamName1 onGame: self)! !

!FootballGame methodsFor: 'initialization' stamp: 'VV 11/28/2022 18:51:30'!
createTeam2

	^ OrderedCollection with: (Defender at: 19@10 onTeam: teamName2 onGame: self)
					   with: (Midfield at: 15@10 onTeam: teamName2 onGame: self)
				          with: (Forward at: 11@10 onTeam: teamName2 onGame: self)! !

!FootballGame methodsFor: 'initialization' stamp: 'VV 11/28/2022 21:31:04'!
initializeWithTeam1: aTeamName1 team2: aTeamName2 usingDice: aDice  
	
	
	teamName1 := aTeamName1.
	teamName2 := aTeamName2.
	
	teams := Dictionary new.
	teams
		at: teamName1 put:( self createTeam1);
		at: teamName2 put: ( self createTeam2).
		
	ball := BallControlledByPlayer at: 10@10 by: (self forwardOf: teamName1).
	teamCurrentlyPlaying _  CircularReadStream on: {teamName1. teamName2} asOrderedCollection moving: NullUnit new.
	dice := aDice
	
	! !


!FootballGame methodsFor: 'players - private' stamp: 'VV 11/28/2022 19:01:14'!
defenderOf: aTeamName

	^ (teams at: aTeamName) detect: [:aPlayer| aPlayer isDefender]! !

!FootballGame methodsFor: 'players - private' stamp: 'VV 11/28/2022 19:00:30'!
forwardOf: aTeamName

	^ (teams at: aTeamName) detect: [:aPlayer| aPlayer isForward]! !

!FootballGame methodsFor: 'players - private' stamp: 'VV 11/28/2022 19:01:02'!
midfieldOf: aTeamName

	^ (teams at: aTeamName) detect: [:aPlayer| aPlayer isMidfield]! !


!FootballGame methodsFor: 'accesing ball' stamp: 'VV 11/28/2022 18:12:59'!
ballPositionIs: aPosition

	^ball isAt: aPosition
	
	
	! !

!FootballGame methodsFor: 'accesing ball' stamp: 'VV 11/28/2022 21:24:23'!
hasBallDefenderOf: aTeam 
	
	^ball isControlledBy: (self defenderOf: aTeam)! !

!FootballGame methodsFor: 'accesing ball' stamp: 'VV 11/28/2022 19:00:30'!
hasBallForwardOf: aTeamName 
	
	 ^ball isControlledBy: (self forwardOf: aTeamName)! !

!FootballGame methodsFor: 'accesing ball' stamp: 'VV 11/28/2022 20:54:03'!
hasBallMidfieldOf: aTeam 
	
	^ball isControlledBy: (self midfieldOf: aTeam)! !


!FootballGame methodsFor: 'accessing players' stamp: 'VV 11/28/2022 18:56:39'!
defenderOf: aTeam isAt: aPosition

	|defender|
	
	defender := (teams at: aTeam) detect: [:aPlayer| aPlayer isDefender].
	^defender isAt: aPosition
	! !

!FootballGame methodsFor: 'accessing players' stamp: 'VV 11/28/2022 18:57:38'!
forwardOf: aTeam isAt: aPosition 
	
	|forward|
	
	forward := (teams at: aTeam) detect: [:aPlayer| aPlayer isForward].
	^forward isAt: aPosition
	! !

!FootballGame methodsFor: 'accessing players' stamp: 'VV 11/28/2022 18:57:43'!
midfieldOf: aTeam isAt: aPosition

	|midfield|
	
	midfield := (teams at: aTeam) detect: [:aPlayer| aPlayer isMidfield].
	^midfield isAt: aPosition
	! !

!FootballGame methodsFor: 'accessing players' stamp: 'VV 11/28/2022 21:20:36'!
playersAt: aPosition 
	
	|playersAtPosition|
	
	playersAtPosition _ OrderedCollection new.
	
	(teams at: teamName1) do: [:aPlayer| (aPlayer isAt: aPosition) ifTrue:[ playersAtPosition add: aPlayer]].
	(teams at: teamName2) do: [:aPlayer| (aPlayer isAt: aPosition) ifTrue:[ playersAtPosition add: aPlayer]].
	^playersAtPosition ! !


!FootballGame methodsFor: 'moving' stamp: 'VV 11/28/2022 20:15:16'!
finalPositionWhenMoving: aPlayer to: aPosition

 	|verticalDelta horizontalDelta|
	
	horizontalDelta  _ ((aPosition x - aPlayer position x) * (dice roll / 10) asFloat ) asInteger.
	verticalDelta _ ((aPosition y - aPlayer position y) * (dice roll / 10) asFloat) asInteger.
	^aPlayer position + (horizontalDelta@verticalDelta).
	! !

!FootballGame methodsFor: 'moving' stamp: 'VV 11/28/2022 21:42:43'!
moveDefenderTo: aPosition 
	|defender endPosition |
	self class assertIsOutOfBounds: aPosition.
	defender _ self defenderOf: self currentTeam .
	
	endPosition _ self finalPositionWhenMoving: defender to: aPosition.
	
	defender moveTo: endPosition.
	(ball isControlledBy: defender) ifTrue: [ball moveTo: endPosition].
	(ball isAt: endPosition) ifTrue: [ball _ Ball disputedBy: (self playersAt: endPosition) at: endPosition ].
	self changeTurn .! !

!FootballGame methodsFor: 'moving' stamp: 'VV 11/28/2022 21:42:28'!
moveForwardTo: aPosition
 	|forward endPosition |
	
	self class assertIsOutOfBounds: aPosition.
	
	forward _ self forwardOf: self currentTeam .
	
	endPosition _ self finalPositionWhenMoving: forward to: aPosition.
	
	forward moveTo: endPosition.
	(ball isControlledBy: forward) ifTrue: [ball moveTo: endPosition].
	(ball isAt: endPosition) ifTrue: [ball _ Ball disputedBy: (self playersAt: endPosition) at: endPosition ].
	self changeTurn .! !

!FootballGame methodsFor: 'moving' stamp: 'VV 11/28/2022 21:43:54'!
moveMidfieldTo: aPosition 
	
	|midfield endPosition |
	self class assertIsOutOfBounds: aPosition.
	midfield _ self midfieldOf: self currentTeam .
	
	endPosition _ self finalPositionWhenMoving: midfield to: aPosition.
	
	midfield moveTo: endPosition.
	(ball isControlledBy: midfield) ifTrue: [ball moveTo: endPosition].
	(ball isAt: endPosition) ifTrue: [ball _ Ball disputedBy: (self playersAt: endPosition) at: endPosition].
	self changeTurn .! !


!FootballGame methodsFor: 'kicking' stamp: 'VV 11/28/2022 21:44:12'!
defenderKicksTo: aPosition 
	|player endPosition|
	self class assertIsOutOfBounds: aPosition.
	player _ (self midfieldOf:  self currentTeam).
	
	(ball isControlledBy: player) ifFalse: [self error: self class cannotKickErrorMessage].
	endPosition _ self finalPositionWhenMoving: player to: aPosition.
	self kickBallTo: endPosition 
	
	
	! !

!FootballGame methodsFor: 'kicking' stamp: 'VV 11/28/2022 21:44:12'!
forwardKicksTo: aPosition 
	|player endPosition|
	self class assertIsOutOfBounds: aPosition.
	player _ (self forwardOf:  self currentTeam).
	
	(ball isControlledBy:  player) ifFalse: [self error: self class cannotKickErrorMessage].
	endPosition _ self finalPositionWhenMoving: player to: aPosition.
	
	self kickBallTo: endPosition 
	
	
	! !

!FootballGame methodsFor: 'kicking' stamp: 'VV 11/28/2022 21:44:12'!
midfieldKicksTo: aPosition 
	|player endPosition|
	self class assertIsOutOfBounds: aPosition.
	player _ (self midfieldOf:  self currentTeam).
	
	(ball isControlledBy:  player) ifFalse: [self error: self class cannotKickErrorMessage].
	endPosition _ self finalPositionWhenMoving: player to: aPosition.
	
	self kickBallTo: endPosition 
	
	
	! !


!FootballGame methodsFor: 'turns' stamp: 'VV 11/28/2022 21:31:44'!
changeTurn

	^ teamCurrentlyPlaying next.! !

!FootballGame methodsFor: 'turns' stamp: 'VV 11/28/2022 21:31:32'!
currentTeam

	^ teamCurrentlyPlaying current.! !


!FootballGame methodsFor: 'moving the ball - private' stamp: 'VV 11/28/2022 21:49:14'!
kickBallTo: aPosition

	self class assertIsOutOfBounds: aPosition.
	
	ball _ Ball disputedBy: (self playersAt: aPosition) at: aPosition! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FootballGame class' category: 'ISW1-2022-2C-2doParcial'!
FootballGame class
	instanceVariableNames: ''!

!FootballGame class methodsFor: 'instance creation' stamp: 'VV 11/28/2022 17:53:01'!
assertIsValidTeam1: aTeamName2 team2: aTeamName1
	
	((aTeamName1 isKindOf: String) and: [aTeamName2 isKindOf: String]) ifFalse:[self error: self teamNamesMustBeStringsErrorMessage].
	(aTeamName1 = aTeamName2) ifTrue: [self error: self sameTeamNameErrorMessage].
	(aTeamName1 isEmpty or: [aTeamName2 isEmpty]) ifTrue: [self error: self emptyTeamNameErrorMessage]! !

!FootballGame class methodsFor: 'instance creation' stamp: 'VV 11/28/2022 19:28:55'!
withTeam1: aTeamName1 team2: aTeamName2 usingDice: aDice  
	
	self assertIsValidTeam1: aTeamName2 team2: aTeamName1.
	^self new initializeWithTeam1: aTeamName1 team2: aTeamName2 usingDice: aDice ! !


!FootballGame class methodsFor: 'error messages' stamp: 'VV 11/28/2022 17:55:26'!
emptyTeamNameErrorMessage
	^'Team names cannot be empty'! !

!FootballGame class methodsFor: 'error messages' stamp: 'VV 11/28/2022 20:37:10'!
outOfBoundsErrorMessage
	^'cannot move or kick out of bounds'! !

!FootballGame class methodsFor: 'error messages' stamp: 'VV 11/28/2022 17:53:32'!
sameTeamNameErrorMessage
	^'Team names cannot be the same'! !

!FootballGame class methodsFor: 'error messages' stamp: 'VV 11/28/2022 17:57:01'!
teamNamesMustBeStringsErrorMessage
	^'Team names must be strings'! !


!FootballGame class methodsFor: 'assertions' stamp: 'VV 11/28/2022 20:36:58'!
assertIsOutOfBounds: aPosition.

	(aPosition x < 1 or: [aPosition x > 20] or: [aPosition y <1] or: [aPosition y > 20]) ifTrue: [self error: self outOfBoundsErrorMessage]! !


!classDefinition: #Player category: 'ISW1-2022-2C-2doParcial'!
Object subclass: #Player
	instanceVariableNames: 'position team game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-2doParcial'!

!Player methodsFor: 'as yet unclassified' stamp: 'VV 11/28/2022 19:08:22'!
= anObject

	^ (anObject isKindOf: self class) and: 
		[anObject isAt: position] and:
		[anObject isOfTeam: team] and:
		 [anObject isInGame: game]

! !

!Player methodsFor: 'as yet unclassified' stamp: 'VV 11/28/2022 21:58:40'!
disputeWith: anAdversaryPlayer

	self subclassResponsibility .! !

!Player methodsFor: 'as yet unclassified' stamp: 'VV 11/28/2022 18:41:36'!
initializeAt: aPosition onTeam: aTeamName onGame: aFootballGame

	position := aPosition.
	team := aTeamName.
	game := aFootballGame.! !

!Player methodsFor: 'as yet unclassified' stamp: 'VV 11/28/2022 18:34:32'!
isAt: aPosition

	^position = aPosition! !

!Player methodsFor: 'as yet unclassified' stamp: 'VV 11/28/2022 18:44:11'!
isDefender

	^false! !

!Player methodsFor: 'as yet unclassified' stamp: 'VV 11/28/2022 18:44:20'!
isForward

	^false! !

!Player methodsFor: 'as yet unclassified' stamp: 'VV 11/28/2022 19:09:20'!
isInGame: aFootballGame

	^ game = aFootballGame ! !

!Player methodsFor: 'as yet unclassified' stamp: 'VV 11/28/2022 18:44:27'!
isMidfield

	^false! !

!Player methodsFor: 'as yet unclassified' stamp: 'VV 11/28/2022 19:09:03'!
isOfTeam: aTeamName

	^ team = aTeamName ! !

!Player methodsFor: 'as yet unclassified' stamp: 'VV 11/28/2022 19:43:47'!
position

	^position copy! !

!Player methodsFor: 'as yet unclassified' stamp: 'VV 11/28/2022 19:43:00'!
position: aPosition

	^position = aPosition copy! !


!Player methodsFor: 'moving' stamp: 'VV 11/28/2022 19:59:23'!
moveTo: endPosition 
	position _ endPosition .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Player class' category: 'ISW1-2022-2C-2doParcial'!
Player class
	instanceVariableNames: 'team position game'!

!Player class methodsFor: 'as yet unclassified' stamp: 'VV 11/28/2022 18:55:12'!
at: aPosition onTeam: aTeamName onGame: aFootballGame

	^self new initializeAt: aPosition onTeam: aTeamName onGame: aFootballGame! !


!classDefinition: #Defender category: 'ISW1-2022-2C-2doParcial'!
Player subclass: #Defender
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-2doParcial'!

!Defender methodsFor: 'as yet unclassified' stamp: 'VV 11/28/2022 21:58:40'!
disputeWith: aPlayer

	aPlayer disputeWithDefender: self! !

!Defender methodsFor: 'as yet unclassified' stamp: 'VV 11/28/2022 21:16:29'!
disputeWithDefender: aDefender

	! !

!Defender methodsFor: 'as yet unclassified' stamp: 'VV 11/28/2022 22:00:24'!
disputeWithForward: aForward

	^BallControlledByPlayer at: self position by: self! !

!Defender methodsFor: 'as yet unclassified' stamp: 'VV 11/28/2022 21:16:40'!
disputeWithMidfield: aDefender

	! !

!Defender methodsFor: 'as yet unclassified' stamp: 'VV 11/28/2022 18:43:32'!
isDefender

	^true! !


!classDefinition: #Forward category: 'ISW1-2022-2C-2doParcial'!
Player subclass: #Forward
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-2doParcial'!

!Forward methodsFor: 'as yet unclassified' stamp: 'VV 11/28/2022 21:58:55'!
disputeWith: aPlayer

	^aPlayer disputeWithForward: self! !

!Forward methodsFor: 'as yet unclassified' stamp: 'VV 11/28/2022 21:59:01'!
disputeWithDefender: aDefender
	
	^BallControlledByPlayer at: aDefender position by: aDefender.
! !

!Forward methodsFor: 'as yet unclassified' stamp: 'VV 11/28/2022 21:58:55'!
disputeWithForward: aForward

	"aForward es quien controlaba originalmente"
	^BallControlledByPlayer at: aForward position by: aForward.! !

!Forward methodsFor: 'as yet unclassified' stamp: 'VV 11/28/2022 21:58:45'!
disputeWithMidfield: aMidfield
	
	(game roll > 6) ifTrue: [	^BallControlledByPlayer at: aMidfield position by: aMidfield].
	^BallControlledByPlayer at: self position by: self! !

!Forward methodsFor: 'as yet unclassified' stamp: 'VV 11/28/2022 18:44:38'!
isForward

	^true! !



!classDefinition: #Midfield category: 'ISW1-2022-2C-2doParcial'!
Player subclass: #Midfield
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-2doParcial'!

!Midfield methodsFor: 'as yet unclassified' stamp: 'VV 11/28/2022 21:58:40'!
disputeWith: aPlayer

	^aPlayer disputeWith: self! !

!Midfield methodsFor: 'as yet unclassified' stamp: 'VV 11/28/2022 22:02:29'!
disputeWithForward: aForward

	(game roll < 5) ifTrue: [^BallControlledByPlayer at: aForward position by: aForward].
	^BallControlledByPlayer at: self position by: self! !

!Midfield methodsFor: 'as yet unclassified' stamp: 'VV 11/28/2022 18:44:56'!
isMidfield

	^true! !
