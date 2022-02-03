"
I represent Characters. Currently I am a sub-class of PjString, but that's probably wrong.
"
Class {
	#name : #PjCharacter,
	#superclass : #WrString,
	#instVars : [
		'string'
	],
	#category : #'WebStREPL-PharoJS'
}

{ #category : #'pharoJs support' }
PjCharacter class >> jsTranspilationImportMethods [

	<pharoJsSkip>
	^ { 
		  (Character class -> #( cr escape lf linefeed space tab )).
		  (Character -> #( isVowel isCharacter to: )) }
]

{ #category : #'instance creation' }
PjCharacter class >> new [

	<javascript: 'return new PjCharacter()'>
	
]

{ #category : #'instance creation' }
PjCharacter class >> with: aString [
	^ self new with: aString
]

{ #category : #copying }
PjCharacter >> , other [

	self errorNotIndexable
]

{ #category : #converting }
PjCharacter >> asJsObject [

	^ self
]

{ #category : #converting }
PjCharacter >> asString [

	<jsAlias: 'toString'>
	^ string
]

{ #category : #accessing }
PjCharacter >> at: index [

	self errorNotIndexable
]

{ #category : #accessing }
PjCharacter >> at: index put: ignored [

	self errorNotIndexable
]

{ #category : #private }
PjCharacter >> errorNotIndexable [

	self error:
		'Instances of Character are not indexable'
]

{ #category : #testing }
PjCharacter >> isCollection [

	^ false
]

{ #category : #testing }
PjCharacter >> isString [
	^ false
]

{ #category : #printing }
PjCharacter >> printOn: aStream [
	aStream nextPutAll: '$';nextPutAll: string
]

{ #category : #converting }
PjCharacter >> valueOf [

	" I implement the valueOf method so that references to me as a raw string will work properly 
	  This requires changes to the exporter to remove the standard prefix and the _ to look like a standard Javascript method "

	<jsAlias: 'valueOf'>
	^ string asString
]

{ #category : #'instance creation' }
PjCharacter >> with: aString [
	string := aString
]
