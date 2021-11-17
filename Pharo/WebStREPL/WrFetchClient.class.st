Class {
	#name : #WrFetchClient,
	#superclass : #PjWebApplication,
	#instVars : [
		'outputZone',
		'inputTextArea',
		'serverUrl',
		'evalButton'
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

	self send: inputTextArea value withResponseDo: [ :resultString | 
		outputZone textContent: resultString ]
]

{ #category : #evaluating }
WrFetchClient >> send: aString withResponseDo: aBlock [

	| promise |
	promise := window fetch: serverUrl options: { 
			           (#method -> 'POST').
			           (#body -> aString) } asJsObject.
	promise then: [ :responseWrapper | 
		responseWrapper text then: aBlock ]
]

{ #category : #accessing }
WrFetchClient >> serverUrl [

	^ serverUrl
]

{ #category : #initialization }
WrFetchClient >> serverUrl: anObject [

	serverUrl := anObject
]

{ #category : #initialization }
WrFetchClient >> setupDOM [

	| title code |
	title := self addElement: 'h1'.
	title textContent: 'Smalltalk REPL using PharoJS'.
	inputTextArea := self addElement: 'textarea' style: { 
			                 (#width -> '100%').
			                 (#height -> '50px') }. 
	inputTextArea id: #inputTextArea.
	evalButton := self addElement: 'button'.
	evalButton
		textContent: 'Eval';
		id: #evalButton.
	evalButton addEventListener: #click block: [ self eval ].
	code := self addElement: 'code'.
	outputZone := self
		              addElement: #pre
		              to: code
		              style: { (#width -> '100%') }.
	outputZone id: #outputZone
]

{ #category : #initialization }
WrFetchClient >> start [

	super start.
	self serverUrl: 'repl'.
	self setupDOM
]
