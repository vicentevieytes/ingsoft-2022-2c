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


!classDefinition: #CreditCardTest category: 'TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: 'card'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'tests' stamp: 'MV 11/7/2022 11:33:32'!
test01cardsNumberMustBe16CharactersLong

	self should: [CreditCard numbered: 1  expiringOn: (Month month: 2 year: 2024 ) ownedBy: 'Falsulio' ]
		raise: Error
		withExceptionDo: [:anError| self assert: anError messageText equals: CreditCard invalidCardNumberErrorMessage ].
		
	self should: [CreditCard numbered: 1111111111111111111111  expiringOn: (Month month: 2 year: 2024 ) ownedBy: 'Falsulio' ]
		raise: Error
		withExceptionDo: [:anError| self assert: anError messageText equals: CreditCard invalidCardNumberErrorMessage ].! !

!CreditCardTest methodsFor: 'tests' stamp: 'MV 11/7/2022 12:06:03'!
test02cardsNumberMustBeANumber

	self should: [CreditCard numbered: 'aaaaaaaaaaaaaaaa'  expiringOn: (Month month: 2 year: 2024 ) ownedBy: 'Falsulio']
		raise: Error
		withExceptionDo: [:anError| self assert: anError messageText equals: CreditCard invalidCardNumberErrorMessage].! !

!CreditCardTest methodsFor: 'tests' stamp: 'MV 11/7/2022 12:09:28'!
test03cardsNameCanNotBeEmpty

	self assertInvalidNameErrorIsRaisedWhenCreatingCardWithName: ''! !

!CreditCardTest methodsFor: 'tests' stamp: 'MV 11/7/2022 12:09:44'!
test04cardsNameCanNotBeAllSpaces

	self assertInvalidNameErrorIsRaisedWhenCreatingCardWithName: '      '! !

!CreditCardTest methodsFor: 'tests' stamp: 'MV 11/7/2022 12:10:00'!
test05cardsNameCanNotContainInvalidCharacters

	self assertInvalidNameErrorIsRaisedWhenCreatingCardWithName: '/*/-_-~'! !

!CreditCardTest methodsFor: 'tests' stamp: 'MV 11/7/2022 12:07:41'!
test06cardsExpirationMustBeAMonth

	self should: [CreditCard numbered: 1111222233334444 expiringOn: 'Pasado mañana' ownedBy: 'Clamudio']
		raise: Error
		withExceptionDo: [:anError| self assert: anError messageText equals: CreditCard invalidExpirationErrorMessage].! !


!CreditCardTest methodsFor: 'assertions' stamp: 'MV 11/7/2022 12:09:07'!
assertInvalidNameErrorIsRaisedWhenCreatingCardWithName: aNameString

	self should: [CreditCard numbered: 1111222233334444 expiringOn: (Month month: 2 year: 2024 ) ownedBy: aNameString]
		raise: Error
		withExceptionDo: [:anError| self assert: anError messageText equals: CreditCard invalidNameErrorMessage].! !


!classDefinition: #InternalRestInterfaceTest category: 'TusLibros'!
TestCase subclass: #InternalRestInterfaceTest
	instanceVariableNames: 'factory autheticator internalRestInterface clockBehaviour defaultUsername defaultPassword'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InternalRestInterfaceTest methodsFor: 'merchant processor protocol' stamp: 'MV 11/5/2022 21:08:44'!
debit: total from: creditCard 
	
	^true! !


!InternalRestInterfaceTest methodsFor: 'setUp' stamp: 'MV 11/7/2022 12:47:24'!
setUp

	factory _ StoreTestObjectsFactory new.
	autheticator _ true.
	internalRestInterface _ 	InternalRestInterface withAuthenticator: self withCatalog: factory defaultCatalog withClock: self .
	clockBehaviour _ DateAndTime now.
	defaultUsername _ 'aValidUsername'.
	defaultPassword _ 'aValidUsernamesPassword'.! !


!InternalRestInterfaceTest methodsFor: 'tests' stamp: 'MV 11/7/2022 12:47:51'!
test01createCartReturnsCartIdOfEmptyCartWithValidAuth

	|cartId| 
	
	cartId _ internalRestInterface createCartFor: defaultUsername authenticatedWith: defaultPassword.
	
	self assert: (internalRestInterface listCart: cartId) isEmpty.
	
	

	! !

!InternalRestInterfaceTest methodsFor: 'tests' stamp: 'MV 11/7/2022 12:48:01'!
test02createCartFailsWithInvalidAuth
	|cartId|
	
	autheticator _ false.
	
	cartId _ 0.
	self should:[ cartId _ internalRestInterface createCartFor: defaultUsername authenticatedWith: defaultPassword] raise: Error - MessageNotUnderstood
	withExceptionDo:[
		:anError | self assert: anError messageText equals: InternalRestInterface failedAuthenticationErrorMessage.
			       self assert: cartId equals: 0]	
	
	
	

	! !

!InternalRestInterfaceTest methodsFor: 'tests' stamp: 'MV 11/7/2022 11:19:37'!
test03createReturnsDifferentCartIdFromLastTime

	|cartId1 cartId2| 
			
	cartId1 _ 	internalRestInterface createCartFor: 'aValidUser1' authenticatedWith: 'user1Password'.
	cartId2 _ internalRestInterface createCartFor: 'aValidUser2' authenticatedWith: 'user2Password'. 
	
	self deny: (cartId1 = cartId2)

	! !

!InternalRestInterfaceTest methodsFor: 'tests' stamp: 'MV 11/7/2022 12:48:21'!
test04addToCartCorrectlyAddsSingleBookToCart

	|cartId| 
		
	cartId _ internalRestInterface createCartFor: defaultUsername authenticatedWith: defaultPassword. 
	
	internalRestInterface addToCart: cartId book: factory itemSellByTheStore ammount: 1.
	
	self assert: (internalRestInterface listCart: cartId) equals: ' ', factory itemSellByTheStore , ' 1|'.

	
	! !

!InternalRestInterfaceTest methodsFor: 'tests' stamp: 'MV 11/7/2022 12:48:49'!
test05addToCartCorrectlyAddsSeveralBooksToCart

	|cartId| 
		
	cartId _ internalRestInterface createCartFor: defaultUsername authenticatedWith: defaultPassword. 
	
	internalRestInterface addToCart: cartId book: factory itemSellByTheStore ammount: 2.
	internalRestInterface addToCart: cartId book: factory itemSellByTheStore2 ammount: 3.
	
	self assert: (internalRestInterface listCart: cartId) equals: ' ', factory itemSellByTheStore , ' 2|' , ' ', factory itemSellByTheStore2 , ' 3|'.

	
	! !

!InternalRestInterfaceTest methodsFor: 'tests' stamp: 'MV 11/7/2022 12:48:58'!
test06listCartOfEmptyCartIsEmpty

	|cartId| 
		
	cartId _ internalRestInterface createCartFor: defaultUsername authenticatedWith: defaultPassword. 
	
	self assert: (internalRestInterface listCart: cartId) isEmpty.

	
	! !

!InternalRestInterfaceTest methodsFor: 'tests' stamp: 'MV 11/7/2022 12:51:01'!
test07listCartFailsWithInvalidCartId

	self should: [internalRestInterface listCart: 666] raise: Error
	withExceptionDo:[:anError| self assert: anError messageText equals: InternalRestInterface nonExistentCartIDErrorMessage].

	
	! !

!InternalRestInterfaceTest methodsFor: 'tests' stamp: 'MV 11/7/2022 12:53:14'!
test08createCartForUnknownClientCreatesClientWithNoPurchases

	internalRestInterface createCartFor: defaultUsername authenticatedWith: defaultPassword.
	
	self assert: (internalRestInterface listPurchases: defaultUsername password: defaultPassword) equals: '0'.
	
	
	
	! !

!InternalRestInterfaceTest methodsFor: 'tests' stamp: 'MV 11/7/2022 12:53:52'!
test09listPurchasesHasCorrectTransactionAfterCheckout

	|cartId itemAmmount | 
		
	cartId _ internalRestInterface createCartFor: defaultUsername authenticatedWith: defaultPassword. 
	itemAmmount _ 1.
	
	self addToCartAndCheckout: factory itemSellByTheStore ammount: itemAmmount toCart: cartId.
	
	self assert: (internalRestInterface listPurchases: defaultUsername password: defaultPassword) 
		equals: (factory itemSellByTheStore,'|',itemAmmount asString,'|', factory itemSellByTheStorePrice asString).
	
	
	! !

!InternalRestInterfaceTest methodsFor: 'tests' stamp: 'MV 11/7/2022 12:54:20'!
test10listPurchasesHasCorrectTransactionsAfterSeveralCheckouts

	|cartId item item2 itemPrice item2Price ammount| 
		
	cartId _ internalRestInterface createCartFor: defaultUsername authenticatedWith: defaultPassword. 
	item _ factory itemSellByTheStore.
	itemPrice _ factory itemSellByTheStorePrice.
	ammount _ 2.
	
	self addToCartAndCheckout: item ammount: ammount toCart: cartId.
	
	cartId _ internalRestInterface createCartFor: defaultUsername authenticatedWith: defaultPassword. 
	item2 _ factory itemSellByTheStore2.
	item2Price _ factory itemSellByTheStore2Price.
	
	self addToCartAndCheckout: item2 ammount: ammount toCart: cartId.
	
	self assert: (internalRestInterface listPurchases: defaultUsername password: 'password')
		equals: (item,'|',ammount asString,'|', item2, '|',ammount asString,'|', (item2Price * ammount + (itemPrice * ammount))asString).
	
	
	! !

!InternalRestInterfaceTest methodsFor: 'tests' stamp: 'MV 11/7/2022 11:00:31'!
test11canNotCheckOutWithNonexistentCartID

	self should: [	internalRestInterface checkOutCart: 'Non-existent Cart ID' withCard: factory notExpiredCreditCard through: self on: Date today]
		raise: Error
		withExceptionDo: [:anError| self assert: anError messageText equals: InternalRestInterface nonExistentCartIDErrorMessage]
	
	
	
	
	! !

!InternalRestInterfaceTest methodsFor: 'tests' stamp: 'MV 11/7/2022 11:02:24'!
test12canNotListPurchasesOfNonexistentClientID
		
	self should: [internalRestInterface listPurchases: 'nonExistentClient' password: 'nonExistentClientsPassword']
		raise: Error
		withExceptionDo: [:anError| self assert: anError messageText equals: InternalRestInterface nonExistentClientErrorMessage]
	
	
	
	
	! !

!InternalRestInterfaceTest methodsFor: 'tests' stamp: 'MV 11/7/2022 11:02:27'!
test13canNotListPurchasesWithInvalidAuth
	
	autheticator _ false.
	
	self should: [internalRestInterface listPurchases: 'user1' password: 'wrongPassword']
		raise: Error
		withExceptionDo: [:anError| self assert: anError messageText equals: InternalRestInterface failedAuthenticationErrorMessage]
	
	
	
	
	! !

!InternalRestInterfaceTest methodsFor: 'tests' stamp: 'MV 11/7/2022 12:57:25'!
test14sameClientCanUseTwoCartsAtTheSameTime
	
	|cartId cart2Id item item2 itemPrice item2Price| 
		
	item _ factory itemSellByTheStore.
	itemPrice _ factory itemSellByTheStorePrice.
	item2 _ factory itemSellByTheStore2.
	item2Price _ factory itemSellByTheStore2Price.
	
	
	cartId _ internalRestInterface createCartFor: defaultUsername authenticatedWith: defaultPassword . 
	cart2Id _ internalRestInterface createCartFor: defaultUsername authenticatedWith: defaultPassword. 
	internalRestInterface addToCart: cartId book: item ammount: 2.
	internalRestInterface addToCart: cart2Id book: item2 ammount: 2.
	internalRestInterface checkOutCart: cartId withCard: factory notExpiredCreditCard through: self on: Date today.
	internalRestInterface checkOutCart: cart2Id withCard: factory notExpiredCreditCard through: self on: Date today.
	
	self assert: (internalRestInterface listPurchases: defaultUsername password: defaultPassword) 
		equals: (item,'|2|', item2, '|2|', (item2Price * 2 + (itemPrice * 2))asString).
	
	
	! !

!InternalRestInterfaceTest methodsFor: 'tests' stamp: 'MV 11/7/2022 11:15:50'!
test15canNotAddToCart30MinutesAfterLastAction
		
	self assertExpiredCartRaisesExpiredErrorWhenDoing: [:cartId| internalRestInterface addToCart: cartId book: factory itemSellByTheStore ammount: 1]
	
	! !

!InternalRestInterfaceTest methodsFor: 'tests' stamp: 'MV 11/7/2022 11:15:50'!
test16canNotListCart30MinutesAfterLastAction
	
	self assertExpiredCartRaisesExpiredErrorWhenDoing: [:cartId | internalRestInterface listCart: cartId]
	
	
	! !

!InternalRestInterfaceTest methodsFor: 'tests' stamp: 'MV 11/7/2022 11:15:50'!
test17canNotCheckOutCart30MinutesAfterLastAction
	
	self assertExpiredCartRaisesExpiredErrorWhenDoing: [:cartId | internalRestInterface checkOutCart: cartId withCard: factory notExpiredCreditCard through: self on: Date today]! !

!InternalRestInterfaceTest methodsFor: 'tests' stamp: 'MV 11/7/2022 13:33:51'!
test18addToCartExtendsCartExpiration
	
	self assertThatExpirationIsExtendedAfterDoing: [:cartId | 	internalRestInterface addToCart: cartId book: factory itemSellByTheStore ammount: 1]! !

!InternalRestInterfaceTest methodsFor: 'tests' stamp: 'MV 11/7/2022 13:34:07'!
test19ListCartExtendsCartExpiration
	
	self assertThatExpirationIsExtendedAfterDoing: [:cartId | 	internalRestInterface listCart: cartId]! !


!InternalRestInterfaceTest methodsFor: 'user authenticator protocol' stamp: 'MV 11/5/2022 20:04:35'!
canAuth: anUser withPassword: aPassword

	^autheticator value! !


!InternalRestInterfaceTest methodsFor: 'clock protocol' stamp: 'MV 11/7/2022 12:35:59'!
moveClockForwardHalfAExpirationDuration

	^ clockBehaviour _ clockBehaviour + (Duration minutes: 15)! !

!InternalRestInterfaceTest methodsFor: 'clock protocol' stamp: 'MV 11/7/2022 12:35:39'!
moveClockForwardOneExpirationDuration

	^ clockBehaviour _ clockBehaviour + (Duration minutes: 30)! !

!InternalRestInterfaceTest methodsFor: 'clock protocol' stamp: 'MV 11/7/2022 11:05:59'!
now

	^clockBehaviour! !


!InternalRestInterfaceTest methodsFor: 'assertions' stamp: 'MV 11/7/2022 12:35:39'!
assertExpiredCartRaisesExpiredErrorWhenDoing: aBlock
	
	|cartId| 
		
	cartId _ internalRestInterface createCartFor: 'manuel' authenticatedWith: 'asdsadasd'. 
	
	self moveClockForwardOneExpirationDuration.
	
	self should: [aBlock value: cartId]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError| self assert: anError messageText equals: InternalRestInterface expiredCartErrorMessage]

	
	! !

!InternalRestInterfaceTest methodsFor: 'assertions' stamp: 'MV 11/7/2022 13:44:23'!
assertThatExpirationIsExtendedAfterDoing: aBlock
	
	| cartId | 
		
	cartId _ internalRestInterface createCartFor: defaultUsername authenticatedWith: defaultPassword. 
	internalRestInterface addToCart: cartId book: factory itemSellByTheStore ammount: 1.
		
	self moveClockForwardHalfAExpirationDuration.
	
	aBlock value: cartId.
	
	self moveClockForwardHalfAExpirationDuration.
	
	internalRestInterface checkOutCart: cartId withCard: factory notExpiredCreditCard through: self on: Date today.
	
	[internalRestInterface listPurchases: defaultUsername password: 'password'. self error: 'not expiredCartErrorMessage, this is not a real error'] 
		on: Error
		do: [:anError| self deny: (anError messageText = InternalRestInterface expiredCartErrorMessage)]	
	
	! !


!InternalRestInterfaceTest methodsFor: 'auxiliary' stamp: 'MV 11/7/2022 12:45:58'!
addToCartAndCheckout: item ammount: ammount toCart: cartId

	internalRestInterface addToCart: cartId book: item ammount: ammount.
	internalRestInterface checkOutCart: cartId withCard: factory notExpiredCreditCard through: self on: Date today! !


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


!Cart methodsFor: 'initialization' stamp: 'MV 11/3/2022 20:16:41'!
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


!Cart methodsFor: 'interface - private' stamp: 'MV 11/6/2022 13:29:45'!
sendAddToPurchasesTo: anInterface ofClient: aClient
	
	^anInterface addToPurchases: items copy withTotal: self total to: aClient! !

!Cart methodsFor: 'interface - private' stamp: 'MV 11/6/2022 13:33:22'!
sendPrintListCartToInterface: anInterface
	
	^anInterface printListCart: items copy
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


!classDefinition: #Client category: 'TusLibros'!
Object subclass: #Client
	instanceVariableNames: 'id purchases total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Client methodsFor: 'initialization' stamp: 'MV 11/6/2022 12:37:53'!
initializeWithId: aClientId

	id _ aClientId.	
	purchases _ Bag new.
	total _ 0.! !


!Client methodsFor: 'interface - private' stamp: 'MV 11/6/2022 13:19:10'!
sendPurchasesToInterface: aInterface  

	^aInterface listPurchases: purchases andTotal: total.! !


!Client methodsFor: 'add purchase' stamp: 'MV 11/6/2022 12:47:45'!
addPurchase: aPurchase withTotal: aPrice

	purchases addAll: aPurchase.
	total _ total + aPrice
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Client class' category: 'TusLibros'!
Client class
	instanceVariableNames: ''!

!Client class methodsFor: 'instance creation' stamp: 'MV 11/5/2022 20:58:08'!
with: aClientId

	^self new initializeWithId: aClientId! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration cardNumber'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'MV 11/7/2022 11:35:39'!
initializeNumbered: aString expiring: aMonth ownedBy: aName  
	
	cardNumber := aString.
	expiration := aMonth.! !


!CreditCard methodsFor: 'comparing' stamp: 'MV 11/7/2022 11:34:47'!
= aCard

	^cardNumber = aCard cardNumber! !


!CreditCard methodsFor: 'accessing' stamp: 'MV 11/7/2022 11:35:22'!
cardNumber

	^cardNumber ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'MV 11/7/2022 11:33:32'!
numbered: anInteger expiringOn: aMonth ownedBy: aNameString  

	(anInteger asString size = 16 and: (anInteger isKindOf: Integer) )ifFalse: [self error: self invalidCardNumberErrorMessage].
	(self isInvalidName: aNameString) ifTrue: [self error: self invalidNameErrorMessage].
	(aMonth isKindOf: Month) ifFalse: [self error: self invalidExpirationErrorMessage].
	
	^self new initializeNumbered: anInteger expiring: aMonth ownedBy: aNameString ! !


!CreditCard class methodsFor: 'error message' stamp: 'MV 11/7/2022 11:30:38'!
invalidCardNumberErrorMessage

	^'Card number must be a 16 digits long number'! !

!CreditCard class methodsFor: 'error message' stamp: 'MV 11/7/2022 11:33:41'!
invalidExpirationErrorMessage

	^'Invalid card expiration'! !

!CreditCard class methodsFor: 'error message' stamp: 'MV 11/7/2022 11:33:54'!
invalidNameErrorMessage
	
	^'Card name can not be empty, nor contain only spaces, nor contain invalid characters'! !


!CreditCard class methodsFor: 'instance creation assertions' stamp: 'MV 11/7/2022 11:34:04'!
isInvalidName: aNameString

	^aNameString isEmpty or: (self nameIsAllSpaces: aNameString) or: (self nameContainsInvalidCharacters: aNameString)! !

!CreditCard class methodsFor: 'instance creation assertions' stamp: 'MV 11/7/2022 11:34:25'!
nameContainsInvalidCharacters: aNameString

	'/*{}+-[].,-_^?¿!!%$#"/~`' do: [:invalidCharacter| (aNameString includes: invalidCharacter) ifTrue: [^true]].
	^false.! !

!CreditCard class methodsFor: 'instance creation assertions' stamp: 'MV 11/7/2022 11:34:30'!
nameIsAllSpaces: aNameString

	^ (aNameString occurrencesOf: ' 'first) = aNameString size! !


!classDefinition: #InternalRestInterface category: 'TusLibros'!
Object subclass: #InternalRestInterface
	instanceVariableNames: 'cartIds catalog authenticator lastCartId salesBook clients cartOwners clock cartsLastUpdate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InternalRestInterface methodsFor: 'initialization' stamp: 'MV 11/6/2022 14:36:56'!
initializeWithAuthenticator: anAuthenticator withCatalog: aCatalog withClock: aClock  
	
	authenticator := anAuthenticator.
	catalog := aCatalog.
	lastCartId _ 0.
	salesBook _ OrderedCollection new.
	cartIds _ Dictionary new.
	clients _ Dictionary new.
	cartOwners _ Dictionary new.
	cartsLastUpdate _ Dictionary new.
	clock _ aClock.! !


!InternalRestInterface methodsFor: 'authentication' stamp: 'MV 11/6/2022 13:11:54'!
authenticate: aPassword withPassword: aClientID

	^ (authenticator canAuth: aClientID withPassword: aPassword) ifFalse: [self error: self class failedAuthenticationErrorMessage]! !


!InternalRestInterface methodsFor: 'list purchases -private' stamp: 'MV 11/6/2022 12:50:23'!
addToPurchases: aBagOfItems withTotal: aPrice to: aClient 

	aClient addPurchase: aBagOfItems withTotal: aPrice! !

!InternalRestInterface methodsFor: 'list purchases -private' stamp: 'MV 11/6/2022 13:17:01'!
listPurchases: aBagOfPurchases andTotal: aPrice
	
	|listOfPurchases|
	
	listOfPurchases _ ''.
	
	aBagOfPurchases sortedElements associationsDo: [:anAssociation| listOfPurchases _ listOfPurchases , anAssociation key, '|', anAssociation value asString, '|'].
	
	^listOfPurchases , aPrice asString! !


!InternalRestInterface methodsFor: 'list purchases' stamp: 'MV 11/6/2022 13:19:10'!
listPurchases: aClientID password: aPassword
	
	self authenticate: aPassword withPassword: aClientID.
	
	^(clients at: aClientID ifAbsent: [self error: self class nonExistentClientErrorMessage]) sendPurchasesToInterface: self ! !


!InternalRestInterface methodsFor: 'cart' stamp: 'MV 11/6/2022 14:07:10'!
addToCart: aCartId book: aBook ammount: anAmmount 
	
	self assertCartIsNotExpired: aCartId.
	
	(cartIds at: aCartId) add: anAmmount of: aBook.
	
	self updateCartLastUpdate: aCartId! !

!InternalRestInterface methodsFor: 'cart' stamp: 'MV 11/6/2022 14:28:50'!
checkOutCart: aCartId withCard: aCard through: aMerchantProcessor on: aDate
	
	|cashier cart|
	
	self validateCartId: aCartId.
	
	cart _ cartIds at: aCartId.
	
	cashier _ Cashier toCheckout: cart charging: aCard throught: aMerchantProcessor on: aDate registeringOn: salesBook.
	
	cart sendAddToPurchasesTo: self ofClient: (cartOwners at: aCartId).
		
	cashier checkOut.
	
	self updateCartLastUpdate: aCartId.
	
	! !

!InternalRestInterface methodsFor: 'cart' stamp: 'MV 11/6/2022 14:37:21'!
createCartFor: aClientID authenticatedWith: aPassword 
	
	|cart cartId client|
	
	self authenticate: aClientID withPassword: aPassword.
	
	client _ clients at: aClientID ifAbsent: [clients add: aClientID->(Client with: aClientID). clients at: aClientID].
	cart _ Cart acceptingItemsOf: catalog .
	cartId _ self newCartId.
	cartIds add: cartId->cart.
	cartOwners add: cartId->client.
	self updateCartLastUpdate: cartId.
		
	^cartId.! !

!InternalRestInterface methodsFor: 'cart' stamp: 'MV 11/6/2022 14:29:11'!
listCart: aCartId 
	
	self validateCartId: aCartId.
	self updateCartLastUpdate: aCartId.
	
	^(cartIds at: aCartId) sendPrintListCartToInterface: self. 
	
	
	! !

!InternalRestInterface methodsFor: 'cart' stamp: 'MV 11/6/2022 14:38:02'!
newCartId
	
	|newId|
	
	newId _ lastCartId + 1.
	lastCartId _ newId.
	^newId.! !


!InternalRestInterface methodsFor: 'cart - private' stamp: 'MV 11/6/2022 13:33:36'!
printListCart: aCollectionOfItems
	
	|returnedString|
	
	returnedString _ ''.
	
	aCollectionOfItems asBag sortedElements associationsDo: [:anAssociation| returnedString _  returnedString , ' ', anAssociation key, ' ', anAssociation value asString , '|'].
	
	^returnedString 
	
	! !


!InternalRestInterface methodsFor: 'cart validation' stamp: 'MV 11/6/2022 14:08:53'!
assertCartIsNotExpired: aCartID

	(clock now - (Duration minutes: 30)) < (cartsLastUpdate at: aCartID) ifFalse: [self error: self class expiredCartErrorMessage]! !

!InternalRestInterface methodsFor: 'cart validation' stamp: 'MV 11/6/2022 14:08:43'!
updateCartLastUpdate: aCartId

	cartsLastUpdate at: aCartId put: clock now! !

!InternalRestInterface methodsFor: 'cart validation' stamp: 'MV 11/6/2022 14:28:32'!
validateCartId: aCartId

	cartIds at: aCartId ifAbsent: [self error: self class nonExistentCartIDErrorMessage].
	self assertCartIsNotExpired: aCartId.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InternalRestInterface class' category: 'TusLibros'!
InternalRestInterface class
	instanceVariableNames: ''!

!InternalRestInterface class methodsFor: 'instance creation' stamp: 'MV 11/3/2022 20:57:49'!
failedAuthenticationErrorMessage
	^'Authentication failed: Invalid username or password'! !

!InternalRestInterface class methodsFor: 'instance creation' stamp: 'MV 11/6/2022 13:54:35'!
withAuthenticator: aRestInterfaceTest withCatalog: aCatalog withClock: aClock 
	
	^self new initializeWithAuthenticator: aRestInterfaceTest withCatalog: aCatalog withClock: aClock! !


!InternalRestInterface class methodsFor: 'error messages' stamp: 'MV 11/6/2022 14:20:52'!
expiredCartErrorMessage
	
	^'Expired cart'! !

!InternalRestInterface class methodsFor: 'error messages' stamp: 'MV 11/6/2022 12:57:44'!
nonExistentCartIDErrorMessage

	^'Non existent cart ID'! !

!InternalRestInterface class methodsFor: 'error messages' stamp: 'MV 11/6/2022 13:08:03'!
nonExistentClientErrorMessage
	
	^'Non-existent client'! !


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

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'MV 11/3/2022 21:30:13'!
itemSellByTheStore2
	
	^ 'validBook2'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'MV 11/3/2022 21:30:21'!
itemSellByTheStore2Price
	
	^10! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'MV 11/3/2022 21:30:48'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		at: self itemSellByTheStore2 put: self itemSellByTheStore2Price;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'MV 11/7/2022 11:33:32'!
expiredCreditCard
	
	^CreditCard numbered: 1111222233334444 expiringOn: (Month month: today monthIndex year: today yearNumber - 1) ownedBy: 'expiredCreditCardOwner'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'MV 11/7/2022 11:33:32'!
notExpiredCreditCard
	
	^CreditCard numbered: 1111222233334444 expiringOn: (Month month: today monthIndex year: today yearNumber + 1) ownedBy: 'notExpiredCreditCardOwner'! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
