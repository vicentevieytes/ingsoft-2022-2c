!classDefinition: #I category: 'NaturalNumbers'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalNumbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'NaturalNumbers'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'next' stamp: 'ARM 8/25/2022 20:43:03'!
next
	^II! !


!I class methodsFor: 'operations' stamp: 'LM 8/27/2022 14:36:34'!
* aMultiplicand

	^aMultiplicand! !

!I class methodsFor: 'operations' stamp: 'ARM 8/25/2022 21:12:30'!
+ anAdder

	^anAdder next! !

!I class methodsFor: 'operations' stamp: 'LM 9/3/2022 11:25:29'!
- subtrahend

	self error: I negativeNumbersNotSupportedErrorDescription! !

!I class methodsFor: 'operations' stamp: 'LM 9/3/2022 11:51:18'!
/ aDividend
	
	aDividend = self ifTrue:[^I].
	^self error: II canNotDivideByBiggerNumberErrorDescription.! !

!I class methodsFor: 'operations' stamp: 'LM 8/29/2022 20:31:23'!
substractFrom: aMinuend

	^aMinuend previous.! !


!I class methodsFor: 'errorMessages' stamp: 'LM 9/3/2022 11:26:50'!
negativeNumbersNotSupportedErrorDescription
	
	^'Negative numbers not supported'! !


!classDefinition: #II category: 'NaturalNumbers'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalNumbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'NaturalNumbers'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'next & previous' stamp: 'LM 9/3/2022 11:22:43'!
nameOfNext

	(self name endsWith:'DCCCXCIX') ifTrue: [^(self name withoutSuffix: 'DCCCXCIX') , 'CM'].	
	(self name endsWith:'CDXCIX') ifTrue: [^(self name withoutSuffix: 'CDXCIX') , 'D'].	
	(self name endsWith:'CCCXCIX') ifTrue: [^(self name withoutSuffix: 'CCCXCIX' ), 'CD'].	
	(self name endsWith:'XCIX') ifTrue: [^(self name withoutSuffix: 'XCIX' ), 'C'].	
	(self name endsWith:'LXXXIX') ifTrue: [^(self name withoutSuffix: 'LXXXIX' ), 'XC'].	
	(self name endsWith:'XLIX') ifTrue: [^(self name withoutSuffix: 'XLIX' ), 'L'].	
	(self name endsWith:'XXXIX') ifTrue: [^(self name withoutSuffix: 'XXXIX' ), 'XL'].	
	(self name endsWith:'IX') ifTrue: [^(self name withoutSuffix: 'IX' ), 'X'].
	(self name endsWith:'VIII') ifTrue: [^(self name withoutSuffix: 'VIII' ), 'IX'].
	(self name endsWith: 'IV') ifTrue: [^(self name withoutSuffix: 'IV'), 'V'].
	(self name endsWith: 'III') ifTrue: [^(self name withoutSuffix: 'III'), 'IV'].
	^ self name , 'I'! !

!II class methodsFor: 'next & previous' stamp: 'LM 9/3/2022 01:41:55'!
next
	next ifNil:[
		next _ II createChildNamed: self nameOfNext.
		next previous: self.
		].
	^next! !

!II class methodsFor: 'next & previous' stamp: 'ARM 8/25/2022 21:21:12'!
previous

	^previous! !

!II class methodsFor: 'next & previous' stamp: 'ARM 8/25/2022 21:25:57'!
previous: aNumber 

	previous := aNumber! !


!II class methodsFor: 'remove all next' stamp: 'ARM 8/25/2022 21:37:56'!
removeAllNext

	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !


!II class methodsFor: 'operations' stamp: 'LM 8/29/2022 20:23:18'!
* aMultiplicand
	
	^aMultiplicand + (self previous * aMultiplicand).
	! !

!II class methodsFor: 'operations' stamp: 'ARM 8/25/2022 21:19:09'!
+ anAdder 

	^self previous + anAdder next! !

!II class methodsFor: 'operations' stamp: 'LM 8/29/2022 20:34:16'!
- subtrahend 
	
	^subtrahend substractFrom: self! !

!II class methodsFor: 'operations' stamp: 'LM 9/3/2022 11:46:43'!
/ aDivisor
	
	self = aDivisor ifTrue: [^I].
	
	self-aDivisor = 'Negative numbers not supported' ifTrue:[^self error: II canNotDivideByBiggerNumberErrorDescription].
	
	^ I + ((self-aDivisor) / aDivisor).! !

!II class methodsFor: 'operations' stamp: 'LM 9/3/2022 11:40:29'!
substractFrom: aMinuend
	
	aMinuend = I ifTrue:[^I negativeNumbersNotSupportedErrorDescription].
	^ self previous substractFrom: aMinuend previous! !


!II class methodsFor: 'errorMessages' stamp: 'LM 9/3/2022 11:48:06'!
canNotDivideByBiggerNumberErrorDescription
	
	^'Can not divide by bigger number'! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'LM 9/3/2022 11:54:15'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !


!classDefinition: #III category: 'NaturalNumbers'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalNumbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'NaturalNumbers'!
III class
	instanceVariableNames: ''!

!III class methodsFor: '--** private fileout/in **--' stamp: 'LM 9/3/2022 11:54:15'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IV.
	previous := II.! !


!classDefinition: #IV category: 'NaturalNumbers'!
II subclass: #IV
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalNumbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IV class' category: 'NaturalNumbers'!
IV class
	instanceVariableNames: ''!

!IV class methodsFor: '--** private fileout/in **--' stamp: 'LM 9/3/2022 11:54:15'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := III.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IV initializeAfterFileIn!