!classDefinition: #MarsRoverExtendedFuncionalityTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverExtendedFuncionalityTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverExtendedFuncionalityTest methodsFor: 'setup' stamp: 'LK 10/30/2023 00:04:07'!
east

	^ MarsRoverHeadingEast! !

!MarsRoverExtendedFuncionalityTest methodsFor: 'setup' stamp: 'LK 10/30/2023 00:03:57'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverExtendedFuncionalityTest methodsFor: 'setup' stamp: 'LK 10/30/2023 00:04:01'!
south

	^ MarsRoverHeadingSouth! !

!MarsRoverExtendedFuncionalityTest methodsFor: 'setup' stamp: 'LK 10/30/2023 00:04:15'!
west

	^ MarsRoverHeadingWest! !


!MarsRoverExtendedFuncionalityTest methodsFor: 'as yet unclassified' stamp: 'LK 10/30/2023 00:15:14'!
test01logsAreEmptyAtStart
	
	|marsRover|
	
	marsRover := MarsRover at: 1@1 heading: self north.
	
	self assert: (marsRover areLoggersEmpty)! !

!MarsRoverExtendedFuncionalityTest methodsFor: 'as yet unclassified' stamp: 'LK 10/30/2023 01:04:53'!
test02logsPositionForSingleLogger
	
	|marsRover expectedLogs|
	
	marsRover := MarsRover at: 1@1 heading: self north.
	expectedLogs := OrderedCollection new.
	expectedLogs add: 1@2.
	
	marsRover addNewPositionLogger.
	marsRover process: 'f'.
	
	self assert: ((marsRover positionLoggerAt: 1) = expectedLogs).! !

!MarsRoverExtendedFuncionalityTest methodsFor: 'as yet unclassified' stamp: 'LK 10/30/2023 01:02:48'!
test03logsMoreThanOnePositionForSingleLogger
	
	|marsRover expectedLogs|
	
	marsRover := MarsRover at: 1@1 heading: self north.
	expectedLogs := OrderedCollection new.
	expectedLogs add: 1@2; add: 1@3.
	
	marsRover addNewPositionLogger.
	marsRover process: 'ff'.
	
	self assert: ((marsRover positionLoggerAt: 1) = expectedLogs).! !

!MarsRoverExtendedFuncionalityTest methodsFor: 'as yet unclassified' stamp: 'LK 10/30/2023 01:02:59'!
test04logsPositionForMultipleLoggers
	
	|marsRover expectedFirstLog expectedSecondLog|
	
	marsRover := MarsRover at: 1@1 heading: self north.
	expectedFirstLog := OrderedCollection new.
	expectedFirstLog add: 1@2; add: 1@3; add: 1@4.
	expectedSecondLog := OrderedCollection new.
	expectedSecondLog add: 1@3; add: 1@4.
	
	marsRover addNewPositionLogger.
	marsRover process: 'f'.
	marsRover addNewPositionLogger.
	marsRover process: 'ff'.
	
	self assert: ((marsRover positionLoggerAt: 1) = expectedFirstLog).
	self assert: ((marsRover positionLoggerAt: 2) = expectedSecondLog).! !

!MarsRoverExtendedFuncionalityTest methodsFor: 'as yet unclassified' stamp: 'LK 10/30/2023 01:03:05'!
test05logsDirectionForSingleLogger

	|marsRover expectedLog|
	
	marsRover := MarsRover at: 1@1 heading: self north.
	expectedLog := OrderedCollection new.
	expectedLog add: 'West'.
	
	marsRover addNewDirectionLogger.
	marsRover process: 'l'.
	
	self assert: ((marsRover directionLoggerAt: 1) = expectedLog).! !

!MarsRoverExtendedFuncionalityTest methodsFor: 'as yet unclassified' stamp: 'LK 10/30/2023 01:05:21'!
test06logsMoreThanOneDirectionForSingleLogger

	|marsRover expectedLog|
	
	marsRover := MarsRover at: 1@1 heading: self north.
	expectedLog := OrderedCollection new.
	expectedLog add: 'West'; add: 'South'.
	
	marsRover addNewDirectionLogger.
	marsRover process: 'll'.
	
	self assert: ((marsRover directionLoggerAt: 1) = expectedLog).! !

!MarsRoverExtendedFuncionalityTest methodsFor: 'as yet unclassified' stamp: 'LK 10/30/2023 01:03:32'!
test07logsDirectionForMultipleLoggers

	|marsRover expectedFirstLog expectedSecondLog|
	
	marsRover := MarsRover at: 1@1 heading: self north.
	expectedFirstLog := OrderedCollection new.
	expectedFirstLog add: 'West'; add: 'North'; add: 'West'.
	expectedSecondLog := OrderedCollection new.
	expectedSecondLog add: 'North'; add: 'West'.
	
	marsRover addNewDirectionLogger.
	marsRover process: 'l'.
	marsRover addNewDirectionLogger.
	marsRover process: 'rl'.
	
	self assert: ((marsRover directionLoggerAt: 1) = expectedFirstLog).
	self assert: ((marsRover directionLoggerAt: 2) = expectedSecondLog).! !

!MarsRoverExtendedFuncionalityTest methodsFor: 'as yet unclassified' stamp: 'LK 10/30/2023 01:04:23'!
test08logsBothDirectionAndPositionForSingleLogger
	
	|marsRover expectedLogs|
	
	marsRover := MarsRover at: 1@1 heading: self north.
	expectedLogs := OrderedCollection new.
	expectedLogs add: 1@2; add: 'East'.
	
	marsRover addNewPositionAndDirectionLogger.
	marsRover process: 'fr'.
	
	self assert: ((marsRover bothLoggerAt: 1) = expectedLogs).! !

!MarsRoverExtendedFuncionalityTest methodsFor: 'as yet unclassified' stamp: 'LK 10/30/2023 01:04:37'!
test09logsBothDirectionAndPositionForMultipleLoggers
	
	|marsRover expectedFirstLog expectedSecondLog|
	
	marsRover := MarsRover at: 1@1 heading: self north.
	expectedFirstLog := OrderedCollection new.
	expectedFirstLog add: 1@2; add: 'East'; add: 'North'; add: 1@3; add: 1@4.
	expectedSecondLog := OrderedCollection new.
	expectedSecondLog add: 'North'; add: 1@3; add: 1@4.
	
	marsRover addNewPositionAndDirectionLogger.
	marsRover process: 'fr'.
	marsRover addNewPositionAndDirectionLogger.
	marsRover process: 'lff'.
	
	self assert: ((marsRover bothLoggerAt: 1) = expectedFirstLog).
	self assert: ((marsRover bothLoggerAt: 2) = expectedSecondLog).! !

!MarsRoverExtendedFuncionalityTest methodsFor: 'as yet unclassified' stamp: 'LK 10/30/2023 01:09:59'!
test10logsDifferentTypeOfLoggersAtOnce
	
	|marsRover expectedPositionLog expectedDirectionLog expectedBothLogs|
	
	marsRover := MarsRover at: 1@1 heading: self north.
	expectedPositionLog := OrderedCollection new.
	expectedPositionLog add: 1@2.
	expectedDirectionLog := OrderedCollection new.
	expectedDirectionLog add: 'East'.
	expectedBothLogs := OrderedCollection new.
	expectedBothLogs add: 1@2; add: 'East'.
	
	marsRover addNewPositionAndDirectionLogger.
	marsRover addNewDirectionLogger.
	marsRover addNewPositionLogger.
	marsRover process: 'fr'.
	
	self assert: ((marsRover bothLoggerAt: 1) = expectedBothLogs ).
	self assert: ((marsRover directionLoggerAt: 1) = expectedDirectionLog).
	self assert: ((marsRover positionLoggerAt: 1) = expectedPositionLog).! !


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


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head positionObserver directionObserver directionLogs positionAndDirectionLogs positionLogs'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'LK 10/30/2023 14:35:56'!
initializeAt: aPosition heading: aHeadingType

	position := MarsRoverObservableVariable for: aPosition.
	head := MarsRoverObservableVariable for: (aHeadingType for: self).
	
	
	positionLogs := OrderedCollection new.
	directionLogs := OrderedCollection new.
	positionAndDirectionLogs := OrderedCollection new.! !


!MarsRover methodsFor: 'heading' stamp: 'LK 10/30/2023 13:35:09'!
headEast
	
	head updateContent: (MarsRoverHeadingEast for: self).
	
	"directionLogs do: [:aLogger | aLogger add: 'East'].
	positionAndDirectionLogs do: [:aLogger | aLogger add: 'East']."! !

!MarsRover methodsFor: 'heading' stamp: 'LK 10/30/2023 13:35:20'!
headNorth
	
	head updateContent: (MarsRoverHeadingNorth for: self).
	
	"directionLogs do: [:aLogger | aLogger add: 'North'].
	positionAndDirectionLogs do: [:aLogger | aLogger add: 'North']."! !

!MarsRover methodsFor: 'heading' stamp: 'LK 10/30/2023 13:35:25'!
headSouth
	
	head updateContent: (MarsRoverHeadingSouth for: self).	
	
	"directionLogs do: [:aLogger | aLogger add: 'South'].
	positionAndDirectionLogs do: [:aLogger | aLogger add: 'South']."! !

!MarsRover methodsFor: 'heading' stamp: 'LK 10/30/2023 13:35:29'!
headWest
	
	head updateContent: (MarsRoverHeadingWest for: self).
	
	"directionLogs do: [:aLogger | aLogger add: 'West'].
	positionAndDirectionLogs do: [:aLogger | aLogger add: 'West']."! !

!MarsRover methodsFor: 'heading' stamp: 'LK 10/30/2023 14:39:15'!
rotateLeft
	
	(head value) rotateLeft! !

!MarsRover methodsFor: 'heading' stamp: 'LK 10/30/2023 14:39:21'!
rotateRight
	
	(head value) rotateRight! !


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


!MarsRover methodsFor: 'moving' stamp: 'LK 10/30/2023 14:37:09'!
moveBackward
	
	(head value) moveBackward! !

!MarsRover methodsFor: 'moving' stamp: 'LK 10/30/2023 13:41:53'!
moveEast
	
	position updateContent: (position value + (1@0)).
	
	"positionLogs do: [:aLogger | aLogger add: position].
	positionAndDirectionLogs do: [:aLogger | aLogger add: position]."! !

!MarsRover methodsFor: 'moving' stamp: 'LK 10/30/2023 14:37:02'!
moveForward
	
	(head value) moveForward! !

!MarsRover methodsFor: 'moving' stamp: 'LK 10/30/2023 13:37:36'!
moveNorth
	
	position updateContent: (position value + (0@1))
	
	"positionLogs do: [:aLogger | aLogger add: position].
	positionAndDirectionLogs do: [:aLogger | aLogger add: position]."! !

!MarsRover methodsFor: 'moving' stamp: 'LK 10/30/2023 13:42:15'!
moveSouth
	
	position updateContent: (position value + (0@-1)).
	
	"positionLogs do: [:aLogger | aLogger add: position].
	positionAndDirectionLogs do: [:aLogger | aLogger add: position]."! !

!MarsRover methodsFor: 'moving' stamp: 'LK 10/30/2023 13:42:35'!
moveWest
	
	position updateContent: (position value + (-1@0)).
	
	"positionLogs do: [:aLogger | aLogger add: position].
	positionAndDirectionLogs do: [:aLogger | aLogger add: position]."! !


!MarsRover methodsFor: 'command processing' stamp: 'HAW 6/30/2018 19:48:26'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'HAW 8/22/2019 12:08:50'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !


!MarsRover methodsFor: 'loggers' stamp: 'LK 10/30/2023 15:11:27'!
addNewDirectionLogger

	directionLogs add: (MarsRoverLogger with: head)! !

!MarsRover methodsFor: 'loggers' stamp: 'LK 10/30/2023 15:11:36'!
addNewPositionAndDirectionLogger

	positionAndDirectionLogs add: (MarsRoverLogger with: head with: position)! !

!MarsRover methodsFor: 'loggers' stamp: 'LK 10/30/2023 15:11:44'!
addNewPositionLogger

	positionLogs add: (MarsRoverLogger with: position).! !

!MarsRover methodsFor: 'loggers' stamp: 'LK 10/30/2023 15:11:51'!
areLoggersEmpty
	
	^ positionLogs isEmpty and: [directionLogs isEmpty and: [positionAndDirectionLogs isEmpty]].! !

!MarsRover methodsFor: 'loggers' stamp: 'LK 10/30/2023 15:12:01'!
bothLoggerAt: aNumber
	
	^(positionAndDirectionLogs at: aNumber) getLog.! !

!MarsRover methodsFor: 'loggers' stamp: 'LK 10/30/2023 15:12:07'!
directionLoggerAt: aNumber
	
	^(directionLogs at: aNumber) getLog.! !

!MarsRover methodsFor: 'loggers' stamp: 'LK 10/30/2023 15:12:14'!
positionLoggerAt: aNumber
	
	^(positionLogs at: aNumber) getLog.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


!classDefinition: #MarsRoverFunctionality category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverFunctionality
	instanceVariableNames: 'proxies'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverFunctionality methodsFor: 'as yet unclassified' stamp: 'LK 10/30/2023 15:01:32'!
initializeFor: aProxy

	proxies := OrderedCollection new.
	proxies add: aProxy.
	proxies do: [:proxt | proxt addSubscriber: self].
	! !

!MarsRoverFunctionality methodsFor: 'as yet unclassified' stamp: 'LK 10/30/2023 15:01:32'!
subscribeTo: aProxy

	proxies add: aProxy.
	aProxy addSubscriber: self.! !


!classDefinition: #MarsRoverLogger category: 'MarsRover-WithHeading'!
MarsRoverFunctionality subclass: #MarsRoverLogger
	instanceVariableNames: 'logs'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLogger methodsFor: 'as yet unclassified' stamp: 'LK 10/30/2023 13:27:11'!
getLog

	^logs copy! !

!MarsRoverLogger methodsFor: 'as yet unclassified' stamp: 'LK 10/30/2023 13:56:27'!
initialize

	logs := OrderedCollection new.! !

!MarsRoverLogger methodsFor: 'as yet unclassified' stamp: 'LK 10/30/2023 15:10:02'!
update: aThing

	logs add: aThing value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverLogger class' category: 'MarsRover-WithHeading'!
MarsRoverLogger class
	instanceVariableNames: ''!

!MarsRoverLogger class methodsFor: 'as yet unclassified' stamp: 'LK 10/30/2023 12:11:25'!
with: aProxy

	^self new initializeFor: aProxy! !

!MarsRoverLogger class methodsFor: 'as yet unclassified' stamp: 'LK 10/30/2023 12:13:12'!
with: aProxy with: aSecondProxy

	|logger|
	
	logger := self new initializeFor: aProxy.
	
	logger subscribeTo: aSecondProxy.
	
	^logger! !


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

!MarsRoverHeading methodsFor: 'heading' stamp: 'LK 10/30/2023 15:08:46'!
value

	self subclassResponsibility! !


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

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'LK 10/30/2023 15:09:00'!
value

	^'East'! !


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

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'LK 10/30/2023 15:09:11'!
value

	^'North'! !


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

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'LK 10/30/2023 15:09:25'!
value

	^'South'! !


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

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'LK 10/30/2023 15:09:35'!
value

	^'West'! !


!classDefinition: #MarsRoverObservableVariable category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverObservableVariable
	instanceVariableNames: 'variable subscribers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverObservableVariable methodsFor: 'as yet unclassified' stamp: 'LK 10/30/2023 11:59:39'!
addSubscriber: aSubscriber

	subscribers add: aSubscriber.! !

!MarsRoverObservableVariable methodsFor: 'as yet unclassified' stamp: 'LK 10/30/2023 11:58:13'!
initializeFor: aCollaborator

	variable := aCollaborator.
	subscribers := OrderedCollection new.! !

!MarsRoverObservableVariable methodsFor: 'as yet unclassified' stamp: 'LK 10/30/2023 15:21:32'!
updateContent: aNewValue
	
	variable := aNewValue.
	subscribers do: [:aSubscriber | aSubscriber update: variable].
	! !

!MarsRoverObservableVariable methodsFor: 'as yet unclassified' stamp: 'LK 10/30/2023 13:37:51'!
value
	^variable! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverObservableVariable class' category: 'MarsRover-WithHeading'!
MarsRoverObservableVariable class
	instanceVariableNames: ''!

!MarsRoverObservableVariable class methodsFor: 'as yet unclassified' stamp: 'LK 10/30/2023 04:07:48'!
for: aCollaborator

	^self new initializeFor: aCollaborator! !
