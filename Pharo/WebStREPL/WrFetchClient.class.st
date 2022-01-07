Class {
	#name : #WrFetchClient,
	#superclass : #PjWebApplication,
	#instVars : [
		'outputZone',
		'inputTextArea',
		'serverUrl',
		'evalButton',
		'transcriptDiv'
	],
	#classVars : [
		'TranscriptElement'
	],
	#category : #'WebStREPL-Fetch'
}

{ #category : #adding }
WrFetchClient class >> addToTranscript: aString [
	TranscriptElement innerText: TranscriptElement innerText , aString
]

{ #category : #description }
WrFetchClient class >> appClasses [
<pharoJsSkip>
	^ super appClasses , { WrTranscript }
]

{ #category : #description }
WrFetchClient class >> appJsSubFolder [

	<pharoJsSkip>
	^ 'js'
]

{ #category : #compiling }
WrFetchClient class >> compileTag [
	^ #compile
]

{ #category : #initialization }
WrFetchClient >> addElement: tagString class: classString [
	^ self addElement: tagString to: self body class: classString
]

{ #category : #initialization }
WrFetchClient >> addElement: tagString to: parentNode class: classString [

	| newElement |
	newElement := self
		              createElement: tagString.
	parentNode appendChild: newElement.
	newElement className: classString.
	^ newElement
]

{ #category : #initialization }
WrFetchClient >> addInputArea [

	inputTextArea := self addElement: 'textarea'.
	inputTextArea placeholder:
		'Type in any Smalltalk code, then click the "Eval" button'.
		inputTextArea focus.
	evalButton := self addElement: 'button'.
	inputTextArea addEventListener: #keydown block: [ :event | 
		event keyCode = 9 ifTrue: [ " make tab work properly in Safari "
			evalButton focus.
			event stopPropagation.
			event preventDefault.
			false ] ].
	evalButton textContent: 'Eval'.
	evalButton type: #button.
	evalButton addEventListener: #click block: [ self eval ].
	evalButton addEventListener: #keypress block: [ :event | 
		event preventDefault.
		event keyCode = 13 ifTrue: [ self eval ] ].
	inputTextArea focus
]

{ #category : #evaluating }
WrFetchClient >> displayError: aString [

	self outputZone style color: #red.
	outputZone textContent: aString
]

{ #category : #evaluating }
WrFetchClient >> displayResult: anObject [

	TranscriptElement textContent = ''
		ifTrue: [ 
		transcriptDiv parentNode removeChild: transcriptDiv ]
		ifFalse: [ anObject = WrTranscript ifTrue: [ ^ self ] ].
	self outputZone.
	anObject ifNil: [ ^ outputZone textContent: 'nil' ].
	(anObject isString and: [ anObject isEmpty ]) ifTrue: [ 
		^ outputZone textContent: '<empty string>' ].
	window at: #result put: anObject.
	outputZone textContent:
		(String streamContents: [ :s | anObject printOn: s ])
]

{ #category : #evaluating }
WrFetchClient >> eval [

	| content |
	content := inputTextArea value.
	content ifEmpty: [ ^ self ].
	evalButton parentNode removeChild: evalButton.
	inputTextArea parentNode removeChild: inputTextArea.
	inputTextArea := self addElement: #pre class: #input.
	inputTextArea textContent: content.
	inputTextArea title: 'input'.
	transcriptDiv := self addElement: 'div' class: #transcript.
	transcriptDiv innerText: 'Transcript'.
	TranscriptElement := self
		                     addElement: 'pre'
		                     to: transcriptDiv
		                     class: #transcript.
	TranscriptElement title: 'Transcript'.
	self
		send: content
		withResponseDo: [ :jsCode | 
			self eval: jsCode.
			self addInputArea ]
		onErrorDo: [ :message | 
			self displayError: message.
			self addInputArea ]
]

{ #category : #evaluating }
WrFetchClient >> eval: jsCode [

	(jsCode beginsWith: 'Error:') ifTrue: [ ^ self displayError: jsCode ].
	[ self displayResult: (window eval: jsCode) value ]
		on: Error
		do: [ :ex | self displayError: ex message ]
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

	| code |
	code := self addElement: 'code'.
	outputZone := self addElement: #pre to: code class: #output.
	outputZone title: 'result'.
"	self cssClassesElement: outputZone set: #( output )."
	^ outputZone
]

{ #category : #evaluating }
WrFetchClient >> send: aString withResponseDo: aBlock onErrorDo: errorBlock [

	| promise |
	promise := window fetch: serverUrl options: { 
			           (#method -> 'POST').
			           (#body -> aString) } asJsObject.
	promise
		then: [ :responseWrapper | 
			responseWrapper text then: [ :jsCode | aBlock value: jsCode ] ]
		catch: [ :ex | errorBlock value: ex messageText ]
]

{ #category : #accessing }
WrFetchClient >> serverUrl [

	^ serverUrl
]

{ #category : #initialization }
WrFetchClient >> serverUrl: anObject [

	serverUrl := anObject
]

{ #category : #accessing }
WrFetchClient >> smalltalkCode [

	^ inputTextArea value ifEmpty: [ 'nil' ]
]

{ #category : #'start-stop' }
WrFetchClient >> start [

	| hash |
	super start.
	self serverUrl: 'repl/' , self class compileTag.
	self addInputArea.
	hash := window unescape: (window location at: #hash) allButFirst.
	hash = '' ifTrue: [ ^ self ].
	inputTextArea value: hash.
	self eval
]
