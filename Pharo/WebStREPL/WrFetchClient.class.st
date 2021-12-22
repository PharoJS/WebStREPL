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
WrFetchClient >> displayError: aString [
	outputZone style color: #red.
	outputZone textContent: aString.
]

{ #category : #evaluating }
WrFetchClient >> displayResult: anObject [

	outputZone style color: #black.
	anObject ifNil: [ ^ outputZone textContent: 'nil' ].
	(anObject isString and: [ anObject isEmpty ]) ifTrue: [ 
		^ outputZone textContent: '<empty string>' ].
window at: #result put: anObject.
	outputZone textContent:
		(String streamContents: [ :s | anObject printOn: s ])
]

{ #category : #evaluating }
WrFetchClient >> eval [

	self send: inputTextArea value withResponseDo: [ :jsCode | 
		self eval: jsCode ]
]

{ #category : #evaluating }
WrFetchClient >> eval: jsCode [
console log: jsCode.
	(jsCode beginsWith: 'Error:') ifTrue: [ ^ self displayError: jsCode ].
	[ self displayResult: (window eval: jsCode) value ]
		on: Error
		do: [ :ex | self displayError: ex description ]
]

{ #category : #accessing }
WrFetchClient >> evalButton [ 
	^evalButton 
]

{ #category : #accessing }
WrFetchClient >> inputTextArea [
	^inputTextArea
]

{ #category : #accessing }
WrFetchClient >> outputZone [
	^outputZone
]

{ #category : #evaluating }
WrFetchClient >> send: aString withResponseDo: aBlock [

	| promise |
	promise := window fetch: serverUrl options: { 
			           (#method -> 'POST').
			           (#body -> aString) } asJsObject.
	promise
		then: [ :responseWrapper | 
			responseWrapper text then: [ :jsCode | 
				aBlock value: jsCode ] ]
		catch: [ :ex | self displayError: ex messageText ]
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
	evalButton := self addElement: 'button'.
	evalButton
		textContent: 'Eval'.
	evalButton addEventListener: #click block: [ self eval ].
	code := self addElement: 'code'.
	outputZone := self
		              addElement: #pre
		              to: code
		              style: { (#width -> '100%') }.
]

{ #category : #initialization }
WrFetchClient >> start [

	super start.
	self serverUrl: 'repl'.
	self setupDOM
]
