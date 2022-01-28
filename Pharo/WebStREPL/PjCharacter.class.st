Class {
	#name : #PjCharacter,
	#superclass : #PjString,
	#instVars : [
		'string'
	],
	#category : #'WebStREPL-PharoJS'
}

{ #category : #'instance creation' }
PjCharacter class >> new [

	<javascript: 'return new PjCharacter()'>
	
]

{ #category : #'instance creation' }
PjCharacter class >> with: aString [
	^ self new with: aString
]

{ #category : #converting }
PjCharacter >> asJsObject [

	^ self
]

{ #category : #converting }
PjCharacter >> asString [

	^ string asString
	
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

{ #category : #'instance creation' }
PjCharacter >> with: aString [
	string := aString
]
