!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'LM 10/10/2022 15:43:18'!
test01EmptyPortfolioHasBalance0

	|portfolio1|
	
	portfolio1 _ Portfolio new.
	
	self assert: portfolio1 balance equals: 0
	
	
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'vv 10/13/2022 21:14:57'!
test02PortfolioWithOneAccountHasSameBalanceAsAccount

	|portfolio1 account1|
	
	portfolio1 _ Portfolio new.
	account1 _ ReceptiveAccount new.
	
	Deposit register: 50 on: account1.
	portfolio1 add: account1.
	
	self assert: portfolio1 balance equals: account1 balance
	
	
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'vv 10/13/2022 21:14:57'!
test03PortfolioWithAccountsAndAnotherPortfolioHasCorrectBalance

	|portfolio1 portfolio2 account1 account2|
	
	portfolio1 _ Portfolio new.
	portfolio2 _ Portfolio new.
	account1 _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new.
	
	Deposit register: 50  on: account1 .
	Withdraw register: 20 on: account2 .
	
	portfolio1 add: account1.
	(portfolio2 add: account2) add: portfolio1.

	
	self assert: portfolio2 balance equals: portfolio1 balance + account2 balance
	
	
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'vv 10/13/2022 21:14:57'!
test04PortfolioWithAccountsAndAnotherPortfolioContainingAPortfolioHasCorrectBalance

	|portfolio1 portfolio2 portfolio3 account1 account2 account3|
	
	portfolio1 _ Portfolio new.
	portfolio2 _ Portfolio new.
	portfolio3 _ Portfolio new.
	account1 _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new.
	account3 _ ReceptiveAccount new.
	
	Deposit register: 50  on: account1 .
	Withdraw register: 20 on: account2 .
	Deposit register: 30 on: account3.
	
	portfolio1 add: account1.
	(portfolio2 add: account2) add: portfolio1.
	(portfolio3 add: account3) add: portfolio2.

	
	self assert: portfolio3 balance equals: portfolio2 balance + account3 balance
	
	
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'LM 10/10/2022 16:07:12'!
test05EmptyPortfolioHasNoTransactions

	|portfolio1|
	
	portfolio1 _ Portfolio new.
	
	self assert: portfolio1 transactions equals: OrderedCollection new.
	
	
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'vv 10/13/2022 21:14:56'!
test06PortfolioWithOneAccountHasSameTransactionsAsAccount

	|portfolio1 account1|
	
	portfolio1 _ Portfolio new.
	account1 _ ReceptiveAccount new.
	
	Deposit register: 50 on: account1.
	portfolio1 add: account1.
	
	self assert: (portfolio1 transactions sum:[:transaction| transaction value]) equals: (account1 transactions sum:[:transaction| transaction value])
	
	
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'vv 10/13/2022 21:14:56'!
test07PortfolioWithAccountsAndAnotherPortfolioHasCorrectTransactions

	|portfolio1 portfolio2 account1 account2|
	
	portfolio1 _ Portfolio new.
	portfolio2 _ Portfolio new.
	account1 _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new.
	
	Deposit register: 50  on: account1 .
	Withdraw register: 20 on: account2 .
	
	portfolio1 add: account1.
	(portfolio2 add: account2) add: portfolio1.

	
	self assert: (portfolio2 transactions sum:[:transaction| transaction value]) equals: (portfolio1 transactions sum:[:transaction| transaction value]) + (account2 transactions sum:[:transaction| transaction value])
	
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'vv 10/13/2022 21:14:57'!
test08PortfolioWithAccountsAndAnotherPortfolioContainingAPortfolioHasCorrectTransactions

	|portfolio1 portfolio2 portfolio3 account1 account2 account3|
	
	portfolio1 _ Portfolio new.
	portfolio2 _ Portfolio new.
	portfolio3 _ Portfolio new.
	account1 _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new.
	account3 _ ReceptiveAccount new.
	
	Deposit register: 50  on: account1 .
	Withdraw register: 20 on: account2 .
	Deposit register: 30 on: account3.
	
	portfolio1 add: account1.
	(portfolio2 add: account2) add: portfolio1.
	(portfolio3 add: account3) add: portfolio2.

	
	self assert: (portfolio3 transactions sum:[:transaction| transaction value]) equals: (portfolio2 transactions sum:[:transaction| transaction value]) + (account3 transactions sum:[:transaction| transaction value])
	
	
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'LM 10/10/2022 16:14:37'!
test09EmptyPortfolioHasNotRegisteredATransaction

	|portfolio1 account1 transaction1|
	
	portfolio1 _ Portfolio new.
	account1 _ ReceptiveAccount new.
	
	transaction1 _ Deposit register: 420 on: account1.
	
	self deny: (portfolio1 hasRegistered: transaction1) 
	
	
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'vv 10/13/2022 21:14:57'!
test10PortfolioWithOneAccountHasRegisteredItsTransaction

	|portfolio1 account1|
	
	portfolio1 _ Portfolio new.
	account1 _ ReceptiveAccount new.
	
	Deposit register: 50 on: account1.
	portfolio1 add: account1.
	
	self assert: (portfolio1 hasRegistered: account1 transactions first)
	
	
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'vv 10/13/2022 21:14:56'!
test11PortfolioWithAccountsAndAnotherPortfolioHasRegisteredTheAccountsTransaction

	|portfolio1 portfolio2 account1 account2 transaction1|
	
	portfolio1 _ Portfolio new.
	portfolio2 _ Portfolio new.
	account1 _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new.
	
	transaction1 _ Deposit register: 50  on: account1 .
	Withdraw register: 20 on: account2 .
	
	portfolio1 add: account1.
	(portfolio2 add: account2) add: portfolio1.

	
	self assert: (portfolio2 hasRegistered: transaction1)
	
	
	! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LM 10/10/2022 00:16:26'!
test01ReceptiveAccountHasZeroAsBalanceWhenCreated 

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


!classDefinition: #BankEntity category: 'Portfolio-Ejercicio'!
Object subclass: #BankEntity
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!BankEntity methodsFor: 'testing' stamp: 'vv 10/13/2022 21:24:45'!
hasRegistered: aTransaction

	self subclassResponsibility ! !


!BankEntity methodsFor: 'accessing' stamp: 'vv 10/13/2022 21:24:43'!
balance

	self subclassResponsibility ! !

!BankEntity methodsFor: 'accessing' stamp: 'vv 10/13/2022 21:24:47'!
transactions

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
BankEntity subclass: #Portfolio
	instanceVariableNames: 'bankEntities'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'accessing' stamp: 'vv 10/13/2022 21:11:23'!
balance

	^bankEntities sum: [:bankEntity | bankEntity balance] ifEmpty: [0]! !

!Portfolio methodsFor: 'accessing' stamp: 'vv 10/13/2022 21:22:08'!
transactions
	
	
	^bankEntities inject: OrderedCollection new into:[: transactionsSoFar :bankEntity| transactionsSoFar union: bankEntity transactions ]! !


!Portfolio methodsFor: 'testing' stamp: 'vv 10/13/2022 21:12:59'!
hasRegistered: aTransaction

	^ bankEntities anySatisfy: [:bankEntity| bankEntity hasRegistered: aTransaction]
! !


!Portfolio methodsFor: 'adding' stamp: 'vv 10/13/2022 21:15:12'!
add: aBankEntity

	bankEntities add: aBankEntity ! !


!Portfolio methodsFor: 'initialization' stamp: 'vv 10/13/2022 21:11:44'!
initialize

	bankEntities _ OrderedCollection new.! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
BankEntity subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


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
