!classDefinition: #NumeroTest category: 'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!
!NumeroTest commentStamp: '<historical>' prior: 0!
EnteroMayorAUno with: 4!


!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:11'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:12'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:18'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:20'!
test07EnteroDividesEnteroCorrectly

	self assert: two / two equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:38'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:52'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:56'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: oneHalf / oneFifth equals: fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: one + oneFifth equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test12FraccionAddsEnteroCorrectly

	self assert: oneFifth + one equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:50'!
test13EnteroMultipliesFraccionCorrectly

	self assert: two * oneFifth equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:52'!
test14FraccionMultipliesEnteroCorrectly

	self assert: oneFifth * two equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:57'!
test15EnteroDividesFraccionCorrectly

	self assert: one / twoFifth equals: fiveHalfs  ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:59'!
test16FraccionDividesEnteroCorrectly

	self assert: twoFifth / five equals: twoTwentyfifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:40'!
test19AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: (two/five) * (five/two) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test21DividingFraccionesCanReturnAnEntero

	self assert: oneHalf / oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:43'!
test22DividingEnterosCanReturnAFraccion

	self assert: two / four equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 4/15/2021 16:45:35'!
test27EnteroSubstractsEnteroCorrectly

	self assert: four - one equals: three! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:41'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: twoFifth - oneFifth equals: oneFifth.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:00'!
test29EnteroSubstractsFraccionCorrectly

	self assert: one - oneHalf equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:05'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: sixFifth - one equals: oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:08'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: threeHalfs - oneHalf equals: one.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:48'!
test32SubstractingSameEnterosReturnsZero

	self assert: one - one equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:01'!
test33SubstractingSameFraccionesReturnsZero

	self assert: oneHalf - oneHalf equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:14'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: one - fiveHalfs equals: negativeThreeHalfs.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:23'!
test35FibonacciZeroIsOne

	self assert: zero fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:32'!
test36FibonacciOneIsOne

	self assert: one fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:39'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: four fibonacci equals: five.
	self assert: three fibonacci equals: three. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:47'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Entero negativeFibonacciErrorDescription ].! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:55'!
test39NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.
		! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:03'!
test40NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOne / two.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/23/2018 23:46:28'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: 'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 22:21:28'!
- aSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 23:37:13'!
negated
	
	^self * (Entero with: -1)! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:02'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero!!!!!!'! !

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:09'!
invalidNumberTypeErrorDescription
	
	^ 'Tipo de número inválido!!!!!!'! !


!classDefinition: #Entero category: 'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'arithmetic operations' stamp: 'LM 9/11/2022 18:22:45'!
* aMultiplier 
	
	^aMultiplier multiplyAnEntero: self.
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'LM 9/11/2022 18:16:40'!
+ anAdder 
	
	^anAdder AddAnEntero: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'LM 9/11/2022 18:31:45'!
- aSubtrahend 
	
	^ aSubtrahend substractFromAnEntero: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'LM 9/11/2022 19:05:20'!
/ aDivisor 
	
	^aDivisor divideAnEntero: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'LM 9/12/2022 21:52:24'!
// aDivisor 
	
	^Entero with: self integerValue // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'LM 9/12/2022 20:53:40'!
fibonacci

	^self subclassResponsibility.
		! !

!Entero methodsFor: 'arithmetic operations' stamp: 'LM 9/12/2022 21:53:21'!
greatestCommonDivisorWith: anEntero
	^Entero with: (self integerValue gcd: anEntero integerValue)! !


!Entero methodsFor: 'comparing' stamp: 'LM 9/12/2022 21:42:58'!
= anObject

	^(anObject isKindOf: self class) and: [ self integerValue = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'LM 9/12/2022 21:43:28'!
hash

	^self integerValue hash! !


!Entero methodsFor: 'value' stamp: 'LM 9/12/2022 21:01:05'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^self integerValue! !


!Entero methodsFor: 'printing' stamp: 'LM 9/12/2022 21:49:02'!
printOn: aStream

	aStream print: self integerValue! !


!Entero methodsFor: 'testing' stamp: 'LM 9/12/2022 20:54:52'!
isNegative
	
	^self integerValue < 0! !

!Entero methodsFor: 'testing' stamp: 'LM 9/12/2022 21:43:48'!
isOne
	
	^self integerValue = 1! !

!Entero methodsFor: 'testing' stamp: 'LM 9/12/2022 21:43:55'!
isZero
	
	^self integerValue = 0! !


!Entero methodsFor: 'polimonkey' stamp: 'LM 9/11/2022 18:21:21'!
AddAFraccion: aFraccion
	^ (self * aFraccion denominator + aFraccion numerator) / aFraccion denominator! !

!Entero methodsFor: 'polimonkey' stamp: 'LM 9/12/2022 21:52:47'!
AddAnEntero: anEnteroAdder 
	^Entero with: self integerValue + anEnteroAdder integerValue! !

!Entero methodsFor: 'polimonkey' stamp: 'LM 9/11/2022 19:04:03'!
divideAFraccion: aFraccionDividend

	^ aFraccionDividend numerator / (aFraccionDividend denominator * self).	! !

!Entero methodsFor: 'polimonkey' stamp: 'LM 9/11/2022 19:06:13'!
divideAnEntero: anEnteroDividend

	^Fraccion with: anEnteroDividend over: self! !

!Entero methodsFor: 'polimonkey' stamp: 'LM 9/11/2022 18:28:26'!
multiplyAFraccion: aFraccionMultiplying

	^ aFraccionMultiplying numerator * self / aFraccionMultiplying denominator ! !

!Entero methodsFor: 'polimonkey' stamp: 'LM 9/12/2022 21:53:38'!
multiplyAnEntero: anEnteroMultiplying
	
	^ Entero with: self integerValue * anEnteroMultiplying integerValue! !

!Entero methodsFor: 'polimonkey' stamp: 'LM 9/11/2022 18:57:50'!
substractFromAFraccion: aFraccionMinuend

	^ aFraccionMinuend numerator - (self * aFraccionMinuend denominator) / aFraccionMinuend denominator ! !

!Entero methodsFor: 'polimonkey' stamp: 'LM 9/12/2022 21:54:42'!
substractFromAnEntero: AnEnteroMinued

	^ Entero with: AnEnteroMinued integerValue - self integerValue.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: 'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'NR 4/15/2021 16:42:24'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no está definido aquí para Enteros Negativos!!!!!!'! !

!Entero class methodsFor: 'instance creation' stamp: 'LM 9/12/2022 21:31:15'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	aValue = 1 ifTrue: [^Uno new ].
	aValue = 0 ifTrue: [^Cero new ].
	aValue < 0 ifTrue: [^EnteroNegativo new initializeWith: aValue].
	^EnteroMayorAUno with: aValue! !


!classDefinition: #Cero category: 'Numero-Exercise'!
Entero subclass: #Cero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Cero methodsFor: 'arithmetic operations' stamp: 'LM 9/12/2022 21:56:53'!
fibonacci

	^Entero with: 1.! !


!Cero methodsFor: 'initialization' stamp: 'LM 9/12/2022 20:40:36'!
initialize

	value:= 0.! !


!Cero methodsFor: 'value' stamp: 'LM 9/12/2022 20:58:18'!
integerValue

	^value! !


!classDefinition: #EnteroMayorAUno category: 'Numero-Exercise'!
Entero subclass: #EnteroMayorAUno
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroMayorAUno methodsFor: 'arithmetic operations' stamp: 'LM 9/12/2022 21:57:05'!
fibonacci
	|uno dos|
	
	uno := Entero with: 1.
	dos := 	Entero with: 2.
	
	^ (self - uno) fibonacci + (self - dos) fibonacci! !


!EnteroMayorAUno methodsFor: 'initialization' stamp: 'LM 9/12/2022 20:55:36'!
initializeWith: aValue 
	
	value := aValue! !


!EnteroMayorAUno methodsFor: 'as yet unclassified' stamp: 'LM 9/12/2022 20:58:26'!
integerValue

	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroMayorAUno class' category: 'Numero-Exercise'!
EnteroMayorAUno class
	instanceVariableNames: ''!

!EnteroMayorAUno class methodsFor: 'as yet unclassified' stamp: 'LM 9/12/2022 21:31:43'!
with: aValue

	^self new initializeWith: aValue.! !


!classDefinition: #EnteroNegativo category: 'Numero-Exercise'!
Entero subclass: #EnteroNegativo
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroNegativo methodsFor: 'arithmetic operations' stamp: 'LM 9/12/2022 21:57:13'!
fibonacci

	^self error: Entero negativeFibonacciErrorDescription.! !

!EnteroNegativo methodsFor: 'arithmetic operations' stamp: 'LM 9/12/2022 20:25:32'!
fibonacci: anEntero

	^self error: Entero negativeFibonacciErrorDescription.! !

!EnteroNegativo methodsFor: 'arithmetic operations' stamp: 'LM 9/12/2022 20:58:59'!
integerValue

	^value! !


!EnteroNegativo methodsFor: 'initialization' stamp: 'LM 9/12/2022 20:52:48'!
initializeWith: aValue 
	
	value := aValue.! !


!classDefinition: #Uno category: 'Numero-Exercise'!
Entero subclass: #Uno
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Uno methodsFor: 'initialization' stamp: 'LM 9/12/2022 20:37:26'!
initialize

	value:= 1.! !


!Uno methodsFor: 'arithmetic operations' stamp: 'LM 9/12/2022 21:57:20'!
fibonacci

	^self.! !

!Uno methodsFor: 'arithmetic operations' stamp: 'LM 9/12/2022 20:30:31'!
fibonacci: anEntero

	^self.! !

!Uno methodsFor: 'arithmetic operations' stamp: 'LM 9/12/2022 20:59:04'!
integerValue

	^value! !


!classDefinition: #Fraccion category: 'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'arithmetic operations' stamp: 'LM 9/11/2022 18:27:00'!
* aMultiplier 
	
	^aMultiplier multiplyAFraccion: self.
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'LM 9/11/2022 18:19:17'!
+ anAdder 
	
	^anAdder AddAFraccion: self.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'LM 9/11/2022 18:49:03'!
- aSubtrahend 
	
	^aSubtrahend substractFromAFraccion: self.
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'LM 9/11/2022 19:11:30'!
/ aDivisor 
	
	^ aDivisor divideAFraccion: self.! !


!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:42'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'initialization' stamp: 'LM 9/11/2022 19:12:44'!
initializeWith: aNumerator over: aDenominator

	(aNumerator isZero or: aDenominator isOne)  ifTrue: [ ^ Entero with: aNumerator].
	
	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'polimonkey' stamp: 'LM 9/11/2022 18:17:59'!
AddAFraccion: aFraccionAdder

	| newNumerator newDenominator |
	
	newNumerator := (numerator * aFraccionAdder denominator) + (denominator * aFraccionAdder numerator).
	newDenominator := denominator * aFraccionAdder denominator.
	
	^newNumerator / newDenominator ! !

!Fraccion methodsFor: 'polimonkey' stamp: 'LM 9/11/2022 18:16:40'!
AddAnEntero: anEnteroAdder

	^ (anEnteroAdder * self denominator + self numerator) / self denominator

	! !

!Fraccion methodsFor: 'polimonkey' stamp: 'LM 9/11/2022 19:01:45'!
divideAFraccion: aFraccionDividend

	^(aFraccionDividend numerator * denominator) / (aFraccionDividend denominator * numerator)! !

!Fraccion methodsFor: 'polimonkey' stamp: 'LM 9/11/2022 19:07:41'!
divideAnEntero: anEnteroDividend

	^ denominator * anEnteroDividend / numerator! !

!Fraccion methodsFor: 'polimonkey' stamp: 'LM 9/11/2022 18:27:32'!
multiplyAFraccion: aFraccionMultiplying

	^(numerator * aFraccionMultiplying numerator) / (denominator * aFraccionMultiplying denominator)! !

!Fraccion methodsFor: 'polimonkey' stamp: 'LM 9/11/2022 18:26:17'!
multiplyAnEntero: anEnteroMultiplying
	
	^ self numerator * anEnteroMultiplying / self denominator ! !

!Fraccion methodsFor: 'polimonkey' stamp: 'LM 9/11/2022 18:43:37'!
substractFromAFraccion: aFraccionMinuend

	| newNumerator newDenominator |
	
	newNumerator := (aFraccionMinuend numerator * denominator) - (aFraccionMinuend denominator * numerator).
	newDenominator := aFraccionMinuend denominator * denominator.
	
	^newNumerator / newDenominator ! !

!Fraccion methodsFor: 'polimonkey' stamp: 'LM 9/11/2022 18:55:13'!
substractFromAnEntero: AnEnteroMinued

	^ AnEnteroMinued * denominator - numerator / denominator! !


!Fraccion methodsFor: 'testing' stamp: 'NR 9/23/2018 23:41:38'!
isNegative
	
	^numerator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: 'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'NR 9/23/2018 23:45:19'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	aDivisor isZero ifTrue: [ self error: self canNotDivideByZeroErrorDescription ].
	aDividend isZero ifTrue: [ ^aDividend ].
	
	aDivisor isNegative ifTrue:[ ^aDividend negated / aDivisor negated].
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator isOne ifTrue: [ ^numerator ].

	^self new initializeWith: numerator over: denominator
	! !
