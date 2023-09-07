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

!CustomerBookTest methodsFor: 'testing' stamp: 'LK 9/4/2023 21:58:09'!
assertQueClosureCorra: aClosure enMenosQue: unTiempo

	| millisecondsBeforeRunning millisecondsAfterRunning|
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	[aClosure] value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	^self assert: (millisecondsAfterRunning-millisecondsBeforeRunning	) < ( unTiempo * millisecond)
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LK 9/4/2023 21:54:58'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self assertQueClosureCorra: [customerBook addCustomerNamed: 'John Lennon'.] enMenosQue: 50.
	
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LK 9/4/2023 21:55:47'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	  
	
	self assertQueClosureCorra:[customerBook removeCustomerNamed: paulMcCartney.] enMenosQue: 100.

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'oa 9/7/2023 16:11:59'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.
	self
		verificarQue: [ customerBook addCustomerNamed: '']
		fallaCon: Error
		meFijoQue: [:anError | 
			self assert: anError messageText = CustomerBook     customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'oa 9/7/2023 15:59:42'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	self
		verificarQue: [customerBook removeCustomerNamed: 'Paul McCartney'.]
		fallaCon: NotFound
		meFijoQue: [self verificarQue: customerBook soloTieneAlCliente: johnLennon]
	! !

!CustomerBookTest methodsFor: 'testing' stamp: 'oa 9/7/2023 16:26:00'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	self verificarQue: customerBook cantidadClientesTotales: 1 
		cantidadClientesActivos: 0 cantidadClientesSuspendidos: 1.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'oa 9/7/2023 16:24:32'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self verificarQue: customerBook cantidadClientesTotales: 0 
		cantidadClientesActivos: 0 cantidadClientesSuspendidos: 0.
	
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'oa 9/7/2023 16:14:17'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	self
		verificarQue: [customerBook suspendCustomerNamed: 'George Harrison']
		fallaCon: CantSuspend
		meFijoQue: [self verificarQue: customerBook soloTieneAlCliente: johnLennon]
	! !

!CustomerBookTest methodsFor: 'testing' stamp: 'oa 9/7/2023 16:16:07'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	self
		verificarQue: [ customerBook suspendCustomerNamed: johnLennon]
		fallaCon: CantSuspend
		meFijoQue: [self verificarQue: customerBook soloTieneAlCliente: johnLennon]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'oa 9/7/2023 16:22:07'!
verificarQue: customerBook
cantidadClientesTotales: clientesTotales
cantidadClientesActivos: clientesActivos
cantidadClientesSuspendidos: clientesSuspendidos
	
	self assert: clientesActivos equals: customerBook numberOfActiveCustomers.
	self assert: clientesSuspendidos equals: customerBook numberOfSuspendedCustomers.
	self assert: clientesTotales equals: customerBook numberOfCustomers.

	! !

!CustomerBookTest methodsFor: 'testing' stamp: 'oa 9/7/2023 16:17:37'!
verificarQue: aClosure fallaCon: error  meFijoQue:anotherClosure

	[aClosure value.
		self fail]
	on: error
	do: 
		anotherClosure! !

!CustomerBookTest methodsFor: 'testing' stamp: 'oa 9/7/2023 16:08:06'!
verificarQue: customerBook soloTieneAlCliente: cliente
	self assert: customerBook numberOfCustomers = 1.
	self assert: (customerBook includesCustomerNamed: cliente)! !


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

!CustomerBook methodsFor: 'customer management' stamp: 'oa 9/7/2023 16:06:26'!
removeCustomerNamed: aName 
 	1 to: active size do: 
	[ :index |
		aName = (active at: index)
			ifTrue: [
				active removeAt: index.
				^ aName 
			] 
	].

	1 to: suspended size do: 
	[ :index |
		aName = (suspended at: index)
			ifTrue: [
				suspended removeAt: index.
				^ aName 
			] 
	].
	^NotFound signal.! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

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
