!classDefinition: #PortfolioAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioAccountTest
	instanceVariableNames: 'portfolio1 portfolio2 portfolio3 receptiveAccount1 receptiveAccount2 receptiveAccount3 transaction1'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioAccountTest methodsFor: 'tests' stamp: 'LM 10/17/2022 12:15:37'!
test01EmptyPortfolioHasBalance0

	self assert: portfolio1 balance equals: 0
	
	
	
	! !

!PortfolioAccountTest methodsFor: 'tests' stamp: 'LM 10/17/2022 12:15:56'!
test02PortfolioWithOneAccountHasSameBalanceAsAccount

	Deposit register: 50 on: receptiveAccount1.
	portfolio1 add: receptiveAccount1.
	
	self assert: portfolio1 balance equals: receptiveAccount1 balance
	
	
	
	! !

!PortfolioAccountTest methodsFor: 'tests' stamp: 'LM 10/17/2022 12:15:59'!
test03PortfolioWithAccountsAndAnotherPortfolioHasCorrectBalance

	Deposit register: 50  on: receptiveAccount1 .
	Withdraw register: 20 on: receptiveAccount2 .
	
	portfolio1 add: receptiveAccount1.
	(portfolio2 add: receptiveAccount2) add: portfolio1.

	
	self assert: portfolio2 balance equals: portfolio1 balance + receptiveAccount2 balance
	
	
	
	! !

!PortfolioAccountTest methodsFor: 'tests' stamp: 'LM 10/17/2022 12:19:26'!
test04PortfolioWithAccountsAndAnotherPortfolioContainingAPortfolioHasCorrectBalance

	Deposit register: 50  on: receptiveAccount1 .
	Withdraw register: 20 on: receptiveAccount2 .
	Deposit register: 30 on: receptiveAccount3.
	
	portfolio1 add: receptiveAccount1.
	(portfolio2 add: receptiveAccount2) add: portfolio1.
	(portfolio3 add: receptiveAccount3) add: portfolio2.
	
	self assert: portfolio3 balance equals: portfolio2 balance + receptiveAccount3 balance
	
	
	
	! !

!PortfolioAccountTest methodsFor: 'tests' stamp: 'LM 10/17/2022 12:15:37'!
test05EmptyPortfolioHasNoTransactions

	self assert: portfolio1 transactions equals: Set new.
	
	
	
	! !

!PortfolioAccountTest methodsFor: 'tests' stamp: 'LM 10/17/2022 12:15:56'!
test06PortfolioWithOneAccountHasSameTransactionsAsAccount

	Deposit register: 50 on: receptiveAccount1.
	portfolio1 add: receptiveAccount1.
	
	self assert: portfolio1 transactions equals: receptiveAccount1 transactions
	
	
	
	! !

!PortfolioAccountTest methodsFor: 'tests' stamp: 'LM 10/17/2022 12:19:34'!
test07PortfolioWithAccountsAndAnotherPortfolioHasCorrectTransactions

	Deposit register: 50  on: receptiveAccount1.
	Withdraw register: 20 on: receptiveAccount2.
	
	portfolio1 add: receptiveAccount1.
	(portfolio2 add: receptiveAccount2) add: portfolio1.

	self assert: portfolio2 transactions equals: (portfolio1 transactions union: receptiveAccount2 transactions) 
	
	
	! !

!PortfolioAccountTest methodsFor: 'tests' stamp: 'LM 10/17/2022 12:19:38'!
test08PortfolioWithAccountsAndAnotherPortfolioContainingAPortfolioHasCorrectTransactions

	Deposit register: 50  on: receptiveAccount1.
	Withdraw register: 20 on: receptiveAccount2.
	Deposit register: 30 on: receptiveAccount3.
	
	portfolio1 add: receptiveAccount1.
	(portfolio2 add: receptiveAccount2) add: portfolio1.
	(portfolio3 add: receptiveAccount3) add: portfolio2.
	
	self assert: portfolio3 transactions equals: (portfolio2 transactions union: receptiveAccount3 transactions)
	
	
	
	! !

!PortfolioAccountTest methodsFor: 'tests' stamp: 'LM 10/17/2022 12:16:25'!
test09EmptyPortfolioHasNotRegisteredATransaction

	transaction1 _ Deposit register: 50 on: receptiveAccount1.
	
	self deny: (portfolio1 hasRegistered: transaction1) 
	
	
	
	! !

!PortfolioAccountTest methodsFor: 'tests' stamp: 'LM 10/17/2022 12:15:56'!
test10PortfolioWithOneAccountHasRegisteredItsTransaction

	Deposit register: 50 on: receptiveAccount1.
	portfolio1 add: receptiveAccount1.
	
	self assert: (portfolio1 hasRegistered: receptiveAccount1 transactions asOrderedCollection first)
	
	
	
	! !

!PortfolioAccountTest methodsFor: 'tests' stamp: 'LM 10/17/2022 12:16:25'!
test11PortfolioWithAccountsAndAnotherPortfolioHasRegisteredTheAccountsTransaction

	transaction1 _ Deposit register: 50  on: receptiveAccount1.
	Withdraw register: 20 on: receptiveAccount2.
	
	portfolio1 add: receptiveAccount1.
	(portfolio2 add: receptiveAccount2) add: portfolio1.

	
	self assert: (portfolio2 hasRegistered: transaction1)
	
	
	! !

!PortfolioAccountTest methodsFor: 'tests' stamp: 'LM 10/17/2022 12:16:25'!
test12CannotAddReceptiveAccountToPortfolioTwice

	portfolio1 _ PortfolioAccount new.
	receptiveAccount1 _ ReceptiveAccount new.
		
	portfolio1 add: receptiveAccount1.
	transaction1 _ Deposit register: 50  on: receptiveAccount1.
		
	self assertThatDoing: [portfolio1 add: receptiveAccount1] raisesDuplicatedAccountErrorAndDoesntChangePortfolio: portfolio1.! !

!PortfolioAccountTest methodsFor: 'tests' stamp: 'LM 10/17/2022 12:16:25'!
test13CannotAddReceptiveAccountToPortfolioThatAlreadyHasAPortfolioWithThatAccount

	portfolio2 add: receptiveAccount1.
	portfolio1 add: portfolio2.
	transaction1 _ Deposit register: 50  on: receptiveAccount1.
		
	self assertThatDoing: [portfolio1 add: receptiveAccount1] raisesDuplicatedAccountErrorAndDoesntChangePortfolio: portfolio1
	
	
	! !

!PortfolioAccountTest methodsFor: 'tests' stamp: 'LM 10/17/2022 12:17:06'!
test14CannotAddPortfolioToSamePortfolio

	portfolio1 add: receptiveAccount1.
	transaction1 _ Deposit register: 50  on: receptiveAccount1.
		
	self assertThatDoing: [portfolio1 add: portfolio1] raisesDuplicatedAccountErrorAndDoesntChangePortfolio: portfolio1
	! !

!PortfolioAccountTest methodsFor: 'tests' stamp: 'LM 10/17/2022 12:17:48'!
test15CannotAddReceptiveAccountThatAlreadyIsInAParentsPortfolio

	portfolio1 add: receptiveAccount1.
	portfolio1 add: portfolio2.
	transaction1 _ Deposit register: 50  on: receptiveAccount1.
		
	self assertThatDoing: [portfolio2 add: receptiveAccount1] raisesDuplicatedAccountErrorAndDoesntChangePortfolio: portfolio1
	
	
	
	! !

!PortfolioAccountTest methodsFor: 'tests' stamp: 'LM 10/17/2022 12:18:08'!
test16CannotAddPortfolioThatHasReceptiveAccountToAPortfolioThatAlreadyHasTheReceptiveAccount

	portfolio3 add: receptiveAccount1.
	portfolio3 add: portfolio2.
	portfolio1 add: receptiveAccount1.
	transaction1 _ Deposit register: 50  on: receptiveAccount1.
		
	self assertThatDoing: [portfolio2 add: portfolio1] raisesDuplicatedAccountErrorAndDoesntChangePortfolio: portfolio1
	! !


!PortfolioAccountTest methodsFor: 'setUp' stamp: 'LM 10/17/2022 12:16:01'!
setUp

	portfolio1 _ PortfolioAccount new.
	portfolio2 _ PortfolioAccount new.
	portfolio3 _ PortfolioAccount new.
	receptiveAccount1 _ ReceptiveAccount new.
	receptiveAccount2 _ ReceptiveAccount new.
	receptiveAccount3 _ ReceptiveAccount new.! !


!PortfolioAccountTest methodsFor: 'assertions' stamp: 'LM 10/17/2022 12:16:25'!
assertThatDoing: aBlock raisesDuplicatedAccountErrorAndDoesntChangePortfolio: aPortfolio
		
	self should: aBlock
		raise: Error
		withExceptionDo: [:anError| self assert: [
							anError messageText = PortfolioAccount duplicatedAccountErrorMessage.
							aPortfolio transactions = (Set with: transaction1).
							]]
	
	
	! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LM 10/17/2022 12:23:13'!
test01ReceptiveAccountHasZeroAsBalanceWhenCreated 

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LM 10/17/2022 12:23:13'!
test02DepositIncreasesBalanceOnTransactionValue 

	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LM 10/17/2022 12:23:13'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LM 10/17/2022 12:23:13'!
test04WithdrawValueMustBePositive 

	| withdrawValue |
	
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LM 10/17/2022 12:23:13'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LM 10/17/2022 12:24:25'!
test06ReceptiveAccountDoesNotKnowNotRegisteredTransactions

	| deposit withdraw |
	
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LM 10/17/2022 12:29:00'!
test07AccountKnowsItsTransactions 

	| deposit |
	
	deposit := Deposit register: 50 on: account.
		
	self assert: 1 equals: account transactions size.
	self assert: (account transactions includes: deposit).
! !


!ReceptiveAccountTest methodsFor: 'setUp' stamp: 'LM 10/17/2022 12:23:13'!
setUp

	account _ ReceptiveAccount new.! !


!classDefinition: #Account category: 'Portfolio-Ejercicio'!
Object subclass: #Account
	instanceVariableNames: 'parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Account methodsFor: 'testing' stamp: 'vv 10/13/2022 21:24:45'!
hasRegistered: aTransaction

	self subclassResponsibility ! !


!Account methodsFor: 'accessing' stamp: 'LM 10/16/2022 00:08:41'!
addParent: aPortfolioAccount
	
	parents add: aPortfolioAccount.! !

!Account methodsFor: 'accessing' stamp: 'vv 10/13/2022 21:24:43'!
balance

	self subclassResponsibility ! !

!Account methodsFor: 'accessing' stamp: 'LM 10/16/2022 00:05:34'!
initialize

	parents _ OrderedCollection new.! !

!Account methodsFor: 'accessing' stamp: 'vv 10/13/2022 21:24:47'!
transactions

	self subclassResponsibility ! !


!classDefinition: #PortfolioAccount category: 'Portfolio-Ejercicio'!
Account subclass: #PortfolioAccount
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioAccount methodsFor: 'accessing' stamp: 'LM 10/16/2022 12:03:05'!
allAccounts

	^accounts inject: Set new into: [:allAccountsSoFar :account| allAccountsSoFar add: account. allAccountsSoFar union: account allAccounts].
	
! !

!PortfolioAccount methodsFor: 'accessing' stamp: 'LM 10/15/2022 23:53:50'!
balance

	^accounts sum: [:bankEntity | bankEntity balance] ifEmpty: [0]! !

!PortfolioAccount methodsFor: 'accessing' stamp: 'LM 10/17/2022 11:54:49'!
transactions
	
	
	^accounts inject: Set new into:[:transactionsSoFar :bankEntity| transactionsSoFar union: bankEntity transactions ]! !


!PortfolioAccount methodsFor: 'testing' stamp: 'LM 10/16/2022 12:12:19'!
cannotAdd: anAccount

	^	(accounts anySatisfy: [:account| account containsAccount: anAccount])   or: 
		(parents anySatisfy: [:aParent| aParent isAChildOfAncestor: anAccount]) or: 
		(self = anAccount)! !

!PortfolioAccount methodsFor: 'testing' stamp: 'LM 10/16/2022 12:12:46'!
containsAccount: anAccount

	^ (accounts anySatisfy: [:account| 			account = anAccount 
										or: [anAccount allAccounts includes: account]])
		or: (self = anAccount)! !

!PortfolioAccount methodsFor: 'testing' stamp: 'LM 10/15/2022 23:53:50'!
hasRegistered: aTransaction

	^ accounts anySatisfy: [:bankEntity| bankEntity hasRegistered: aTransaction]
! !

!PortfolioAccount methodsFor: 'testing' stamp: 'LM 10/16/2022 12:10:22'!
isAChildOfAncestor: anAccount

	^ 	(accounts anySatisfy: [:account| (account containsAccount: anAccount) or: [anAccount allAccounts includes: account]]) 
		or: 
		(parents anySatisfy: [:aParent| aParent isAChildOfAncestor: anAccount])
		or:
		(self = anAccount)
		
		"Lo importante es la buena onda"! !


!PortfolioAccount methodsFor: 'adding' stamp: 'LM 10/16/2022 12:08:34'!
add: anAccount

	(self cannotAdd: anAccount) ifTrue: [self error: self class duplicatedAccountErrorMessage].
	
	accounts add: anAccount.
	anAccount addParent: self. ! !


!PortfolioAccount methodsFor: 'initialization' stamp: 'LM 10/16/2022 00:42:10'!
initialize

	accounts _ OrderedCollection new.
	super initialize.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioAccount class' category: 'Portfolio-Ejercicio'!
PortfolioAccount class
	instanceVariableNames: ''!

!PortfolioAccount class methodsFor: 'as yet unclassified' stamp: 'LM 10/15/2022 23:53:16'!
duplicatedAccountErrorMessage

	^'Can not add duplicated account to porfolio'! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'LM 10/17/2022 11:55:01'!
initialize

	transactions := Set new.
	super initialize.! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'LM 10/16/2022 00:43:31'!
cannotAdd: anAccount

	^self = anAccount! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'LM 10/16/2022 12:10:22'!
containsAccount: anAccount

	^self = anAccount! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'accessing' stamp: 'LM 10/16/2022 12:00:35'!
allAccounts

	^Set with: self.! !

!ReceptiveAccount methodsFor: 'accessing' stamp: 'MV 10/6/2022 21:24:29'!
balance

	^transactions inject: 0 into:[:balance :aTransaction| aTransaction applyToBalance: balance]! !

!ReceptiveAccount methodsFor: 'accessing' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'adding' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

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
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'MV 10/6/2022 21:17:53'!
applyToBalance: aBalance

	^aBalance + value! !

!Deposit methodsFor: 'value' stamp: 'MV 10/6/2022 20:57:49'!
signedValue
	^value! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'MV 10/6/2022 20:53:35'!
initializeFor: aValue

	value :=  aValue ! !


!Withdraw methodsFor: 'value' stamp: 'MV 10/6/2022 21:17:53'!
applyToBalance: aBalance

	^aBalance - value! !

!Withdraw methodsFor: 'value' stamp: 'MV 10/6/2022 20:58:07'!
signedValue

	 ^ 0 - value! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !
