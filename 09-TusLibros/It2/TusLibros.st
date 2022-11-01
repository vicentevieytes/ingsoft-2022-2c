!classDefinition: #CardTest category: 'TusLibros'!
TestCase subclass: #CardTest
	instanceVariableNames: 'card'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CardTest methodsFor: 'as yet unclassified' stamp: 'MV 10/31/2022 23:51:30'!
setUp! !

!CardTest methodsFor: 'as yet unclassified' stamp: 'MV 11/1/2022 00:27:02'!
test01cardsNumberMustBe16CharactersLong

	self should: [Card numbered: '1'  expiring: (Month month: 2 year: 2024 ) ownedBy: 'Falsulio' ]
		raise: Error
		withExceptionDo: [:anError| self assert: anError messageText equals: Card invalidCardNumberErrorMessage ].
		
	self should: [Card numbered: '1111111111111111111111'  expiring: (Month month: 2 year: 2024 ) ownedBy: 'Falsulio' ]
		raise: Error
		withExceptionDo: [:anError| self assert: anError messageText equals: Card invalidCardNumberErrorMessage ].! !

!CardTest methodsFor: 'as yet unclassified' stamp: 'MV 11/1/2022 00:28:48'!
test02cardsNumberMustBeAllDigits

	self should: [Card numbered: 'aaaaaaaaaaaaaaaa'  expiring: (Month month: 2 year: 2024 ) ownedBy: 'Falsulio']
		raise: Error
		withExceptionDo: [:anError| self assert: anError messageText equals: Card invalidCardNumberErrorMessage].! !

!CardTest methodsFor: 'as yet unclassified' stamp: 'MV 11/1/2022 00:38:16'!
test03cardsNameCanNotBeEmpty

	self should: [Card numbered: 1111222233334444 expiring: (Month month: 2 year: 2024 ) ownedBy: '']
		raise: Error
		withExceptionDo: [:anError| self assert: anError messageText equals: Card invalidNameErrorMessage].! !

!CardTest methodsFor: 'as yet unclassified' stamp: 'MV 11/1/2022 00:38:16'!
test04cardsNameCanNotBeAllSpaces

	self should: [Card numbered: 1111222233334444 expiring: (Month month: 2 year: 2024 ) ownedBy: '    ']
		raise: Error
		withExceptionDo: [:anError| self assert: anError messageText equals: Card invalidNameErrorMessage].! !

!CardTest methodsFor: 'as yet unclassified' stamp: 'MV 11/1/2022 00:58:37'!
test05cardsNameCanNotContainInvalidCharacters

	self should: [Card numbered: 1111222233334444 expiring: (Month month: 2 year: 2024 ) ownedBy: '/*/-_-~']
		raise: Error
		withExceptionDo: [:anError| self assert: anError messageText equals: Card invalidNameErrorMessage].! !


!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'MV 10/31/2022 21:20:59'!
defaultCatalog
	
	^ Dictionary with: (self itemSellByTheStore)->(1*peso).! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'nonExpiredCard salesBook cashier cart1 cart2'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'setup' stamp: 'MV 11/1/2022 00:31:55'!
setUp
	
	cart1 _ self createCart.
	cart2 _ self createCart.
	nonExpiredCard _ Card numbered: 1111222233334444 expiring: (Month month: 1 year: 2026) ownedBy: 'Clamidio'.
	salesBook _ OrderedCollection new.
	cashier _ Cashier new. ! !


!CashierTest methodsFor: 'tests' stamp: 'MV 10/31/2022 23:45:07'!
test01checkoutOfEmptyCartThrowsAnException

	self should: [cashier checkout: cart1 withCard: 	nonExpiredCard andRecordAt: salesBook ]
		raise: Error
		withExceptionDo: [:anError| self assert: anError messageText equals: Cashier emptyCartErrorMessage.
							   self assert: salesBook isEmpty.]! !

!CashierTest methodsFor: 'tests' stamp: 'MV 10/31/2022 23:45:07'!
test02canCorrectlyCheckoutCartWithOnlyOneBook

	cart1 add: 'aValidBook1'.
	
	cashier checkout: cart1 withCard: (nonExpiredCard) andRecordAt: salesBook . 
	self assert: salesBook equals: (OrderedCollection with: (OrderedCollection with: '1 of aValidBook1 for 20 * pesos' with: 'Total: 20 * pesos')).! !

!CashierTest methodsFor: 'tests' stamp: 'MV 10/31/2022 23:45:07'!
test03canCorrectlyCheckoutCartWithManyBooks

	cart1 add: 2 of: 'aValidBook1'.
	cart1 add: 'aValidBook2'.
	
	cashier checkout: cart1 withCard: (nonExpiredCard) andRecordAt: salesBook . 
	self assert: salesBook equals: (OrderedCollection with: (OrderedCollection with: '2 of aValidBook1 for 40 * pesos' with: '1 of aValidBook2 for 20 * pesos' with: 'Total: 60 * pesos')).! !

!CashierTest methodsFor: 'tests' stamp: 'MV 10/31/2022 23:46:49'!
test04salesBookStoresSeveralPurchases

	cart1 add: 2 of: 'aValidBook1'.
	cart1 add: 'aValidBook2'.
	
	cart2 add: 1 of: 'aValidBook1'.
	cart2 add: 3 of: 'aValidBook2'.
	
	cashier checkout: cart1 withCard: (nonExpiredCard) andRecordAt: salesBook . 
	cashier checkout: cart2 withCard: (nonExpiredCard) andRecordAt: salesBook . 
	
	self assert: salesBook equals: (OrderedCollection with: (OrderedCollection with: '2 of aValidBook1 for 40 * pesos' with: '1 of aValidBook2 for 20 * pesos' with: 'Total: 60 * pesos') with: (OrderedCollection with: '1 of aValidBook1 for 20 * pesos' with: '3 of aValidBook2 for 60 * pesos' with: 'Total: 80 * pesos')).! !

!CashierTest methodsFor: 'tests' stamp: 'MV 11/1/2022 00:32:00'!
test05canNotCheckOutWithExpiredCard

	|expiredCard|
	
	expiredCard _ Card numbered: 1111222233334444 expiring: (Month month: 1 year: 2001) ownedBy: 'Clamidio'.
	cart1 add: 'aValidBook1'.
	
	self should: [cashier checkout: cart1 withCard: (expiredCard) andRecordAt: salesBook]
		raise: Error
		withExceptionDo: [:anError| 
								self assert: anError messageText equals: Cashier expiredCardErrorMessage.
								self assert: salesBook isEmpty]

! !


!CashierTest methodsFor: 'support' stamp: 'MV 10/31/2022 23:45:34'!
createCart

	^ Cart acceptingItemsOf:( Dictionary with: 'aValidBook1'->(20*peso) with: 'aValidBook2'->(20*peso))! !


!classDefinition: #MPInterfaceTest category: 'TusLibros'!
TestCase subclass: #MPInterfaceTest
	instanceVariableNames: 'cart nonExpiredCard salesBook cashier validCardWithNoCredit validStolenCard expiredStolenCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MPInterfaceTest methodsFor: 'support' stamp: 'MV 11/1/2022 01:18:09'!
createCart

	^ Cart acceptingItemsOf:( Dictionary with: 'aValidBook1'->(20*peso) with: 'aValidBook2'->(20*peso))! !


!MPInterfaceTest methodsFor: 'setUp' stamp: 'MV 11/1/2022 01:43:07'!
setUp
	
	cart _ self createCart.
	nonExpiredCard _ Card numbered: 1111222233334444 expiring: (Month month: 1 year: 2026) ownedBy: 'Clamidio'.
	validCardWithNoCredit _ Card numbered: 6666999966669999 expiring: (Month month: 1 year: 2026) ownedBy: 'Ignatius J R'.
	validStolenCard _ Card numbered: 1234567891234567 expiring: (Month month: 1 year: 2026) ownedBy: 'Elsa Payo'.
	expiredStolenCard _ Card numbered: 6666999966669999 expiring: (Month month: 1 year: 2003) ownedBy: 'Elsa Payo'.
	salesBook _ OrderedCollection new.
	cashier _ Cashier new. ! !


!MPInterfaceTest methodsFor: 'tests' stamp: 'MV 11/1/2022 01:39:30'!
test01canNotDebitIfCardHasNoCredit

	cart add: 'aValidBook1'.
	self should: [cashier checkout: cart withCard: validCardWithNoCredit andRecordAt: salesBook]
		raise: Error
		withExceptionDo: [:anError| self assert: anError messageText equals: MPInterface noCreditErrorMessage.
							   self assert: salesBook isEmpty]	
	! !

!MPInterfaceTest methodsFor: 'tests' stamp: 'MV 11/1/2022 01:39:26'!
test02canNotDebitIfCardIsStolen

	cart add: 'aValidBook1'.
	self should: [cashier checkout: cart withCard: validStolenCard andRecordAt: salesBook]
		raise: Error
		withExceptionDo: [:anError| self assert: anError messageText equals: MPInterface stolenCardErrorMessage.
							   self assert: salesBook isEmpty]	
	! !

!MPInterfaceTest methodsFor: 'tests' stamp: 'MV 11/1/2022 01:39:22'!
test03canDebitIfCardIsNotStolenAndItHasCredit

	cart add: 'aValidBook1'.
	cashier checkout: cart withCard: nonExpiredCard andRecordAt: salesBook.
	
	self deny: salesBook isEmpty
	! !

!MPInterfaceTest methodsFor: 'tests' stamp: 'MV 11/1/2022 01:42:40'!
test04MPInterfaceIsNotContactedIfCardIsExpired

	cart add: 'aValidBook1'.
	
	self should: [cashier checkout: cart withCard: expiredStolenCard andRecordAt: salesBook.]
		raise: Error
		withExceptionDo: [:anError| self assert: anError messageText equals: Cashier expiredCardErrorMessage]
	! !


!classDefinition: #Card category: 'TusLibros'!
Object subclass: #Card
	instanceVariableNames: 'cardNumber expiringMonth'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Card methodsFor: 'initialization' stamp: 'MV 10/31/2022 21:32:47'!
initializeNumbered: aString expiring: aMonth ownedBy: aName  
	
	cardNumber := aString.
	expiringMonth := aMonth.! !


!Card methodsFor: 'accessing' stamp: 'MV 11/1/2022 01:32:58'!
cardNumber

	^cardNumber ! !

!Card methodsFor: 'accessing' stamp: 'MV 11/1/2022 00:12:27'!
isExpiredOn: aDate 
	
	^(Date year: expiringMonth yearNumber month: expiringMonth monthIndex day: 1) < aDate! !


!Card methodsFor: 'as yet unclassified' stamp: 'MV 11/1/2022 01:35:02'!
= aCard

	^cardNumber = aCard cardNumber! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Card class' category: 'TusLibros'!
Card class
	instanceVariableNames: ''!

!Card class methodsFor: 'instance creation' stamp: 'MV 11/1/2022 00:54:55'!
numbered: anInteger expiring: aMonth ownedBy: aNameString  

	(anInteger asString size = 16 and: (anInteger isKindOf: Integer) )ifFalse: [self error: self invalidCardNumberErrorMessage].
	(self isInvalidName: aNameString) ifTrue: [self error: self invalidNameErrorMessage].
	
	^self new initializeNumbered: anInteger expiring: aMonth ownedBy: aNameString ! !


!Card class methodsFor: 'error message' stamp: 'MV 11/1/2022 00:35:09'!
invalidCardNumberErrorMessage

	^'Card number must be a 16 digits long number'! !

!Card class methodsFor: 'error message' stamp: 'MV 11/1/2022 00:38:52'!
invalidNameErrorMessage
	
	^'Card name can not be empty, nor contain only spaces, nor contain invalid characters'! !


!Card class methodsFor: 'as yet unclassified' stamp: 'MV 11/1/2022 00:54:42'!
isInvalidName: aNameString

	^aNameString isEmpty or: (self nameIsAllSpaces: aNameString) or: (self nameContainsInvalidCharacters: aNameString)! !

!Card class methodsFor: 'as yet unclassified' stamp: 'MV 11/1/2022 00:59:47'!
nameContainsInvalidCharacters: aNameString

	'/*{}+-[].,-_^?¿!!%$#"/~`' do: [:invalidCharacter| (aNameString includes: invalidCharacter) ifTrue: [^true]].
	^false.! !

!Card class methodsFor: 'as yet unclassified' stamp: 'MV 11/1/2022 00:52:24'!
nameIsAllSpaces: aNameString

	^ (aNameString occurrencesOf: ' 'first) = aNameString size! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalogWIthPrices items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'MV 10/31/2022 21:30:58'!
assertIsValidItem: anItem

	(catalogWIthPrices keys includes: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'MV 10/31/2022 21:30:58'!
initializeAcceptingItemsOf: aCatalog

	catalogWIthPrices := aCatalog.
	items := Bag new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'price' stamp: 'MV 10/31/2022 21:41:15'!
totalPrice 
	|totalPrice bookValue|
	totalPrice _ 0.
	items sortedElements associationsDo: [:anAssociation|
		bookValue _ catalogWIthPrices at: anAssociation key ifAbsent: [self error: Cashier bookNotInPriceListErrorMessage].
		totalPrice _ totalPrice + ((anAssociation value) * (bookValue))]. 
	^totalPrice ! !


!Cart methodsFor: 'printing - private' stamp: 'MV 10/31/2022 23:49:14'!
purchaseStringsForCashier: aCashier
	
	|purchases|
	
	purchases _ OrderedCollection new.
	items sortedElements associationsDo: [:anAssociation|
		purchases add: (aCashier stringLineFromItems: anAssociation priced: (catalogWIthPrices at: anAssociation key))].
	purchases add: 'Total: ', self totalPrice asString .
	^purchases.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'bookPrices salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'MV 10/31/2022 19:00:16'!
initializeWithPriceList: aDictionary 
	
	bookPrices := aDictionary.! !


!Cashier methodsFor: 'checkout' stamp: 'MV 11/1/2022 01:24:28'!
checkout: aCart withCard: aCard andRecordAt: aSalesBook

	|total|
	
	(aCart isEmpty) ifTrue: [^self error: self class emptyCartErrorMessage].
	(aCard isExpiredOn: Date today) ifTrue: [^self error: self class expiredCardErrorMessage ].
	
	total := aCart totalPrice. 
	MPInterface new debit: total from: aCard.
	
	aSalesBook add: (aCart purchaseStringsForCashier: self).! !


!Cashier methodsFor: 'printing' stamp: 'MV 10/31/2022 21:46:10'!
stringLineFromItems: anAssociation priced: aPrice 
	
	^anAssociation value asString , ' of ' , anAssociation key , ' for ' , (aPrice * anAssociation value) asString .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'MV 10/31/2022 18:21:44'!
emptyCartErrorMessage
	
	^'Can not checkout an empty cart'! !


!Cashier class methodsFor: 'accessing' stamp: 'MV 10/31/2022 18:22:07'!
purchases
	^OrderedCollection new.! !


!Cashier class methodsFor: 'instance creation' stamp: 'MV 10/31/2022 18:59:16'!
withPriceList: aDictionary 

	^self new initializeWithPriceList: aDictionary ! !


!Cashier class methodsFor: 'error message' stamp: 'MV 10/31/2022 19:22:18'!
bookNotInPriceListErrorMessage
	
	^'Can not checkout items that are not in the price list'! !

!Cashier class methodsFor: 'error message' stamp: 'MV 10/31/2022 23:58:04'!
expiredCardErrorMessage
	
	^'Can not do checkout with expired card'! !


!classDefinition: #MPInterface category: 'TusLibros'!
Object subclass: #MPInterface
	instanceVariableNames: 'stolenCards cardsWithNoCredit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MPInterface methodsFor: 'debit' stamp: 'MV 11/1/2022 01:40:21'!
debit: total from: aCard 
	
	(stolenCards includes: aCard) ifTrue: [self error: self class stolenCardErrorMessage].
	(cardsWithNoCredit includes: aCard) ifTrue: [self error: self class noCreditErrorMessage].! !


!MPInterface methodsFor: 'initialization' stamp: 'MV 11/1/2022 01:31:31'!
initialize

	cardsWithNoCredit _ OrderedCollection with: (Card numbered: 6666999966669999 expiring: (Month month: 1 year: 2026) ownedBy: 'Ignatius J R').
	stolenCards _ OrderedCollection with: (Card numbered: 1234567891234567 expiring: (Month month: 1 year: 2026) ownedBy: 'Elsa Payo').! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MPInterface class' category: 'TusLibros'!
MPInterface class
	instanceVariableNames: ''!

!MPInterface class methodsFor: 'error message' stamp: 'MV 11/1/2022 01:35:51'!
noCreditErrorMessage
	
	^'Card has no credit'! !

!MPInterface class methodsFor: 'error message' stamp: 'MV 11/1/2022 01:36:38'!
stolenCardErrorMessage

	^'Card is a stolen card'! !
