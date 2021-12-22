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

	self
		send: self smalltalkCode
		withResponseDo: [ :jsCode | self eval: jsCode ]
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

	| code resultLabel |
	inputTextArea := self addElement: 'textarea' style: { 
			                 (#width -> '100%').
			                 (#height -> '50px').
			                 (#'box-sizing' -> 'border-box') }.
	inputTextArea placeholder: '"Smalltalk code"'.
	evalButton := self addElement: 'button' style: { 
			              (#width -> '140px').
			              (#height -> '30px').
			              (#'background-color' -> 'rgb(230,250,255)').
			              (#color -> 'rgb(51,153,235)').
			              (#'font-size' -> '1.1em').
			              (#'border-radius' -> '3px').
			              ('margin-top' -> '4px') }.
	evalButton textContent: 'Eval'.
	evalButton addEventListener: #click block: [ self eval ].
	resultLabel := self
		               addElement: 'div'
		               style: { (#'margin-top' -> '30px') }.
	resultLabel textContent: 'Result'.
	code := self addElement: 'code'.
	outputZone := self addElement: #pre to: code style: { 
			              (#width -> '100%').
			              (#'box-sizing' -> 'border-box').
			              (#'background-color' -> #lightgray).
			              (#padding -> '10px').
			              (#'min-height' -> '100px') }
]

{ #category : #accessing }
WrFetchClient >> smalltalkCode [

	^ inputTextArea value ifEmpty: [ 'nil' ]
]

{ #category : #initialization }
WrFetchClient >> start [

	super start.
	self serverUrl: 'repl'.
	self setupDOM
]
