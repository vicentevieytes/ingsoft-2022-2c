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
	instanceVariableNames: 'emptyCartWithEmptyCatalog nonExpiredCard salesBook cashier'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'setup' stamp: 'MV 10/31/2022 21:35:38'!
setUp
	emptyCartWithEmptyCatalog _ Cart acceptingItemsOf: OrderedCollection new.
	nonExpiredCard _ Card numbered: '1111 1111 1111 1111' expiring: (Month month: 1 year: 2026) ownedBy: 'Clamidio'.
	salesBook _ OrderedCollection new.
	cashier _ Cashier new. ! !


!CashierTest methodsFor: 'tests' stamp: 'MV 10/31/2022 21:35:38'!
test01checkoutOfEmptyCartThrowsAnException

	self should: [(cashier) checkout: emptyCartWithEmptyCatalog withCard: 	nonExpiredCard andRecordAt: salesBook ]
		raise: Error
		withExceptionDo: [:anError| self assert: anError messageText equals: Cashier emptyCartErrorMessage.
							   self assert: salesBook isEmpty.]! !

!CashierTest methodsFor: 'tests' stamp: 'MV 10/31/2022 21:39:41'!
test02canCorrectlyCheckoutCartWithOnlyOneBook

	|cart|
	
	cart _ Cart acceptingItemsOf:( Dictionary with: 'aValidBook'->(20*peso)).
	cart add: 'aValidBook'.
	
	cashier checkout: cart withCard: (nonExpiredCard) andRecordAt: salesBook . 
	self assert: salesBook equals: (OrderedCollection with: (OrderedCollection with: '1 of aValidBook for 20 * pesos' with: 'Total: 20 * pesos')).! !

!CashierTest methodsFor: 'tests' stamp: 'MV 10/31/2022 21:43:50'!
test03canCorrectlyCheckoutCartWithManyBooks

	|cart|
	
	cart _ Cart acceptingItemsOf:( Dictionary with: 'aValidBook1'->(20*peso) with: 'aValidBook2'->(20*peso)).
	cart add: 2 of: 'aValidBook1'.
	cart add: 'aValidBook2'.
	
	cashier checkout: cart withCard: (nonExpiredCard) andRecordAt: salesBook . 
	self assert: salesBook equals: (OrderedCollection with: (OrderedCollection with: '2 of aValidBook1 for 40 * pesos' with: '1 of aValidBook2 for 20 * pesos' with: 'Total: 60 * pesos')).! !

!CashierTest methodsFor: 'tests' stamp: 'MV 10/31/2022 21:49:20'!
test04salesBookStoresSeveralPurchases

	|cart1 cart2|
	
	cart1 _ Cart acceptingItemsOf:( Dictionary with: 'aValidBook1'->(20*peso) with: 'aValidBook2'->(20*peso)).
	cart1 add: 2 of: 'aValidBook1'.
	cart1 add: 'aValidBook2'.
	
	cart2 _ Cart acceptingItemsOf:( Dictionary with: 'aValidBook1'->(20*peso) with: 'aValidBook2'->(20*peso)).
	cart2 add: 1 of: 'aValidBook1'.
	cart2 add: 3 of: 'aValidBook2'.
	
	cashier checkout: cart1 withCard: (nonExpiredCard) andRecordAt: salesBook . 
	cashier checkout: cart2 withCard: (nonExpiredCard) andRecordAt: salesBook . 
	self assert: salesBook equals: (OrderedCollection with: (OrderedCollection with: '2 of aValidBook1 for 40 * pesos' with: '1 of aValidBook2 for 20 * pesos' with: 'Total: 60 * pesos') with: (OrderedCollection with: '1 of aValidBook1 for 20 * pesos' with: '3 of aValidBook2 for 60 * pesos' with: 'Total: 80 * pesos')).! !


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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Card class' category: 'TusLibros'!
Card class
	instanceVariableNames: ''!

!Card class methodsFor: 'instance creation' stamp: 'MV 10/31/2022 21:33:54'!
numbered: aString expiring: aMonth ownedBy: aName  

	^self new initializeNumbered: aString expiring: aMonth ownedBy: aName ! !


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


!Cart methodsFor: 'as yet unclassified' stamp: 'MV 10/31/2022 21:41:43'!
purchaseStringsForCashier: aCashier
	|purchases|
	purchases _ OrderedCollection new.
	items sortedElements associationsDo: [:anAssociation|
		purchases add: (aCashier stringLineFromItems: anAssociation priced: (catalogWIthPrices at: anAssociation key))].
	purchases add: 'Total: ', self totalPrice asString .
	^purchases.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'MV 10/31/2022 21:41:15'!
totalPrice 
	|totalPrice bookValue|
	totalPrice _ 0.
	items sortedElements associationsDo: [:anAssociation|
		bookValue _ catalogWIthPrices at: anAssociation key ifAbsent: [self error: Cashier bookNotInPriceListErrorMessage].
		totalPrice _ totalPrice + ((anAssociation value) * (bookValue))]. 
	^totalPrice ! !

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

!Cashier methodsFor: 'as yet unclassified' stamp: 'MV 10/31/2022 19:20:18'!
checkout: aCart

	! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'MV 10/31/2022 19:36:46'!
debit: total from: aCard 
	! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'MV 10/31/2022 19:37:29'!
purchaseStringFrom: aCart 
	self shouldBeImplemented.! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'MV 10/31/2022 21:46:10'!
stringLineFromItems: anAssociation priced: aPrice 
	
	^anAssociation value asString , ' of ' , anAssociation key , ' for ' , (aPrice * anAssociation value) asString .! !


!Cashier methodsFor: 'initialization' stamp: 'MV 10/31/2022 19:00:16'!
initializeWithPriceList: aDictionary 
	
	bookPrices := aDictionary.! !


!Cashier methodsFor: 'checkout' stamp: 'MV 10/31/2022 21:41:15'!
checkout: aCart withCard: aCard andRecordAt: aSalesBook

	|total|
	(aCart isEmpty) ifTrue: [^self error: self class emptyCartErrorMessage].
	total := aCart totalPrice. 
	self debit: total from: aCard.
	
	aSalesBook add: (aCart purchaseStringsForCashier: self).! !


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


!Cashier class methodsFor: 'errorMessage' stamp: 'MV 10/31/2022 19:22:18'!
bookNotInPriceListErrorMessage
	
	^'Can not checkout items that are not in the price list'! !
