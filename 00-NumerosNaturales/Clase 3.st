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

!I class methodsFor: 'as yet unclassified' stamp: 'LK 9/3/2023 18:09:02'!
- aNaturalNumber
	^self error: self descripcionDeErrorDeNumerosNegativosNoSoportados! !

!I class methodsFor: 'as yet unclassified' stamp: 'LK 9/3/2023 18:11:14'!
/ aNaturalNumber
	self = aNaturalNumber ifTrue:[^self.].
	^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor.! !

!I class methodsFor: 'as yet unclassified' stamp: 'LK 9/3/2023 18:45:28'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No puedo dividir por un número mayor!!!!!!'.! !

!I class methodsFor: 'as yet unclassified' stamp: 'LK 9/3/2023 18:45:38'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'No soporto a los numeros negativos'.! !

!I class methodsFor: 'as yet unclassified' stamp: 'LK 9/3/2023 18:15:54'!
next
	^II.! !

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

!II class methodsFor: 'as yet unclassified' stamp: 'LK 8/28/2023 21:00:36'!
* aNaturalNumber
	^(self previous * aNaturalNumber) + aNaturalNumber
	! !

!II class methodsFor: 'as yet unclassified' stamp: 'LK 8/28/2023 20:39:54'!
+ aNaturalNumber
	^self previous + aNaturalNumber next.! !

!II class methodsFor: 'as yet unclassified' stamp: 'LK 9/3/2023 17:39:44'!
- aNaturalNumber
	^aNaturalNumber restateA: self! !

!II class methodsFor: 'as yet unclassified' stamp: 'LK 9/3/2023 18:37:59'!
/ aNaturalNumber
	
	| resultado |
	self = aNaturalNumber ifTrue: [^I].
	[resultado := self - aNaturalNumber] on: Error do: [^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor].
	^ I + (resultado / aNaturalNumber).
	
! !

!II class methodsFor: 'as yet unclassified' stamp: 'LK 9/3/2023 18:44:07'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No puedo dividir por un número mayor!!!!!!'.! !

!II class methodsFor: 'as yet unclassified' stamp: 'LK 9/3/2023 18:44:19'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'No soporto a los numeros negativos'.! !

!II class methodsFor: 'as yet unclassified' stamp: 'LK 8/28/2023 21:18:51'!
next
	next ifNotNil: [^next].
	next := II createChildNamed: self name , 'I'.
	next previous: self.
	^next.! !

!II class methodsFor: 'as yet unclassified' stamp: 'lk 8/24/2023 21:22:03'!
previous
	
	^ previous.! !

!II class methodsFor: 'as yet unclassified' stamp: 'lk 8/24/2023 21:27:05'!
previous: aNaturalNumber
	
	previous := aNaturalNumber! !

!II class methodsFor: 'as yet unclassified' stamp: 'LK 9/3/2023 17:39:44'!
restateA: aNaturalNumber

	^aNaturalNumber  previous - self previous.! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'LK 9/3/2023 18:50:43'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !


!classDefinition: #III category: 'Clase 3'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Clase 3'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'Clase 3'!
III class
	instanceVariableNames: ''!

!III class methodsFor: '--** private fileout/in **--' stamp: 'LK 9/3/2023 18:50:43'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !


!classDefinition: #IIII category: 'Clase 3'!
II subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Clase 3'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: 'Clase 3'!
IIII class
	instanceVariableNames: ''!

!IIII class methodsFor: '--** private fileout/in **--' stamp: 'LK 9/3/2023 18:50:43'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIII.
	previous := III.! !


!classDefinition: #IIIII category: 'Clase 3'!
II subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Clase 3'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIII class' category: 'Clase 3'!
IIIII class
	instanceVariableNames: ''!

!IIIII class methodsFor: '--** private fileout/in **--' stamp: 'LK 9/3/2023 18:50:43'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := IIII.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!
IIIII initializeAfterFileIn!