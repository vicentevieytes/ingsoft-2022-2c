!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 18:17:51'!
test01Import

	CustomerImporter valueFrom: self validImportData into: session..

	self assertImportedRightNumberOfCustomers.
	self assertPepeSanchezWasImportedCorrecty.
	self assertJuanPerezWasImportedCorrectly ! !

!ImportTest methodsFor: 'tests' stamp: 'MV 11/14/2022 18:20:11'!
test02ImportingAnInvalidRecordTypeRaisesError

	self should: [CustomerImporter valueFrom: self importDataWithInvalidRecordType into: session]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError| 						self assert: CustomerImporter invalidRecordTypeErrorMessage equals: anError messageText.
								self assert: 0 equals: (session selectAllOfType: Customer) size ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'MV 11/14/2022 18:30:56'!
test03ImportingDataWithInvalidCustomerTypeRaisesError

	self should: [CustomerImporter valueFrom: self importDataWithInvalidCustomerType into: session]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError| 						self assert: CustomerImporter invalidRecordTypeErrorMessage equals: anError messageText.
								self assert: 0 equals: (session selectAllOfType: Customer) size ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'MV 11/14/2022 18:51:29'!
test04ImportingDataWithInvalidAddressTypeRaisesError

	self should: [CustomerImporter valueFrom: self importDataWithInvalidAddressType into: session]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError| 						self assert: CustomerImporter invalidRecordTypeErrorMessage equals: anError messageText.
								self assert: (session selectAllOfType: Customer) anyOne addresses isEmpty]

	! !

!ImportTest methodsFor: 'tests' stamp: 'MV 11/14/2022 18:50:19'!
test05ImportingDataWithEmptyLineRaisesException

	self should: [CustomerImporter valueFrom: self importDataWithEmptyLine into: session]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError| 						self assert: CustomerImporter emptyLineOnDataErrorMessage equals: anError messageText.
								self assert: 0 equals: (session selectAllOfType: Customer) size ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'MV 11/14/2022 18:54:05'!
test06ImportingDataWithAddressBeforeCustomerRaisesException

	self should: [CustomerImporter valueFrom: self importDataWithAddressBeforeCustomer into: session]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError| 						self assert: CustomerImporter noCustomerToAssignAddressErrorMessage equals: anError messageText.
								self assert: 0 equals: (session selectAllOfType: Customer) size ]

	! !


!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:22:05'!
assertAddressOf: importedCustomer at: aStreetName hasNumber: aNumber town: aTown zipCode: aZipCode province: aProvince

	| importedAddress |

	importedAddress := importedCustomer addressAt: aStreetName ifNone: [ self fail ].
	self assert: aStreetName equals: importedAddress streetName.
	self assert: aNumber equals: importedAddress streetNumber.
	self assert: aTown equals: importedAddress town.
	self assert: aZipCode equals: importedAddress zipCode.
	self assert: aProvince equals: importedAddress province.

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:27:57'!
assertCustomerWithIdentificationType: anIdType number: anIdNumber hasFirstName: aFirstName lastName: aLastName

	| importedCustomer |

	importedCustomer := self customerWithIdentificationType: anIdType number: anIdNumber.

	self assert: aFirstName equals: importedCustomer firstName.
	self assert: aLastName equals: importedCustomer lastName.
	self assert: anIdType equals: importedCustomer identificationType.
	self assert: anIdNumber equals: importedCustomer identificationNumber.

	^importedCustomer

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:12:18'!
assertImportedRightNumberOfCustomers

	^ self assert: 2 equals: (session selectAllOfType: Customer) size! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:45'!
assertJuanPerezWasImportedCorrectly

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'C' number: '23-25666777-9' hasFirstName: 'Juan' lastName: 'Perez'.
	self assertAddressOf: importedCustomer at: 'Alem' hasNumber: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'
	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:05'!
assertPepeSanchezWasImportedCorrecty

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.
	self assertAddressOf: importedCustomer at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	self assertAddressOf: importedCustomer at: 'Maipu' hasNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'.


	! !


!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 00:27:50'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction.
! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 00:28:23'!
tearDown

	session commit.
	session close.
	! !


!ImportTest methodsFor: 'customer' stamp: 'HAW 5/22/2022 18:14:22'!
customerWithIdentificationType: anIdType number: anIdNumber

	^ (session
		select: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]
		ofType: Customer) anyOne! !


!ImportTest methodsFor: 'test data' stamp: 'MV 11/14/2022 18:55:16'!
importDataWithAddressBeforeCustomer
	^ReadStream on: 'A,San Martin,3322,Olivos,1636,BsAs
	C,Pepe,Sanchez,D,22333444'! !

!ImportTest methodsFor: 'test data' stamp: 'MV 11/14/2022 18:41:44'!
importDataWithEmptyLine
	^ReadStream on:'
	
	C,Pepe,Sanchez,D,22333444	'! !

!ImportTest methodsFor: 'test data' stamp: 'MV 11/14/2022 18:32:49'!
importDataWithInvalidAddressType
	
	^ReadStream on:
'C,Pepe,Sanchez,D,22333444
AX,San Martin,3322,Olivos,1636,BsAs'! !

!ImportTest methodsFor: 'test data' stamp: 'MV 11/14/2022 18:29:36'!
importDataWithInvalidCustomerType
	
	^ReadStream on: 'CX,Pepe,Sanchez,D,22333444'! !

!ImportTest methodsFor: 'test data' stamp: 'MV 11/14/2022 18:21:15'!
importDataWithInvalidRecordType
	
	^ReadStream on: 'X'.! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 18:08:08'!
validImportData

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !


!classDefinition: #Address category: 'CustomerImporter'!
Object subclass: #Address
	instanceVariableNames: 'id streetName streetNumber town zipCode province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province

	^province! !

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province: aProvince

	province := aProvince
	! !


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 17:55:46'!
isAt: aStreetName

	^streetName = aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName: aStreetName

	streetName := aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber

	^streetNumber ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber: aStreetNumber

	streetNumber := aStreetNumber ! !


!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town

	^town! !

!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town: aTown

	town := aTown! !


!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode: aZipCode

	zipCode := aZipCode! !


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 17:55:17'!
addressAt: aStreetName ifNone: aNoneBlock

	^addresses detect: [ :address | address isAt: aStreetName ] ifNone: aNoneBlock ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addresses

	^ addresses! !


!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName

	^firstName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName: aName

	firstName := aName! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName

	^lastName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName: aLastName

	lastName := aLastName
! !


!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber

	^identificationNumber ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber: anIdentificationNumber

	identificationNumber := anIdentificationNumber! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType

	^identificationType ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType: anIdentificationType

	identificationType := anIdentificationType! !


!Customer methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initialize

	super initialize.
	addresses := OrderedCollection new.! !


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'session readStream line record newCustomer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'HAW 5/22/2022 18:06:47'!
initializeFrom: aReadStream into: aSession
	session := aSession.
	readStream := aReadStream.! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'MV 11/14/2022 18:12:32'!
import

	[self hasLineToImport ] whileTrue: [ 
		self createRecord.
		self importRecord.
		].

	! !


!CustomerImporter methodsFor: 'auxiliary' stamp: 'MV 11/14/2022 18:43:40'!
assertLineIsNotEmpty

	^ line isEmpty ifTrue: [self error: self class emptyLineOnDataErrorMessage ]! !

!CustomerImporter methodsFor: 'auxiliary' stamp: 'MV 11/14/2022 18:11:34'!
createRecord

	^ record := line findTokens: $,! !

!CustomerImporter methodsFor: 'auxiliary' stamp: 'MV 11/14/2022 18:12:48'!
hasLineToImport

	line := readStream nextLine.
	^line notNil! !

!CustomerImporter methodsFor: 'auxiliary' stamp: 'MV 11/14/2022 18:58:40'!
importAddress

	| newAddress |
			newAddress := Address new.
			newCustomer ifNil: [self error: self class noCustomerToAssignAddressErrorMessage ]. 
			newCustomer addAddress: newAddress.
			newAddress streetName: record second.
			newAddress streetNumber: record third asNumber .
			newAddress town: record fourth.
			newAddress zipCode: record fifth asNumber .
			newAddress province: record sixth! !

!CustomerImporter methodsFor: 'auxiliary' stamp: 'MV 11/14/2022 18:10:25'!
importCustomer

	newCustomer := Customer new.
			newCustomer firstName: record second.
			newCustomer lastName: record third.
			newCustomer identificationType: record fourth.
			newCustomer identificationNumber: record fifth.
			session persist: newCustomer! !

!CustomerImporter methodsFor: 'auxiliary' stamp: 'MV 11/14/2022 18:43:40'!
importRecord

	self isCustomerRecord ifTrue: [		^self importCustomer ].
	self isAddressRecord ifTrue: [ ^self importAddress ].
	self assertLineIsNotEmpty.
	self error: self class invalidRecordTypeErrorMessage! !

!CustomerImporter methodsFor: 'auxiliary' stamp: 'MV 11/14/2022 18:33:07'!
isAddressRecord

	^ line beginsWith: 'A,'! !

!CustomerImporter methodsFor: 'auxiliary' stamp: 'MV 11/14/2022 18:29:58'!
isCustomerRecord

	^ line beginsWith: 'C,'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 18:06:47'!
from: aReadStream into: aSession
	^self new initializeFrom: aReadStream into: aSession! !


!CustomerImporter class methodsFor: 'importing' stamp: 'MV 11/14/2022 18:05:00'!
valueFrom: aReadStream into: aSession

	^(self from: aReadStream into: aSession) import! !


!CustomerImporter class methodsFor: 'error message' stamp: 'MV 11/14/2022 18:40:27'!
emptyLineOnDataErrorMessage
	^'Empty line detected on import data'.! !

!CustomerImporter class methodsFor: 'error message' stamp: 'MV 11/14/2022 18:18:46'!
invalidRecordTypeErrorMessage
	
	^'Invalid Record Type'! !

!CustomerImporter class methodsFor: 'error message' stamp: 'MV 11/14/2022 18:58:17'!
noCustomerToAssignAddressErrorMessage

^'No customer to assign address'! !


!classDefinition: #DataBaseSession category: 'CustomerImporter'!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 00:19:29'!
beginTransaction

	! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 19:17:36'!
commit

	(tables at: Customer ifAbsent: [#()]) do: [ :aCustomer | self persistAddressesOf: aCustomer ]
	! !


!DataBaseSession methodsFor: 'closing' stamp: 'HAW 5/22/2022 00:19:29'!
close

	! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 19:29:06'!
objectsOfType: aType

	^ tables at: aType ifAbsent: [ #() ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
persistAddressesOf: anObjectWithAddresses

	anObjectWithAddresses addresses do: [ :anAddress | self persist: anAddress ]
	! !


!DataBaseSession methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.! !


!DataBaseSession methodsFor: 'id' stamp: 'HAW 5/22/2022 00:19:29'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'HAW 5/22/2022 00:19:29'!
persist: anObject

	| table |

	self delay.
	table := tables at: anObject class ifAbsentPut: [ Set new ].

	self defineIdOf: anObject.
	table add: anObject.

	(anObject isKindOf: Customer) ifTrue: [ self persistAddressesOf: anObject ].! !


!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
select: aCondition ofType: aType

	self delay.
	^(self objectsOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
selectAllOfType: aType

	self delay.
	^(self objectsOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 00:19:29'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !
