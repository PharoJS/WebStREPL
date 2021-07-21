Class {
	#name : #WrFileBasedClient,
	#superclass : #PjFileBasedWebApp,
	#instVars : [
		'outputZone',
		'inputTextArea',
		'serverUrl',
		'evalButton'
	],
	#category : #'WebStREPL-Common'
}

{ #category : #description }
WrFileBasedClient class >> appJsSubFolder [

	<pharoJsSkip>
	^ 'js'
]

{ #category : #'class initialization' }
WrFileBasedClient class >> defaultAppFolderName [

	<pharoJsSkip>
	^ WrFileBasedClient name
]

{ #category : #evaluating }
WrFileBasedClient >> eval [

	self
		send: inputTextArea textContent
		withResponseDo: [ :resultString | 
			outputZone textContent: resultString  ]
]

{ #category : #initialization }
WrFileBasedClient >> initialize [

	super initialize.
	inputTextArea := self elementAt: #inputTextArea.
	evalButton := self elementAt: #evalButton.
	outputZone := self elementAt: #outputZone.
	evalButton addEventListener: #click block: [ self eval ]
]

{ #category : #evaluating }
WrFileBasedClient >> send: aString withResponseDo: aBlock [

	self subclassResponsibility 
]

{ #category : #accessing }
WrFileBasedClient >> serverUrl [

	^ serverUrl
]

{ #category : #initialization }
WrFileBasedClient >> serverUrl: anObject [

	serverUrl := anObject
]
