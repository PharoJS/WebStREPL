Class {
	#name : #PjSymbol,
	#superclass : #PjString,
	#instVars : [
		'string'
	],
	#category : #'WebStREPL-PharoJS'
}

{ #category : #'instance creation' }
PjSymbol class >> new [
	<javascript: 'return new PjSymbol()'>
]

{ #category : #'instance creation' }
PjSymbol class >> with: aString [

	^ self new with: aString
]

{ #category : #converting }
PjSymbol >> _valueOf [

	" I implement the valueOf method so that references to me as a raw string will work properly 
	  This requires changes to the exporter to remove the standard prefix and the _ to look like a standard Javascript method "

	^ string asString
]

{ #category : #converting }
PjSymbol >> asJsObject [

	^ self
]

{ #category : #converting }
PjSymbol >> asString [

	^ string asString
	
]

{ #category : #testing }
PjSymbol >> isEmpty [
	^ string = ''
]

{ #category : #printing }
PjSymbol >> printOn: aStream [

	aStream
		nextPutAll: '#';
		nextPutAll: string
]

{ #category : #'instance creation' }
PjSymbol >> with: aString [
	string := aString
]
