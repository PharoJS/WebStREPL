Class {
	#name : #WrClient,
	#superclass : #PjFileBasedWebApp,
	#instVars : [
		'evalButtion',
		'outputZone',
		'inputTextArea',
		'serverUrl'
	],
	#category : #'WebStREPL-Client'
}

{ #category : #description }
WrClient class >> appJsSubFolder [

	<pharoJsSkip>
	^ 'js'
]

{ #category : #evaluating }
WrClient >> eval [

	self
		send: inputTextArea textContent
		withResponseDo: [ :resultString | 
			outputZone textContent: resultString  ]
]

{ #category : #initialization }
WrClient >> initialize [

	super initialize.
	inputTextArea := self elementAt: #inputTextArea.
	evalButtion := self elementAt: #evalButton.
	outputZone := self elementAt: #outputZone.
	evalButtion addEventListener: #click block: [ self eval ]
]

{ #category : #evaluating }
WrClient >> send: aString withResponseDo: aBlock [

	| promise |
	promise := window fetch: serverUrl options: { 
			           (#method -> 'POST').
			           (#body -> aString) } asJsObject.
	promise then: [ :responseWrapper | responseWrapper json then: aBlock ]
]

{ #category : #accessing }
WrClient >> serverUrl [

	^ serverUrl
]

{ #category : #initialization }
WrClient >> serverUrl: anObject [

	serverUrl := anObject
]
