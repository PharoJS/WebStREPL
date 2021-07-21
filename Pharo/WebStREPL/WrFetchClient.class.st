Class {
	#name : #WrFetchClient,
	#superclass : #PjFileBasedWebApp,
	#instVars : [
		'evalButtion',
		'outputZone',
		'inputTextArea',
		'serverUrl'
	],
	#category : #'WebStREPL-Fetch'
}

{ #category : #description }
WrFetchClient class >> appJsSubFolder [

	<pharoJsSkip>
	^ 'js'
]

{ #category : #evaluating }
WrFetchClient >> eval [

	self
		send: inputTextArea textContent
		withResponseDo: [ :resultString | 
			outputZone textContent: resultString  ]
]

{ #category : #initialization }
WrFetchClient >> initialize [

	super initialize.
	inputTextArea := self elementAt: #inputTextArea.
	evalButtion := self elementAt: #evalButton.
	outputZone := self elementAt: #outputZone.
	evalButtion addEventListener: #click block: [ self eval ]
]

{ #category : #evaluating }
WrFetchClient >> send: aString withResponseDo: aBlock [

	| promise |
	promise := window fetch: serverUrl options: { 
			           (#method -> 'POST').
			           (#body -> aString) } asJsObject.
	promise then: [ :responseWrapper | responseWrapper json then: aBlock ]
]

{ #category : #accessing }
WrFetchClient >> serverUrl [

	^ serverUrl
]

{ #category : #initialization }
WrFetchClient >> serverUrl: anObject [

	serverUrl := anObject
]
