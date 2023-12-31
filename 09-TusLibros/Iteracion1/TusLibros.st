!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'OA 11/1/2023 17:49:50'!
test01cartStartsEmpty 
	|cart|
	cart := Cart new.
	
	self assert: cart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'OA 11/1/2023 21:30:48'!
test02cartWithOneBookSizeIsOne
	|cart isbn quantity availableItems|
	cart := Cart new.
	isbn := 1273849.
	quantity := 1.
	availableItems := OrderedCollection with: isbn.
	cart availability: availableItems.
	cart addToCartItem: isbn amount: quantity.
	
	self assert: cart size = 1! !

!CartTest methodsFor: 'tests' stamp: 'OA 11/1/2023 21:31:12'!
test03cartWithTwoIdenticalBooksSizeIsTwo
	|cart isbn quantity availableItems|
	cart := Cart new.
	isbn := 1273849.
	quantity := 2.
	availableItems := OrderedCollection with: isbn.
	cart availability: availableItems.
	cart addToCartItem: isbn amount: quantity.
	
	self assert: cart size = 2! !

!CartTest methodsFor: 'tests' stamp: 'OA 11/1/2023 21:32:03'!
test04cartWithTwoBooksSizeIsSumOfQuantities
	|cart isbn isbn2 quantity quantity2 availableItems|
	cart := Cart new.
	isbn := 1273849.
	quantity := 2.
	isbn2 := 1829333.
	quantity2 := 1.
	availableItems := OrderedCollection with: isbn with: isbn2.
	cart availability: availableItems.
	cart addToCartItem: isbn amount: quantity.
	cart addToCartItem: isbn2 amount: quantity2.
	
	self assert: cart size = 3! !

!CartTest methodsFor: 'tests' stamp: 'OA 11/1/2023 21:32:35'!
test05cartWithTwoIdenticalBooksSizeIsSomeOfQuantities
	|cart isbn quantity quantity2 availableItems|
	cart := Cart new.
	isbn := 1273849.
	quantity := 2.
	quantity2 := 3.
	availableItems := OrderedCollection with: isbn.
	cart availability: availableItems.
	cart addToCartItem: isbn amount: quantity.
	cart addToCartItem: isbn amount: quantity2.
	
	self assert: cart size = 5! !

!CartTest methodsFor: 'tests' stamp: 'OA 11/1/2023 21:33:03'!
test06cartWithTwoBooksKnowsItsContents
	|cart isbn quantity isbn2 quantity2 listOfItems availableItems|
	cart := Cart new.
	isbn := 1273849.
	isbn2 := 1239203.
	quantity := 2.
	quantity2 := 3.
	availableItems := OrderedCollection with: isbn with: isbn2.
	cart availability: availableItems.
	cart addToCartItem: isbn2 amount: quantity2.
	cart addToCartItem: isbn amount: quantity.
	
	listOfItems := OrderedCollection with: isbn2 with: quantity2 with: isbn with: quantity.
	
	self assert: cart listContents = listOfItems! !

!CartTest methodsFor: 'tests' stamp: 'LK 11/2/2023 18:40:37'!
test07itemQuantityShouldBeGreaterThanZero
	|isbn quantity availableItems cart|
	cart := Cart new.
	isbn := 1414893.
	quantity := 0.
	availableItems := OrderedCollection with: isbn.
	cart availability: availableItems.
	self should: [cart addToCartItem: isbn amount: quantity]		raise: Error		withExceptionDo: [:anError | self assert: anError messageText = 		cart nonPositiveAmountOfItemsError].
			
! !

!CartTest methodsFor: 'tests' stamp: 'LK 11/2/2023 18:40:23'!
test08itemShouldBeAvailable

	|isbn quantity availableItems cart|
	cart := Cart new.
	isbn := 5473533.
	quantity := 1.
	availableItems := OrderedCollection with: 1232112 with: 1232134 with: 7675477.
	cart availability: availableItems .
	
	self should: [cart addToCartItem: isbn amount: quantity]
		raise: Error
		withExceptionDo: [:anError | 
				self assert: anError messageText = cart nonAvailableItemError]! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'cart contents itemsAvailable'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'initialization' stamp: 'OA 11/1/2023 17:49:32'!
initialize
	cart := Dictionary new.
	contents := OrderedCollection new! !


!Cart methodsFor: 'operations' stamp: 'OA 11/1/2023 21:19:06'!
addToCartItem: isbn amount: quantity
	self requireAmountGreaterThanZero: quantity.
	self requireItemIsAvailable: isbn.
	
	cart at: isbn put: ((cart at: isbn ifAbsent: [0]) + quantity).
	contents addLast: isbn ; addLast: quantity
! !

!Cart methodsFor: 'operations' stamp: 'OA 11/1/2023 21:11:29'!
availability: availableItems
	itemsAvailable := availableItems ! !

!Cart methodsFor: 'operations' stamp: 'OA 10/30/2023 19:27:36'!
isEmpty
	^cart isEmpty ! !

!Cart methodsFor: 'operations' stamp: 'OA 11/1/2023 20:48:16'!
listContents
	^contents! !

!Cart methodsFor: 'operations' stamp: 'OA 10/30/2023 19:50:15'!
size
	^((cart values) sum: [:a |  a]).
	! !


!Cart methodsFor: 'error handling' stamp: 'LK 11/2/2023 14:08:39'!
nonAvailableItemError

	^ 'Item is not available'! !

!Cart methodsFor: 'error handling' stamp: 'LK 11/2/2023 14:08:21'!
nonPositiveAmountOfItemsError

	^ 'Amount should be greater than zero'! !

!Cart methodsFor: 'error handling' stamp: 'LK 11/2/2023 14:03:33'!
requireAmountGreaterThanZero: anAmount
	(anAmount > 0) ifFalse: [self error: self nonPositiveAmountOfItemsError]! !

!Cart methodsFor: 'error handling' stamp: 'LK 11/2/2023 13:15:53'!
requireItemIsAvailable: isbn
	(itemsAvailable includes: isbn) ifFalse: [self error: self nonAvailableItemError]! !
