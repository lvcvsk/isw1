!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session inputFile'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'as yet unclassified' stamp: 'LK 11/16/2023 00:28:43'!
assertGivenAddress: singleAddress hasName: aStreetName withNumber: aStreetNumber inTown: aTown withZipCode: aZipCode withProvince: aProvince     

	self assert: (singleAddress streetName) equals: aStreetName.
	self assert: singleAddress streetNumber equals: aStreetNumber.
	self assert: singleAddress town equals: aTown.
	self assert: singleAddress zipCode equals: aZipCode.
	self assert: singleAddress province equals: aProvince! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'LK 11/16/2023 00:23:23'!
assertGivenCustomer: customer hasName: aName andLastName: aLastName withIdType: anIDType andIdNumber: IdNumber    

	self assert: customer firstName equals: aName.
	self assert: customer lastName equals: aLastName.
	self assert: customer identificationType equals: anIDType.
	self assert: customer identificationNumber equals: IdNumber! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'LK 11/16/2023 00:46:35'!
getJuanFromSession

	^ session
				select: [:aCustomer | aCustomer identificationType = 'C' 
					and: [aCustomer identificationNumber = '23-25666777-9']] ofType: Customer! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'LK 11/16/2023 00:45:59'!
getPepeFromSession

	^ session
				select: [:aCustomer | aCustomer identificationType = 'D' 
					and: [aCustomer identificationNumber = '22333444']] ofType: Customer! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'LK 11/16/2023 01:08:01'!
importCustomersWithStream
	(ImportCustomer fromSession: session andInputStream: inputFile) importCustomers! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'LK 11/16/2023 00:18:29'!
setUp

	inputFile := (UniFileStream new open: 'input.txt' forWrite: false).
	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'k 11/13/2023 20:33:11'!
tearDown

	session commit.
	session close! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'LK 11/16/2023 01:05:48'!
test01shouldImportCustomers

	|numberOfCustomers singleCustomer customers |

	self importCustomersWithStream.
	numberOfCustomers := (session selectAllOfType: Customer) size.
	self assert: numberOfCustomers equals: 2.
	
	customers := self getPepeFromSession.	
	self assert: customers size equals: 1.
	
	singleCustomer := customers anyOne.
	self assertGivenCustomer: singleCustomer hasName: 'Pepe' andLastName: 'Sanchez' withIdType: 'D' andIdNumber: '22333444'.
	
	customers := self getJuanFromSession.
	self assert: customers size equals: 1.
	
	singleCustomer := customers anyOne.
	self assertGivenCustomer: singleCustomer hasName: 'Juan'andLastName: 'Perez'  withIdType: 'C' andIdNumber: '23-25666777-9'.! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'LK 11/16/2023 01:05:52'!
test02shouldImportAddresses

	|selectedCustomers customerAddresses singleAddress singleCustomer|

	self importCustomersWithStream.
	
	selectedCustomers := self getPepeFromSession.
		
	singleCustomer := selectedCustomers anyOne.
	customerAddresses := singleCustomer addresses.
	
	self assert: customerAddresses size equals: 2.
	
	singleAddress := customerAddresses select: [:anAddress | anAddress streetName = 'Maipu'].
	singleAddress := singleAddress first.
	
	self assertGivenAddress: singleAddress hasName: 'Maipu' withNumber: 888 inTown: 'Florida' withZipCode: 1122 withProvince: 'Buenos Aires'.
	
	singleAddress := customerAddresses select: [:anAddress | anAddress streetName = 'San Martin'].
	singleAddress := singleAddress first.
	
	self assertGivenAddress: singleAddress hasName: 'San Martin' withNumber: 3322 inTown: 'Olivos' withZipCode:  1636 withProvince:  'BsAs'.
	
	selectedCustomers := self getJuanFromSession.
				
	singleCustomer := selectedCustomers anyOne.
	customerAddresses := singleCustomer addresses.
	self assert: customerAddresses size equals: 1.

	singleAddress := customerAddresses select: [:anAddress | anAddress streetName = 'Alem'].
	singleAddress := singleAddress first.
	
	self assertGivenAddress: singleAddress hasName: 'Alem' withNumber: 1122 inTown: 'CABA' withZipCode: 1001 withProvince: 'CABA'.

	
	
	! !


!classDefinition: #Address category: 'CustomerImporter'!
Object subclass: #Address
	instanceVariableNames: 'id streetName streetNumber town zipCode province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province

	^province! !

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province: aProvince

	province := aProvince
	! !


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName: aStreetName

	streetName := aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber

	^streetNumber ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber: aStreetNumber

	streetNumber := aStreetNumber ! !


!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town

	^town! !

!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town: aTown

	town := aTown! !


!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode: aZipCode

	zipCode := aZipCode! !


!Address methodsFor: 'equals' stamp: 'LK 11/16/2023 00:54:28'!
= anAddress

	^(anAddress province = province) & (anAddress streetName = streetName) & (anAddress streetNumber = streetNumber ) & (anAddress town = town) & (anAddress zipCode = zipCode).! !


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addresses

	^ addresses! !


!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName

	^firstName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName: aName

	firstName := aName! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName

	^lastName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName: aLastName

	lastName := aLastName
! !


!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber

	^identificationNumber ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber: anIdentificationNumber

	identificationNumber := anIdentificationNumber! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType

	^identificationType ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType: anIdentificationType

	identificationType := anIdentificationType! !


!Customer methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initialize

	super initialize.
	addresses := OrderedCollection new.! !


!classDefinition: #DataBaseSession category: 'CustomerImporter'!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 00:19:29'!
beginTransaction

	! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 19:17:36'!
commit

	(tables at: Customer ifAbsent: [#()]) do: [ :aCustomer | self persistAddressesOf: aCustomer ]
	! !


!DataBaseSession methodsFor: 'closing' stamp: 'HAW 5/22/2022 00:19:29'!
close

	! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 19:29:06'!
objectsOfType: aType

	^ tables at: aType ifAbsent: [ #() ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
persistAddressesOf: anObjectWithAddresses

	anObjectWithAddresses addresses do: [ :anAddress | self persist: anAddress ]
	! !


!DataBaseSession methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.! !


!DataBaseSession methodsFor: 'id' stamp: 'HAW 5/22/2022 00:19:29'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'HAW 5/22/2022 00:19:29'!
persist: anObject

	| table |

	self delay.
	table := tables at: anObject class ifAbsentPut: [ Set new ].

	self defineIdOf: anObject.
	table add: anObject.

	(anObject isKindOf: Customer) ifTrue: [ self persistAddressesOf: anObject ].! !


!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
select: aCondition ofType: aType

	self delay.
	^(self objectsOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
selectAllOfType: aType

	self delay.
	^(self objectsOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 00:19:29'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !


!classDefinition: #ImportCustomer category: 'CustomerImporter'!
Object subclass: #ImportCustomer
	instanceVariableNames: 'currentSession inputStream'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportCustomer methodsFor: 'initialization' stamp: 'LK 11/16/2023 01:03:14'!
initializeFromSession: aSession andInputStream: anAnInputStream
	currentSession := aSession.
	inputStream := anAnInputStream.! !


!ImportCustomer methodsFor: 'evaluating' stamp: 'LK 11/16/2023 01:08:01'!
importCustomers

	"
	self importCustomers
	"
	
	| newCustomer line |

	line := inputStream nextLine.
	[ line notNil ] whileTrue: [
		(line beginsWith: 'C') ifTrue: [ | customerData |
			customerData := line findTokens: $,.
			newCustomer := Customer new.
			newCustomer firstName: customerData second.
			newCustomer lastName: customerData third.
			newCustomer identificationType: customerData fourth.
			newCustomer identificationNumber: customerData fifth.
			currentSession persist: newCustomer ].

		(line beginsWith: 'A') ifTrue: [ | addressData newAddress |
			addressData := line findTokens: $,.
			newAddress := Address new.
			newCustomer addAddress: newAddress.
			newAddress streetName: addressData second.
			newAddress streetNumber: addressData third asNumber .
			newAddress town: addressData fourth.
			newAddress zipCode: addressData fifth asNumber .
			newAddress province: addressData sixth].

		line := inputStream nextLine. ].

	inputStream close.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ImportCustomer class' category: 'CustomerImporter'!
ImportCustomer class
	instanceVariableNames: ''!

!ImportCustomer class methodsFor: 'instance creation' stamp: 'LK 11/16/2023 01:03:14'!
fromSession: aSession andInputStream: anAnInputStream
	^self new initializeFromSession: aSession andInputStream: anAnInputStream! !
