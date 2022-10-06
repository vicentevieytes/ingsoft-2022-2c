!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'north east west south'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'tests' stamp: 'LM 10/6/2022 12:09:04'!
test01NewRoverIsAtPositionWithDirection

	|position direction rover|
	
	position := 1@1.
	direction := north.
	
	rover := MarsRover in: position facing: direction.
	
	self assert: (rover isAt: position facing: direction).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LM 10/6/2022 12:16:34'!
test02ForwardFacingNorthMovesRoverTowardsNorth

	self assertThatRoverIn: 1@1 facing: north isAt: 1@2 facing: north afterCommands: 'f'! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LM 10/6/2022 12:17:15'!
test03ForwardFacingEastMovesRoverTowardsEast

	self assertThatRoverIn: 1@1 facing: east isAt: 2@1 facing: east afterCommands: 'f'! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LM 10/6/2022 12:18:06'!
test04ForwardFacingSouthMovesRoverTowardsSouth

	self assertThatRoverIn: 1@1 facing: south isAt: 1@0 facing: south afterCommands: 'f'! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LM 10/6/2022 12:18:25'!
test05ForwardFacingWestMovesRoverTowardsWest

	self assertThatRoverIn: 1@1 facing: west isAt: 0@1 facing: west afterCommands: 'f'! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LM 10/6/2022 12:18:49'!
test06BackwardsFacingNorthMovesTowardsSouth

	self assertThatRoverIn: 1@1 facing: north isAt: 1@0 facing: north afterCommands: 'b'! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LM 10/6/2022 12:19:10'!
test07BackwardsFacingEastMovesTowardsWest

	self assertThatRoverIn: 1@1 facing: east isAt: 0@1 facing: east afterCommands: 'b'! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LM 10/6/2022 12:23:22'!
test08BackwardsFacingSouthMovesTowardsNorth

	self assertThatRoverIn: 1@1 facing: south isAt: 1@2 facing: south afterCommands: 'b'! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LM 10/6/2022 12:24:34'!
test09BackwardsFacingWestMovesTowardsEast

	self assertThatRoverIn: 1@1 facing: west isAt: 2@1 facing: west afterCommands: 'b'! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LM 10/6/2022 12:24:58'!
test10RotateLeftFacingNorthEndsUpFacingWest

	self assertThatRoverIn: 1@1 facing: north isAt: 1@1 facing: west afterCommands: 'l'! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LM 10/6/2022 12:25:15'!
test11RotateLeftFacingEastEndsUpFacingNorth

	self assertThatRoverIn: 1@1 facing: east isAt: 1@1 facing: north afterCommands: 'l'! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LM 10/6/2022 12:25:26'!
test12RotateLeftFacingSouthEndsUpFacingEast

	self assertThatRoverIn: 1@1 facing: south isAt: 1@1 facing: east afterCommands: 'l'! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LM 10/6/2022 12:25:39'!
test13RotateLeftFacingWestEndsUpFacingSouth

	self assertThatRoverIn: 1@1 facing: west isAt: 1@1 facing: south afterCommands: 'l'! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LM 10/6/2022 12:26:15'!
test14RotateRightFacingNorthEndsUpFacingEast

	self assertThatRoverIn: 1@1 facing: north isAt: 1@1 facing: east afterCommands: 'r'! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LM 10/6/2022 12:26:31'!
test15RotateRightFacingEastEndsUpFacingSouth

	self assertThatRoverIn: 1@1 facing: east isAt: 1@1 facing: south afterCommands: 'r'! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LM 10/6/2022 12:26:45'!
test16RotateRightFacingSouthEndsUpFacingWest

	self assertThatRoverIn: 1@1 facing: south isAt: 1@1 facing: west afterCommands: 'r'! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LM 10/6/2022 12:26:55'!
test17RotateRightFacingWestEndsUpFacingNorth

	self assertThatRoverIn: 1@1 facing: west isAt: 1@1 facing: north afterCommands: 'r'! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LM 10/6/2022 12:54:07'!
test18InvalidCommandFails

	self assertThatRoverIn: 1@1 facing: north failsAfterInvalidCommands: 'k' andIsAt: 1@1 facing: north! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LM 10/6/2022 12:27:27'!
test19SequenceOfCommandsIsCorrectlyExecuted

	self assertThatRoverIn: 1@1 facing: north isAt: 2@1 facing: north afterCommands: 'fbflbrb'! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LM 10/6/2022 12:54:24'!
test20SequenceOfCommandsWithInvalidCommandIsCorrectlyExecutedUpToInvalidOne

	self assertThatRoverIn: 1@1 facing: north failsAfterInvalidCommands: 'fbflbrbkffffffl' andIsAt: 2@1 facing: north! !


!MarsRoverTest methodsFor: 'setUp' stamp: 'LM 10/6/2022 12:52:16'!
setUp

	north _ NorthDirection new.
	east _ EastDirection new.
	west _ WestDirection new.
	south _ SouthDirection new.! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'LM 10/6/2022 12:39:18'!
assertThatRoverIn: aPosition facing: aDirection failsAfterInvalidCommands: aSequenceOfInvalidCommands andIsAt: aNextPosition facing: aNextDirection

	|rover|
	
	rover _ MarsRover in: aPosition facing: aDirection.
	
	self
		should: [ rover move: aSequenceOfInvalidCommands]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = MarsRover invalidCommandErrorMessage.
			self assert: (rover isAt: aNextPosition facing: aNextDirection).
			]! !

!MarsRoverTest methodsFor: 'assertions' stamp: 'LM 10/6/2022 12:15:29'!
assertThatRoverIn: aPosition facing: aDirection isAt: aNextPosition facing: aNextDirection afterCommands: aSequenceOfCommands

	|rover|
	
	rover _ MarsRover in: aPosition facing: aDirection.
	
	rover move: aSequenceOfCommands.
	
	self assert: (rover isAt: aNextPosition facing: aNextDirection).! !


!classDefinition: #CardinalDirection category: 'MarsRover'!
Object subclass: #CardinalDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!CardinalDirection methodsFor: 'rotate' stamp: 'LM 10/6/2022 11:13:00'!
rotateLeft
	self subclassResponsibility! !

!CardinalDirection methodsFor: 'rotate' stamp: 'LM 10/6/2022 11:33:08'!
rotateRight
	self subclassResponsibility! !


!CardinalDirection methodsFor: 'comparing' stamp: 'LM 10/6/2022 11:18:07'!
= aCardinalDirection
	^self class = aCardinalDirection class.
	! !


!CardinalDirection methodsFor: 'displacement' stamp: 'LM 10/6/2022 11:26:18'!
backwardsDisplacement

	self subclassResponsibility! !

!CardinalDirection methodsFor: 'displacement' stamp: 'LM 10/6/2022 11:22:53'!
forwardDisplacement

	self subclassResponsibility ! !


!classDefinition: #EastDirection category: 'MarsRover'!
CardinalDirection subclass: #EastDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!EastDirection methodsFor: 'rotate' stamp: 'LM 10/6/2022 12:52:06'!
rotateLeft
	^NorthDirection new.! !

!EastDirection methodsFor: 'rotate' stamp: 'LM 10/6/2022 12:52:11'!
rotateRight
	^SouthDirection new.! !


!EastDirection methodsFor: 'displacement' stamp: 'LM 10/6/2022 11:26:03'!
backwardsDisplacement

	^(-1)@0! !

!EastDirection methodsFor: 'displacement' stamp: 'LM 10/6/2022 11:23:14'!
forwardDisplacement

	^1@0! !


!classDefinition: #NorthDirection category: 'MarsRover'!
CardinalDirection subclass: #NorthDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!NorthDirection methodsFor: 'rotate' stamp: 'LM 10/6/2022 12:52:16'!
rotateLeft
	^WestDirection new.! !

!NorthDirection methodsFor: 'rotate' stamp: 'LM 10/6/2022 12:51:54'!
rotateRight
	^EastDirection new.! !


!NorthDirection methodsFor: 'displacement' stamp: 'LM 10/6/2022 11:26:33'!
backwardsDisplacement

	^0@(-1)! !

!NorthDirection methodsFor: 'displacement' stamp: 'LM 10/6/2022 11:23:24'!
forwardDisplacement

	^0@1! !


!classDefinition: #SouthDirection category: 'MarsRover'!
CardinalDirection subclass: #SouthDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!SouthDirection methodsFor: 'rotate' stamp: 'LM 10/6/2022 12:51:54'!
rotateLeft
	^EastDirection new.! !

!SouthDirection methodsFor: 'rotate' stamp: 'LM 10/6/2022 12:52:16'!
rotateRight
	^WestDirection new.! !


!SouthDirection methodsFor: 'displacement' stamp: 'LM 10/6/2022 11:26:42'!
backwardsDisplacement

	^0@1! !

!SouthDirection methodsFor: 'displacement' stamp: 'LM 10/6/2022 11:23:35'!
forwardDisplacement

	^0@(-1)! !


!classDefinition: #WestDirection category: 'MarsRover'!
CardinalDirection subclass: #WestDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!WestDirection methodsFor: 'rotate' stamp: 'LM 10/6/2022 12:52:11'!
rotateLeft
	^SouthDirection new.! !

!WestDirection methodsFor: 'rotate' stamp: 'LM 10/6/2022 12:52:06'!
rotateRight
	^NorthDirection new.! !


!WestDirection methodsFor: 'displacement' stamp: 'LM 10/6/2022 11:26:54'!
backwardsDisplacement

	^1@0! !

!WestDirection methodsFor: 'displacement' stamp: 'LM 10/6/2022 11:23:53'!
forwardDisplacement

	^(-1)@0! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'LM 10/3/2022 21:03:40'!
initializeIn: aPosition facing: aCardinalDirection 
	
	position _ aPosition.
	direction _ aCardinalDirection.! !


!MarsRover methodsFor: 'accessing' stamp: 'LM 10/3/2022 21:03:40'!
direction

	^direction ! !

!MarsRover methodsFor: 'accessing' stamp: 'LM 10/3/2022 21:03:34'!
position

	^position! !


!MarsRover methodsFor: 'moving' stamp: 'LM 10/6/2022 14:27:20'!
move: aSequenceOfCommandsAsString
	
	aSequenceOfCommandsAsString do: [:character| (RoverCommand fromCharacter: character) moveRover: self.]! !


!MarsRover methodsFor: 'testing' stamp: 'LM 10/6/2022 12:29:54'!
isAt: aPosition facing: aDirection
	^aPosition = self position and: aDirection = self direction.! !


!MarsRover methodsFor: 'moving - private' stamp: 'LM 10/6/2022 11:41:28'!
moveBackward
	position _ position + direction backwardsDisplacement.! !

!MarsRover methodsFor: 'moving - private' stamp: 'LM 10/6/2022 11:38:49'!
moveForward
	
	position _ position + direction forwardDisplacement.! !

!MarsRover methodsFor: 'moving - private' stamp: 'LM 10/6/2022 11:39:41'!
rotateLeft
	
	direction _ direction rotateLeft! !

!MarsRover methodsFor: 'moving - private' stamp: 'LM 10/6/2022 11:39:37'!
rotateRight
		
	direction _ direction rotateRight.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'LM 10/3/2022 20:55:10'!
in: aPosition facing: aCardinalDirection 
	
	^self new initializeIn: aPosition facing: aCardinalDirection! !


!MarsRover class methodsFor: 'error messages' stamp: 'LM 10/6/2022 11:49:03'!
invalidCommandErrorMessage

	^'Invalid command'! !


!classDefinition: #RoverCommand category: 'MarsRover'!
Object subclass: #RoverCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RoverCommand methodsFor: 'moving' stamp: 'LM 10/6/2022 11:37:15'!
moveRover: aRover

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RoverCommand class' category: 'MarsRover'!
RoverCommand class
	instanceVariableNames: ''!

!RoverCommand class methodsFor: 'instance creation' stamp: 'LM 10/6/2022 11:54:11'!
fromCharacter: aCharacter

	aCharacter = $f ifTrue: [^Forward new].
	aCharacter = $b ifTrue: [^Backward new].
	aCharacter = $l ifTrue: [^RotateLeft new].
	aCharacter = $r ifTrue: [^RotateRight new].
	^InvalidCommand new! !


!classDefinition: #Backward category: 'MarsRover'!
RoverCommand subclass: #Backward
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Backward methodsFor: 'moving' stamp: 'LM 10/6/2022 11:41:39'!
moveRover: aRover
	
	aRover moveBackward! !


!classDefinition: #Forward category: 'MarsRover'!
RoverCommand subclass: #Forward
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Forward methodsFor: 'moving' stamp: 'LM 10/6/2022 11:41:43'!
moveRover: aRover

	aRover moveForward! !


!classDefinition: #InvalidCommand category: 'MarsRover'!
RoverCommand subclass: #InvalidCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!InvalidCommand methodsFor: 'moving' stamp: 'LM 10/6/2022 11:55:08'!
moveRover: aRover

	self error: MarsRover invalidCommandErrorMessage.! !


!classDefinition: #RotateLeft category: 'MarsRover'!
RoverCommand subclass: #RotateLeft
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RotateLeft methodsFor: 'moving' stamp: 'LM 10/6/2022 11:38:20'!
moveRover: aRover

	aRover rotateLeft.! !


!classDefinition: #RotateRight category: 'MarsRover'!
RoverCommand subclass: #RotateRight
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RotateRight methodsFor: 'moving' stamp: 'LM 10/6/2022 11:38:30'!
moveRover: aRover

	aRover rotateRight.! !
