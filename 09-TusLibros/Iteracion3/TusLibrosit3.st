!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #InputInterfaceTest category: 'TusLibros'!
TestCase subclass: #InputInterfaceTest
	instanceVariableNames: 'inputBehavior testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InputInterfaceTest methodsFor: 'testing' stamp: 'LK 11/9/2023 15:39:28'!
test01cannotCreateCardWithInvalidCredentials

	|inputInterface|
	
	inputInterface := InputInterface with: self andMP: self.
	
	inputBehavior := [:aUser :aPassword | self error: InputInterface invalidLoginCredentialsErrorMessage].
	
	self
		should: [inputInterface createCartwithUser: testObjectsFactory invalidUser usingPassword: testObjectsFactory invalidPassword]
		raise: Error 
		withExceptionDo: [:anError |
			self assert: anError messageText = InputInterface invalidLoginCredentialsErrorMessage.]
		
		! !

!InputInterfaceTest methodsFor: 'testing' stamp: 'LK 11/9/2023 15:39:31'!
test02canCreateCartForValidUser

	|inputInterface cartID|
	
	inputInterface := InputInterface with: self andMP: self.
	
	cartID := inputInterface createCartwithUser: testObjectsFactory validUser usingPassword: testObjectsFactory validPassword.
	
	self shouldnt: [inputInterface listCartWithID: cartID] 
		raise: Error! !

!InputInterfaceTest methodsFor: 'testing' stamp: 'LK 11/9/2023 15:39:37'!
test03cannotAddValidItemWithInvalidCartID

	|inputInterface|
	
	inputInterface := InputInterface with: self andMP: self.
	
	self should: [inputInterface addToCart:  testObjectsFactory invalidCartID withAmount: 1 of: 23424.]
		raise: Error
		withExceptionDo: [:anError |
			self assert: anError messageText = InputInterface InvalidCartIDErrorDescription].
	! !

!InputInterfaceTest methodsFor: 'testing' stamp: 'LK 11/9/2023 15:39:39'!
test04canAddValidItemWithValidCartID

	|inputInterface cartID|
	
	inputInterface := InputInterface with: self andMP: self.
	
	cartID := inputInterface createCartwithUser: testObjectsFactory validUser usingPassword: testObjectsFactory validPassword.
	
	self shouldnt: [inputInterface addToCart:  cartID withAmount: 10 of: testObjectsFactory itemSellByTheStore.]
		raise: Error.
	! !

!InputInterfaceTest methodsFor: 'testing' stamp: 'LK 11/9/2023 15:39:42'!
test05canListItemsOfValidCart

	|inputInterface cartID|
	
	inputInterface := InputInterface with: self andMP: self.
	
	cartID := inputInterface createCartwithUser: testObjectsFactory validUser usingPassword: testObjectsFactory validPassword.
	
	inputInterface addToCart: cartID withAmount: 10 of: testObjectsFactory itemSellByTheStore.
	
	self assert: '| ISBN: validBook | Quantity: 10 |' equals: (inputInterface listCartWithID: cartID)! !

!InputInterfaceTest methodsFor: 'testing' stamp: 'LK 11/9/2023 15:39:44'!
test06cannotListItemsOfInalidCart

	|inputInterface |
	
	inputInterface := InputInterface with: self andMP: self.
	
	inputInterface createCartwithUser: testObjectsFactory validUser usingPassword: testObjectsFactory validPassword.
	
	self should: [inputInterface listCartWithID: testObjectsFactory invalidCartID]
		raise: Error
		withExceptionDo: [:anError |
			self assert: anError messageText = InputInterface InvalidCartIDErrorDescription].! !

!InputInterfaceTest methodsFor: 'testing' stamp: 'LK 11/9/2023 15:39:46'!
test07cannotCheckoutCartWithInvalidCartID

	|inputInterface |
	
	inputInterface := InputInterface with: self andMP: self.
	
	inputInterface createCartwithUser: testObjectsFactory validUser usingPassword: testObjectsFactory validPassword.
	
	self should: [inputInterface checkoutFor: testObjectsFactory invalidCartID usingCreditCardFrom: 'Pepe' numbered: '332138791237023' withExpiryDate: GregorianMonthOfYear current]
		raise: Error
		withExceptionDo: [:anError |
			self assert: anError messageText = InputInterface InvalidCartIDErrorDescription].! !

!InputInterfaceTest methodsFor: 'testing' stamp: 'LK 11/9/2023 15:46:02'!
test08canCheckout

	|inputInterface cartID total|
	
	inputInterface := InputInterface with: self andMP: self.
	
	cartID := inputInterface createCartwithUser: testObjectsFactory validUser usingPassword: testObjectsFactory validPassword.
	
	inputInterface addToCart: cartID withAmount: 10 of: testObjectsFactory itemSellByTheStore.
	
	total := inputInterface checkoutFor: cartID usingCreditCardFrom: 'Juan' numbered: '1234567890123456' withExpiryDate: testObjectsFactory nonExpiringMonth .
	
	self assert: total = 10.
	
	! !


!InputInterfaceTest methodsFor: 'setup' stamp: 'LK 11/9/2023 15:41:42'!
debit: anAmount from: aCreditCard ! !

!InputInterfaceTest methodsFor: 'setup' stamp: 'LK 11/6/2023 20:11:45'!
inputFrom: aUser and: aPassword 

	^inputBehavior value: aUser value: aPassword ! !

!InputInterfaceTest methodsFor: 'setup' stamp: 'LK 11/6/2023 20:10:27'!
setUp

	testObjectsFactory := StoreTestObjectsFactory new.
	inputBehavior := [ :anAmount :aCreditCard | ]! !


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


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

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


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:07'!
createSale

	^ Sale of: total
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #InputInterface category: 'TusLibros'!
Object subclass: #InputInterface
	instanceVariableNames: 'authenticator cartsOfUsers catalog mp salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!


!InputInterface methodsFor: 'as yet unclassified' stamp: 'LK 11/9/2023 14:09:41'!
addToCart: aCartId withAmount: aBookQuantity of: bookISBN

	(self validateCardID: aCartId).
	
	(cartsOfUsers at: aCartId) add: aBookQuantity of: bookISBN.
! !

!InputInterface methodsFor: 'as yet unclassified' stamp: 'LK 11/9/2023 15:41:30'!
checkoutFor: aCartId usingCreditCardFrom: anOwner numbered: aCreditCardNumber withExpiryDate: aMonthOfYear

	|cart cashier|
	
	(self validateCardID: aCartId).
	
	cart := cartsOfUsers at: aCartId.
	
	cashier := Cashier 
		toCheckout: cart 
		charging: (CreditCard expiringOn: aMonthOfYear)
		throught: mp
		on: self time
		registeringOn: salesBook.
		
	cashier checkOut.! !

!InputInterface methodsFor: 'as yet unclassified' stamp: 'LK 11/9/2023 13:50:18'!
createCartwithUser: aUser usingPassword: aPassword 
	
	|cartID| 
	authenticator inputFrom: aUser and: aPassword.
	
	cartID := self generateNewCartID.
	cartsOfUsers at: cartID put: (Cart acceptingItemsOf: catalog).
	
	^cartID! !

!InputInterface methodsFor: 'as yet unclassified' stamp: 'LK 11/9/2023 13:48:48'!
generateNewCartID

	^ (100000 atRandom)! !

!InputInterface methodsFor: 'as yet unclassified' stamp: 'LK 11/9/2023 15:36:46'!
initializeFor: anAuthenticator andMP: merchantProcessor 

	authenticator := anAuthenticator.
	
	mp := merchantProcessor.
	
	cartsOfUsers := Dictionary new.
	
	salesBook := Dictionary new.
	
	catalog := Dictionary new
		at: 'validBook' put: 10;
		yourself.
! !

!InputInterface methodsFor: 'as yet unclassified' stamp: 'LK 11/9/2023 14:31:59'!
listCartWithID: cartID

	|list cart|
	
	(self validateCardID: cartID).
	
	list := '|'.
	
	cart := cartsOfUsers at: cartID.
	
	(catalog keys) do: [:aBook | ((cart occurrencesOf: aBook) > 0) ifTrue:[
				list := list, ' ISBN: ', aBook, ' | Quantity: ', (cart occurrencesOf: aBook) asString, ' |']
		].
	^list.
	! !

!InputInterface methodsFor: 'as yet unclassified' stamp: 'LK 11/9/2023 15:03:35'!
time! !

!InputInterface methodsFor: 'as yet unclassified' stamp: 'LK 11/9/2023 13:44:40'!
validateCardID: aCartId

	((cartsOfUsers keys) includes: aCartId) ifFalse: [self error: InputInterface InvalidCartIDErrorDescription].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InputInterface class' category: 'TusLibros'!
InputInterface class
	instanceVariableNames: ''!


!InputInterface class methodsFor: 'as yet unclassified' stamp: 'LK 11/9/2023 13:41:34'!
InvalidCartIDErrorDescription

	^'The Cart ID given is invalid'! !

!InputInterface class methodsFor: 'as yet unclassified' stamp: 'LK 11/9/2023 13:41:14'!
invalidLoginCredentialsErrorMessage

	^'Your login credentials are invalid'! !

!InputInterface class methodsFor: 'as yet unclassified' stamp: 'LK 11/9/2023 15:38:11'!
with: anAuthenticator andMP: aMerchantProcessor 

	^self new initializeFor: anAuthenticator andMP: aMerchantProcessor.! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'LK 11/9/2023 15:45:48'!
nonExpiringMonth
	^(Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'database' stamp: 'LK 11/9/2023 13:31:33'!
invalidCartID

	^'nononononono'! !

!StoreTestObjectsFactory methodsFor: 'database' stamp: 'LK 11/6/2023 20:19:33'!
invalidPassword

	^'sd'! !

!StoreTestObjectsFactory methodsFor: 'database' stamp: 'LK 11/6/2023 20:19:39'!
invalidUser

	^'sdsd'! !

!StoreTestObjectsFactory methodsFor: 'database' stamp: 'LK 11/6/2023 20:19:20'!
validPassword

	^'validPassword'! !

!StoreTestObjectsFactory methodsFor: 'database' stamp: 'LK 11/6/2023 20:18:55'!
validUser

	^'ValidUser'! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
