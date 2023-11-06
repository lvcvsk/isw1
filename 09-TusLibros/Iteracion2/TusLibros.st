!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HAW 11/2/2023 17:12:35'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: self itemSellByTheStore withOcurrences: 0  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HAW 11/2/2023 17:12:46'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add:  self itemNotSellByTheStore withOcurrences: 2  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HAW 11/2/2023 17:12:59'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore withOcurrences: 2.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !

!CartTest methodsFor: 'tests' stamp: 'LK 11/6/2023 00:35:07'!
test09CartCalculatesCorrectPricesForOneItem

	|cart|
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	
	self assert: (cart valueOfCart = 10)! !

!CartTest methodsFor: 'tests' stamp: 'LK 11/6/2023 00:34:50'!
test10CartCalculatesCorrectPricesForManyItems

	|cart|
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore withOcurrences: 2.
	cart add: self itemSellByTheStore withOcurrences: 2.
	
	self assert: (cart valueOfCart = 40)! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'LK 11/3/2023 02:55:29'!
defaultCatalog
	
	|aDictionary|
	
	aDictionary := Dictionary new.
	
	aDictionary add: self itemSellByTheStore ->10.
	
	^aDictionary ! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'testing' stamp: 'LK 11/6/2023 00:43:52'!
test01cannotMakeCashierWithEmptyCart

	|cart|
	
	cart := self createCart.
	
	self 
		should: [Cashier for: cart from: self defaultCreditCard andTodayIs: self today.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
				self assert: anError messageText = Cashier invalidCartErrorMessage.]! !

!CashierTest methodsFor: 'testing' stamp: 'LK 11/6/2023 00:44:35'!
test02cannotUseExpiredCreditCardForCashier

	| cart |
	
	cart := self createCart.
	cart add: self itemSellByTheStore.
	
	self 
		should: [Cashier for: cart from: self expiredCreditCard andTodayIs: self today.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
				self assert: anError messageText = Cashier expiredCCErrorMessage.]
! !

!CashierTest methodsFor: 'testing' stamp: 'LK 11/6/2023 00:49:03'!
test03cannotUsePastDateForCashier

	| cart pastDate|
	
	cart := self createCart.
	cart add: self itemSellByTheStore.
	pastDate := GregorianMonthOfYear yearNumber: 2012 monthNumber: 2.
	
	self 
		should: [Cashier for: cart from: self defaultCreditCard andTodayIs: pastDate.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
				self assert: anError messageText = Cashier notValidTodayDateMessage.]
! !


!CashierTest methodsFor: 'support' stamp: 'LK 11/2/2023 18:43:53'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CashierTest methodsFor: 'support' stamp: 'LK 11/3/2023 02:57:39'!
defaultCatalog
	
	|aDictionary|
	
	aDictionary := Dictionary new.
	
	aDictionary add: 'validBook' ->10.
	
	^aDictionary ! !

!CashierTest methodsFor: 'support' stamp: 'LK 11/3/2023 03:14:23'!
defaultCreditCard

	^(CreditCard withNumber: '1234567890123456' fromOwner: 'Carlos' withExpDate: GregorianMonthOfYear current)! !

!CashierTest methodsFor: 'support' stamp: 'LK 11/3/2023 03:19:27'!
expiredCreditCard

	^(CreditCard withNumber: '1234567890123456' fromOwner: 'Carlos' withExpDate: (GregorianMonthOfYear yearNumber: 2019 monthNumber: 11))! !

!CashierTest methodsFor: 'support' stamp: 'LK 11/3/2023 03:11:10'!
itemSellByTheStore
	
	^ 'validBook'! !

!CashierTest methodsFor: 'support' stamp: 'LK 11/3/2023 03:09:05'!
today

	^GregorianMonthOfYear current! !


!classDefinition: #CreditCardTest category: 'TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'LK 11/6/2023 00:41:21'!
test01cannotUseEmptyNameForCreditCard

	|invalidName idCreditCard expiryDate|
	
	invalidName := ''.
	idCreditCard := '1234567890123456'.
	expiryDate := GregorianMonthOfYear current.
	
	self
		should: [CreditCard withNumber: idCreditCard fromOwner: invalidName withExpDate: expiryDate]
		raise: Error
		withExceptionDo: [:anError | 
				self assert: anError messageText = CreditCard invalidNameErrorDescription]	
	
	
	! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'LK 11/6/2023 00:41:47'!
test02shouldBe16DigitsCreditCardID

	|cardName invalidIdCard expiryDate|
	
	cardName := 'Carlos'.
	invalidIdCard := '3'.
	expiryDate := GregorianMonthOfYear current.
	
	self
		should: [CreditCard withNumber: invalidIdCard fromOwner: cardName withExpDate: expiryDate]
		raise: Error
		withExceptionDo: [:anError | 
				self assert: anError messageText = CreditCard invalidIdCardNumberDescription]	
	
	
	! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'LK 11/6/2023 00:42:05'!
test03shouldUseValidFormatExpiryDate

	|cardName idCreditCard expiryDate|
	
	cardName := 'Carlos'.
	idCreditCard := '1234567890123456'.
	expiryDate := 'AAAAAA'.
	
	self
		should: [CreditCard withNumber: idCreditCard fromOwner: cardName withExpDate: expiryDate]
		raise: Error
		withExceptionDo: [:anError | 
				self assert: (anError messageText = CreditCard invalidExpiryDate)]	
	
	
	! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'LK 11/6/2023 00:42:31'!
test04currentMonthOfYearShouldBeValidDate

	|cardName idCreditCard expiryDate cc|
	
	cardName := 'Carlos'.
	idCreditCard := '1234567890123456'.
	expiryDate := GregorianMonthOfYear current.
	cc := CreditCard withNumber: idCreditCard fromOwner: cardName withExpDate: expiryDate.
	
	self assert: ((cc isExpiredAsToday: GregorianMonthOfYear current) = false)

	
	
	
	! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'LK 11/6/2023 00:43:16'!
test05shouldBeExpiredIfExpiryDateHasPassed

	|cardName idCreditCard expiryDate cc|
	
	cardName := 'Carlos'.
	idCreditCard := '1234567890123456'.
	expiryDate := GregorianMonthOfYear yearNumber: 2018 monthNumber: 12.
	cc := CreditCard withNumber: idCreditCard fromOwner: cardName withExpDate: expiryDate.
	
	self assert: ((cc isExpiredAsToday: GregorianMonthOfYear current) = true)

	
	
	
	! !


!classDefinition: #MPTest category: 'TusLibros'!
TestCase subclass: #MPTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'LK 11/3/2023 02:56:17'!
assertIsValidItem: anItem

	(catalog keys includes: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !

!Cart methodsFor: 'queries' stamp: 'LK 11/3/2023 03:06:39'!
valueOfCart

	^ items sum: [:a | catalog at: a]! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !

!Cart methodsFor: 'testing' stamp: 'LK 11/2/2023 18:52:47'!
items
	
	^items copy! !


!Cart methodsFor: 'adding' stamp: 'HAW 11/2/2023 17:13:30'!
add: anItem

	^ self add: anItem withOcurrences: 1 ! !

!Cart methodsFor: 'adding' stamp: 'HAW 11/2/2023 17:13:19'!
add: anItem withOcurrences: aQuantity

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items add: anItem withOccurrences: aQuantity .
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart creditCard todaysDate priceCatalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'operations' stamp: 'LK 11/3/2023 03:12:11'!
checkout
	
	|totalAmount|
	
	totalAmount := cart valueOfCart.
	
	self debit: totalAmount from: creditCard .
	
	^totalAmount.
	
	! !

!Cashier methodsFor: 'operations' stamp: 'LK 11/2/2023 19:24:45'!
debit: totalAmount from: aCreditCard 
	! !


!Cashier methodsFor: 'initialization' stamp: 'LK 11/3/2023 03:02:00'!
initializeFor: aCart from: aCreditCard andTodayIs: aMonthOfYear

	cart := aCart.
	creditCard := aCreditCard.
	todaysDate := aMonthOfYear.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'LK 11/3/2023 03:04:17'!
expiredCCErrorMessage

	^'This credit card is expired.'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'LK 11/6/2023 00:48:32'!
for: aCart from: aCreditCard andTodayIs: aMonthOfYear

	(aCart isEmpty) ifTrue: [self error: self invalidCartErrorMessage].
	
	(aCreditCard isExpiredAsToday: aMonthOfYear) ifTrue: [self error: self expiredCCErrorMessage].
	
	(aMonthOfYear = GregorianMonthOfYear current) ifFalse: [self error: self notValidTodayDateMessage].

	^self new initializeFor: aCart from: aCreditCard andTodayIs: aMonthOfYear ! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'LK 11/3/2023 03:03:16'!
invalidCartErrorMessage

	^'Cart should have at least one item'.! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'LK 11/6/2023 00:48:51'!
notValidTodayDateMessage

	^'Given date is not correct!!!!'! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expirationDate cardNumber cardOwner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'as yet unclassified' stamp: 'LK 11/2/2023 19:55:07'!
initializeCard: aNumber fromOwner: aNameOfOwner withExpDate: aMonthOfYear

	expirationDate := aMonthOfYear.
	cardNumber := aNumber.
	cardOwner := aNameOfOwner.! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'LK 11/3/2023 02:52:08'!
isExpiredAsToday: aCurrentMonthOfYear

	"se puede mejorar la logica"
	
	((aCurrentMonthOfYear < expirationDate) or: [expirationDate = aCurrentMonthOfYear]) ifFalse: [^true] ifTrue: [^false].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'LK 11/2/2023 21:42:11'!
invalidExpiryDate

	^'Expiry date must be date and month'.! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'LK 11/2/2023 21:37:58'!
invalidIdCardNumberDescription

	^'Card Number must be 16 digits'! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'LK 11/2/2023 21:36:13'!
invalidNameErrorDescription

	^'Owner name cant be empty'! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'LK 11/2/2023 21:38:57'!
validateCardNumber: anIDCard

	(anIDCard size = 16) ifFalse: [self error: self invalidIdCardNumberDescription]! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'LK 11/3/2023 02:39:59'!
validateExpiryDate: aDate

	(aDate isKindOf: GregorianMonthOfYear) ifFalse: [self error: self invalidExpiryDate]. ! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'LK 11/2/2023 21:35:52'!
validateOwnerName: aName

	(aName = '') ifTrue: [self error: self invalidNameErrorDescription]! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'LK 11/2/2023 21:42:38'!
withNumber: anIDCard fromOwner: aNameOfOwner withExpDate: aMonthOfYear


	self validateOwnerName: aNameOfOwner.
	self validateCardNumber: anIDCard.
	self validateExpiryDate: aMonthOfYear.
	
	^self new initializeCard: anIDCard fromOwner: aNameOfOwner withExpDate: aMonthOfYear! !
