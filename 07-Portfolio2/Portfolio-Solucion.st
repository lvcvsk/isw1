!classDefinition: #Portfolio2Test category: 'Portfolio-Solucion'!
TestCase subclass: #Portfolio2Test
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio2Test methodsFor: 'tests' stamp: 'LK 10/25/2023 01:27:16'!
test01trasferringModifiesBalanceByCorrectAmount
	
	|withdrawingAcc depositAcc |
	
	withdrawingAcc := ReceptiveAccount new.
	depositAcc := ReceptiveAccount new.
	
	Transfer for: 50 from: withdrawingAcc to: depositAcc.
	
	self assert: depositAcc balance = 50.
	self assert: withdrawingAcc balance = -50.! !

!Portfolio2Test methodsFor: 'tests' stamp: 'LK 10/25/2023 00:42:54'!
test02transferringGetsRegisteredInBothAccounts
	
	|withdrawingAcc depositAcc transfer|
	
	withdrawingAcc := ReceptiveAccount new.
	depositAcc := ReceptiveAccount new.
	
	transfer := Transfer for: 50 from: withdrawingAcc to: depositAcc.
	
	self assert: (depositAcc hasRegistered: transfer depositingLeg).
	self assert: (withdrawingAcc hasRegistered: transfer withdrawLeg).! !

!Portfolio2Test methodsFor: 'tests' stamp: 'LK 10/25/2023 00:43:16'!
test03canNavigateBetweenTransferLegs
	
	|withdrawingAcc depositAcc transfer|
	
	withdrawingAcc := ReceptiveAccount new.
	depositAcc := ReceptiveAccount new.
	
	transfer := Transfer for: 50 from: withdrawingAcc to: depositAcc.
	
	self assert: (depositAcc hasRegistered: transfer depositingLeg).
	self assert: (withdrawingAcc hasRegistered: transfer withdrawLeg).! !

!Portfolio2Test methodsFor: 'tests' stamp: 'LK 10/26/2023 14:56:23'!
test04reportsAccountSummaryOfEmptyAccount

	|account expectedString report| 
	
	account := ReceptiveAccount new.
	report := AccountSummaryReport for: account.
	
	expectedString := OrderedCollection new.
	expectedString add: 'Balance = 0'.
	
	self assert: expectedString = report process.! !

!Portfolio2Test methodsFor: 'tests' stamp: 'LK 10/26/2023 12:43:34'!
test05reportsAccountSummaryWithWithdrawal

	|account  expectedString report| 
	
	account := ReceptiveAccount new.
	Withdraw register: 50 on: account.
	report := AccountSummaryReport for: account.
	
	expectedString := OrderedCollection new.
	expectedString add: 'Extracción por 50.'.
	expectedString add: 'Balance = -50'.
	
	self assert: expectedString = report process.
	
	! !

!Portfolio2Test methodsFor: 'tests' stamp: 'LK 10/26/2023 12:45:37'!
test06reportsAccountSummaryWithDeposit

	|account report expectedString| 
	
	account := ReceptiveAccount new.
	Deposit register: 50 on: account.
	report := AccountSummaryReport for: account.
	
	expectedString := OrderedCollection new.
	expectedString add: 'Depósito por 50.'.
	expectedString add: 'Balance = 50'.
	
	self assert: expectedString = report process.
	
	! !

!Portfolio2Test methodsFor: 'tests' stamp: 'LK 10/26/2023 12:46:23'!
test07reportsAccountSummaryWithDepositTransferLeg

	|depositAccount withdrawAccount expectedString report| 
	
	depositAccount := ReceptiveAccount new.
	withdrawAccount := ReceptiveAccount new.
	Transfer for: 30 from: withdrawAccount to: depositAccount.
	report := AccountSummaryReport for: depositAccount.
	
	expectedString := OrderedCollection new.
	expectedString add: 'Entrada por transferencia por 30.'.
	expectedString add: 'Balance = 30'.
	
	self assert: expectedString = report process.
	
	! !

!Portfolio2Test methodsFor: 'tests' stamp: 'LK 10/26/2023 12:46:52'!
test08reportsAccountSummaryWithWithdrawTransferLeg

	|depositAccount withdrawAccount expectedString report| 
	
	depositAccount := ReceptiveAccount new.
	withdrawAccount := ReceptiveAccount new.
	Transfer for: 30 from: withdrawAccount to: depositAccount.
	report := AccountSummaryReport for: withdrawAccount.
	
	expectedString := OrderedCollection new.
	expectedString add: 'Salida por transferencia por 30.'.
	expectedString add: 'Balance = -30'.
	
	self assert: expectedString = report process.
	
	! !

!Portfolio2Test methodsFor: 'tests' stamp: 'LK 10/26/2023 12:49:16'!
test09reportsPortfolioSummaryWithManyAccounts

	| account portfolio anotherAccount expectedString report|
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	Withdraw register: 100 on: anotherAccount.
	portfolio := Portfolio with: account.
	portfolio add: anotherAccount.
	report := AccountSummaryReport for: portfolio.
		
	expectedString := OrderedCollection new.
	expectedString addLast: 'Depósito por 100.'.
	expectedString addLast: 'Extracción por 100.'.
	expectedString addLast: 'Balance = 0'.
	
	self assert: expectedString = report process.
	
	! !

!Portfolio2Test methodsFor: 'tests' stamp: 'LK 10/26/2023 12:49:57'!
test10reportsTransferNetForWithdrawLegs
	
	|withdrawAccount depositAccount expectedValue report|
	
	withdrawAccount := ReceptiveAccount new.
	depositAccount := ReceptiveAccount new.
	Transfer for: 10 from: withdrawAccount to: depositAccount.
	report := TransferNetReport for: withdrawAccount.
	
	expectedValue := -10.
	
	self assert: report process = expectedValue.! !

!Portfolio2Test methodsFor: 'tests' stamp: 'LK 10/26/2023 12:50:24'!
test11reportsTransferNetForDepositLegs
	
	|withdrawAccount depositAccount expectedValue report|
	
	withdrawAccount := ReceptiveAccount new.
	depositAccount := ReceptiveAccount new.
	Transfer for: 10 from: withdrawAccount to: depositAccount.
	report := TransferNetReport for: depositAccount.
	
	expectedValue := 10.
	
	self assert: report process = expectedValue.! !

!Portfolio2Test methodsFor: 'tests' stamp: 'LK 10/26/2023 12:53:55'!
test12reportsTransferNetForMultipleTransfers
	
	|withdrawAccount depositAccount expectedValue report|
	
	withdrawAccount := ReceptiveAccount new.
	depositAccount := ReceptiveAccount new.
	Transfer for: 10 from: withdrawAccount to: depositAccount.
	Transfer for: 50 from: depositAccount to: withdrawAccount.
	report := TransferNetReport for: depositAccount.
		
	expectedValue := -40.
	
	self assert: report process = expectedValue.! !

!Portfolio2Test methodsFor: 'tests' stamp: 'LK 10/26/2023 12:54:30'!
test13reportsTransferNetForPortfoliosWithMultipleAccounts
	
	|withdrawAccount depositAccount expectedValue portfolio report|
	
	withdrawAccount := ReceptiveAccount new.
	depositAccount := ReceptiveAccount new.
	portfolio := Portfolio with: withdrawAccount.
	portfolio add: depositAccount.
	Transfer for: 10 from: withdrawAccount to: depositAccount.
	report := TransferNetReport for: portfolio.
	
	expectedValue := 0.
	
	self assert: report process = expectedValue.! !

!Portfolio2Test methodsFor: 'tests' stamp: 'LK 10/26/2023 14:20:55'!
test14reportsTransferNetForEmptyAccount
	
	|account expectedValue report|
	
	account := ReceptiveAccount new.
	report := TransferNetReport for: account.
	
	expectedValue := 0.
	
	self assert: report process = expectedValue.! !

!Portfolio2Test methodsFor: 'tests' stamp: 'LK 10/26/2023 14:20:20'!
test15reportsPortfolioTreeWithEmptyPortfolio

	|portfolio report expectedString|
	
	portfolio := Portfolio named: 'Portfolio de Hijos'.
	report := PortfolioTreeReport for: portfolio.
	
	expectedString := OrderedCollection new.
	expectedString add: 'Portfolio de Hijos'.
	
	self assert: report process = expectedString
	
	! !

!Portfolio2Test methodsFor: 'tests' stamp: 'LK 10/26/2023 15:00:27'!
test16reportPortfolioTreeWithOneChild

	|account portfolio report expectedString|
	
	account := ReceptiveAccount named: 'Cuenta de Juan'.
	portfolio := Portfolio named: 'Portfolio de Hijos' with: account.
	report := PortfolioTreeReport for: portfolio.
	
	expectedString := OrderedCollection new.
	expectedString add: 'Portfolio de Hijos'.
	expectedString add: String tab, 'Cuenta de Juan'.
	
	self assert: report process = expectedString
	
	! !

!Portfolio2Test methodsFor: 'tests' stamp: 'LK 10/26/2023 15:04:30'!
test17reportPortfolioTreeWithBigHierarchy

	|johnsAccount angiesAccount childrenPortfolio myAccount familyPortfolio report expectedString|
	
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'.
	angiesAccount := ReceptiveAccount named: 'Cuenta de Angeles'.
	childrenPortfolio := Portfolio named: 'Portfolio de hijos' with: johnsAccount with: angiesAccount.
	myAccount := ReceptiveAccount named: 'Cuenta Mia'.
	familyPortfolio := Portfolio named: 'Portfolio de la familia' with: myAccount with: childrenPortfolio.
	report := PortfolioTreeReport for: familyPortfolio.
	
	expectedString := OrderedCollection new.
	expectedString add: 'Portfolio de la familia'.
	expectedString add: String tab, 'Cuenta Mia'.
	expectedString add: String tab, 'Portfolio de hijos'.
	expectedString add: String tab, String tab, 'Cuenta de Juan'.
	expectedString add: String tab, String tab, 'Cuenta de Angeles'.
	
	self assert: report process = expectedString
	! !


!classDefinition: #PortfolioTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #Account category: 'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'processing' stamp: 'LK 10/26/2023 13:25:23'!
processForReport: aVisitor
	
	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'name' stamp: 'LK 10/26/2023 13:54:46'!
name
	^name! !

!Account methodsFor: 'name' stamp: 'LK 10/26/2023 14:16:54'!
named: anAccountName

	name := anAccountName.! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Account class' category: 'Portfolio-Solucion'!
Account class
	instanceVariableNames: ''!

!Account class methodsFor: 'as yet unclassified' stamp: 'LK 10/26/2023 14:18:36'!
named: anAccountName

	^self new named: anAccountName.! !


!classDefinition: #Portfolio category: 'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'processing' stamp: 'LK 10/26/2023 14:14:30'!
processForReport: aVisitor
	
	aVisitor processPortfolio: self.
	accounts do: [:anAccount | anAccount processForReport: aVisitor].! !


!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'LK 10/26/2023 14:26:30'!
named: anAccountName with: anAccount

	|portfolio|
	
	portfolio := self named: anAccountName.
	
	portfolio add: anAccount.
	
	^portfolio.! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'LK 10/26/2023 14:26:50'!
named: anAccountName with: anAccount with: aSecondAccount

	|portfolio|
	
	portfolio := self named: anAccountName.
	
	portfolio add: anAccount.
	
	portfolio add: aSecondAccount.
	
	^portfolio.! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'processing' stamp: 'LK 10/26/2023 14:57:57'!
processForReport: aVisitor

	aVisitor processReceptiveAccount: self.
	transactions do: [:aTransaction | aTransaction processForReport: aVisitor]! !


!classDefinition: #AccountTransaction category: 'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'LK 10/25/2023 00:33:47'!
valueForTransferNet

	self subclassResponsibility! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'processing' stamp: 'LK 10/26/2023 13:11:08'!
processForReport: aVisitor

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

!Deposit methodsFor: 'value' stamp: 'LK 10/25/2023 00:33:52'!
valueForTransferNet
	^0.! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'processing' stamp: 'LK 10/26/2023 13:11:43'!
processForReport: aVisitor
	aVisitor processForDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferLegs category: 'Portfolio-Solucion'!
AccountTransaction subclass: #TransferLegs
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferLegs methodsFor: 'processing' stamp: 'LK 10/26/2023 13:11:56'!
processForReport: aVisitor

	self subclassResponsibility! !


!TransferLegs methodsFor: 'balance' stamp: 'LK 10/25/2023 00:32:39'!
affectBalance: aBalance

	self subclassResponsibility! !


!TransferLegs methodsFor: 'initialization' stamp: 'LK 10/25/2023 00:29:06'!
initializeFor: aTransfer

	self subclassResponsibility! !


!TransferLegs methodsFor: 'value' stamp: 'LK 10/25/2023 00:29:24'!
value
	 ^(transfer value).! !

!TransferLegs methodsFor: 'value' stamp: 'LK 10/25/2023 00:34:07'!
valueForTransferNet

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLegs class' category: 'Portfolio-Solucion'!
TransferLegs class
	instanceVariableNames: ''!

!TransferLegs class methodsFor: 'as yet unclassified' stamp: 'LK 10/25/2023 00:28:28'!
for: aTransfer
	^self new initializeFor: aTransfer.! !


!classDefinition: #DepositLeg category: 'Portfolio-Solucion'!
TransferLegs subclass: #DepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!DepositLeg methodsFor: 'processing' stamp: 'LK 10/26/2023 13:12:09'!
processForReport: aVisitor

	aVisitor processForDepositLeg: self.! !


!DepositLeg methodsFor: 'initialization' stamp: 'LK 10/25/2023 00:29:06'!
initializeFor: aTransfer

	transfer := aTransfer.! !


!DepositLeg methodsFor: 'balance' stamp: 'LK 10/25/2023 00:32:54'!
affectBalance: aBalance

	^aBalance + transfer value.! !


!DepositLeg methodsFor: 'value' stamp: 'LK 10/25/2023 00:34:19'!
valueForTransferNet
	^transfer value.! !


!classDefinition: #WithdrawLeg category: 'Portfolio-Solucion'!
TransferLegs subclass: #WithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!WithdrawLeg methodsFor: 'processing' stamp: 'LK 10/26/2023 13:12:36'!
processForReport: aVisitor

	aVisitor processForWithdrawLeg: self.! !


!WithdrawLeg methodsFor: 'initialization' stamp: 'LK 10/25/2023 00:29:06'!
initializeFor: aTransfer

	transfer := aTransfer.! !


!WithdrawLeg methodsFor: 'balance' stamp: 'LK 10/25/2023 00:33:03'!
affectBalance: aBalance

	^aBalance - transfer value.! !


!WithdrawLeg methodsFor: 'value' stamp: 'LK 10/25/2023 00:34:38'!
valueForTransferNet
	^(transfer value) negated.! !


!classDefinition: #Withdraw category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

!Withdraw methodsFor: 'value' stamp: 'LK 10/25/2023 00:33:57'!
valueForTransferNet
	^0.! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'processing' stamp: 'LK 10/26/2023 13:12:52'!
processForReport: aVisitor
	
	aVisitor processForWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #NodeVisitor category: 'Portfolio-Solucion'!
Object subclass: #NodeVisitor
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!NodeVisitor methodsFor: 'processing' stamp: 'LK 10/26/2023 14:12:29'!
endProcess

	self subclassResponsibility! !

!NodeVisitor methodsFor: 'processing' stamp: 'LK 10/26/2023 13:22:05'!
process

	account processForReport: self.
	^self endProcess.! !

!NodeVisitor methodsFor: 'processing' stamp: 'LK 10/26/2023 13:52:43'!
processForDeposit: aTransaction

	self subclassResponsibility! !

!NodeVisitor methodsFor: 'processing' stamp: 'LK 10/26/2023 13:52:51'!
processForDepositLeg: aTransaction

	self subclassResponsibility! !

!NodeVisitor methodsFor: 'processing' stamp: 'LK 10/26/2023 13:52:56'!
processForWithdraw: aTransaction

	self subclassResponsibility! !

!NodeVisitor methodsFor: 'processing' stamp: 'LK 10/26/2023 13:53:01'!
processForWithdrawLeg: aTransaction

	self subclassResponsibility! !

!NodeVisitor methodsFor: 'processing' stamp: 'LK 10/26/2023 13:51:45'!
processPortfolio: anAccount

	self subclassResponsibility! !

!NodeVisitor methodsFor: 'processing' stamp: 'LK 10/26/2023 13:51:33'!
processReceptiveAccount: anAccount

	self subclassResponsibility! !


!NodeVisitor methodsFor: 'initialization' stamp: 'LK 10/26/2023 12:08:01'!
initializeFor: anAccount
	
	account := anAccount.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NodeVisitor class' category: 'Portfolio-Solucion'!
NodeVisitor class
	instanceVariableNames: ''!

!NodeVisitor class methodsFor: 'as yet unclassified' stamp: 'LK 10/26/2023 14:19:18'!
for: anAccount
	
	^self new initializeFor: anAccount.! !


!classDefinition: #AccountSummaryReport category: 'Portfolio-Solucion'!
NodeVisitor subclass: #AccountSummaryReport
	instanceVariableNames: 'summary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummaryReport methodsFor: 'processing' stamp: 'LK 10/26/2023 13:49:41'!
endProcess

	summary addLast: ('Balance = ', account balance asString).
	^summary.! !

!AccountSummaryReport methodsFor: 'processing' stamp: 'LK 10/26/2023 13:49:41'!
processForDeposit: aTransaction

	summary addLast: 'Depósito por ', aTransaction value asString, '.'.! !

!AccountSummaryReport methodsFor: 'processing' stamp: 'LK 10/26/2023 13:49:41'!
processForDepositLeg: aTransaction
	
	summary addLast: 'Entrada por transferencia por ', aTransaction value asString, '.'! !

!AccountSummaryReport methodsFor: 'processing' stamp: 'LK 10/26/2023 13:49:41'!
processForWithdraw: aTransaction
	
	summary addLast: 'Extracción por ', aTransaction value asString, '.'! !

!AccountSummaryReport methodsFor: 'processing' stamp: 'LK 10/26/2023 13:49:40'!
processForWithdrawLeg: aTransaction

	summary addLast: 'Salida por transferencia por ', aTransaction value asString, '.'! !

!AccountSummaryReport methodsFor: 'processing' stamp: 'LK 10/26/2023 13:51:52'!
processPortfolio: anAccount

	! !

!AccountSummaryReport methodsFor: 'processing' stamp: 'LK 10/26/2023 13:51:33'!
processReceptiveAccount: anAccount! !


!AccountSummaryReport methodsFor: 'initialization' stamp: 'LK 10/26/2023 13:49:41'!
initialize

	summary := OrderedCollection new.! !


!classDefinition: #PortfolioTreeReport category: 'Portfolio-Solucion'!
NodeVisitor subclass: #PortfolioTreeReport
	instanceVariableNames: 'tree'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTreeReport methodsFor: 'processing' stamp: 'LK 10/26/2023 14:12:45'!
endProcess

	^tree! !

!PortfolioTreeReport methodsFor: 'processing' stamp: 'LK 10/26/2023 14:13:26'!
processForDeposit: aTransaction

	! !

!PortfolioTreeReport methodsFor: 'processing' stamp: 'LK 10/26/2023 14:13:31'!
processForDepositLeg: aTransaction

	! !

!PortfolioTreeReport methodsFor: 'processing' stamp: 'LK 10/26/2023 14:13:34'!
processForWithdraw: aTransaction

	! !

!PortfolioTreeReport methodsFor: 'processing' stamp: 'LK 10/26/2023 14:13:36'!
processForWithdrawLeg: aTransaction

	! !

!PortfolioTreeReport methodsFor: 'processing' stamp: 'LK 10/26/2023 14:15:09'!
processPortfolio: anAccount

	tree addLast: anAccount name! !

!PortfolioTreeReport methodsFor: 'processing' stamp: 'LK 10/26/2023 15:01:24'!
processReceptiveAccount: anAccount

	tree addLast: String tab, anAccount name.! !


!PortfolioTreeReport methodsFor: 'initialization' stamp: 'LK 10/26/2023 13:50:03'!
initialize
	tree := OrderedCollection new.! !


!classDefinition: #TransferNetReport category: 'Portfolio-Solucion'!
NodeVisitor subclass: #TransferNetReport
	instanceVariableNames: 'netValue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetReport methodsFor: 'processing' stamp: 'LK 10/26/2023 13:21:36'!
endProcess
	
	^netValue! !

!TransferNetReport methodsFor: 'processing' stamp: 'LK 10/26/2023 13:20:42'!
processForDeposit: aTransaction
	! !

!TransferNetReport methodsFor: 'processing' stamp: 'LK 10/26/2023 13:21:08'!
processForDepositLeg: aTransaction
	
	netValue := netValue + aTransaction value! !

!TransferNetReport methodsFor: 'processing' stamp: 'LK 10/26/2023 13:20:46'!
processForWithdraw: aTransaction
	! !

!TransferNetReport methodsFor: 'processing' stamp: 'LK 10/26/2023 13:21:12'!
processForWithdrawLeg: aTransaction
	
	netValue := netValue - aTransaction value! !

!TransferNetReport methodsFor: 'processing' stamp: 'LK 10/26/2023 13:51:58'!
processPortfolio: anAccount

	! !

!TransferNetReport methodsFor: 'processing' stamp: 'LK 10/26/2023 13:51:33'!
processReceptiveAccount: anAccount! !


!TransferNetReport methodsFor: 'initialization' stamp: 'LK 10/26/2023 12:09:52'!
initialize
	
	netValue := 0.! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdrawingLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'legs' stamp: 'LK 10/25/2023 00:23:44'!
depositingLeg
	^depositLeg! !

!Transfer methodsFor: 'legs' stamp: 'LK 10/25/2023 00:23:33'!
withdrawLeg
	^withdrawingLeg.! !


!Transfer methodsFor: 'value' stamp: 'LK 10/25/2023 00:20:06'!
value
	^value! !


!Transfer methodsFor: 'initialization' stamp: 'LK 10/25/2023 00:23:20'!
initializeWith: aValue from: aWithdrawLeg to: aDepositLeg
	
	value := aValue.
	withdrawingLeg := aWithdrawLeg.
	depositLeg := aDepositLeg.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'as yet unclassified' stamp: 'LK 10/25/2023 00:32:03'!
for: aValue from: aWithdrawAccount to: aDepositAccount

	|transfer withdrawingAccLeg depositingAccLeg|
	
	transfer := self new.
	
	withdrawingAccLeg := WithdrawLeg for: transfer.
	depositingAccLeg := DepositLeg for: transfer.
	
	transfer initializeWith: aValue from: withdrawingAccLeg to: depositingAccLeg.
	
	aWithdrawAccount register: withdrawingAccLeg.
	aDepositAccount register: depositingAccLeg.
	
	^transfer.
	
	! !
