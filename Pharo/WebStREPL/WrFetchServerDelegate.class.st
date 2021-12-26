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

	| jsCode |
	jsCode := self transpile: request entity contents.
	^ ZnResponse ok: (ZnEntity text: jsCode)
]

{ #category : #public }
WrFetchServerDelegate >> handleRequest: request [
	[ request uri firstPathSegment = '' ] whileTrue: [ request uri removeFirstPathSegment ].
	^ super handleRequest: request
]

{ #category : #handling }
WrFetchServerDelegate >> transpile: stCode [

	| someClass classesToSkip |
	[ 
	someClass := Class new.
	someClass class compile: 'replMethod ^[' , stCode , ']'.
	classesToSkip := PjExporter bootstrapClasses collect: [ : each | each classToUseForJsConversion ].
	^ PjDependentTranspiler new
		  pharoJsSelectorPrefix: 'pj_';
		  alreadyConvertedClasses: classesToSkip;
		  addAlreadyDefinedClasses: classesToSkip;
		  convertToJs: someClass replMethod ]
		on: Exception
		do: [ :ex | ^ 'Error: ' , ex printString ]
]
