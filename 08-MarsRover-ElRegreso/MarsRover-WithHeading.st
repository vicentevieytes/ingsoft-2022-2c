!classDefinition: #LogTest category: 'MarsRover-WithHeading'!
TestCase subclass: #LogTest
	instanceVariableNames: 'rover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!
!LogTest commentStamp: '<historical>' prior: 0!
t!


!LogTest methodsFor: 'headings' stamp: 'MV 10/24/2022 20:17:42'!
east

	^MarsRoverHeadingEast.! !

!LogTest methodsFor: 'headings' stamp: 'MV 10/24/2022 20:17:45'!
north

	^MarsRoverHeadingNorth .! !

!LogTest methodsFor: 'headings' stamp: 'MV 10/24/2022 20:17:56'!
south

	^MarsRoverHeadingSouth .! !

!LogTest methodsFor: 'headings' stamp: 'MV 10/24/2022 20:17:50'!
west

	^MarsRoverHeadingWest .! !


!LogTest methodsFor: 'setUp' stamp: 'MV 10/24/2022 20:17:19'!
setUp

	rover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.! !


!LogTest methodsFor: 'tests' stamp: 'MV 10/24/2022 20:53:10'!
test01NewRoverHasNoLogsAfterProcessingEmptyWhenLoggingPositions
	|logger|
	
	logger _ Logger for: rover.
	logger startLoggingPositions.
	rover process: ''.
	self assert: logger logs equals: OrderedCollection new.  ! !

!LogTest methodsFor: 'tests' stamp: 'MV 10/24/2022 20:52:55'!
test02NewRoverHasNoLogsAfterProcessingEmptyWhenLoggingDirections
	|logger|
	
	logger _ Logger for: rover.
	logger startLoggingDirections.
	rover process: ''.
	self assert: logger logs equals: OrderedCollection new.  ! !

!LogTest methodsFor: 'tests' stamp: 'MV 10/24/2022 20:53:27'!
test03NewMarsRoverHasNoLogsAfterProcessingEmptyWhenLoggingBothDirectionsAndPositions
	|logger|
	
	logger _ Logger for: rover.
	logger startLoggingDirections.
	logger startLoggingPositions.
	rover process: ''.
	self assert: logger logs equals: OrderedCollection new.  ! !

!LogTest methodsFor: 'tests' stamp: 'MV 10/24/2022 21:24:35'!
test04LoggerLoggingPositionsCorrectlyLogsMovingForward
	
	|logger|
	
	logger _ Logger for: rover.
	logger startLoggingPositions.
	
	rover process: 'f'.
	
	self assert: logger logs equals: (OrderedCollection with: '1@2' )! !

!LogTest methodsFor: 'tests' stamp: 'MV 10/24/2022 21:28:23'!
test05LoggerLoggingPositionsCorrectlyLogsManyMovements
	
	|logger|
	
	logger _ Logger for: rover.
	logger startLoggingPositions.
	
	rover process: 'ffbrfrb'.
	
	self assert: logger logs equals: {'1@2'. '1@3'. '1@2'. '2@2'. '2@3'} asOrderedCollection ! !

!LogTest methodsFor: 'tests' stamp: 'MV 10/24/2022 21:31:15'!
test06LoggerLoggingPositionsCorrectlyStoppsLogging
	
	|logger|
	
	logger _ Logger for: rover.
	logger startLoggingPositions.
	
	rover process: 'f'.
	
	logger stopLoggingPositions.
	rover process: 'fff'.
	
	logger startLoggingPositions.
	rover process: 'f'. 
	
	self assert: logger logs equals: {'1@2'. '1@6'} asOrderedCollection ! !

!LogTest methodsFor: 'tests' stamp: 'MV 10/24/2022 21:32:47'!
test07LoggerLoggingDirectionsCorrectlyLogsTurningRight
	
	 |logger|
	
	logger _ Logger for: rover.
	logger startLoggingDirections.
	
	rover process: 'r'.
	
	self assert: logger logs equals: (OrderedCollection with: 'East')! !


!classDefinition: #MarsRoverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:21:23'!
test01DoesNotMoveWhenNoCommand

	self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: '' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:12'!
test02IsAtFailsForDifferentPosition

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@2 heading: self north)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:31'!
test03IsAtFailsForDifferentHeading

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@1 heading: self south)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:17'!
test04IncrementsYAfterMovingForwardWhenHeadingNorth

	self 
		assertIsAt: 1@3 
		heading: self north 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:11'!
test06DecrementsYAfterMovingBackwardsWhenHeadingNorth

	self 
		assertIsAt: 1@1 
		heading: self north 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:59'!
test07PointToEashAfterRotatingRightWhenHeadingNorth

	self 
		assertIsAt: 1@2 
		heading: self east 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:51'!
test08PointsToWestAfterRotatingLeftWhenPointingNorth

	self 
		assertIsAt: 1@2 
		heading: self west 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:45'!
test09DoesNotProcessInvalidCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: self north.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: self north) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:39'!
test10CanProcessMoreThanOneCommand

	self 
		assertIsAt: 1@4 
		heading: self north 
		afterProcessing: 'ff' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:31'!
test11IncrementsXAfterMovingForwareWhenHeadingEast

	self 
		assertIsAt: 2@2 
		heading: self east 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:19'!
test12DecrementsXAfterMovingBackwardWhenHeadingEast

	self 
		assertIsAt: 0@2 
		heading: self east 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:14'!
test13PointsToSouthAfterRotatingRightWhenHeadingEast

		self 
		assertIsAt: 1@2 
		heading: self south 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:05'!
test14PointsToNorthAfterRotatingLeftWhenPointingEast

		self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:00'!
test15ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingSouth

	self 
		assertIsAt: 1@1 
		heading: self west 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self south 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:52'!
test16ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingWest

	self 
		assertIsAt: 0@2 
		heading: self north 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self west 
! !


!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:31'!
east

	^ MarsRoverHeadingEast ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:38'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:45'!
south

	^ MarsRoverHeadingSouth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:54'!
west

	^ MarsRoverHeadingWest ! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'HAW 10/7/2021 20:20:47'!
assertIsAt: newPosition heading: newHeadingType afterProcessing: commands whenStartingAt: startPosition heading: startHeadingType

	| marsRover |
	
	marsRover := MarsRover at: startPosition heading: startHeadingType. 
	
	marsRover process: commands.
	
	self assert: (marsRover isAt: newPosition heading: newHeadingType)! !


!classDefinition: #Logger category: 'MarsRover-WithHeading'!
Object subclass: #Logger
	instanceVariableNames: 'marsRover loggingPositions loggingDirections log'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!Logger methodsFor: 'initialization' stamp: 'MV 10/24/2022 21:41:25'!
initializeFor: aMarsRover
	
	loggingPositions _ false.
	loggingDirections _ false.
	log := OrderedCollection new.
	marsRover := aMarsRover.
	aMarsRover setLogger: self.! !


!Logger methodsFor: 'logging' stamp: 'MV 10/24/2022 21:59:19'!
headingName: aHeadingType

	(aHeadingType name = MarsRoverHeadingEast name asString) ifTrue: [^'East'].
	(aHeadingType name = MarsRoverHeadingNorth name asString) ifTrue:[^'North'].
	(aHeadingType name = MarsRoverHeadingWest name asString) ifTrue: [^'West'].
	(aHeadingType name = MarsRoverHeadingSouth name asString) ifTrue:[^'South'].! !

!Logger methodsFor: 'logging' stamp: 'MV 10/24/2022 21:42:23'!
startLoggingDirections
	loggingDirections _ true.! !

!Logger methodsFor: 'logging' stamp: 'MV 10/24/2022 21:13:04'!
startLoggingPositions
	loggingPositions _ true 
	! !

!Logger methodsFor: 'logging' stamp: 'MV 10/24/2022 21:31:03'!
stopLoggingPositions
	loggingPositions _ false.! !


!Logger methodsFor: 'accessing' stamp: 'MV 10/24/2022 21:24:16'!
logs
	^log.! !


!Logger methodsFor: 'as yet unclassified' stamp: 'MV 10/24/2022 21:50:33'!
logHeading: aHeadingType.

	loggingDirections ifTrue: [log addLast: (self headingName: aHeadingType)]! !

!Logger methodsFor: 'as yet unclassified' stamp: 'MV 10/24/2022 21:23:21'!
logPosition: aPosition.

	loggingPositions ifTrue: [log addLast: aPosition asString]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Logger class' category: 'MarsRover-WithHeading'!
Logger class
	instanceVariableNames: ''!

!Logger class methodsFor: 'instance creation' stamp: 'MV 10/24/2022 20:24:12'!
for: aMarsRover 
	
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head logger'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'MV 10/24/2022 21:18:53'!
initializeAt: aPosition heading: aHeadingType

	position := aPosition.
	head := aHeadingType for: self.
	logger _ NullLogger new! !

!MarsRover methodsFor: 'initialization' stamp: 'MV 10/24/2022 20:56:24'!
setLogger: aLogger

	logger _ aLogger! !


!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:02'!
headEast
	
	head := MarsRoverHeadingEast for: self! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:12'!
headNorth
	
	head := MarsRoverHeadingNorth for: self ! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:17'!
headSouth
	
	head := MarsRoverHeadingSouth for: self! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:24'!
headWest
	
	head := MarsRoverHeadingWest for: self ! !

!MarsRover methodsFor: 'heading' stamp: 'MV 10/24/2022 21:36:39'!
rotateLeft
	
	head rotateLeft.
	logger logHeading: head! !

!MarsRover methodsFor: 'heading' stamp: 'MV 10/24/2022 21:36:43'!
rotateRight
	
	head rotateRight.
	logger logHeading: head! !


!MarsRover methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:16:32'!
isAt: aPosition heading: aHeadingType

	^position = aPosition and: [ head isHeading: aHeadingType ]! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'moving' stamp: 'MV 10/24/2022 21:21:13'!
moveBackward
	
	head moveBackward.
	logger logPosition: position
	! !

!MarsRover methodsFor: 'moving' stamp: 'MV 10/24/2022 21:02:27'!
moveEast
	
	position := position + (1@0)
	! !

!MarsRover methodsFor: 'moving' stamp: 'MV 10/24/2022 21:21:28'!
moveForward
	
	head moveForward.
	logger logPosition: position! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:13:12'!
moveNorth
	
	position := position + (0@1)! !

!MarsRover methodsFor: 'moving' stamp: 'MV 10/24/2022 21:01:39'!
moveSouth
	
	position := position + (0@-1).
	! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:15:32'!
moveWest
	
	position := position + (-1@0)! !


!MarsRover methodsFor: 'command processing' stamp: 'HAW 6/30/2018 19:48:26'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'MV 10/24/2022 21:05:05'!
processCommand: aCommand
	
	
	
	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


!classDefinition: #MarsRoverHeading category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:15:38'!
isHeading: aHeadingType

	^self isKindOf: aHeadingType ! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:11:59'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:11:35'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headSouth! !


!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headEast! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headWest! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	^marsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headNorth! !


!classDefinition: #NullLogger category: 'MarsRover-WithHeading'!
Object subclass: #NullLogger
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!NullLogger methodsFor: 'as yet unclassified' stamp: 'MV 10/24/2022 21:38:01'!
logDirection: aDirection! !

!NullLogger methodsFor: 'as yet unclassified' stamp: 'MV 10/24/2022 21:38:28'!
logHeading: aHeadingType! !

!NullLogger methodsFor: 'as yet unclassified' stamp: 'MV 10/24/2022 21:37:51'!
logPosition: aPosition! !
