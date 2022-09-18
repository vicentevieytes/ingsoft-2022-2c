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
	instanceVariableNames: 'sentenceFinder'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'LM 9/17/2022 20:36:08'!
test01Ejemplo

	|aStack anOrderedCollection|

	aStack := OOStack new.
	aStack push: 'winter is coming'.
	aStack push: 'winning is everything'.
	aStack push: 'The winds of Winter'.
	aStack push: 'Winter is here'.
	
	anOrderedCollection := OrderedCollection new.
	anOrderedCollection addFirst: 'Winter is here'.
		
	self assert: (sentenceFinder find: 'Wint' in: aStack) equals: anOrderedCollection.! !


!SentenceFinderByPrefixTest methodsFor: 'setUp' stamp: 'LM 9/17/2022 20:33:50'!
setUp

	sentenceFinder := SentenceFinderByPrefix new.! !


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


!SentenceFinderByPrefix methodsFor: 'find' stamp: 'LM 9/17/2022 20:38:53'!
find: aPrefix in: aStack

	|top|
	
	aStack isEmpty ifTrue: [
		self restaurarStack: aStack.
		^foundSentences
		].
	top := aStack pop.
	backupStack push: top.
	(top beginsWith: aPrefix) ifTrue: [foundSentences addFirst: top].
	^self find: aPrefix in: aStack.
	! !

!SentenceFinderByPrefix methodsFor: 'find' stamp: 'LM 9/17/2022 20:29:59'!
restaurarStack: aStack

	backupStack isEmpty ifTrue: [^self].
	aStack push: backupStack pop.
	self restaurarStack: aStack.! !
