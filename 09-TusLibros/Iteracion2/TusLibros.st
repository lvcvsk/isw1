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

!CashierTest methodsFor: 'testing' stamp: 'LK 11/6/2023 15:29:58'!
test01cannotMakeCashierWithEmptyCart

	|cart mp|
	
	cart := self createCart.
	mp := MerchantProcessor for: OrderedCollection new.
	
	self 
		should: [Cashier for: cart from: self defaultCreditCard andTodayIs: self today withMP: mp.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
				self assert: anError messageText = Cashier invalidCartErrorMessage.]! !

!CashierTest methodsFor: 'testing' stamp: 'LK 11/6/2023 15:30:13'!
test02cannotUseExpiredCreditCardForCashier

	| cart mp |
	
	cart := self createCart.
	cart add: self itemSellByTheStore.
	mp := MerchantProcessor for: OrderedCollection new.
	self 
		should: [Cashier for: cart from: self expiredCreditCard andTodayIs: self today withMP: mp]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
				self assert: anError messageText = Cashier expiredCCErrorMessage.]
! !

!CashierTest methodsFor: 'testing' stamp: 'LK 11/6/2023 15:30:40'!
test03cannotUsePastDateForCashier

	| cart pastDate mp|
	
	cart := self createCart.
	cart add: self itemSellByTheStore.
	pastDate := GregorianMonthOfYear current previous: (TimeUnits month with: 1).
	mp := MerchantProcessor for: OrderedCollection new.
	
	self 
		should: [Cashier for: cart from: self defaultCreditCard andTodayIs: pastDate withMP: mp.]
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

!CreditCardTest methodsFor: 'testing' stamp: 'LK 11/6/2023 00:41:21'!
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

!CreditCardTest methodsFor: 'testing' stamp: 'LK 11/6/2023 00:41:47'!
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

!CreditCardTest methodsFor: 'testing' stamp: 'LK 11/6/2023 00:42:05'!
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

!CreditCardTest methodsFor: 'testing' stamp: 'LK 11/6/2023 00:42:31'!
test04currentMonthOfYearShouldBeValidDate

	|cardName idCreditCard expiryDate cc|
	
	cardName := 'Carlos'.
	idCreditCard := '1234567890123456'.
	expiryDate := GregorianMonthOfYear current.
	cc := CreditCard withNumber: idCreditCard fromOwner: cardName withExpDate: expiryDate.
	
	self assert: ((cc isExpiredAsToday: GregorianMonthOfYear current) = false)

	
	
	
	! !

!CreditCardTest methodsFor: 'testing' stamp: 'LK 11/6/2023 15:20:40'!
test05shouldBeExpiredIfExpiryDateHasPassed

	|cardName idCreditCard expiryDate cc|
	
	cardName := 'Carlos'.
	idCreditCard := '1234567890123456'.
	expiryDate := GregorianMonthOfYear current previous: (TimeUnits month with: 1).
	cc := CreditCard withNumber: idCreditCard fromOwner: cardName withExpDate: expiryDate.
	
	self assert: ((cc isExpiredAsToday: GregorianMonthOfYear current) = true)

	
	
	
	! !

!CreditCardTest methodsFor: 'testing' stamp: 'LK 11/6/2023 15:18:19'!
test06shouldStoreLimit

	|cardName idCreditCard expiryDate cc|
	
	cardName := 'Carlos'.
	idCreditCard := '1234567890123456'.
	expiryDate := GregorianMonthOfYear current.
	cc := CreditCard withNumber: idCreditCard fromOwner: cardName withExpDate: expiryDate.
	
	cc addLimit: 30.
	
	self assert: (cc limit) = 30

	
	
	
	! !


!classDefinition: #MerchantProcessorTest category: 'TusLibros'!
TestCase subclass: #MerchantProcessorTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorTest methodsFor: 'testing' stamp: 'OA 11/6/2023 16:06:19'!
test01shouldRaiseStolenCardError

	|mp stolenCreditCards creditCard limit|
	
	creditCard := self validCreditCard .
	limit := creditCard limit.
	stolenCreditCards := OrderedCollection new.
	stolenCreditCards add: creditCard.
	
	mp := MerchantProcessor for: stolenCreditCards.
	
	self
		should: [mp debit: 100 from: creditCard]
		raise: Error
		withExceptionDo: [:anError | 
				self assert: anError messageText = mp stolenCardErrorDescription.
				self assert: creditCard limit equals: limit ]	
	
	
	
	
	! !

!MerchantProcessorTest methodsFor: 'testing' stamp: 'OA 11/6/2023 16:15:36'!
test02shouldRaiseInsuficientFundsError

	|mp creditCard limit|
	
	creditCard := self validCreditCard.
	creditCard addLimit: 30.
	limit := creditCard limit.
	
	mp := MerchantProcessor for: OrderedCollection new.
	
	self
		should: [mp debit: 100 from: creditCard]
		raise: Error
		withExceptionDo: [:anError | 
				self assert: anError messageText = mp declinedCreditCardErrorDescription.
				self assert: creditCard limit equals: limit]	
	
	
	
	
	! !

!MerchantProcessorTest methodsFor: 'testing' stamp: 'OA 11/6/2023 16:17:37'!
test03shouldGiveTransactionID

	|mp creditCard limit|
	
	creditCard := self validCreditCard.
	creditCard addLimit: 150.
	limit := creditCard limit.
	
	mp := MerchantProcessor for: OrderedCollection new.
	
	self assert: (mp debit: 100 from: creditCard) = '123'.
	self assert: creditCard limit equals: limit-100
	
	
	
	
	! !

!MerchantProcessorTest methodsFor: 'testing' stamp: 'LK 11/6/2023 15:03:26'!
validCreditCard

	^CreditCard withNumber: '1234567890123567' fromOwner: 'Pepe' withExpDate: GregorianMonthOfYear current! !


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
	instanceVariableNames: 'cart creditCard todaysDate priceCatalog mp transactionId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'operations' stamp: 'LK 11/6/2023 15:15:17'!
checkout
	
	|totalAmount|
	
	totalAmount := cart valueOfCart.
	
	transactionId := mp debit: totalAmount from: creditCard .
	
	^totalAmount.
	
	! !

!Cashier methodsFor: 'operations' stamp: 'LK 11/6/2023 15:15:30'!
getTransactionId

	^transactionId.! !


!Cashier methodsFor: 'initialization' stamp: 'LK 11/6/2023 14:57:09'!
initializeFor: aCart from: aCreditCard andTodayIs: aMonthOfYear withMP: aMerchantProcessor 

	cart := aCart.
	creditCard := aCreditCard.
	todaysDate := aMonthOfYear.
	mp := aMerchantProcessor.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'LK 11/3/2023 03:04:17'!
expiredCCErrorMessage

	^'This credit card is expired.'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'LK 11/6/2023 15:31:18'!
for: aCart from: aCreditCard andTodayIs: aMonthOfYear withMP: aMerchantProcessor

	(aCart isEmpty) ifTrue: [self error: self invalidCartErrorMessage].
	
	(aCreditCard isExpiredAsToday: aMonthOfYear) ifTrue: [self error: self expiredCCErrorMessage].
	
	(aMonthOfYear = GregorianMonthOfYear current) ifFalse: [self error: self notValidTodayDateMessage].

	^self new initializeFor: aCart from: aCreditCard andTodayIs: aMonthOfYear withMP: aMerchantProcessor ! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'LK 11/3/2023 03:03:16'!
invalidCartErrorMessage

	^'Cart should have at least one item'.! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'LK 11/6/2023 00:48:51'!
notValidTodayDateMessage

	^'Given date is not correct!!!!'! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expirationDate cardNumber cardOwner limit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'LK 11/2/2023 19:55:07'!
initializeCard: aNumber fromOwner: aNameOfOwner withExpDate: aMonthOfYear

	expirationDate := aMonthOfYear.
	cardNumber := aNumber.
	cardOwner := aNameOfOwner.! !


!CreditCard methodsFor: 'information' stamp: 'LK 11/6/2023 15:18:43'!
isExpiredAsToday: aCurrentMonthOfYear

	"se puede mejorar la logica, menor o igual"
	
	((aCurrentMonthOfYear < expirationDate) or: [expirationDate = aCurrentMonthOfYear]) ifFalse: [^true] ifTrue: [^false].! !

!CreditCard methodsFor: 'information' stamp: 'LK 11/6/2023 15:07:37'!
limit

	^limit! !


!CreditCard methodsFor: 'operations' stamp: 'LK 11/6/2023 14:58:50'!
addLimit: aLimitAmount

	limit := aLimitAmount ! !

!CreditCard methodsFor: 'operations' stamp: 'OA 11/6/2023 16:10:02'!
updateLimit: anAmount
	limit := limit - anAmount! !

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


!classDefinition: #MerchantProcessor category: 'TusLibros'!
Object subclass: #MerchantProcessor
	instanceVariableNames: 'stolenCards'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessor methodsFor: 'initialization' stamp: 'LK 11/6/2023 14:30:03'!
addStolenCard: aCreditCard

	stolenCards add: aCreditCard! !

!MerchantProcessor methodsFor: 'initialization' stamp: 'LK 11/6/2023 14:29:46'!
initializeFor: aCollectionOfStolenCards

	stolenCards := aCollectionOfStolenCards.! !


!MerchantProcessor methodsFor: 'debit' stamp: 'OA 11/6/2023 16:10:30'!
debit: anAmount from: aCreditCard

	| transactionId |
	
	(stolenCards includes: aCreditCard) ifTrue: [self error: self stolenCardErrorDescription].
	
	(aCreditCard limit < anAmount) ifTrue: [self error: self declinedCreditCardErrorDescription].
	
	aCreditCard updateLimit: anAmount.
	
	transactionId := '123'.
	
	^transactionId! !


!MerchantProcessor methodsFor: 'errors' stamp: 'LK 11/6/2023 15:07:21'!
declinedCreditCardErrorDescription

	^'Your card has been declined.'! !

!MerchantProcessor methodsFor: 'errors' stamp: 'LK 11/6/2023 15:05:01'!
stolenCardErrorDescription

	^'This credit card was stolen!!'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessor class' category: 'TusLibros'!
MerchantProcessor class
	instanceVariableNames: ''!

!MerchantProcessor class methodsFor: 'as yet unclassified' stamp: 'LK 11/6/2023 14:29:24'!
for: aCollectionOfStolenCards

	^self new initializeFor: aCollectionOfStolenCards.! !
