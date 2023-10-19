!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'OA 10/16/2023 22:38:27'!
test01newPortfolioHasZeroBalance
	|portfolio|
	portfolio := Portfolio new.
	
	self assert: portfolio balance = 0.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'OA 10/19/2023 15:11:56'!
test02portfolioBalanceIsTheSumOfEachAccountBalance
	|portfolio account account2|
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	portfolio add: account.
	portfolio add: account2.
	Deposit register: 200 on: account2.
	Withdraw register: 100 on: account2.
	Deposit register: 100 on: account .
	Withdraw register: 50 on: account.
	self assert: portfolio balance = 150.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'OA 10/19/2023 15:15:47'!
test03portfolioBalanceIsTheSumOfAccountsAndPortfoliosBalances
	|portfolio account account2 portfolio2|
	portfolio := Portfolio new.
	portfolio2 := Portfolio new.
	account := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	portfolio add: account.
	portfolio add: portfolio2.
	portfolio2 add: account2.
	Deposit register: 200 on: account2.
	Withdraw register: 100 on: account2.
	Deposit register: 100 on: account .
	Withdraw register: 50 on: account.
	self assert: portfolio balance = 150.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'OA 10/18/2023 23:38:40'!
test04newPortfolioWithoutRegisteredTransactions
	|portfolio deposit|
	portfolio := Portfolio new.
	deposit := Deposit for: 200.
	self deny: (portfolio hasRegistered: deposit).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'OA 10/19/2023 15:16:03'!
test05portfolioWithAccountsCheckTransaction
	|portfolio deposit account deposit2|
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	portfolio add: account.
	deposit2 := Deposit register: 100 on: account.
	deposit := Deposit for: 200.
	
	self assert: (portfolio hasRegistered: deposit2).
	self deny: (portfolio hasRegistered: deposit).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'OA 10/19/2023 15:16:31'!
test06portfolioWithAccountsAndPortfoliosCheckTransaction
	|portfolio portfolio2 deposit account account2 deposit2|
	portfolio := Portfolio new.
	portfolio2 := Portfolio new.
	account := ReceptiveAccount new.
	account2 :=ReceptiveAccount new.
	portfolio add: account.
	portfolio add: portfolio2.
	portfolio2 add: account2.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
	deposit2 := Deposit register: 50 on: account2.
	deposit := Deposit for: 70.
	
	self assert: (portfolio hasRegistered: deposit2).
	self deny: (portfolio hasRegistered: deposit).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'OA 10/19/2023 00:09:56'!
test07newPortfolioHasNoTransactions
	|portfolio|
	portfolio := Portfolio new.
	
	self assert: portfolio transactions = (OrderedCollection new).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'OA 10/19/2023 15:17:05'!
test08portfolioWithAccountsTransactions
	|portfolio account transactions deposit withdraw|
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	portfolio add: account.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
	transactions := OrderedCollection with: deposit with: withdraw.
	
	self assert: portfolio transactions = (OrderedCollection with: transactions).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'OA 10/19/2023 15:17:21'!
test09portfolioWithAccountsAndPortfoliosTransactions
	|portfolio portfolio2 account account2 transactions deposit withdraw transactions2|
	portfolio := Portfolio new.
	portfolio2 := Portfolio new.
	account := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	portfolio add: account.
	portfolio add: portfolio2.
	portfolio2 add: account2.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
	transactions := OrderedCollection with: deposit with: withdraw.
	deposit := Deposit register: 200 on: account2.
	withdraw := Withdraw register: 75 on: account2.
	transactions2 := OrderedCollection with: deposit with: withdraw.
	
	self assert: portfolio transactions = (OrderedCollection with: transactions
			with: (OrderedCollection with: transactions2)).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'OA 10/19/2023 16:16:30'!
test10cannotAddRepeatedAccount
	|portfolio account|
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	portfolio add: account.
	self
		should: [portfolio add: account]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText =
				 PortfolioTree repeatedAccountErrorDescription ]! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'OA 10/19/2023 16:19:27'!
test11cannotAddAccountAlreadyInChildren
	|portfolio portfolio2 account|
	portfolio := Portfolio new.
	portfolio2 := Portfolio new.
	account := ReceptiveAccount new.
	portfolio add: portfolio2.
	portfolio2 add: account.
	self
		should: [portfolio add: account]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText =
				 PortfolioTree repeatedAccountErrorDescription ]! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'OA 10/19/2023 16:35:12'!
test12cannotAddTheSamePortfolio
	|portfolio  account|
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	portfolio add: account.
	self
		should: [portfolio add: portfolio]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText =
				 PortfolioTree repeatedPortfolioErrorDescription ]! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'OA 10/19/2023 16:35:20'!
test13cannotAddAccountAlreadyInParentsChildren
	|portfolio portfolio2  account|
	portfolio := Portfolio new.
	portfolio2 := Portfolio new.
	account := ReceptiveAccount new.
	portfolio add: portfolio2.
	portfolio add: account.
	self
		should: [portfolio2 add: account]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText =
				 PortfolioTree repeatedAccountErrorDescription ]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'as yet unclassified' stamp: 'OA 10/19/2023 00:22:37'!
computeOn: anAccumulator
	^self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'as yet unclassified' stamp: 'OA 10/19/2023 00:00:09'!
computeOn: anAccumulator
	^anAccumulator +value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'as yet unclassified' stamp: 'OA 10/19/2023 00:00:45'!
computeOn: anAccumulator
	^anAccumulator - value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #PortfolioTree category: 'Portfolio-Ejercicio'!
Object subclass: #PortfolioTree
	instanceVariableNames: 'parentNode'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTree methodsFor: 'as yet unclassified' stamp: 'OA 10/19/2023 16:27:04'!
add: aTreeNode
	^self subclassResponsibility ! !

!PortfolioTree methodsFor: 'as yet unclassified' stamp: 'OA 10/19/2023 16:05:28'!
addParent: aParentNode

	parentNode := aParentNode.! !

!PortfolioTree methodsFor: 'as yet unclassified' stamp: 'OA 10/19/2023 00:37:22'!
balance
	^self subclassResponsibility.! !

!PortfolioTree methodsFor: 'as yet unclassified' stamp: 'OA 10/19/2023 00:37:47'!
hasRegistered: aTransaction
	^self subclassResponsibility.! !

!PortfolioTree methodsFor: 'as yet unclassified' stamp: 'OA 10/19/2023 16:21:46'!
initialize
! !

!PortfolioTree methodsFor: 'as yet unclassified' stamp: 'OA 10/19/2023 00:38:01'!
transactions
	^self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioTree class' category: 'Portfolio-Ejercicio'!
PortfolioTree class
	instanceVariableNames: ''!

!PortfolioTree class methodsFor: 'as yet unclassified' stamp: 'OA 10/19/2023 15:22:56'!
repeatedAccountErrorDescription
	^'The account is already in the portfolio.'! !

!PortfolioTree class methodsFor: 'as yet unclassified' stamp: 'OA 10/19/2023 15:23:04'!
repeatedPortfolioErrorDescription
	^'The portfolio is already in the PortfolioTree.'! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
PortfolioTree subclass: #Portfolio
	instanceVariableNames: 'childrenNodes'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'as yet unclassified' stamp: 'OA 10/19/2023 16:45:01'!
add: aNewChildrenNode

 	|parentCollection|
	"(parentNode includesANode: aNewChildrenNode) ifTrue:
			 [self error: PortfolioTree repeatedAccountErrorDescription ]."
	(aNewChildrenNode =self ) ifTrue:
			 [self error: PortfolioTree repeatedPortfolioErrorDescription].
	(self getAllDescendants includes: aNewChildrenNode ) ifTrue:
			 [self error: PortfolioTree repeatedAccountErrorDescription].
	childrenNodes addLast: aNewChildrenNode.
	
	parentCollection := OrderedCollection new.
	parentCollection addLast: self.
	aNewChildrenNode addParent: parentCollection.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'OA 10/19/2023 15:06:06'!
balance
	|balance|
	
	balance := childrenNodes inject:0 into: [:sum :child | sum + child balance].
	
	^balance.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'OA 10/19/2023 15:55:22'!
getAllDescendants
	|descendants|
	descendants := Set new.
	childrenNodes do: [:child | (child isKindOf: Portfolio) ifTrue: [descendants addAll: child getAllDescendants] ifFalse: [descendants add: child]].
	
	^(descendants asOrderedCollection).! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'OA 10/19/2023 15:08:41'!
hasRegistered: aTransaction
	|found|
	found := childrenNodes anySatisfy: [:child | child hasRegistered: aTransaction].
	^found
! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'OA 10/19/2023 16:08:51'!
includesANode: aNode
	^childrenNodes includes: aNode.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'OA 10/19/2023 16:33:47'!
initialize

	childrenNodes := OrderedCollection new.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'OA 10/19/2023 15:10:31'!
transactions
	|transactions|
	transactions := OrderedCollection new.
	
	childrenNodes do: [:child | transactions addLast: (child transactions)].
	^transactions! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
PortfolioTree subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'OA 10/19/2023 16:33:40'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'OA 10/19/2023 15:48:37'!
getDescendants
	^self.! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'OA 10/19/2023 00:01:07'!
balance
	^transactions inject: 0 into: [:sum :aTransaction | 		
								aTransaction computeOn: sum].! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'OA 10/19/2023 15:30:46'!
isIncludedIn: aNode
	^aNode includes: self.! !
