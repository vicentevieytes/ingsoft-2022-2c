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


!classDefinition: #RoverDistanceMeasurerTest category: 'MarsRover-WithHeading'!
TestCase subclass: #RoverDistanceMeasurerTest
	instanceVariableNames: 'rover measurer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!RoverDistanceMeasurerTest methodsFor: 'setUp' stamp: 'LM 10/26/2022 21:27:51'!
setUp

	rover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	measurer _ RoverDistanceMeasurer for: rover! !


!RoverDistanceMeasurerTest methodsFor: 'tests' stamp: 'LM 10/26/2022 21:31:34'!
test01NewRoverHasDistance0AfterProcessingEmpty
	
	rover process: ''.
	self assert: measurer distanceFromOrigin equals: 0! !

!RoverDistanceMeasurerTest methodsFor: 'tests' stamp: 'LM 10/26/2022 21:39:14'!
test02CalculatesDistanceAfterMoving
	
	rover process: 'ffrff'.
	self assert: measurer distanceFromOrigin equals: (1@1 dist: 3@3)! !


!classDefinition: #RoverLoggerTest category: 'MarsRover-WithHeading'!
TestCase subclass: #RoverLoggerTest
	instanceVariableNames: 'rover logger'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!
!RoverLoggerTest commentStamp: '<historical>' prior: 0!
t!


!RoverLoggerTest methodsFor: 'headings' stamp: 'MV 10/24/2022 20:17:42'!
east

	^MarsRoverHeadingEast.! !

!RoverLoggerTest methodsFor: 'headings' stamp: 'MV 10/24/2022 20:17:45'!
north

	^MarsRoverHeadingNorth .! !

!RoverLoggerTest methodsFor: 'headings' stamp: 'MV 10/24/2022 20:17:56'!
south

	^MarsRoverHeadingSouth .! !

!RoverLoggerTest methodsFor: 'headings' stamp: 'MV 10/24/2022 20:17:50'!
west

	^MarsRoverHeadingWest .! !


!RoverLoggerTest methodsFor: 'setUp' stamp: 'V 10/25/2022 20:02:55'!
setUp

	rover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger _ RoverLogger for: rover! !


!RoverLoggerTest methodsFor: 'tests' stamp: 'LM 10/26/2022 21:48:11'!
startLoggingDirectionsAndAssertThatLogsAreEqualTo: aLog  afterProcessing: aSequenceOfCommands.

	logger startLoggingDirections.
	
	rover process: aSequenceOfCommands.
	
	self assert: logger logs equals: aLog! !

!RoverLoggerTest methodsFor: 'tests' stamp: 'LM 10/26/2022 21:45:34'!
startLoggingPositionsAndAssertThatLogsAreEqualTo: aLog afterProcessing: aSequenceOfCommands
	
	logger startLoggingPositions.
	
	rover process: aSequenceOfCommands .
	
	self assert: logger logs equals: aLog! !

!RoverLoggerTest methodsFor: 'tests' stamp: 'LM 10/26/2022 21:41:27'!
test01NewRoverHasNoLogsAfterProcessingEmptyCommandWhenLoggingPositions
	
	logger startLoggingPositions.
	rover process: ''.
	self assert: logger logs equals: OrderedCollection new.  ! !

!RoverLoggerTest methodsFor: 'tests' stamp: 'LM 10/26/2022 21:41:31'!
test02NewRoverHasNoLogsAfterProcessingEmptyCommandWhenLoggingDirections
	
	logger startLoggingDirections.
	rover process: ''.
	self assert: logger logs equals: OrderedCollection new.  ! !

!RoverLoggerTest methodsFor: 'tests' stamp: 'LM 10/26/2022 21:41:35'!
test03NewMarsRoverHasNoLogsAfterProcessingEmptyWhenLoggingBothDirectionsAndPositions
	
	logger startLoggingDirections.
	logger startLoggingPositions.
	rover process: ''.
	self assert: logger logs equals: OrderedCollection new.  ! !

!RoverLoggerTest methodsFor: 'tests' stamp: 'LM 10/26/2022 21:47:38'!
test04LoggerLoggingPositionsCorrectlyLogsMovingForward
	
	self startLoggingPositionsAndAssertThatLogsAreEqualTo: {'1@2'} asOrderedCollection afterProcessing: 'f'.! !

!RoverLoggerTest methodsFor: 'tests' stamp: 'LM 10/26/2022 21:46:48'!
test05LoggerLoggingPositionsCorrectlyLogsManyMovements
	
	self startLoggingPositionsAndAssertThatLogsAreEqualTo: {'1@2'. '1@3'. '1@2'. '2@2'. '2@3'} asOrderedCollection  afterProcessing: 'ffbrfrb'.! !

!RoverLoggerTest methodsFor: 'tests' stamp: 'LM 10/26/2022 21:41:49'!
test06LoggerLoggingPositionsCorrectlyStoppsLogging
	
	logger startLoggingPositions.
	
	rover process: 'f'.
	
	logger stopLoggingPositions.
	rover process: 'fff'.
	
	logger startLoggingPositions.
	rover process: 'f'. 
	
	self assert: logger logs equals: {'1@2'. '1@6'} asOrderedCollection ! !

!RoverLoggerTest methodsFor: 'tests' stamp: 'LM 10/26/2022 21:48:38'!
test07LoggerLoggingDirectionsCorrectlyLogsTurningRight

	self startLoggingDirectionsAndAssertThatLogsAreEqualTo: {'East'} asOrderedCollection  afterProcessing: 'r'.! !

!RoverLoggerTest methodsFor: 'tests' stamp: 'LM 10/26/2022 21:49:01'!
test08LoggerLoggingDirectionsCorrectlyLogsManyRotations

	self startLoggingDirectionsAndAssertThatLogsAreEqualTo: {'East'. 'North'. 'West'. 'South'. 'East'} asOrderedCollection  afterProcessing: 'rllfll'! !

!RoverLoggerTest methodsFor: 'tests' stamp: 'LM 10/26/2022 21:42:01'!
test09LoggerLoggingDirectionsCorrectlyStopsLogging
	
	logger startLoggingDirections.
	
	rover process: 'rr'.
	logger stopLoggingDirections.
	rover process:'r'.
	logger startLoggingDirections.
	rover process:'l'.	
	self assert: logger logs equals: ({'East'. 'South'. 'South'} asOrderedCollection)! !

!RoverLoggerTest methodsFor: 'tests' stamp: 'LM 10/26/2022 21:42:04'!
test10LoggerCorrectlyLogsBothPositionsAndDirections
	
	logger startLoggingDirections.
	logger startLoggingPositions.
	rover process: 'rffl'.
		
	self assert: logger logs equals: ({'East'. '2@1'. '3@1'. 'North'} asOrderedCollection)! !


!classDefinition: #RoverMonitorTest category: 'MarsRover-WithHeading'!
TestCase subclass: #RoverMonitorTest
	instanceVariableNames: 'rover monitor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!RoverMonitorTest methodsFor: 'setUp' stamp: 'LM 10/26/2022 20:42:59'!
setUp

	rover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	monitor _ RoverMonitor for: rover.
	! !


!RoverMonitorTest methodsFor: 'tests' stamp: 'LM 10/26/2022 21:05:39'!
startMonitoringDirectionAndAssertThatMonitorShows: aString afterProcessing: aSequenceOfCommands

	monitor startMonitoringDirection.
	
	rover process: aSequenceOfCommands.
	
	self assert: aString equals: monitor currentDirection! !

!RoverMonitorTest methodsFor: 'tests' stamp: 'LM 10/26/2022 20:43:48'!
test01PositionDoesNotChangeAfterProcessingEmptyCommandSequence

	|initialPosition finalPosition|
	
	monitor startMonitoringPosition.
	
	initialPosition _ monitor currentPosition.
	rover process: ''.
	finalPosition _ monitor currentPosition.
	
	self assert: initialPosition equals: finalPosition.
	! !

!RoverMonitorTest methodsFor: 'tests' stamp: 'LM 10/26/2022 20:49:55'!
test02PositionInMonitorCorrectlyChangesAfterMoving

	self startMonitoringPositionAndAssertThatMonitorShows: '1@2' afterProcessing: 'f'. 
	! !

!RoverMonitorTest methodsFor: 'tests' stamp: 'LM 10/26/2022 20:51:08'!
test03PositionInMonitorCorrectlyChangesAfterManyMoves

	self startMonitoringPositionAndAssertThatMonitorShows: '3@3' afterProcessing:'ffrff'. ! !

!RoverMonitorTest methodsFor: 'tests' stamp: 'LM 10/26/2022 20:53:22'!
test04MonitorCorrectlyStopsMonitoringPosition
	
	monitor startMonitoringPosition.
	rover process: 'ffrff'.
	monitor stopMonitoringPosition.
	
	self assert: '' equals: monitor currentPosition. 
	! !

!RoverMonitorTest methodsFor: 'tests' stamp: 'LM 10/26/2022 20:52:08'!
test05DirectionDoesNotChangeAfterProcessingEmptyCommandSequence

	|initialDirection finalDirection|
	
	monitor startMonitoringDirection.
	
	initialDirection _ monitor currentDirection.
	rover process: ''.
	finalDirection _ monitor currentDirection.
	
	self assert: initialDirection equals: finalDirection.
	! !

!RoverMonitorTest methodsFor: 'tests' stamp: 'LM 10/26/2022 21:06:36'!
test06DirectionInMonitorCorrrectlyChangesAfterRotating

	self startMonitoringDirectionAndAssertThatMonitorShows: 'Apuntando al Este' afterProcessing: 'r'. 
	! !

!RoverMonitorTest methodsFor: 'tests' stamp: 'LM 10/26/2022 21:07:03'!
test07DirectionInMonitorCorrrectlyChangesAfterManyRotations

	self startMonitoringDirectionAndAssertThatMonitorShows: 'Apuntando al Sur' afterProcessing: 'rllfl'.! !

!RoverMonitorTest methodsFor: 'tests' stamp: 'LM 10/26/2022 20:42:59'!
test08MonitorCorrrectlyStopsMonitoringDirections

	monitor startMonitoringDirection.	
	rover process:'rllfl'.
	monitor stopMonitoringDirection. 
	
	self assert: '' equals: monitor currentDirection.
	! !

!RoverMonitorTest methodsFor: 'tests' stamp: 'LM 10/26/2022 20:54:59'!
test09MonitorCorrrectlyMonitorsBothDirectionAndPositionAtTheSameTime

	monitor startMonitoringDirection.	
	monitor startMonitoringPosition.
	rover process:'llff'. 
	
	self assert: 'Apuntando al Sur' equals: monitor currentDirection.
	self assert: 	'1@ -1' equals: monitor currentPosition.! !


!RoverMonitorTest methodsFor: 'assertions' stamp: 'LM 10/26/2022 20:50:22'!
startMonitoringPositionAndAssertThatMonitorShows: aPositionAsString afterProcessing: aSequenceOfCommands

	monitor startMonitoringPosition.
	
	rover process: aSequenceOfCommands.
	
	
	self assert: aPositionAsString equals: monitor currentPosition! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head positionSubscriptors directionSubscriptors'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'V 10/25/2022 20:23:36'!
addDirectionSubscriptor: aClosure

	directionSubscriptors add: aClosure.
	aClosure value: head.! !

!MarsRover methodsFor: 'initialization' stamp: 'V 10/25/2022 20:23:56'!
addPositionSubscriptor: aClosure

	positionSubscriptors add: aClosure.
	aClosure value: position.! !

!MarsRover methodsFor: 'initialization' stamp: 'V 10/25/2022 20:45:34'!
initializeAt: aPosition heading: aHeadingType

	position := aPosition.
	head := aHeadingType for: self.
	directionSubscriptors := OrderedCollection new.
	positionSubscriptors  := OrderedCollection new.
	
	! !


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

!MarsRover methodsFor: 'heading' stamp: 'V 10/25/2022 19:55:23'!
rotateLeft
	
	head rotateLeft.
	directionSubscriptors do: [:aSubscriptorClosure| aSubscriptorClosure value: head]! !

!MarsRover methodsFor: 'heading' stamp: 'V 10/25/2022 19:55:28'!
rotateRight
	
	head rotateRight.
	directionSubscriptors do: [:aSubscriptorClosure| aSubscriptorClosure value: head]! !


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


!MarsRover methodsFor: 'moving' stamp: 'V 10/25/2022 19:54:07'!
moveBackward
	
	head moveBackward.
	positionSubscriptors do: [:aSubscriptorClosure| aSubscriptorClosure value: position]
	
	! !

!MarsRover methodsFor: 'moving' stamp: 'V 10/25/2022 19:54:55'!
moveEast
	
	position := position + (1@0).
	! !

!MarsRover methodsFor: 'moving' stamp: 'V 10/25/2022 19:53:45'!
moveForward
	
	head moveForward.
	positionSubscriptors do: [:aSubscriptorClosure| aSubscriptorClosure value: position]! !

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


!classDefinition: #RoverSubscriptor category: 'MarsRover-WithHeading'!
Object subclass: #RoverSubscriptor
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!RoverSubscriptor methodsFor: 'initialization' stamp: 'V 10/25/2022 21:05:51'!
initializeFor: aRover

	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RoverSubscriptor class' category: 'MarsRover-WithHeading'!
RoverSubscriptor class
	instanceVariableNames: ''!

!RoverSubscriptor class methodsFor: 'initialization' stamp: 'V 10/25/2022 21:09:13'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #RoverDistanceMeasurer category: 'MarsRover-WithHeading'!
RoverSubscriptor subclass: #RoverDistanceMeasurer
	instanceVariableNames: 'origin currentPosition'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!RoverDistanceMeasurer methodsFor: 'initialization' stamp: 'LM 10/26/2022 21:50:43'!
initializeFor: aMarsRover
	
	" Clase de ejemplo para mostrar la extensibilidad del modelo :D "

	marsRover := aMarsRover.
	aMarsRover addPositionSubscriptor: [:aPosition| self setCurrentPosition: aPosition].
	origin _ currentPosition.
	
	! !


!RoverDistanceMeasurer methodsFor: 'measuring' stamp: 'LM 10/26/2022 21:36:04'!
distanceFromOrigin

	^ origin dist: currentPosition.! !

!RoverDistanceMeasurer methodsFor: 'measuring' stamp: 'LM 10/26/2022 21:35:10'!
setCurrentPosition: aPosition
	
	currentPosition _ aPosition.! !


!classDefinition: #RoverLogger category: 'MarsRover-WithHeading'!
RoverSubscriptor subclass: #RoverLogger
	instanceVariableNames: 'loggingPositions loggingDirections log'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!RoverLogger methodsFor: 'initialization' stamp: 'V 10/25/2022 19:52:32'!
initializeFor: aMarsRover
	
	loggingPositions _ false.
	loggingDirections _ false.
	log := OrderedCollection new.
	marsRover := aMarsRover.
	aMarsRover addPositionSubscriptor: [:aPosition| self logPosition: aPosition].
	aMarsRover addDirectionSubscriptor: [:aHeadingType| self logDirection: aHeadingType].! !


!RoverLogger methodsFor: 'logging' stamp: 'V 10/25/2022 19:59:18'!
logDirection: aHeadingType.

	loggingDirections ifTrue: [log addLast: (self headingName: aHeadingType)]! !

!RoverLogger methodsFor: 'logging' stamp: 'MV 10/24/2022 21:23:21'!
logPosition: aPosition.

	loggingPositions ifTrue: [log addLast: aPosition asString]! !

!RoverLogger methodsFor: 'logging' stamp: 'LM 10/26/2022 20:27:36'!
startLoggingDirections

	loggingDirections _ true.
	! !

!RoverLogger methodsFor: 'logging' stamp: 'LM 10/26/2022 20:27:43'!
startLoggingPositions

	loggingPositions _ true 
	! !

!RoverLogger methodsFor: 'logging' stamp: 'LM 10/26/2022 20:27:47'!
stopLoggingDirections

	loggingDirections _ false.! !

!RoverLogger methodsFor: 'logging' stamp: 'LM 10/26/2022 20:27:49'!
stopLoggingPositions

	loggingPositions _ false.! !


!RoverLogger methodsFor: 'accessing' stamp: 'LM 10/26/2022 20:27:05'!
logs
	
	^log.! !


!RoverLogger methodsFor: 'text generation' stamp: 'V 10/25/2022 19:17:13'!
headingName: aHeadingType

	(aHeadingType class name = MarsRoverHeadingEast name asString) ifTrue: [^'East'].
	(aHeadingType class name = MarsRoverHeadingNorth name asString) ifTrue:[^'North'].
	(aHeadingType class name = MarsRoverHeadingWest name asString) ifTrue: [^'West'].
	(aHeadingType class name = MarsRoverHeadingSouth name asString) ifTrue:[^'South'].! !


!classDefinition: #RoverMonitor category: 'MarsRover-WithHeading'!
RoverSubscriptor subclass: #RoverMonitor
	instanceVariableNames: 'currentPosition monitoringPosition currentDirection monitoringDirection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!RoverMonitor methodsFor: 'initialization' stamp: 'V 10/25/2022 21:08:01'!
initializeFor: aMarsRover 

	monitoringPosition _ false.
	monitoringDirection _ false.
	marsRover := aMarsRover.
	marsRover addPositionSubscriptor: [:aPosition|  self changeCurrentPosition: aPosition].
	marsRover addDirectionSubscriptor: [:aHeadingType|  self changeCurrentDirection: aHeadingType].
	
! !


!RoverMonitor methodsFor: 'accessing' stamp: 'V 10/25/2022 20:51:49'!
currentDirection

	monitoringDirection ifTrue:[ ^self headingName: currentDirection.].
	^''! !

!RoverMonitor methodsFor: 'accessing' stamp: 'V 10/25/2022 20:36:15'!
currentPosition
	
	monitoringPosition ifTrue: [^currentPosition asString].
	^''! !


!RoverMonitor methodsFor: 'monitoring' stamp: 'V 10/25/2022 20:44:18'!
changeCurrentDirection: aMarsRoverHeadingNorth 
	
	currentDirection _ aMarsRoverHeadingNorth.! !

!RoverMonitor methodsFor: 'monitoring' stamp: 'V 10/25/2022 20:35:46'!
changeCurrentPosition: aPosition 
	
	currentPosition _ aPosition.! !

!RoverMonitor methodsFor: 'monitoring' stamp: 'V 10/25/2022 20:54:04'!
startMonitoringDirection
	
	monitoringDirection _ true.! !

!RoverMonitor methodsFor: 'monitoring' stamp: 'V 10/25/2022 20:18:50'!
startMonitoringPosition
	
	monitoringPosition _ true.! !

!RoverMonitor methodsFor: 'monitoring' stamp: 'V 10/25/2022 20:51:05'!
stopMonitoringDirection
	
	monitoringDirection _ false
	! !

!RoverMonitor methodsFor: 'monitoring' stamp: 'LM 10/26/2022 20:28:15'!
stopMonitoringPosition

	monitoringPosition _ false.! !


!RoverMonitor methodsFor: 'text generation' stamp: 'LM 10/26/2022 20:35:45'!
headingName: aHeadingType

	(aHeadingType class name = MarsRoverHeadingEast name asString) ifTrue: [^'Apuntando al Este'].
	(aHeadingType class name = MarsRoverHeadingNorth name asString) ifTrue:[^'Apuntando al Norte'].
	(aHeadingType class name = MarsRoverHeadingWest name asString) ifTrue: [^'Apuntando al Oeste'].
	(aHeadingType class name = MarsRoverHeadingSouth name asString) ifTrue:[^'Apuntando al Sur'].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RoverMonitor class' category: 'MarsRover-WithHeading'!
RoverMonitor class
	instanceVariableNames: 'rover'!
