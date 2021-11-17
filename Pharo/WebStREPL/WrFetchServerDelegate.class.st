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

{ #category : #handling }
WrFetchServerDelegate >> transpile: stCode [

	| someClass |
	[ 
	someClass := Class new.
	someClass class compile: 'replMethod ^[' , stCode , ']'.
	^ PjDependentTranspiler new
		  pharoJsSelectorPrefix: 'pj_';
		  alreadyConvertedClasses: PjExporter bootstrapClasses;
		addAlreadyDefinedClasses:  PjExporter bootstrapClasses;
		  convertToJs: someClass replMethod ]
		on: Exception
		do: [ :ex | ^ 'Error: ' , ex printString ]
]
