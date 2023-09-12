!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'LK 9/12/2023 13:37:54'!
assertCantidadEn: aCustomerBook activos: activeNumber suspendidos: suspendedNumber
	
	
	self assert: activeNumber equals: aCustomerBook numberOfActiveCustomers.
	self assert: suspendedNumber equals: aCustomerBook numberOfSuspendedCustomers.
	self assert:(suspendedNumber  + activeNumber) equals: aCustomerBook numberOfCustomers.


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LK 9/12/2023 13:11:51'!
assertQueClosureCorra: aClosureToMeasure enMenosQueMs: aTimeLimitInMs
	
	self assert: (self tomarTiempoA: aClosureToMeasure ) < ( aTimeLimitInMs * millisecond)
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LK 9/12/2023 13:30:47'!
shouldDo: aClosureQueFalla on: anError thenDo: aClosureCatch

	[ aClosureQueFalla value
	self fail ]
		on: anError
		do: aClosureCatch! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LK 9/7/2023 20:15:32'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self assertQueClosureCorra: [customerBook addCustomerNamed: 'John Lennon'.] enMenosQueMs: 50.
	
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LK 9/7/2023 20:15:32'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	  
	
	self assertQueClosureCorra:[customerBook removeCustomerNamed: paulMcCartney.] enMenosQueMs: 100.

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LK 9/12/2023 13:30:48'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.
	
	self shouldDo:[customerBook addCustomerNamed: ''.] on: Error thenDo: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LK 9/12/2023 13:30:48'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self shouldDo: [customerBook removeCustomerNamed: 'Paul McCartney'] on:NotFound thenDo:[ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon)].
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LK 9/12/2023 13:39:13'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self assertCantidadEn: customerBook activos:  0 suspendidos: 1.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LK 9/12/2023 13:38:40'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assertCantidadEn: customerBook activos: 0 suspendidos: 0.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LK 9/12/2023 13:46:40'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self shouldDo: [ customerBook suspendCustomerNamed: 'George Harrison'] on:CantSuspend thenDo: 
	[ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon)].

! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LK 9/12/2023 13:46:44'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	self shouldDo: [ customerBook suspendCustomerNamed: johnLennon] on: CantSuspend thenDo: 
	[ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon)].
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LK 9/12/2023 13:27:41'!
tomarTiempoA: aClosureToMeasure

	| millisecondsBeforeRunning millisecondsAfterRunning|
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aClosureToMeasure value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	^millisecondsAfterRunning-millisecondsBeforeRunning
! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'LK 9/12/2023 13:46:06'!
remove: elem from: aCollectionToRemove ifAbsent: aClosure
 
	1 to: aCollectionToRemove size do: 
	[ :index |
		elem = (aCollectionToRemove at: index)
			ifTrue: [
				aCollectionToRemove removeAt: index.
				^ elem 
			] 
	].

	^ aClosure value.
	
! !

!CustomerBook methodsFor: 'customer management' stamp: 'LK 9/12/2023 13:42:06'!
removeCustomerNamed: aName 

	^self remove: aName from: active ifAbsent: 
		[self remove: aName from: suspended ifAbsent: 
			[^NotFound signal.]]
	
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'LK 9/12/2023 13:26:40'!
suspendCustomerNamed: aName 
	
	self remove: aName from: active ifAbsent: [^CantSuspend signal].
	
	suspended add: aName.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/4/2023 17:02:48'!
customerAlreadyExistsErrorMessage

	^'Customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/4/2023 17:02:52'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty!!!!!!'! !
