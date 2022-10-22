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


!classDefinition: #ReportTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReportTest
	instanceVariableNames: 'account1 account2 account3 summarizer portfolio1 portfolio2 portfolio3 portfolio4'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReportTest methodsFor: 'tests' stamp: 'LM 10/22/2022 17:51:43'!
test01AccountSummaryOfReceptiveAccountWithNoTransactions

	self assert: (summarizer summarize: ReceptiveAccount new) equals: (OrderedCollection with: 'Balance = 0').! !

!ReportTest methodsFor: 'tests' stamp: 'LM 10/22/2022 18:17:53'!
test02AccountSummaryOfReceptiveAccountWithOneDeposit

	Deposit register: 50 on: account1.
		
	self assert: (summarizer summarize: account1) equals: ({'Depósito por 50.'. 'Balance = 50'} asOrderedCollection).! !

!ReportTest methodsFor: 'tests' stamp: 'LM 10/22/2022 18:17:53'!
test03AccountSummaryOfReceptiveAccountWithOneWithdrawal

	Withdraw register: 50 on: account1.
		
	self assert: (summarizer summarize: account1) equals: ({'Extracción por 50.'. 'Balance = -50'} asOrderedCollection).! !

!ReportTest methodsFor: 'tests' stamp: 'LM 10/22/2022 18:17:53'!
test04AccountSummaryOfReceptiveAccountWithOneTransferDeposit

	Transfer register: 50 from: ReceptiveAccount new to: account1.
		
	self assert: (summarizer summarize: account1) equals: ({'Depósito por transferencia de 50.'. 'Balance = 50'} asOrderedCollection).! !

!ReportTest methodsFor: 'tests' stamp: 'LM 10/22/2022 18:17:53'!
test05AccountSummaryOfReceptiveAccountWithOneTransferWithdraw

	Transfer register: 50 from: account1 to: ReceptiveAccount new.
		
	self assert: (summarizer summarize: account1) equals: ({'Extracción por transferencia de 50.'. 'Balance = -50'} asOrderedCollection).! !

!ReportTest methodsFor: 'tests' stamp: 'LM 10/22/2022 18:17:53'!
test06AccountSummaryOfReceptiveAccountWithManyTransactions
	
	Transfer register: 50 from: account1 to: ReceptiveAccount new.
	Transfer register: 42 from: ReceptiveAccount new to: account1.
	Deposit register: 10 on: account1.
	Withdraw register: 15 on: account1.
		
	self 
		assert: (summarizer summarize: account1) 
		equals: ({'Extracción por transferencia de 50.'. 'Depósito por transferencia de 42.'. 'Depósito por 10.'. 'Extracción por 15.'. 'Balance = -13'} asOrderedCollection).! !

!ReportTest methodsFor: 'tests' stamp: 'LM 10/22/2022 18:17:57'!
test07AccountSummaryOfEmptyPortfolio

	self 
		assert: (summarizer summarize: portfolio1)
		equals: ({'Balance = 0'} asOrderedCollection).! !

!ReportTest methodsFor: 'tests' stamp: 'LM 10/22/2022 18:17:57'!
test08AccountSummaryOfPortfolioWithAReceptiveAccount

	Deposit register: 33 on: account1.
	
	portfolio1 add: account1.
		
	self 
		assert: (summarizer summarize: portfolio1)
		equals: ({'Depósito por 33.'. 'Balance = 33'} asOrderedCollection).! !

!ReportTest methodsFor: 'tests' stamp: 'LM 10/22/2022 18:18:58'!
test09AccountSummaryOfPortfolioWithAPortfolioWithAReceptiveAccount

	Deposit register: 33 on: account1.
	
	portfolio2 add: account1.
	portfolio1 add: portfolio2.
		
	self 
		assert: (summarizer summarize: portfolio1)
		equals: ({'Depósito por 33.'. 'Balance = 33'} asOrderedCollection).! !

!ReportTest methodsFor: 'tests' stamp: 'LM 10/22/2022 18:34:02'!
test10AccountSummaryOfPortfolioWithManyAccounts

	Deposit register: 33 on: account1.
	Withdraw register: 10 on: account2.
	Transfer register: 10 from: account3 to: account2.
	
	portfolio2 add: account1.
	portfolio3 add: portfolio4.
	portfolio3 add: account3.
	portfolio4 add: account2.
	portfolio1 add: portfolio2.	
	portfolio1 add: portfolio3.
		
	self 
		assert: (summarizer summarize: portfolio1)
		equals: ({'Depósito por 33.'. 'Extracción por 10.'. 'Depósito por transferencia de 10.'. 'Extracción por transferencia de 10.'. 'Balance = 23'} asOrderedCollection).! !


!ReportTest methodsFor: 'setUp' stamp: 'LM 10/22/2022 18:25:40'!
setUp

	account1 _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new.
	account3 _ ReceptiveAccount new.
	summarizer _ AccountSummarizer new.
	portfolio1 _ Portfolio new.
	portfolio2 _ Portfolio new.
	portfolio3 _ Portfolio new.
	portfolio4 _ Portfolio new.! !


!classDefinition: #TransferTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LM 10/20/2022 14:51:04'!
test01BalanceAfterTransactionIsCorrect

	|receptiveAccount1 receptiveAccount2|
	
	receptiveAccount1 _ ReceptiveAccount new.
	receptiveAccount2 _ ReceptiveAccount new.
	
	Transfer register: 50 from: receptiveAccount1 to: receptiveAccount2.
	
	self assert: receptiveAccount1 balance equals: -50.
	self assert: receptiveAccount2 balance equals: 50.

	! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LM 10/20/2022 14:59:32'!
test02TransactionsAreRegistered

	|receptiveAccount1 receptiveAccount2 transfer1|
	
	receptiveAccount1 _ ReceptiveAccount new.
	receptiveAccount2 _ ReceptiveAccount new.
	
	transfer1 _ Transfer register: 50 from: receptiveAccount1 to: receptiveAccount2.
	
	self assert: (receptiveAccount1 hasRegistered: transfer1 withdraw).
	self assert: (receptiveAccount2 hasRegistered: transfer1 deposit)

	! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LM 10/20/2022 14:55:09'!
test03EachPartOfATransactionCanReachTheOther

	|receptiveAccount1 receptiveAccount2 transfer1|
	
	receptiveAccount1 _ ReceptiveAccount new.
	receptiveAccount2 _ ReceptiveAccount new.
	
	transfer1 _ Transfer register: 50 from: receptiveAccount1 to: receptiveAccount2.
	
	self assert: transfer1 deposit equals: transfer1 withdraw deposit.
	self assert: transfer1 withdraw equals: transfer1 deposit withdraw.

	! !


!classDefinition: #Account category: 'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
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


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!Account methodsFor: 'reports' stamp: 'LM 10/20/2022 20:00:38'!
accountSummary

	self subclassResponsibility! !

!Account methodsFor: 'reports' stamp: 'LM 10/22/2022 17:50:51'!
beSummarizedBy: aSummarizer

	self subclassResponsibility! !


!classDefinition: #Portfolio category: 'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

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


!Portfolio methodsFor: 'reports' stamp: 'LM 10/22/2022 18:04:51'!
beSummarizedBy: aSummarizer

	^aSummarizer summarizePortfolioWithAccounts: accounts andBalance: self balance.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

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


!ReceptiveAccount methodsFor: 'reports' stamp: 'LM 10/22/2022 17:50:18'!
beSummarizedBy: aSummarizer
	
	^aSummarizer summarizeReceptiveAccountWithTransactions: transactions withBalance: self balance.! !


!classDefinition: #AccountSummarizer category: 'Portfolio-Solucion'!
Object subclass: #AccountSummarizer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummarizer methodsFor: 'as yet unclassified' stamp: 'LM 10/22/2022 17:50:03'!
summarize: anAccount

	^anAccount beSummarizedBy: self.! !

!AccountSummarizer methodsFor: 'as yet unclassified' stamp: 'LM 10/22/2022 17:59:57'!
summarizePortfolio: aPortfolio

	|res|
	
	res _ OrderedCollection new.
	
	res add:		('Balance = ' , aPortfolio balance asString).
	^res	! !

!AccountSummarizer methodsFor: 'as yet unclassified' stamp: 'LM 10/22/2022 18:14:45'!
summarizePortfolioWithAccounts: aCollectionOfAccounts andBalance: aBalance 

	|res|
	
	res _ OrderedCollection new.
	
	aCollectionOfAccounts do: [:account | res addAllLast: (self summarizeWithoutBalance: account)].
	
	res add:		('Balance = ' , aBalance asString).
	^res	! !

!AccountSummarizer methodsFor: 'as yet unclassified' stamp: 'LM 10/22/2022 17:45:59'!
summarizeReceptiveAccountWithTransactions: aCollectionOfTransactions withBalance: aBalance

	|res|
	
	res := OrderedCollection new .
	aCollectionOfTransactions do: [:aTransaction| 
			(aTransaction isKindOf: Deposit) ifTrue: [(res add: 'Depósito por ' , aTransaction value asString ,'.')].
			(aTransaction isKindOf: Withdraw) ifTrue: [(res add: 'Extracción por ' , aTransaction value asString ,'.')].
			(aTransaction isKindOf: TransferDeposit ) ifTrue: [(res add: 'Depósito por transferencia de ' , aTransaction value asString ,'.')].
			(aTransaction isKindOf: TransferWithdraw ) ifTrue: [(res add: 'Extracción por transferencia de ' , aTransaction value asString ,'.')			]
			].		
			
	res add:		('Balance = ' , aBalance asString).
	^res	! !

!AccountSummarizer methodsFor: 'as yet unclassified' stamp: 'LM 10/22/2022 18:13:07'!
summarizeWithoutBalance: anAccount
	
	|res|

	res _ 	anAccount beSummarizedBy: self.
	res removeLast.
	^res! !


!classDefinition: #AccountTransaction category: 'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!classDefinition: #InterpersonalTransaction category: 'Portfolio-Solucion'!
AccountTransaction subclass: #InterpersonalTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InterpersonalTransaction class' category: 'Portfolio-Solucion'!
InterpersonalTransaction class
	instanceVariableNames: ''!

!InterpersonalTransaction class methodsFor: 'as yet unclassified' stamp: 'LM 10/21/2022 22:04:43'!
registerOn: aReceptiveAccount

	| transaction |
	
	transaction := self new.
	aReceptiveAccount register: transaction.
		
	^ transaction! !

!InterpersonalTransaction class methodsFor: 'as yet unclassified' stamp: 'LM 10/21/2022 22:10:28'!
registerOn: aReceptiveAccount asPartOfTransfer: aTransfer

	| transaction |
	
	transaction := self new initializeAsPartOfTransfer: aTransfer.
	aReceptiveAccount register: transaction.
		
	^ transaction! !


!classDefinition: #TransferDeposit category: 'Portfolio-Solucion'!
InterpersonalTransaction subclass: #TransferDeposit
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'LM 10/20/2022 15:21:22'!
affectBalance: aBalance

	^aBalance + self value! !

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'LM 10/21/2022 22:11:09'!
initializeAsPartOfTransfer: aTransfer

	transfer _ aTransfer.! !

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'LM 10/20/2022 15:19:18'!
setTransfer: aTransfer

	transfer _ aTransfer ! !

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'LM 10/20/2022 15:22:25'!
value

	^transfer value.! !

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'LM 10/20/2022 15:24:09'!
withdraw

	^transfer withdraw.! !


!classDefinition: #TransferWithdraw category: 'Portfolio-Solucion'!
InterpersonalTransaction subclass: #TransferWithdraw
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'LM 10/20/2022 15:21:29'!
affectBalance: aBalance

	^aBalance - self value ! !

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'LM 10/20/2022 15:23:55'!
deposit

	^transfer deposit! !

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'LM 10/21/2022 22:11:11'!
initializeAsPartOfTransfer: aTransfer

	transfer _ aTransfer.! !

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'LM 10/20/2022 15:19:22'!
setTransfer: aTransfer

	transfer _ aTransfer ! !

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'LM 10/20/2022 15:22:34'!
value

	^transfer value.! !


!classDefinition: #PersonalTransaction category: 'Portfolio-Solucion'!
AccountTransaction subclass: #PersonalTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PersonalTransaction class' category: 'Portfolio-Solucion'!
PersonalTransaction class
	instanceVariableNames: ''!

!PersonalTransaction class methodsFor: 'as yet unclassified' stamp: 'LM 10/21/2022 22:03:20'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Solucion'!
PersonalTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'LM 10/20/2022 20:06:30'!
reportText

	^'Depósito por ' , value asString! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Solucion'!
PersonalTransaction subclass: #Withdraw
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


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'withdraw deposit value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'as yet unclassified' stamp: 'LM 10/20/2022 14:59:40'!
deposit

	^deposit ! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'LM 10/21/2022 22:06:19'!
initializeWithValue: anAmount from: senderAccount to: receivingAccount

	value _ anAmount.
	deposit _ (TransferDeposit registerOn: receivingAccount asPartOfTransfer: self).
	withdraw _ (TransferWithdraw registerOn: senderAccount asPartOfTransfer: self).! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'LM 10/20/2022 15:23:15'!
value

	^value! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'LM 10/20/2022 14:59:48'!
withdraw

	^withdraw ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'as yet unclassified' stamp: 'LM 10/20/2022 15:25:23'!
register: anAmount from: senderAccount to: receivingAccount

	| transaction |
	
	transaction := self new initializeWithValue: anAmount from: senderAccount  to: receivingAccount.	
	
	"senderAccount register: transaction."
	"receivingAccount register: transaction."
	
	^ transaction! !


!classDefinition: #TransferTransaction category: 'Portfolio-Solucion'!
Object subclass: #TransferTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferTransaction class' category: 'Portfolio-Solucion'!
TransferTransaction class
	instanceVariableNames: ''!

!TransferTransaction class methodsFor: 'as yet unclassified' stamp: 'LM 10/20/2022 15:11:20'!
register: aValue on: account

	| transaction |
	
	transaction := self new.
	account register: transaction.
		
	^ transaction! !
