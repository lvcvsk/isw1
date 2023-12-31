!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'stackTest finderTest'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'LK 9/18/2023 16:02:29'!
setUp

	stackTest := OOStack new.
	
	stackTest push: 'hola'.
	stackTest push: 'holanda'.
	stackTest push: 'chau'.
	stackTest push: 'Hola'.
	
	finderTest := SentenceFinderByPrefix new.
! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'LK 9/18/2023 16:02:44'!
test01findEncuentraEnElStack

	| matchingPrefix|

	finderTest initializeWith: stackTest andPrefix: 'hola'.
	
	matchingPrefix := finderTest find.
	
	self assert: matchingPrefix size = 2.
	self assert: (matchingPrefix first) = 'holanda'.
	self assert: (matchingPrefix last) = 'hola'
! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'LK 9/18/2023 16:02:56'!
test02findNoEncuentraEnElStack

	| matchingPrefix |

	finderTest := SentenceFinderByPrefix new.
	finderTest initializeWith: stackTest andPrefix: 'wint'.
	
	matchingPrefix := finderTest find.
	
	self assert: matchingPrefix isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'LK 9/18/2023 16:03:05'!
test03findEsCaseSensitive

	| matchingPrefix |	

	finderTest initializeWith: stackTest andPrefix: 'H'.
	
	matchingPrefix := finderTest find.
	self assert: matchingPrefix first = 'Hola'.
	self assert: matchingPrefix size = 1.
	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'LK 9/18/2023 16:03:11'!
test04findNoAceptaPrefijoVacio
	
	self
		should: [ finderTest initializeWith: stackTest andPrefix: ''.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix cannotUseEmptyPrefix ].
	
! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'LK 9/18/2023 16:03:27'!
test05findNoModificaElStack

	| matchingPrefix staticStack|
	
	staticStack := stackTest .
	
	finderTest := SentenceFinderByPrefix new.
	finderTest initializeWith: stackTest andPrefix: 'hola'.
	matchingPrefix := finderTest find.
	
	self assert: staticStack = stackTest .
	

	
	
! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'LK 9/18/2023 16:03:35'!
test06assertErrorNoAceptaEspaciosEnBlanco
	
	self
		should: [ finderTest initializeWith: stackTest andPrefix: ' hola'.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix cannotUseWhiteSpacesInPrefix].
	
! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'LK 9/18/2023 16:03:53'!
test07inicializarConStackVacio

	| emptyStack |
	
	emptyStack := OOStack new.
	
	self
		should: [ finderTest initializeWith: emptyStack andPrefix: 'hola'.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix cannotInitializeWithEmptyStack ].
	
! !


!classDefinition: #ContentStack category: 'Stack-Exercise'!
Object subclass: #ContentStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!ContentStack methodsFor: 'as yet unclassified' stamp: 'LK 9/17/2023 21:11:48'!
isEmpty

	^self subclassResponsibility ! !

!ContentStack methodsFor: 'as yet unclassified' stamp: 'LK 9/17/2023 21:11:51'!
size

	^self subclassResponsibility ! !

!ContentStack methodsFor: 'as yet unclassified' stamp: 'LK 9/17/2023 21:11:37'!
top
	^self subclassResponsibility ! !

!ContentStack methodsFor: 'as yet unclassified' stamp: 'LK 9/17/2023 21:10:09'!
withoutTop
	^self subclassResponsibility ! !


!classDefinition: #ContentNode category: 'Stack-Exercise'!
ContentStack subclass: #ContentNode
	instanceVariableNames: 'nodo previous'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!ContentNode methodsFor: 'as yet unclassified' stamp: 'LK 9/17/2023 21:21:17'!
isEmpty
	^false! !

!ContentNode methodsFor: 'as yet unclassified' stamp: 'LK 9/17/2023 21:15:39'!
size
	^ 1+ previous size.! !

!ContentNode methodsFor: 'as yet unclassified' stamp: 'LK 9/17/2023 21:15:48'!
top
	^nodo! !

!ContentNode methodsFor: 'as yet unclassified' stamp: 'LK 9/18/2023 00:12:42'!
with: anElement onTopOf: aPreviousStack

	nodo := anElement .
	previous := aPreviousStack ! !

!ContentNode methodsFor: 'as yet unclassified' stamp: 'LK 9/18/2023 15:47:15'!
withoutTop
	^previous ! !


!classDefinition: #EmptyNode category: 'Stack-Exercise'!
ContentStack subclass: #EmptyNode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!EmptyNode methodsFor: 'as yet unclassified' stamp: 'LK 9/17/2023 21:23:53'!
isEmpty
	^true! !

!EmptyNode methodsFor: 'as yet unclassified' stamp: 'LK 9/17/2023 21:12:10'!
size
	^0! !

!EmptyNode methodsFor: 'as yet unclassified' stamp: 'LK 9/17/2023 21:14:09'!
top
	^self error: OOStack stackEmptyErrorDescription! !

!EmptyNode methodsFor: 'as yet unclassified' stamp: 'LK 9/18/2023 16:05:17'!
withoutTop

	^self error: OOStack stackEmptyErrorDescription! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'content'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'LK 9/18/2023 15:45:50'!
initialize

	content := EmptyNode new.
	
! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'LK 9/18/2023 15:45:54'!
isEmpty
		
	^content isEmpty
! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'LK 9/18/2023 15:46:02'!
pop

	|last|
	
	last := content top.
	
	content := content withoutTop.
	
	^last
	! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'LK 9/18/2023 15:46:40'!
push: somethingToPush

	content := ContentNode new with: somethingToPush onTopOf: content.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'LK 9/18/2023 15:46:44'!
size
	^content size! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'LK 9/18/2023 15:46:48'!
top

	^content top! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/14/2023 08:12:21'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'originalStack prefixToFind found reversedStack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'LK 9/18/2023 15:38:46'!
filterPrefix: aPrefix

	|hasWhitespace|
	
	(aPrefix = '') ifTrue: [^self error: SentenceFinderByPrefix cannotUseEmptyPrefix].
	
	hasWhitespace := aPrefix includesAnyOf: ' '.
	
	(hasWhitespace) ifTrue:
			 [^self error: SentenceFinderByPrefix cannotUseWhiteSpacesInPrefix].
	! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'LK 9/18/2023 15:29:14'!
find
	
	[(originalStack isEmpty) not] whileTrue: [self getIfTopMatchesPrefix].
	
	self recoverStack.
	
	^found.! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'LK 9/18/2023 15:29:14'!
getIfTopMatchesPrefix

	| currentString | 
	
	currentString := originalStack pop.
	
	(self matchesPrefix: currentString ) ifTrue: [found add: currentString].
	
	reversedStack push: currentString.! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'LK 9/18/2023 14:23:00'!
initializeWith: aStack andPrefix: aPrefix
	
	
	(self filterPrefix: aPrefix).
	
	(aStack isEmpty) ifTrue: [^self error: SentenceFinderByPrefix cannotInitializeWithEmptyStack].
	
	originalStack := aStack.
	
	prefixToFind := aPrefix.
	
	reversedStack := OOStack new.
	
	found := OrderedCollection new.! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'LK 9/18/2023 12:10:41'!
matchesPrefix: aStringToMatch

	| prefixToFindLength sameSize|
	
	prefixToFindLength := prefixToFind size.
	
	(aStringToMatch size < prefixToFindLength) ifTrue: [^false].

	sameSize := aStringToMatch copyFrom: 1 to: (prefixToFind size).
	
	^(sameSize = prefixToFind).
	! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'LK 9/18/2023 15:29:38'!
recoverStack

	[reversedStack isEmpty] whileFalse: 
		[originalStack push: (reversedStack pop)].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'LK 9/18/2023 14:20:55'!
cannotInitializeWithEmptyStack
	^ 'No acepto stacks vacios'! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'LK 9/18/2023 12:17:55'!
cannotUseEmptyPrefix
	^ 'No acepto el prefijo vacio'! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'oa 9/18/2023 12:56:04'!
cannotUseWhiteSpacesInPrefix
	^ 'No acepto prefijos con espacios vacios'! !
