Class {
	#name : #WrFetchServerDelegate,
	#superclass : #PjBridgeServerDelegate,
	#category : #'WebStREPL-Fetch'
}

{ #category : #'public access' }
WrFetchServerDelegate >> evaluate: string [

	| output |
	output := String streamContents: [ :out | 
		          [ 
		          | compiler result |
		          compiler := self class compiler.
		          result := compiler evaluate: string.
		          out
			          print: result;
			          cr ]
			          on: Error
			          do: [ :exception | 
				          out
					          print: exception;
					          cr.
				          exception signalerContext printDetails: out.
				          exception signalerContext sender debugStack: 8 on: out ].
		          out cr ].
	^ String lf join: output lines
]

{ #category : #handling }
WrFetchServerDelegate >> handleEvaluateRequest: request [

	| jsCode stCode |
	stCode := self stCodeFromRequest: request.
	jsCode := self transpile: stCode.
	^ ZnResponse ok: (ZnEntity text: jsCode)
]

{ #category : #public }
WrFetchServerDelegate >> handleRequest: request [

	request uri firstPathSegment = 'repl' ifTrue: [ 
		request uri removeFirstPathSegment ].
	[ 
	request uri firstPathSegment = '' ] whileTrue: [ 
		request uri removeFirstPathSegment ].
	^ super handleRequest: request
]

{ #category : #handling }
WrFetchServerDelegate >> stCodeFromRequest: request [

	request entity ifNil: [ ^ '' ].
	^ request entity contents
]

{ #category : #handling }
WrFetchServerDelegate >> transpile: stCode [

	| method block|
	[ 
	method := OpalCompiler new
		         source: '[' , stCode , ']';
		         noPattern: true;
		         compileDoit.
	block := nil executeMethod: method.
	^ WrFetchServer generatingTranspilerCopy convertToJs: block ]
		on: Exception
		do: [ :ex | ^ 'Error: ' , ex printString ]
]
