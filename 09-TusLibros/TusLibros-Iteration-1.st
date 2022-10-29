!classDefinition: #CartTests category: 'TusLibros-Iteration-1'!
TestCase subclass: #CartTests
	instanceVariableNames: 'isbn1 book1 cartWithEmptyCatalog cartWithBook1InCatalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteration-1'!

!CartTests methodsFor: 'setUp' stamp: 'LM 10/29/2022 18:03:31'!
setUp

	isbn1 _ '0321146530'.
	book1 _ Book withIsbn: isbn1.
	cartWithEmptyCatalog _ Cart withCatalog: (OrderedCollection new).
	cartWithBook1InCatalog _ Cart withCatalog: (OrderedCollection with: isbn1)! !


!CartTests methodsFor: 'tests' stamp: 'LM 10/29/2022 17:45:37'!
test01newCartIsEmpty

	self assert: (Cart withCatalog: OrderedCollection new) isEmpty ! !

!CartTests methodsFor: 'tests' stamp: 'LM 10/29/2022 18:30:49'!
test02cartIsNotEmptyAfterAddToCart

	cartWithBook1InCatalog addToCart: book1.
	
	self deny: cartWithBook1InCatalog isEmpty! !

!CartTests methodsFor: 'tests' stamp: 'LM 10/29/2022 18:30:52'!
test03addToCartCorrectlyAddsSingleBook

	cartWithBook1InCatalog addToCart: book1.
	
	self assert: cartWithBook1InCatalog books equals: (Bag with: book1).! !

!CartTests methodsFor: 'tests' stamp: 'LM 10/29/2022 18:15:11'!
test04addToCartCorrectlyAddsManyOfTheSameBook

	cartWithBook1InCatalog addToCart: book1 amount: 2.
	 
	self assert: cartWithBook1InCatalog books equals: {book1. book1} asBag
	
	! !

!CartTests methodsFor: 'tests' stamp: 'LM 10/29/2022 18:24:48'!
test05cannotAddToCartBookThatIsNotInTheCatalog

	self should: [cartWithEmptyCatalog addToCart: book1.] raise: Error withExceptionDo: [:anError|
		
		self assert: anError messageText equals: Cart bookNotInCatalogErrorMessage. 
		self assert: cartWithEmptyCatalog isEmpty.
		]
	
	 
	
	
	! !

!CartTests methodsFor: 'tests' stamp: 'LM 10/29/2022 18:24:28'!
test06cannotAddBookWithAnAmmountLessThanOne

	self  should: [cartWithBook1InCatalog addToCart: book1 amount: 0]
		raise: Error 
		withExceptionDo: [:anError| self assert: anError messageText = Cart canNotAddLessThanOneBookErrorMessage.
								self assert: cartWithBook1InCatalog isEmpty].	
	
	! !

!CartTests methodsFor: 'tests' stamp: 'LM 10/29/2022 18:20:29'!
test07removingABookRemovesOneApparitionOfThatBook
	
	cartWithBook1InCatalog addToCart: book1 amount: 2.
	
	cartWithBook1InCatalog remove: book1.
	
	self assert: cartWithBook1InCatalog books equals: {book1} asBag.
	
	! !

!CartTests methodsFor: 'tests' stamp: 'LM 10/29/2022 18:23:45'!
test08canNotRemoveAbsentBook
	
	self should: [cartWithBook1InCatalog remove: book1.]
		raise: Error
		withExceptionDo: [:anError| 				self assert: anError messageText = Cart canNotRemoveAbsentBook.
								self assert: cartWithBook1InCatalog isEmpty]
	
	
	
	! !

!CartTests methodsFor: 'tests' stamp: 'LM 10/29/2022 18:28:25'!
test09removeAllOfABookCorrectlyRemovesAllOccurrencesOfThatBook
	
	cartWithBook1InCatalog addToCart: book1 amount: 2.
	
	cartWithBook1InCatalog removeAllOf: book1.
	
	self assert: cartWithBook1InCatalog isEmpty
	
	
	! !


!classDefinition: #Book category: 'TusLibros-Iteration-1'!
Object subclass: #Book
	instanceVariableNames: 'isbn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteration-1'!

!Book methodsFor: 'initialization' stamp: 'LM 10/29/2022 17:48:50'!
initializeWithIsbn: anIsbn


	isbn := anIsbn.! !


!Book methodsFor: 'accessing' stamp: 'VV 10/27/2022 21:18:20'!
isbn

	^isbn! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Book class' category: 'TusLibros-Iteration-1'!
Book class
	instanceVariableNames: ''!

!Book class methodsFor: 'instance creation' stamp: 'LM 10/29/2022 17:49:03'!
withIsbn: anIsbn
	
	^self new initializeWithIsbn: anIsbn! !


!classDefinition: #Cart category: 'TusLibros-Iteration-1'!
Object subclass: #Cart
	instanceVariableNames: 'booksInCart catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteration-1'!

!Cart methodsFor: 'accessing' stamp: 'LM 10/29/2022 18:16:03'!
addToCart: aLibro 
	
	(catalog includes: aLibro isbn) ifFalse: [self error: self class bookNotInCatalogErrorMessage].
	
	booksInCart add: aLibro! !

!Cart methodsFor: 'accessing' stamp: 'LM 10/29/2022 18:15:11'!
addToCart: libro amount: aNaturalNumber 
	
	(aNaturalNumber < 1) ifTrue: [self error: self class canNotAddLessThanOneBookErrorMessage].
	
	aNaturalNumber timesRepeat: [self addToCart: libro]! !

!Cart methodsFor: 'accessing' stamp: 'LM 10/29/2022 18:16:03'!
books
	
	^booksInCart! !

!Cart methodsFor: 'accessing' stamp: 'LM 10/29/2022 18:16:03'!
isEmpty

	^booksInCart isEmpty.! !


!Cart methodsFor: 'initialization' stamp: 'LM 10/29/2022 18:16:03'!
initializeWithCatalog: aCatalog 
	
	booksInCart _ Bag new.
	catalog _ aCatalog
	! !


!Cart methodsFor: 'removing' stamp: 'LM 10/29/2022 18:26:13'!
remove: book1 
	
	^booksInCart remove: book1 ifAbsent: [self error: self class canNotRemoveAbsentBook]! !

!Cart methodsFor: 'removing' stamp: 'LM 10/29/2022 18:30:00'!
removeAllOf: book1 
	
	(booksInCart occurrencesOf: book1) timesRepeat: [self remove: book1]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros-Iteration-1'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'VV 10/27/2022 21:15:29'!
withCatalog: aCatalog 
	
	^self new initializeWithCatalog: aCatalog ! !


!Cart class methodsFor: 'errorMessage' stamp: 'VV 10/27/2022 21:23:22'!
bookNotInCatalogErrorMessage
	
	^'Cannot add book that is not in catalog'! !

!Cart class methodsFor: 'errorMessage' stamp: 'LM 10/29/2022 17:57:36'!
canNotAddLessThanOneBookErrorMessage
	
	^'Can not add less than one book'! !

!Cart class methodsFor: 'errorMessage' stamp: 'LM 10/29/2022 18:25:34'!
canNotRemoveAbsentBook
	
	^'Can not remove absent book'! !
