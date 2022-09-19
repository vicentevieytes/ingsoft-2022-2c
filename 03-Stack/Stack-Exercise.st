!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'sentenceFinder aStack aStackBackup winter_is_coming Winter_is_here winning_is_everything The_winds_of_Winter'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'LM 9/19/2022 11:54:03'!
test01EmptyStackReturnsEmptyCollection

	self assert: (sentenceFinder selectElementsContainingPrefix: 'Wint' inStack: OOStack new) 
		 equals: OrderedCollection new.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'VV 9/19/2022 15:37:38'!
test02OneSentenceWithPrefixReturnsSentence

	aStack push: Winter_is_here.
		
	self assert: (sentenceFinder selectElementsContainingPrefix: 'Wint' inStack: aStack) 
		 equals: {Winter_is_here} asOrderedCollection.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'VV 9/19/2022 15:52:53'!
test03OneSentenceWithoutPrefixReturnsEmptyCollection

	aStack push: 'asd' , Winter_is_here.
		
	self assert: (sentenceFinder selectElementsContainingPrefix: 'Wint' inStack: aStack)
		 equals: OrderedCollection new.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'VV 9/19/2022 15:38:37'!
test04LowercaseSentenceWithUppercasePrefixReturnsEmptyCollection

	aStack push: winter_is_coming.
		
	self assert: (sentenceFinder selectElementsContainingPrefix: 'Wint' inStack: aStack)
		 equals: OrderedCollection new.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'VV 9/19/2022 15:39:27'!
test05UppercaseSentenceWithLowercasePrefixReturnsEmptyCollection

	aStack push: Winter_is_here.	
		
	self assert: (sentenceFinder selectElementsContainingPrefix: 'wint' inStack: aStack)
		 equals: OrderedCollection new.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'VV 9/19/2022 15:41:19'!
test06OneSentenceWithPrefixAtTheBottomOfTheStack
	self pushCollectionToStack: {Winter_is_here. winter_is_coming. winning_is_everything. The_winds_of_Winter} asOrderedCollection.
	
	self assert: (sentenceFinder selectElementsContainingPrefix: 'Wint' inStack: aStack)
		 equals: {Winter_is_here } asOrderedCollection.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'VV 9/19/2022 15:42:52'!
test07OneSentenceWithPrefixAtTheMiddleOfTheStack
	self pushCollectionToStack: {winter_is_coming. Winter_is_here.  winning_is_everything. The_winds_of_Winter} asOrderedCollection.
	self assert: (sentenceFinder selectElementsContainingPrefix: 'Wint' inStack: aStack)
		 equals: {Winter_is_here} asOrderedCollection.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'VV 9/19/2022 15:44:22'!
test08OneSentenceWithPrefixAtTheTopOfTheStack
	self pushCollectionToStack: {winter_is_coming. winning_is_everything. The_winds_of_Winter. Winter_is_here.  } asOrderedCollection.
	
	self assert: (sentenceFinder selectElementsContainingPrefix: 'Wint' inStack: aStack)
		 equals: {Winter_is_here} asOrderedCollection.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'VV 9/19/2022 15:45:33'!
test09OneSentenceWithoutPrefixAndTwoWithPrefix
	self pushCollectionToStack: {winter_is_coming. winning_is_everything. The_winds_of_Winter. Winter_is_here.  } asOrderedCollection.
	
	self assert: (sentenceFinder selectElementsContainingPrefix: 'win' inStack: aStack) 
		 equals: {winter_is_coming. winning_is_everything} asOrderedCollection.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'VV 9/19/2022 15:46:18'!
test10FourSentencesWithoutPrefixReturnsEmptyCollection
	self pushCollectionToStack: {winter_is_coming. winning_is_everything. The_winds_of_Winter. Winter_is_here.}.
		
	self assert: (sentenceFinder selectElementsContainingPrefix: 'Fan' inStack: aStack) equals: OrderedCollection new.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'VV 9/19/2022 15:46:56'!
test11SameSentenceTwiceWithPrefixReturnsSentenceTwice
	self pushCollectionToStack: {winter_is_coming. winning_is_everything. The_winds_of_Winter. Winter_is_here. Winter_is_here}.
	
		
	self assert: (sentenceFinder selectElementsContainingPrefix: 'Wint' inStack: aStack)
		 equals: {Winter_is_here. Winter_is_here} asOrderedCollection .! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'LM 9/19/2022 12:05:30'!
test12EmptyPrefixShouldFail

	self
		should: [ sentenceFinder selectElementsContainingPrefix: '' inStack: aStack]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixCannotBeEmptyErrorDescription ]	
! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'LM 9/19/2022 12:05:30'!
test13PrefixWithSpacesShouldFail

	self
		should: [ sentenceFinder selectElementsContainingPrefix: 'w in' inStack: aStack]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixCannotHaveEmptySpacesErrorDescription ]	
! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'VV 9/19/2022 15:52:05'!
test14StackIsRestoredCorrectly

	
	self pushCollectionToStack: {winter_is_coming . winning_is_everything . Winter_is_here} asOrderedCollection .
	self pushCollectionToBackupStack: {winter_is_coming. winning_is_everything . Winter_is_here .}.
	sentenceFinder selectElementsContainingPrefix: 'Win' inStack: aStack.
	
	self assertStack: aStack equalsStack: aStackBackup.
	! !


!SentenceFinderByPrefixTest methodsFor: 'setUp' stamp: 'VV 9/19/2022 15:50:58'!
pushCollectionToBackupStack: aCollection

	aCollection do: [:each  | aStackBackup push: each]! !

!SentenceFinderByPrefixTest methodsFor: 'setUp' stamp: 'VV 9/19/2022 15:30:47'!
pushCollectionToStack: aCollection

	aCollection do: [:each  | aStack push: each]! !

!SentenceFinderByPrefixTest methodsFor: 'setUp' stamp: 'VV 9/19/2022 15:50:36'!
setUp

	sentenceFinder := SentenceFinderByPrefix new.
	aStack := OOStack new.
	aStackBackup := OOStack new.
	winter_is_coming := 'winter is coming'.
	Winter_is_here := 'Winter is here'.
	winning_is_everything := 'winning is everything'.
	The_winds_of_Winter := 'The winds of winter'
! !


!SentenceFinderByPrefixTest methodsFor: 'assertions' stamp: 'LM 9/19/2022 11:32:46'!
assertStack: anOOStack equalsStack: anOOStack2 
	
	[anOOStack isEmpty] whileFalse: [
		anOOStack pop ~= anOOStack2 pop ifTrue: [self error: self class stackNotRestoredCorrectlyErrorDescription]
	].
	anOOStack2 isEmpty ifFalse: [self error: self class stackNotRestoredCorrectlyErrorDescription]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefixTest class' category: 'Stack-Exercise'!
SentenceFinderByPrefixTest class
	instanceVariableNames: ''!

!SentenceFinderByPrefixTest class methodsFor: 'as yet unclassified' stamp: 'LM 9/19/2022 11:19:09'!
stackNotRestoredCorrectlyErrorDescription

	^'The Stack was not restored correctly'! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'stackTop size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialize' stamp: 'LM 9/18/2022 20:43:43'!
initialize

	stackTop:= OOStackNullElement new.
	size := 0! !


!OOStack methodsFor: 'stack operations' stamp: 'LM 9/17/2022 19:49:09'!
isEmpty
	
	^size = 0! !

!OOStack methodsFor: 'stack operations' stamp: 'LM 9/17/2022 19:27:05'!
pop

	|first|
	
	first := self top.	
	stackTop := stackTop previous.
	size := size - 1.
	^first! !

!OOStack methodsFor: 'stack operations' stamp: 'LM 9/17/2022 19:26:49'!
push: anElement

	stackTop := OOStackElement new in: self withValue: anElement.
	size := size + 1.
	! !

!OOStack methodsFor: 'stack operations' stamp: 'LM 9/17/2022 19:26:41'!
size
	
	 ^size.! !

!OOStack methodsFor: 'stack operations' stamp: 'LM 9/17/2022 19:23:22'!
top
	
	^stackTop elementValue! !


!OOStack methodsFor: 'stack operations - private' stamp: 'LM 9/17/2022 19:30:47'!
stackTop
	
	^stackTop! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/16/2021 17:39:43'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #OOStackElement category: 'Stack-Exercise'!
Object subclass: #OOStackElement
	instanceVariableNames: 'elementValue previous'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackElement methodsFor: 'stack operations' stamp: 'LM 9/18/2022 20:44:43'!
isEmpty
	
	^false! !


!OOStackElement methodsFor: 'stack element operations' stamp: 'LM 9/17/2022 19:13:28'!
elementValue

	^elementValue! !

!OOStackElement methodsFor: 'stack element operations' stamp: 'LM 9/17/2022 19:25:33'!
previous
	
	^previous! !


!OOStackElement methodsFor: 'initialize' stamp: 'LM 9/17/2022 19:30:59'!
in: aStack withValue: aValue

	previous := aStack stackTop.
	elementValue := aValue.! !


!classDefinition: #OOStackNullElement category: 'Stack-Exercise'!
Object subclass: #OOStackNullElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackNullElement methodsFor: 'stack operations' stamp: 'LM 9/18/2022 20:45:04'!
isEmpty
	
	^true! !


!OOStackNullElement methodsFor: 'stack element operations' stamp: 'LM 9/17/2022 19:55:27'!
elementValue

	^self error: self class stackEmptyErrorDescription.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackNullElement class' category: 'Stack-Exercise'!
OOStackNullElement class
	instanceVariableNames: ''!

!OOStackNullElement class methodsFor: 'as yet unclassified' stamp: 'LM 9/17/2022 19:55:20'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'backupStack foundSentences'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'initialize' stamp: 'LM 9/17/2022 20:16:42'!
initialize

		backupStack := OOStack new.
		foundSentences := OrderedCollection new.! !


!SentenceFinderByPrefix methodsFor: 'assertions' stamp: 'LM 9/19/2022 10:50:04'!
assertValidPrefix: aPrefix

	aPrefix isEmpty ifTrue: [self error: self class prefixCannotBeEmptyErrorDescription].
	((aPrefix findString: ' ' startingAt: 0) > 0 ) ifTrue: [self error: self class prefixCannotHaveEmptySpacesErrorDescription ]! !


!SentenceFinderByPrefix methodsFor: 'find' stamp: 'LM 9/17/2022 20:29:59'!
restaurarStack: aStack

	backupStack isEmpty ifTrue: [^self].
	aStack push: backupStack pop.
	self restaurarStack: aStack.! !

!SentenceFinderByPrefix methodsFor: 'find' stamp: 'LM 9/19/2022 11:35:44'!
selectElementsContainingPrefix: aPrefix inStack: aStack

	|top|
	
	self assertValidPrefix: aPrefix.
	
	aStack isEmpty ifTrue: [
		self restaurarStack: aStack.
		^foundSentences
		].
	top := aStack pop.
	backupStack push: top.
	(top beginsWith: aPrefix) ifTrue: [foundSentences addFirst: top].
	^self selectElementsContainingPrefix: aPrefix inStack: aStack.
	
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'VV 9/18/2022 21:37:05'!
prefixCannotBeEmptyErrorDescription

	^'Prefix cannot be an empty string!!!!!!'! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'VV 9/18/2022 21:37:24'!
prefixCannotHaveEmptySpacesErrorDescription

	^'Prefix cannot have empty spaces!!!!!!'! !
