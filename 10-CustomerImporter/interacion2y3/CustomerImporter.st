!classDefinition: #PersistentSet category: 'CustomerImporter'!
Set subclass: #PersistentSet
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!PersistentSet methodsFor: 'initialization' stamp: 'HAW 11/14/2023 08:25:31'!
initializeOn: aSession from: aNonPersistentSet

	session := aSession.
	self addAll: aNonPersistentSet ! !


!PersistentSet methodsFor: 'adding' stamp: 'HAW 11/14/2023 08:23:40'!
add: newObject

	super add: newObject.
	session persist: newObject.
	
	^newObject! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PersistentSet class' category: 'CustomerImporter'!
PersistentSet class
	instanceVariableNames: ''!

!PersistentSet class methodsFor: 'instance creation' stamp: 'HAW 11/14/2023 08:24:32'!
on: aSession

	^self on: aSession from: #()! !

!PersistentSet class methodsFor: 'instance creation' stamp: 'HAW 11/14/2023 08:25:00'!
on: aSession from: aNonPersistentSet

	^self new initializeOn: aSession from: aNonPersistentSet
! !


!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session customerSystem'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests' stamp: 'LK 11/22/2023 18:22:40'!
test01ImportsAllCustomersAndAddressesAsExpected

	CustomerImporter valueFrom: self validImportData into: customerSystem.

	self assertImportedRightNumberOfCustomers.
	self assertPepeSanchezWasImportedCorrecty.
	self assertJuanPerezWasImportedCorrectly ! !

!ImportTest methodsFor: 'tests' stamp: 'LK 11/22/2023 18:22:46'!
test02FailsImportingWhenCustomerRecordHasLessThanFiveFields

	|importer| 
	
	importer := (CustomerImporter from: (ReadStream on: 'C,Pepe,Sanchez, D') into: customerSystem).
	
	self 
		should: [importer value]
		raise: Error
		withExceptionDo: [:anError |
			self assert: anError messageText equals: importer invalidFieldFormatErrorDescription.
			self assert: self numberOfCustomers equals: 0].
	
	! !

!ImportTest methodsFor: 'tests' stamp: 'LK 11/22/2023 18:22:48'!
test03FailsImportingWhenCustomerRecordHasMoreThanFiveFields

	|importer| 
	
	importer := (CustomerImporter from: (ReadStream on: 'C,Pepe,Sanchez, D,3,2') into: customerSystem).
	
	self 
		should: [importer value]
		raise: Error
		withExceptionDo: [:anError |
			self assert: anError messageText equals: importer invalidFieldFormatErrorDescription.
			self assert: self numberOfCustomers equals: 0].
	
	! !

!ImportTest methodsFor: 'tests' stamp: 'LK 11/22/2023 18:22:51'!
test04FailsImportingWhenAddressRecordHasLessThanSixFields

	|importer text| 
	
	text := 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636'.
	
	importer := (CustomerImporter from: (ReadStream on: text ) into: customerSystem).
	

	self 
		should: [importer value]
		raise: Error
		withExceptionDo: [:anError |
			self assert: anError messageText equals: importer invalidFieldFormatErrorDescription.
			self assertSessionHasOneCustomerWithoutAnAddress].! !

!ImportTest methodsFor: 'tests' stamp: 'LK 11/22/2023 18:22:55'!
test05FailsImportingWhenAddressRecordHasMoreThanSixFields

	|importer text| 
	
	text := 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs,CABA'.
	
	importer := (CustomerImporter from: (ReadStream on: text) into: customerSystem).
	
	self 
		should: [importer value]
		raise: Error
		withExceptionDo: [:anError |
			self assert: anError messageText equals: importer invalidFieldFormatErrorDescription.
			self assertSessionHasOneCustomerWithoutAnAddress].! !

!ImportTest methodsFor: 'tests' stamp: 'LK 11/22/2023 18:22:57'!
test06FailsImportingWhenAddressIsGivenWithoutCustomer

	|importer text| 
	
	text := 'A,San Martin,3322,Olivos,1636,BsAs'.
	
	importer := (CustomerImporter from: (ReadStream on: text) into: customerSystem).
	
	self 
		should: [importer value]
		raise: Error
		withExceptionDo: [:anError |
			self assert: anError messageText equals: importer addressWithNoCustomerErrorDescription.
			self assert: self numberOfCustomers equals: 0].! !

!ImportTest methodsFor: 'tests' stamp: 'LK 11/22/2023 20:10:21'!
test07FailsImportingEmptyStream

	|importer | 
	
	importer := (CustomerImporter from: (ReadStream on: '
	') into: customerSystem).
	
	self 
		should: [importer value]
		raise: Error
		withExceptionDo: [:anError |
			self assert: anError messageText equals: importer emptyStreamErrorDescription .
			self assert: self numberOfCustomers equals: 0].! !

!ImportTest methodsFor: 'tests' stamp: 'LK 11/22/2023 18:23:07'!
test08FailsImportingInvalidCustomerThatStartsWithC
	|importer text| 
	
	text := 'CC,Pepe,Sanchez,D,22333444
	A,San Martin,3322,Olivos,1636,BsAs'.
	
	importer := (CustomerImporter from: (ReadStream on: text) into: customerSystem).
	
	self 
		should: [importer value]
		raise: Error
		withExceptionDo: [:anError |
			self assert: anError messageText equals: importer invalidFieldFormatErrorDescription.
			self assert: self numberOfCustomers equals: 0].! !

!ImportTest methodsFor: 'tests' stamp: 'LK 11/22/2023 18:23:11'!
test09FailsImportingInvalidAddressThatStartsWithA
	|importer text| 
	
	text := 'C,Pepe,Sanchez,D,22333444
AA,San Martin,3322,Olivos,1636,BsAs'.
	
	importer := (CustomerImporter from: (ReadStream on: text) into: customerSystem).
	
	self 
		should: [importer value]
		raise: Error
		withExceptionDo: [:anError |
			self assert: anError messageText equals: importer invalidFieldFormatErrorDescription.
			self assertSessionHasOneCustomerWithoutAnAddress].! !


!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:22:05'!
assertAddressOf: importedCustomer at: aStreetName hasNumber: aNumber town: aTown zipCode: aZipCode province: aProvince

	| importedAddress |

	importedAddress := importedCustomer addressAt: aStreetName ifNone: [ self fail ].
	self assert: aStreetName equals: importedAddress streetName.
	self assert: aNumber equals: importedAddress streetNumber.
	self assert: aTown equals: importedAddress town.
	self assert: aZipCode equals: importedAddress zipCode.
	self assert: aProvince equals: importedAddress province.

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:27:57'!
assertCustomerWithIdentificationType: anIdType number: anIdNumber hasFirstName: aFirstName lastName: aLastName

	| importedCustomer |

	importedCustomer := self customerWithIdentificationType: anIdType number: anIdNumber.

	self assert: aFirstName equals: importedCustomer firstName.
	self assert: aLastName equals: importedCustomer lastName.
	self assert: anIdType equals: importedCustomer identificationType.
	self assert: anIdNumber equals: importedCustomer identificationNumber.

	^importedCustomer

	! !

!ImportTest methodsFor: 'assertions' stamp: 'LK 11/22/2023 18:40:43'!
assertImportedRightNumberOfCustomers

	^ self assert: 2 equals: self numberOfCustomers! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:45'!
assertJuanPerezWasImportedCorrectly

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'C' number: '23-25666777-9' hasFirstName: 'Juan' lastName: 'Perez'.
	self assertAddressOf: importedCustomer at: 'Alem' hasNumber: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'
	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:05'!
assertPepeSanchezWasImportedCorrecty

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.
	self assertAddressOf: importedCustomer at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	self assertAddressOf: importedCustomer at: 'Maipu' hasNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'.


	! !

!ImportTest methodsFor: 'assertions' stamp: 'LK 11/22/2023 18:40:53'!
assertSessionHasOneCustomerWithoutAnAddress

	self assert: self numberOfCustomers equals: 1.
	self assert: self numberOfAddressesOfCustomer equals: 0! !


!ImportTest methodsFor: 'setUp/tearDown' stamp: 'LK 11/22/2023 19:53:09'!
setUp

	customerSystem := Enviroment newCustomerSystem.
	customerSystem start.
! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'LK 11/22/2023 18:16:42'!
tearDown

	customerSystem close! !


!ImportTest methodsFor: 'customer' stamp: 'LK 11/22/2023 18:42:58'!
customerWithIdentificationType: anIdType number: anIdNumber

	^ customerSystem customerWithIdentificationType: anIdType number: anIdNumber.! !


!ImportTest methodsFor: 'test data' stamp: 'LK 11/22/2023 18:39:39'!
numberOfAddressesOfCustomer

	^customerSystem numberOfAddressesOfCustomer! !

!ImportTest methodsFor: 'test data' stamp: 'LK 11/22/2023 18:32:31'!
numberOfCustomers

	^customerSystem numberOfCustomers ! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 18:08:08'!
validImportData

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !


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


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 17:55:46'!
isAt: aStreetName

	^streetName = aStreetName ! !

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


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 17:55:17'!
addressAt: aStreetName ifNone: aNoneBlock

	^addresses detect: [ :address | address isAt: aStreetName ] ifNone: aNoneBlock ! !

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


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'customerSystem readStream line newCustomer record'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'LK 11/22/2023 18:21:33'!
initializeFrom: aReadStream into: aSession

	customerSystem := aSession.
	readStream := aReadStream.! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'LK 11/22/2023 17:32:01'!
assertAddressFieldsAreValid

	^ record size ~= 6 ifTrue: [self error: self invalidFieldFormatErrorDescription]! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'LK 11/22/2023 17:32:16'!
assertCustomerFieldsAreValid

	^ record size ~= 5 ifTrue:  [self error: self invalidFieldFormatErrorDescription]! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'LK 11/22/2023 17:29:18'!
assertCustomerWasImportedFirst

	^ (newCustomer isNil) ifTrue: [self error: self addressWithNoCustomerErrorDescription]! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'LK 11/22/2023 20:05:51'!
assertRecordIsNotEmpty

	record isEmpty ifTrue: [self error: self emptyStreamErrorDescription].! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'lk 11/16/2023 19:34:56'!
createRecord

	^record := line findTokens: $,! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'lk 11/16/2023 19:27:09'!
hasLineToImport

	line := readStream nextLine.
	^line notNil! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'LK 11/22/2023 17:31:40'!
importAddress

	| newAddress |
	
	self assertCustomerWasImportedFirst.
	
	self assertAddressFieldsAreValid.
	
	newAddress := Address new.
	newCustomer addAddress: newAddress.
	newAddress streetName: record second.
	newAddress streetNumber: record third asNumber .
	newAddress town: record fourth.
	newAddress zipCode: record fifth asNumber .
	newAddress province: record sixth! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'LK 11/22/2023 18:21:33'!
importCustomer

	self assertCustomerFieldsAreValid.
	
	newCustomer := Customer new.
	newCustomer firstName: record second.
	newCustomer lastName: record third.
	newCustomer identificationType: record fourth.
	newCustomer identificationNumber: record fifth.
	
	customerSystem persist: newCustomer! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'LK 11/22/2023 20:07:03'!
importRecord

	self assertRecordIsNotEmpty.

	(self isCustomerRecord) ifTrue: [^self importCustomer].
	(self isAddressRecord) ifTrue: [^self importAddress].
	
	self error: self invalidFieldFormatErrorDescription.! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'LK 11/18/2023 12:31:08'!
isAddressRecord

	^ record first = 'A'! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'LK 11/22/2023 17:11:28'!
isCustomerRecord

	^ record first = 'C'! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'lk 11/16/2023 19:30:37'!
value
	
	[self hasLineToImport] whileTrue: [
		self createRecord.
		self importRecord.
		]

	! !


!CustomerImporter methodsFor: 'error' stamp: 'LK 11/18/2023 02:36:02'!
addressWithNoCustomerErrorDescription
	^'no'! !

!CustomerImporter methodsFor: 'error' stamp: 'LK 11/22/2023 17:21:05'!
emptyStreamErrorDescription

	^'Cannot parse empty string'! !

!CustomerImporter methodsFor: 'error' stamp: 'LK 11/18/2023 02:35:43'!
invalidFieldFormatErrorDescription

	^'wrong'.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'LK 11/22/2023 18:21:58'!
from: aReadStream into: aCustomerSystem

	^self new initializeFrom: aReadStream into: aCustomerSystem! !


!CustomerImporter class methodsFor: 'importing' stamp: 'LK 11/22/2023 18:22:06'!
valueFrom: aReadStream into: aCustomerSystem

	^(self from: aReadStream into: aCustomerSystem) value! !


!classDefinition: #CustomerSystem category: 'CustomerImporter'!
Object subclass: #CustomerSystem
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerSystem methodsFor: 'as yet unclassified' stamp: 'LK 11/22/2023 19:19:54'!
close

	self subclassResponsibility! !

!CustomerSystem methodsFor: 'as yet unclassified' stamp: 'LK 11/22/2023 19:19:44'!
start

	self subclassResponsibility! !


!classDefinition: #PersistentCustomerSystem category: 'CustomerImporter'!
CustomerSystem subclass: #PersistentCustomerSystem
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!


!PersistentCustomerSystem methodsFor: 'as yet unclassified' stamp: 'LK 11/22/2023 18:16:06'!
close

	session commit.
	session close.! !

!PersistentCustomerSystem methodsFor: 'as yet unclassified' stamp: 'LK 11/22/2023 18:43:39'!
customerWithIdentificationType: anIdType number: anIdNumber

	^ (session
		select: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]
		ofType: Customer) anyOne! !

!PersistentCustomerSystem methodsFor: 'as yet unclassified' stamp: 'LK 11/22/2023 18:12:18'!
initialize

	session := DataBaseSession for: (Array with: Address with: Customer).! !

!PersistentCustomerSystem methodsFor: 'as yet unclassified' stamp: 'LK 11/22/2023 18:33:34'!
numberOfAddressesOfCustomer

	^((session selectAllOfType: Customer) anyOne addresses) size! !

!PersistentCustomerSystem methodsFor: 'as yet unclassified' stamp: 'LK 11/22/2023 19:36:43'!
numberOfCustomers

	^(session selectAllOfType: Customer) size! !

!PersistentCustomerSystem methodsFor: 'as yet unclassified' stamp: 'LK 11/22/2023 18:39:22'!
persist: anObject

	^session persist: anObject! !

!PersistentCustomerSystem methodsFor: 'as yet unclassified' stamp: 'LK 11/22/2023 18:11:48'!
start

	session beginTransaction.! !


!classDefinition: #TransientCustomerSystem category: 'CustomerImporter'!
CustomerSystem subclass: #TransientCustomerSystem
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!TransientCustomerSystem methodsFor: 'as yet unclassified' stamp: 'LK 11/22/2023 19:24:09'!
close! !

!TransientCustomerSystem methodsFor: 'as yet unclassified' stamp: 'LK 11/22/2023 19:38:11'!
customerWithIdentificationType: anIdType number: anIdNumber

	^ (session
		select: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]) anyOne! !

!TransientCustomerSystem methodsFor: 'as yet unclassified' stamp: 'LK 11/22/2023 19:24:19'!
initialize

	session := Set new.! !

!TransientCustomerSystem methodsFor: 'as yet unclassified' stamp: 'LK 11/22/2023 19:33:14'!
numberOfAddressesOfCustomer

	^((session anyOne )addresses) size! !

!TransientCustomerSystem methodsFor: 'as yet unclassified' stamp: 'LK 11/22/2023 19:36:33'!
numberOfCustomers

	^session size! !

!TransientCustomerSystem methodsFor: 'as yet unclassified' stamp: 'LK 11/22/2023 19:35:25'!
persist: anObject

	session add: anObject.! !

!TransientCustomerSystem methodsFor: 'as yet unclassified' stamp: 'LK 11/22/2023 19:24:12'!
start! !


!classDefinition: #DataBaseSession category: 'CustomerImporter'!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id inTransaction closed'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 11/14/2023 08:52:25'!
beginTransaction

	inTransaction := true.! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 11/14/2023 08:52:18'!
commit

	inTransaction := false.! !


!DataBaseSession methodsFor: 'closing' stamp: 'HAW 11/14/2023 08:52:30'!
close

	closed := true.! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:49:30'!
assertCanUseDatabase

	self assertIsOpen.
	self assertInTransaction ! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:48:43'!
assertInTransaction

	inTransaction ifFalse: [ self error: 'Not in transaction' ].! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:48:16'!
assertIsOpen

	closed ifTrue: [ self error: 'Connection with database closed' ].! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 09:09:07'!
assertTypeIsPersisted: aType

	(configuration includes: aType) ifFalse: [ self error: 'Object of type ', aType name, ' are not configured to be persisted' ].! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:58:59'!
isRelationToPersist: possibleRelation

	^ possibleRelation class = Set! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:58:59'!
persistPossibleRelationOf: anObject at: anInstVarOffset

	| possibleRelation |
		
	possibleRelation := anObject instVarAt: anInstVarOffset.
	(self isRelationToPersist: possibleRelation) ifTrue: [ self persistRelationOf: anObject at: anInstVarOffset with: possibleRelation ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:58:03'!
persistRelationOf: anObject at: anInstVarOffset with: aRelation

	| persistentRelation |
	
	persistentRelation := PersistentSet on: self from: aRelation.
	anObject instVarAt: anInstVarOffset put: persistentRelation! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:58:34'!
persistRelationsOf: anObject

	anObject class instVarNamesAndOffsetsDo: [ :anInstVarName :anInstVarOffset | self persistPossibleRelationOf: anObject at: anInstVarOffset]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 09:06:24'!
tableOfType: aType

	^ tables at: aType ifAbsentPut: [ Set new ]! !


!DataBaseSession methodsFor: 'initialization' stamp: 'HAW 11/14/2023 08:44:19'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.
	inTransaction := false.
	closed := false.! !


!DataBaseSession methodsFor: 'id' stamp: 'HAW 5/22/2022 00:19:29'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'HAW 11/14/2023 09:06:24'!
persist: anObject

	| table |

	self assertCanUseDatabase.
	self assertTypeIsPersisted: anObject class.
	self delay.
	
	table := self tableOfType: anObject class.
	self defineIdOf: anObject.
	table add: anObject.
	self persistRelationsOf: anObject.
! !


!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 11/14/2023 09:06:56'!
select: aCondition ofType: aType

	self assertCanUseDatabase.
	self assertTypeIsPersisted: aType.
	self delay.
	
	^(self tableOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 11/14/2023 09:07:12'!
selectAllOfType: aType

	self assertCanUseDatabase.
	self assertTypeIsPersisted: aType.
	self delay.
	
	^(self tableOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 00:19:29'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !


!classDefinition: #Enviroment category: 'CustomerImporter'!
Object subclass: #Enviroment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Enviroment class' category: 'CustomerImporter'!
Enviroment class
	instanceVariableNames: ''!

!Enviroment class methodsFor: 'as yet unclassified' stamp: 'LK 11/22/2023 19:51:11'!
isCurrent

	self subclassResponsibility! !

!Enviroment class methodsFor: 'as yet unclassified' stamp: 'LK 11/22/2023 19:54:09'!
newCustomerSystem
	^(self subclasses detect: [ :env | env isCurrent]) newCustomerSystem.! !


!classDefinition: #DevelopmentEnviroment category: 'CustomerImporter'!
Enviroment subclass: #DevelopmentEnviroment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DevelopmentEnviroment class' category: 'CustomerImporter'!
DevelopmentEnviroment class
	instanceVariableNames: ''!

!DevelopmentEnviroment class methodsFor: 'as yet unclassified' stamp: 'LK 11/22/2023 20:10:36'!
isCurrent

	^true! !

!DevelopmentEnviroment class methodsFor: 'as yet unclassified' stamp: 'LK 11/22/2023 19:52:12'!
newCustomerSystem
	
	^TransientCustomerSystem new.! !


!classDefinition: #IntegrationEnviroment category: 'CustomerImporter'!
Enviroment subclass: #IntegrationEnviroment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IntegrationEnviroment class' category: 'CustomerImporter'!
IntegrationEnviroment class
	instanceVariableNames: ''!

!IntegrationEnviroment class methodsFor: 'as yet unclassified' stamp: 'LK 11/22/2023 19:50:13'!
isCurrent
	^(DevelopmentEnviroment isCurrent) not! !

!IntegrationEnviroment class methodsFor: 'as yet unclassified' stamp: 'LK 11/22/2023 19:52:28'!
newCustomerSystem
	
	^PersistentCustomerSystem new.! !
