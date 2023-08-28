!classDefinition: #I category: 'Clase 3'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Clase 3'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'Clase 3'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'as yet unclassified' stamp: 'LK 8/28/2023 12:26:00'!
* aNaturalNumber
	^aNaturalNumber! !

!I class methodsFor: 'as yet unclassified' stamp: 'lk 8/24/2023 21:01:54'!
+ aNaturalNumber
	
	^aNaturalNumber next! !

!I class methodsFor: 'as yet unclassified' stamp: 'lk 8/24/2023 21:37:06'!
next
	^ self cloneNamed: self name, 'I'! !

!I class methodsFor: 'as yet unclassified' stamp: 'lk 8/24/2023 21:57:00'!
restateA: aNaturalNumber

	^aNaturalNumber previous.! !


!classDefinition: #II category: 'Clase 3'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Clase 3'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'Clase 3'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'as yet unclassified' stamp: 'LK 8/28/2023 12:27:27'!
* aNaturalNumber
	^self previous * aNaturalNumber + aNaturalNumber
	! !

!II class methodsFor: 'as yet unclassified' stamp: 'lk 8/24/2023 21:16:18'!
+ aNaturalNumber
	^aNaturalNumber next next.! !

!II class methodsFor: 'as yet unclassified' stamp: 'lk 8/24/2023 21:48:50'!
- aNaturalNumber
	aNaturalNumber = I ifTrue: [^self previous	].
	^self previous - aNaturalNumber previous.! !

!II class methodsFor: 'as yet unclassified' stamp: 'lk 8/24/2023 21:54:20'!
-- aNaturalNumber
	^aNaturalNumber restateA: self! !

!II class methodsFor: 'as yet unclassified' stamp: 'LK 8/28/2023 14:54:49'!
/ aNaturalNumber
	|sig|
	aNaturalNumber = self ifTrue: [^I].
	sig := (self - aNaturalNumber)/ aNaturalNumber.
	^I + sig
	
! !

!II class methodsFor: 'as yet unclassified' stamp: 'lk 8/24/2023 21:17:48'!
next
	next ifNotNil: [^next].
	next := self cloneNamed: self name , 'I'.
	next previous: self.
	^next.! !

!II class methodsFor: 'as yet unclassified' stamp: 'lk 8/24/2023 21:22:03'!
previous
	
	^ previous.! !

!II class methodsFor: 'as yet unclassified' stamp: 'lk 8/24/2023 21:27:05'!
previous: aNaturalNumber
	
	previous := aNaturalNumber! !

!II class methodsFor: 'as yet unclassified' stamp: 'lk 8/24/2023 21:55:36'!
restateA: aNaturalNumber

	^aNaturalNumber  previous -- self previous.! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'LK 8/28/2023 14:54:56'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !


!classDefinition: #III category: 'Clase 3'!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Clase 3'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'Clase 3'!
III class
	instanceVariableNames: 'next previous'!

!III class methodsFor: 'as yet unclassified' stamp: 'LK 8/28/2023 14:46:31'!
* aNaturalNumber
	^self previous * aNaturalNumber + aNaturalNumber
	! !

!III class methodsFor: 'as yet unclassified' stamp: 'LK 8/28/2023 14:46:31'!
+ aNaturalNumber
	^aNaturalNumber next next.! !

!III class methodsFor: 'as yet unclassified' stamp: 'LK 8/28/2023 14:46:31'!
- aNaturalNumber
	aNaturalNumber = I ifTrue: [^self previous	].
	^self previous - aNaturalNumber previous.! !

!III class methodsFor: 'as yet unclassified' stamp: 'LK 8/28/2023 14:46:32'!
-- aNaturalNumber
	^aNaturalNumber restateA: self! !

!III class methodsFor: 'as yet unclassified' stamp: 'LK 8/28/2023 14:46:32'!
/ aNaturalNumber
	aNaturalNumber = I ifTrue: [^aNaturalNumber].
	^1 + ((self - aNaturalNumber) / aNaturalNumber)
	! !

!III class methodsFor: 'as yet unclassified' stamp: 'LK 8/28/2023 14:46:32'!
next
	next ifNotNil: [^next].
	next := self cloneNamed: self name , 'I'.
	next previous: self.
	^next.! !

!III class methodsFor: 'as yet unclassified' stamp: 'LK 8/28/2023 14:46:32'!
previous
	
	^ previous.! !

!III class methodsFor: 'as yet unclassified' stamp: 'LK 8/28/2023 14:46:32'!
previous: aNaturalNumber
	
	previous := aNaturalNumber! !

!III class methodsFor: 'as yet unclassified' stamp: 'LK 8/28/2023 14:46:32'!
restateA: aNaturalNumber

	^aNaturalNumber  previous -- self previous.! !


!III class methodsFor: '--** private fileout/in **--' stamp: 'LK 8/28/2023 14:54:56'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !


!classDefinition: #IIII category: 'Clase 3'!
DenotativeObject subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Clase 3'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: 'Clase 3'!
IIII class
	instanceVariableNames: 'next previous'!

!IIII class methodsFor: 'as yet unclassified' stamp: 'LK 8/28/2023 14:46:37'!
* aNaturalNumber
	^self previous * aNaturalNumber + aNaturalNumber
	! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'LK 8/28/2023 14:46:37'!
+ aNaturalNumber
	^aNaturalNumber next next.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'LK 8/28/2023 14:46:38'!
- aNaturalNumber
	aNaturalNumber = I ifTrue: [^self previous	].
	^self previous - aNaturalNumber previous.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'LK 8/28/2023 14:46:38'!
-- aNaturalNumber
	^aNaturalNumber restateA: self! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'LK 8/28/2023 14:46:38'!
/ aNaturalNumber
	aNaturalNumber = I ifTrue: [^aNaturalNumber].
	^1 + ((self - aNaturalNumber) / aNaturalNumber)
	! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'LK 8/28/2023 14:46:38'!
next
	next ifNotNil: [^next].
	next := self cloneNamed: self name , 'I'.
	next previous: self.
	^next.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'LK 8/28/2023 14:46:38'!
previous
	
	^ previous.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'LK 8/28/2023 14:46:38'!
previous: aNaturalNumber
	
	previous := aNaturalNumber! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'LK 8/28/2023 14:46:38'!
restateA: aNaturalNumber

	^aNaturalNumber  previous -- self previous.! !


!IIII class methodsFor: '--** private fileout/in **--' stamp: 'LK 8/28/2023 14:54:56'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIII.
	previous := III.! !


!classDefinition: #IIIII category: 'Clase 3'!
DenotativeObject subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Clase 3'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIII class' category: 'Clase 3'!
IIIII class
	instanceVariableNames: 'next previous'!

!IIIII class methodsFor: 'as yet unclassified' stamp: 'LK 8/28/2023 14:46:43'!
* aNaturalNumber
	^self previous * aNaturalNumber + aNaturalNumber
	! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'LK 8/28/2023 14:46:43'!
+ aNaturalNumber
	^aNaturalNumber next next.! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'LK 8/28/2023 14:46:43'!
- aNaturalNumber
	aNaturalNumber = I ifTrue: [^self previous	].
	^self previous - aNaturalNumber previous.! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'LK 8/28/2023 14:46:43'!
-- aNaturalNumber
	^aNaturalNumber restateA: self! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'LK 8/28/2023 14:46:43'!
/ aNaturalNumber
	aNaturalNumber = I ifTrue: [^aNaturalNumber].
	^1 + ((self - aNaturalNumber) / aNaturalNumber)
	! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'LK 8/28/2023 14:46:43'!
next
	next ifNotNil: [^next].
	next := self cloneNamed: self name , 'I'.
	next previous: self.
	^next.! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'LK 8/28/2023 14:46:44'!
previous
	
	^ previous.! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'LK 8/28/2023 14:46:44'!
previous: aNaturalNumber
	
	previous := aNaturalNumber! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'LK 8/28/2023 14:46:44'!
restateA: aNaturalNumber

	^aNaturalNumber  previous -- self previous.! !


!IIIII class methodsFor: '--** private fileout/in **--' stamp: 'LK 8/28/2023 14:54:56'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIII.
	previous := IIII.! !


!classDefinition: #IIIIII category: 'Clase 3'!
DenotativeObject subclass: #IIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Clase 3'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIII class' category: 'Clase 3'!
IIIIII class
	instanceVariableNames: 'next previous'!

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'LK 8/28/2023 14:46:58'!
* aNaturalNumber
	^self previous * aNaturalNumber + aNaturalNumber
	! !

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'LK 8/28/2023 14:46:58'!
+ aNaturalNumber
	^aNaturalNumber next next.! !

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'LK 8/28/2023 14:46:58'!
- aNaturalNumber
	aNaturalNumber = I ifTrue: [^self previous	].
	^self previous - aNaturalNumber previous.! !

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'LK 8/28/2023 14:46:58'!
-- aNaturalNumber
	^aNaturalNumber restateA: self! !

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'LK 8/28/2023 14:46:59'!
/ aNaturalNumber
	aNaturalNumber = I ifTrue: [^aNaturalNumber].
	^1 + ((self - aNaturalNumber) / aNaturalNumber)
	! !

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'LK 8/28/2023 14:46:59'!
next
	next ifNotNil: [^next].
	next := self cloneNamed: self name , 'I'.
	next previous: self.
	^next.! !

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'LK 8/28/2023 14:46:59'!
previous
	
	^ previous.! !

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'LK 8/28/2023 14:46:59'!
previous: aNaturalNumber
	
	previous := aNaturalNumber! !

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'LK 8/28/2023 14:46:59'!
restateA: aNaturalNumber

	^aNaturalNumber  previous -- self previous.! !


!IIIIII class methodsFor: '--** private fileout/in **--' stamp: 'LK 8/28/2023 14:54:56'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := IIIII.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!
IIIII initializeAfterFileIn!
IIIIII initializeAfterFileIn!