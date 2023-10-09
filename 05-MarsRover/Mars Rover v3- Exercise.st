!classDefinition: #MarsRoverTest category: 'Mars Rover- Exercise'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover- Exercise'!

!MarsRoverTest methodsFor: 'testing' stamp: 'LK 10/9/2023 13:52:37'!
assertMarsRover: marsRover shouldBeIn: finalCoordinate pointingTo: direction

	^ self assert: ((marsRover at: finalCoordinate ) and: [marsRover cardinal: direction])! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LK 10/9/2023 13:54:33'!
test01shouldInitializeInGivenCoordinateAndDirection

	| marsRover coordinate direction|
	
	coordinate := 0@0.
	direction := North new.
	marsRover := MarsRover withCoord: coordinate pointingTo: direction.
	
	self assertMarsRover: marsRover shouldBeIn: coordinate pointingTo: direction.
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LK 10/9/2023 13:54:49'!
test02shouldDoNothingOnEmptyString

	|marsRover coordinate direction commands|
	
	coordinate := 0@0.
	direction := North new.
	marsRover  := MarsRover withCoord: coordinate pointingTo: direction.
	commands := ''. 
	
	marsRover execute: commands.
	
	self assertMarsRover: marsRover shouldBeIn: coordinate pointingTo: direction.
	
	
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LK 10/9/2023 13:54:24'!
test03shouldMoveForwardsPointingNorthCorrectly

	|marsRover coordinate direction commands finalCoordinate|
	
	coordinate := 0@0.
	direction := North new.
	finalCoordinate := coordinate + (0@1).
	marsRover  := MarsRover withCoord: coordinate pointingTo: direction.
	commands := 'f'. 
	
	marsRover execute: commands.
	
	self assertMarsRover: marsRover shouldBeIn: finalCoordinate pointingTo: direction.	
	
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LK 10/9/2023 13:55:01'!
test04shouldMoveForwardsPointingSouthCorrectly

	|marsRover coordinate direction commands finalCoordinate|
	
	coordinate := 0@0.
	direction := South new.
	finalCoordinate := coordinate + (0@-1).
	marsRover  := MarsRover withCoord: coordinate pointingTo: direction.
	commands := 'f'. 
	
	marsRover execute: commands.
	
	self assertMarsRover: marsRover shouldBeIn: finalCoordinate pointingTo: direction.	
	
	
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LK 10/9/2023 13:55:05'!
test05shouldMoveForwardsPointingWestCorrectly

	|marsRover coordinate direction commands finalCoordinate|
	
	coordinate := 0@0.
	direction := West new.
	finalCoordinate := coordinate + (-1@0).
	marsRover  := MarsRover withCoord: coordinate pointingTo: direction.
	commands := 'f'. 
	
	marsRover execute: commands.
	
	self assertMarsRover: marsRover shouldBeIn: finalCoordinate pointingTo: direction.	
	
	
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LK 10/9/2023 13:52:37'!
test06shouldMoveForwardsPointingEastCorrectly

	|marsRover coordinate direction commands finalCoordinate|
	
	coordinate := 0@0.
	direction := East new.
	finalCoordinate := coordinate + (1@0).
	marsRover  := MarsRover withCoord: coordinate pointingTo: direction.
	commands := 'f'. 
	marsRover execute: commands.
	
	self assertMarsRover: marsRover shouldBeIn: finalCoordinate pointingTo: direction.	
	
	
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LK 10/9/2023 13:52:37'!
test07shouldMoveBackwardsPointingNorthCorrectly

	|marsRover coordinate direction commands finalCoordinate|
	
	coordinate := 0@0.
	direction := North new.
	finalCoordinate := coordinate - (0@1).
	marsRover  := MarsRover withCoord: coordinate pointingTo: direction.
	commands := 'b'. 
	marsRover execute: commands.
	
	self assertMarsRover: marsRover shouldBeIn: finalCoordinate pointingTo: direction.	
	
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LK 10/9/2023 13:52:37'!
test08shouldMoveBackwardsPointingSouthCorrectly

	|marsRover coordinate direction commands finalCoordinate|
	
	coordinate := 0@0.
	direction := South new.
	finalCoordinate := coordinate - (0@-1).
	marsRover  := MarsRover withCoord: coordinate pointingTo: direction.
	commands := 'b'. 
	marsRover execute: commands.
	
	self assertMarsRover: marsRover shouldBeIn: finalCoordinate pointingTo: direction.	
	
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LK 10/9/2023 13:52:37'!
test09shouldMoveBackwardsPointingEastCorrectly

	|marsRover coordinate direction commands finalCoordinate|
	
	coordinate := 0@0.
	direction := East new.
	finalCoordinate := coordinate - (1@0).
	marsRover  := MarsRover withCoord: coordinate pointingTo: direction.
	commands := 'b'. 
	marsRover execute: commands.
	
	self assertMarsRover: marsRover shouldBeIn: finalCoordinate pointingTo: direction.	
	
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LK 10/9/2023 13:52:37'!
test10shouldMoveBackwardsPointingWestCorrectly

	|marsRover coordinate direction commands finalCoordinate|
	
	coordinate := 0@0.
	direction := West new.
	finalCoordinate := coordinate - (-1@0).
	marsRover  := MarsRover withCoord: coordinate pointingTo: direction.
	commands := 'b'. 
	marsRover execute: commands.
	
	self assertMarsRover: marsRover shouldBeIn: finalCoordinate pointingTo: direction.	
	
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LK 10/9/2023 13:55:42'!
test11shouldRotateRightPointingNorthCorrectly

	|marsRover coordinate direction commands finalDirection |
	
	coordinate := 0@0.
	direction := North new.
	finalDirection := East new.
	marsRover  := MarsRover withCoord: coordinate pointingTo: direction.
	commands := 'r'. 
	
	marsRover execute: commands.
	
	self assertMarsRover: marsRover shouldBeIn: coordinate pointingTo: finalDirection.
	
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LK 10/9/2023 13:55:54'!
test12shouldRotateRightPointingEastCorrectly

	|marsRover coordinate direction commands finalDirection |
	
	coordinate := 0@0.
	direction := East new.
	finalDirection := South new.
	marsRover  := MarsRover withCoord: coordinate pointingTo: direction.
	commands := 'r'. 
	
	marsRover execute: commands.
	
	self assertMarsRover: marsRover shouldBeIn: coordinate pointingTo: finalDirection.
	
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LK 10/9/2023 13:55:59'!
test13shouldRotateRightPointingSouthCorrectly
	|marsRover coordinate direction commands finalDirection |
	
	coordinate := 0@0.
	direction := South new.
	finalDirection := West new.
	marsRover  := MarsRover withCoord: coordinate pointingTo: direction.
	commands := 'r'. 
	
	marsRover execute: commands.
	
	self assertMarsRover: marsRover shouldBeIn: coordinate pointingTo: finalDirection.
	
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LK 10/9/2023 13:56:04'!
test14shouldRotateRightPointingWestCorrectly

	|marsRover coordinate direction commands finalDirection |
	
	coordinate := 0@0.
	direction := West new.
	finalDirection := North new.
	marsRover  := MarsRover withCoord: coordinate pointingTo: direction.
	commands := 'r'. 
	
	marsRover execute: commands.
	
	self assertMarsRover: marsRover shouldBeIn: coordinate pointingTo: finalDirection.
	
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LK 10/9/2023 13:56:11'!
test15shouldRotateLeftPointingNorthCorrectly

	|marsRover coordinate direction commands finalDirection |
	
	coordinate := 0@0.
	direction := North new.
	finalDirection := West new.
	marsRover  := MarsRover withCoord: coordinate pointingTo: direction.
	commands := 'l'. 
	
	marsRover execute: commands.
	
	self assertMarsRover: marsRover shouldBeIn: coordinate pointingTo: finalDirection.
	
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LK 10/9/2023 13:56:15'!
test16shouldRotateLeftPointingSouthCorrectly

	|marsRover coordinate direction commands finalDirection |
	
	coordinate := 0@0.
	direction := South new.
	finalDirection := East new.
	marsRover  := MarsRover withCoord: coordinate pointingTo: direction.
	commands := 'l'. 
	
	marsRover execute: commands.
	
	self assertMarsRover: marsRover shouldBeIn: coordinate pointingTo: finalDirection.
	
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LK 10/9/2023 13:56:20'!
test17shouldRotateLeftPointingEastCorrectly

	|marsRover coordinate direction commands finalDirection |
	
	coordinate := 0@0.
	direction := East new.
	finalDirection := North new.
	marsRover  := MarsRover withCoord: coordinate pointingTo: direction.
	commands := 'l'. 
	
	marsRover execute: commands.
	
	self assertMarsRover: marsRover shouldBeIn: coordinate pointingTo: finalDirection.
	
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LK 10/9/2023 13:56:24'!
test18shouldRotateLeftPointingWestCorrectly

	|marsRover coordinate direction commands finalDirection |
	
	coordinate := 0@0.
	direction := West new.
	finalDirection := South new.
	marsRover  := MarsRover withCoord: coordinate pointingTo: direction.
	commands := 'l'. 
	
	marsRover execute: commands.
	
	self assertMarsRover: marsRover shouldBeIn: coordinate pointingTo: finalDirection.
	
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LK 10/9/2023 13:52:37'!
test19shouldHandleMultipleCommands

	|marsRover coordinate direction commands finalCoordinate |
	
	coordinate := 0@0.
	direction := North new.
	marsRover  := MarsRover withCoord: coordinate pointingTo: direction.
	commands := 'fbf'. 
	finalCoordinate := 0@1.
	
	marsRover execute: commands.
	
	self assertMarsRover: marsRover shouldBeIn: finalCoordinate pointingTo: direction.	
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LK 10/9/2023 15:33:26'!
test20shouldHandleInvalidCommand

	|marsRover coordinate direction commands|
	
	coordinate := 0@0.
	direction := North new.
	marsRover  := MarsRover withCoord: coordinate pointingTo: direction.
	commands := 'ds'. 
	
	self 
		should: [marsRover execute: commands]
		raise: Error
		withExceptionDo: [ :anError | 
			self assert: anError messageText = 'comando invalido'].
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LK 10/9/2023 15:33:39'!
test21shouldHandleCommandsUntilInvalidCommand

	|marsRover coordinate direction commands finalCoordinate |
	
	coordinate := 0@0.
	direction := North new.
	marsRover  := MarsRover withCoord: coordinate pointingTo: direction.
	commands := 'fffpppf'. 
	finalCoordinate := 0@3.
	
	self 
		should: [marsRover execute: commands]
		raise: Error
		withExceptionDo: [ :anError | 
			self assert: anError messageText = 'comando invalido'].
	
	self assertMarsRover: marsRover shouldBeIn: finalCoordinate pointingTo: direction.
	

	! !


!classDefinition: #CommandHandler category: 'Mars Rover- Exercise'!
Object subclass: #CommandHandler
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover- Exercise'!

!CommandHandler methodsFor: 'as yet unclassified' stamp: 'LK 10/9/2023 15:27:41'!
execute: aMarsRover

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CommandHandler class' category: 'Mars Rover- Exercise'!
CommandHandler class
	instanceVariableNames: ''!

!CommandHandler class methodsFor: 'as yet unclassified' stamp: 'LK 10/9/2023 15:14:37'!
canHandle: aChar

	self subclassResponsibility! !

!CommandHandler class methodsFor: 'as yet unclassified' stamp: 'LK 10/9/2023 15:33:12'!
with: aChar

	^(CommandHandler allSubclasses detect: [:aClass | aClass canHandle: aChar] ifNone:[self error: 'comando invalido']) new! !


!classDefinition: #Backward category: 'Mars Rover- Exercise'!
CommandHandler subclass: #Backward
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover- Exercise'!

!Backward methodsFor: 'as yet unclassified' stamp: 'LK 10/9/2023 15:28:08'!
execute: aMarsRover
	aMarsRover commandBackward! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Backward class' category: 'Mars Rover- Exercise'!
Backward class
	instanceVariableNames: ''!

!Backward class methodsFor: 'as yet unclassified' stamp: 'LK 10/9/2023 15:14:49'!
canHandle: aChar
	^aChar = $b.! !


!classDefinition: #Forward category: 'Mars Rover- Exercise'!
CommandHandler subclass: #Forward
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover- Exercise'!

!Forward methodsFor: 'as yet unclassified' stamp: 'LK 10/9/2023 15:28:18'!
execute: aMarsRover
	aMarsRover commandForward
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Forward class' category: 'Mars Rover- Exercise'!
Forward class
	instanceVariableNames: ''!

!Forward class methodsFor: 'as yet unclassified' stamp: 'LK 10/9/2023 15:15:05'!
canHandle: aChar
	^aChar = $f.
! !


!classDefinition: #RotateLeft category: 'Mars Rover- Exercise'!
CommandHandler subclass: #RotateLeft
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover- Exercise'!

!RotateLeft methodsFor: 'as yet unclassified' stamp: 'LK 10/9/2023 15:28:35'!
execute: aMarsRover
	aMarsRover commandRotateLeft! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RotateLeft class' category: 'Mars Rover- Exercise'!
RotateLeft class
	instanceVariableNames: ''!

!RotateLeft class methodsFor: 'as yet unclassified' stamp: 'LK 10/9/2023 15:15:18'!
canHandle: aChar
	^aChar = $l.! !


!classDefinition: #RotateRight category: 'Mars Rover- Exercise'!
CommandHandler subclass: #RotateRight
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover- Exercise'!

!RotateRight methodsFor: 'as yet unclassified' stamp: 'LK 10/9/2023 15:28:51'!
execute: aMarsRover
	aMarsRover commandRotateRight ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RotateRight class' category: 'Mars Rover- Exercise'!
RotateRight class
	instanceVariableNames: ''!

!RotateRight class methodsFor: 'as yet unclassified' stamp: 'LK 10/9/2023 15:15:27'!
canHandle: aChar
	^aChar = $r! !


!classDefinition: #Direction category: 'Mars Rover- Exercise'!
Object subclass: #Direction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover- Exercise'!

!Direction methodsFor: 'as yet unclassified' stamp: 'LK 10/9/2023 12:27:57'!
goBackwards

	self subclassResponsibility! !

!Direction methodsFor: 'as yet unclassified' stamp: 'LK 10/9/2023 12:24:34'!
goForward

	self subclassResponsibility! !

!Direction methodsFor: 'as yet unclassified' stamp: 'LK 10/9/2023 13:23:16'!
rotateLeft

	self subclassResponsibility! !

!Direction methodsFor: 'as yet unclassified' stamp: 'LK 10/9/2023 13:18:19'!
rotateRight

	self subclassResponsibility! !


!classDefinition: #East category: 'Mars Rover- Exercise'!
Direction subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover- Exercise'!

!East methodsFor: 'as yet unclassified' stamp: 'LK 10/9/2023 12:28:15'!
goBackwards
	^(-1@0).
		! !

!East methodsFor: 'as yet unclassified' stamp: 'LK 10/9/2023 12:24:47'!
goForward
	^(1@0).! !

!East methodsFor: 'as yet unclassified' stamp: 'LK 10/9/2023 13:23:25'!
rotateLeft
	^North new.! !

!East methodsFor: 'as yet unclassified' stamp: 'LK 10/9/2023 13:18:56'!
rotateRight
	^South new.! !


!classDefinition: #North category: 'Mars Rover- Exercise'!
Direction subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover- Exercise'!

!North methodsFor: 'as yet unclassified' stamp: 'LK 10/9/2023 12:28:28'!
goBackwards
	^(0@-1)! !

!North methodsFor: 'as yet unclassified' stamp: 'LK 10/9/2023 12:25:38'!
goForward
	^(0@1)! !

!North methodsFor: 'as yet unclassified' stamp: 'LK 10/9/2023 13:23:35'!
rotateLeft
	^West new.! !

!North methodsFor: 'as yet unclassified' stamp: 'LK 10/9/2023 13:18:32'!
rotateRight
	^East new.! !


!classDefinition: #South category: 'Mars Rover- Exercise'!
Direction subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover- Exercise'!

!South methodsFor: 'as yet unclassified' stamp: 'LK 10/9/2023 12:28:39'!
goBackwards

	 ^(0@1)
		! !

!South methodsFor: 'as yet unclassified' stamp: 'LK 10/9/2023 12:32:12'!
goForward
	^(0@-1)! !

!South methodsFor: 'as yet unclassified' stamp: 'LK 10/9/2023 13:23:46'!
rotateLeft
	^East new.! !

!South methodsFor: 'as yet unclassified' stamp: 'LK 10/9/2023 13:19:05'!
rotateRight
	^West new.! !


!classDefinition: #West category: 'Mars Rover- Exercise'!
Direction subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover- Exercise'!

!West methodsFor: 'as yet unclassified' stamp: 'LK 10/9/2023 12:28:50'!
goBackwards
	^(1@0)
	 
		! !

!West methodsFor: 'as yet unclassified' stamp: 'LK 10/9/2023 12:25:52'!
goForward
	^(-1@0).! !

!West methodsFor: 'as yet unclassified' stamp: 'LK 10/9/2023 13:24:00'!
rotateLeft
	^South new.! !

!West methodsFor: 'as yet unclassified' stamp: 'LK 10/9/2023 13:19:15'!
rotateRight
	^North new.! !


!classDefinition: #MarsRover category: 'Mars Rover- Exercise'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover- Exercise'!

!MarsRover methodsFor: 'private' stamp: 'LK 10/9/2023 15:39:56'!
at: aPosition

	^position = aPosition.! !

!MarsRover methodsFor: 'private' stamp: 'LK 10/9/2023 13:14:00'!
cardinal: aDirection

	^direction class = aDirection class.! !


!MarsRover methodsFor: 'init' stamp: 'LK 10/9/2023 12:14:05'!
withCoord: aCoordinate pointingTo: aDirection

	position := aCoordinate.
	direction := aDirection.
	! !


!MarsRover methodsFor: 'commands' stamp: 'LK 10/9/2023 13:58:22'!
commandBackward

	position := position + direction goBackwards! !

!MarsRover methodsFor: 'commands' stamp: 'LK 10/9/2023 13:58:26'!
commandForward

	position := position + direction goForward! !

!MarsRover methodsFor: 'commands' stamp: 'LK 10/9/2023 13:58:28'!
commandRotateLeft

	direction := direction rotateLeft! !

!MarsRover methodsFor: 'commands' stamp: 'LK 10/9/2023 13:58:31'!
commandRotateRight

	direction := direction rotateRight! !

!MarsRover methodsFor: 'commands' stamp: 'LK 10/9/2023 14:00:10'!
execute: commands 

	commands do: [:command | self executeChar: command].

	
! !

!MarsRover methodsFor: 'commands' stamp: 'LK 10/9/2023 15:33:55'!
executeChar: aSingleCommand
	
	|handler|
	
	handler := (CommandHandler with: aSingleCommand).
	
	(handler execute: self).
	
	"
	(aSingleCommand = $f) ifTrue: [	^self commandForward].
	
	(aSingleCommand = $b) ifTrue: [^self commandBackward].
	
	(aSingleCommand = $r) ifTrue: [^	self commandRotateRight].
	
	(aSingleCommand = $l) ifTrue: [^self commandRotateLeft].
	
	self error: MarsRover errorInvalidCommand.
	
"! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'Mars Rover- Exercise'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'LK 10/9/2023 14:10:17'!
errorInvalidCommand
	^'Command is invalid'.! !

!MarsRover class methodsFor: 'instance creation' stamp: 'LK 10/9/2023 11:43:52'!
withCoord: aCoordinate pointingTo: aDirection 
	^self new withCoord: aCoordinate pointingTo: aDirection.! !
