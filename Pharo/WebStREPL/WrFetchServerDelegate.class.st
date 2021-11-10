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

	| result |
	result := self evaluate: request entity.
	^ ZnResponse ok: (ZnEntity text: result)
]
