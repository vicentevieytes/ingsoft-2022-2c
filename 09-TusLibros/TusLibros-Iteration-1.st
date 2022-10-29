!classDefinition: #CartTests category: 'TusLibros-Iteration-1'!
TestCase subclass: #CartTests
	instanceVariableNames: 'isbn1'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteration-1'!

!CartTests methodsFor: 'as yet unclassified' stamp: 'VV 10/27/2022 21:40:24'!
setUp

	isbn1 _ '0321146530'! !

!CartTests methodsFor: 'as yet unclassified' stamp: 'VV 10/27/2022 21:37:43'!
test01newCarritoIsEmpty

	self assert: (Cart withCatalog: OrderedCollection new) isEmpty ! !

!CartTests methodsFor: 'as yet unclassified' stamp: 'VV 10/27/2022 21:40:45'!
test02addToCartCorrectlyAddsSingleBook

	|carrito libro|
	
	carrito _ Cart withCatalog: (OrderedCollection with: isbn1).
	libro _ Book isbn: isbn1.
	
	carrito addToCart: libro.
	self assert: carrito libros equals: (OrderedCollection with: libro).! !

!CartTests methodsFor: 'as yet unclassified' stamp: 'VV 10/27/2022 21:41:08'!
test03cannotAddToCartBookThatIsNotInTheCatalog

	|carrito libro|
	
	carrito _ Cart withCatalog:(OrderedCollection new).
	
	libro _ Book isbn: isbn1.
	
	[carrito addToCart: libro. self fail.] on: Error do: [:anError|
		
		self assert: anError messageText equals: Cart bookNotInCatalogErrorMessage. 
		self assert: carrito isEmpty.
		]
	
	 
	
	
	! !

!CartTests methodsFor: 'as yet unclassified' stamp: 'VV 10/27/2022 21:41:17'!
test04addToCartCorrectlyAddsManyOfTheSameBook

	|carrito libro|
	
	carrito _ Cart withCatalog:(OrderedCollection with: isbn1).
	
	libro _ Book isbn: isbn1.
	
	carrito addToCart: libro ammount: 2.
	 
	self assert: carrito libros equals: {libro. libro} asOrderedCollection.
	
	! !

!CartTests methodsFor: 'as yet unclassified' stamp: 'VV 10/27/2022 21:47:15'!
test05addToCatalogAllowsCartToAddNewBookInCatalog

	|carrito libro|
	
	carrito _ Cart withCatalog:(OrderedCollection new).
	libro _ Book isbn: isbn1.
	carrito addToCatalog: libro isbn.
	
	self assert: (carrito addToCart: libro)	 libros equals: {libro} asOrderedCollection.
	
	! !

!CartTests methodsFor: 'as yet unclassified' stamp: 'VV 10/27/2022 21:52:30'!
test05addToCatalogOfInvalidIsbnRaisesError

	|carrito libro|
	
	carrito _ Cart withCatalog:(OrderedCollection new).
	
	
	! !


!classDefinition: #Book category: 'TusLibros-Iteration-1'!
Object subclass: #Book
	instanceVariableNames: 'isbn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteration-1'!

!Book methodsFor: 'initialization' stamp: 'VV 10/27/2022 21:02:13'!
initializeIsbn: anIsbn


	isbn := anIsbn.! !


!Book methodsFor: 'accessing' stamp: 'VV 10/27/2022 21:18:20'!
isbn

	^isbn! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Book class' category: 'TusLibros-Iteration-1'!
Book class
	instanceVariableNames: ''!

!Book class methodsFor: 'instance creation' stamp: 'VV 10/27/2022 21:01:49'!
isbn: anIsbn
	
	^self new initializeIsbn: anIsbn! !


!classDefinition: #Cart category: 'TusLibros-Iteration-1'!
Object subclass: #Cart
	instanceVariableNames: 'libros catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteration-1'!

!Cart methodsFor: 'accessing' stamp: 'VV 10/27/2022 21:22:41'!
addToCart: aLibro 
	
	(catalog includes: aLibro isbn) ifFalse: [self error: self class bookNotInCatalogErrorMessage].
	libros add: aLibro! !

!Cart methodsFor: 'accessing' stamp: 'VV 10/27/2022 21:34:12'!
addToCart: libro ammount: aNaturalNumber 
	
	aNaturalNumber timesRepeat: [self addToCart: libro]! !

!Cart methodsFor: 'accessing' stamp: 'VV 10/27/2022 21:44:11'!
addToCatalog: anIsbn 
	
	catalog add: anIsbn.! !

!Cart methodsFor: 'accessing' stamp: 'VV 10/27/2022 20:52:58'!
isEmpty

	^true.! !

!Cart methodsFor: 'accessing' stamp: 'VV 10/27/2022 21:04:26'!
libros
	
	^libros! !


!Cart methodsFor: 'initialization' stamp: 'VV 10/27/2022 21:49:40'!
initializeWithCatalog: aCatalog 
	
	libros := OrderedCollection new.
	catalog _ OrderedCollection new.
	aCatalog do: [:anIsbn| self addToCatalog: anIsbn ].
	! !

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
