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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'MV 10/6/2022 21:43:09'!
test08EmptyPortfolioHasBalance0

	|portfolio1|
	
	portfolio1 _ Portfolio new.
	
	self assert: portfolio1 balance equals: 0
	
	
	
	! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'MV 10/6/2022 21:42:22'!
test09PortfolioWithOneAccountHasSameBalanceAsAccount

	|portfolio1 account1|
	
	portfolio1 _ Portfolio new.
	account1 _ ReceptiveAccount new.
	
	Deposit register: 50 on: account1.
	portfolio1 addAccount: account1.
	
	self assert: portfolio1 balance equals: account1 balance
	
	
	
	! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'MV 10/6/2022 21:49:38'!
test10PortfolioWithAccountsAndAnotherPortfolioHasCorrectBalance

	|portfolio1 portfolio2 account1 account2|
	
	portfolio1 _ Portfolio new.
	portfolio2 _ Portfolio new.
	account1 _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new.
	
	Deposit register: 50  on: account1 .
	Withdraw register: 20 on: account2 .
	
	portfolio1 addAccount: account1.
	(portfolio2 addAccount: account2) addPortfolio: portfolio1.

	
	self assert: portfolio2 balance equals: portfolio1 balance + account2 balance
	
	
	
	! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LM 10/10/2022 00:26:06'!
test11PortfolioWithAccountsAndAnotherPortfolioContainingAPortfolioHasCorrectBalance

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
	
	portfolio1 addAccount: account1.
	(portfolio2 addAccount: account2) addPortfolio: portfolio1.
	(portfolio3 addAccount: account3) addPortfolio: portfolio2.

	
	self assert: portfolio3 balance equals: portfolio2 balance + account3 balance
	
	
	
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


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accounts portfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'as yet unclassified' stamp: 'MV 10/6/2022 21:40:12'!
addAccount: anAccount

	accounts add: anAccount.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'MV 10/6/2022 21:50:12'!
addPortfolio: aPortfolio

	portfolios add: aPortfolio.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'MV 10/6/2022 21:51:41'!
balance

	^(accounts sum: [:account| account balance] ifEmpty: [0]) + (portfolios sum: [:portfolio | portfolio balance] ifEmpty: [0])! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'MV 10/6/2022 21:50:40'!
initialize

	accounts _ OrderedCollection new.
	portfolios _ OrderedCollection new.! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'MV 10/6/2022 21:24:29'!
balance

	^transactions inject: 0 into:[:balance :aTransaction| aTransaction applyToBalance: balance]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !
