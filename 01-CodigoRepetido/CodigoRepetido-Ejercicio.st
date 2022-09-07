!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testingTools' stamp: 'LM 9/7/2022 01:10:38'!
afterFailing: closureToFail withError: errorToCheck check: closureOfAssertions 

	[closureToFail value. self fail] on: errorToCheck do: closureOfAssertions! !

!CustomerBookTest methodsFor: 'testingTools' stamp: 'LM 9/7/2022 15:04:29'!
assertThatSoleCustomerIs: aCustomer in: aCustomerBook

	self assert: (aCustomerBook numberOfCustomers = 1 and: (aCustomerBook includesCustomerNamed: aCustomer))
! !

!CustomerBookTest methodsFor: 'testingTools' stamp: 'LM 9/7/2022 15:26:01'!
assertThatSoleSuspendedCustomerIs: aCustomer in: aCustomerBook

	self assert: (aCustomerBook numberOfCustomers = 1 and: (aCustomerBook includesCustomerNamed: aCustomer) and: aCustomerBook numberOfSuspendedCustomers = 1)
! !

!CustomerBookTest methodsFor: 'testingTools' stamp: 'LM 9/6/2022 23:43:49'!
closureExecutionTime: closureToTest takesLessThan: timeLimitInMilliseconds 

	| millisecondsBeforeRunning millisecondsAfterRunning |	
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	closureToTest value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	^(millisecondsAfterRunning-millisecondsBeforeRunning) < (timeLimitInMilliseconds)! !

!CustomerBookTest methodsFor: 'testingTools' stamp: 'LM 9/7/2022 15:14:59'!
initializeCustomerBookWithSoleCustomer: aSoleCustomer

	^(CustomerBook new addCustomerNamed: aSoleCustomer)
	! !

!CustomerBookTest methodsFor: 'testingTools' stamp: 'LM 9/7/2022 15:16:46'!
initializeCustomerBookWithSoleSuspendedCustomer: aSoleCustomer

	^((CustomerBook new addCustomerNamed: aSoleCustomer) suspendCustomerNamed: aSoleCustomer)
	! !


!CustomerBookTest methodsFor: 'tests' stamp: 'LM 9/6/2022 23:42:37'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

		| customerBook |
		
		customerBook := CustomerBook new.
		
		self assert: (self closureExecutionTime: [customerBook addCustomerNamed: 'John Lennon'] takesLessThan: 50 * millisecond	).
		 
		
	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'LM 9/7/2022 15:15:38'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self initializeCustomerBookWithSoleCustomer: paulMcCartney.
	
	 
	self assert: (self closureExecutionTime: [customerBook removeCustomerNamed: paulMcCartney.]  takesLessThan: 100 * millisecond)
	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'LM 9/7/2022 11:26:37'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	self  		afterFailing: [customerBook addCustomerNamed: ''] 
			withError: Error 
			check: [:anError |
				self assert: (anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage).
				self assert: (customerBook isEmpty)
				]
	! !

!CustomerBookTest methodsFor: 'tests' stamp: 'LM 9/7/2022 15:18:37'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon|
			
	johnLennon := 'John Lennon'.
	customerBook := self initializeCustomerBookWithSoleCustomer: johnLennon.
	
	self afterFailing: [customerBook removeCustomerNamed: 'Paul McCartney'.] 
		 withError: NotFound 
		 check: [ 
			self assert: (customerBook numberOfCustomers = 1).
			self assert: (customerBook includesCustomerNamed: johnLennon)
			]
	! !

!CustomerBookTest methodsFor: 'tests' stamp: 'LM 9/7/2022 15:26:14'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self initializeCustomerBookWithSoleSuspendedCustomer: paulMcCartney.
	
	self assertThatSoleSuspendedCustomerIs: paulMcCartney in: customerBook.
	

	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'LM 9/7/2022 15:30:31'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self initializeCustomerBookWithSoleSuspendedCustomer: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assert: customerBook isEmpty.


	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'LM 9/7/2022 15:28:08'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook := self initializeCustomerBookWithSoleCustomer: johnLennon.
	
	self afterFailing: [ customerBook suspendCustomerNamed: 'George Harrison']
		 withError: CantSuspend 
		 check: [	self assertThatSoleCustomerIs: johnLennon  in: customerBook ]
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'LM 9/7/2022 15:29:17'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook := self initializeCustomerBookWithSoleSuspendedCustomer: johnLennon .
	
	self afterFailing: [ customerBook suspendCustomerNamed: johnLennon]
		 withError: CantSuspend 
		 check: [	self assertThatSoleCustomerIs: johnLennon  in: customerBook ]
! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'LM 9/7/2022 15:36:02'!
removeCustomerNamed: aName 
 
	active remove: aName  ifAbsent: [		suspended remove: aName ifAbsent: [^ NotFound signal]]
	
	
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/11/2022 07:18:12'!
customerAlreadyExistsErrorMessage

	^'Customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/11/2022 07:18:16'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty!!!!!!'! !
