Class {
	#name : #WrFetchServerDelegate,
	#superclass : #WrServerDelegate,
	#category : #'WebStREPL-Fetch'
}

{ #category : #'public access' }
WrFetchServerDelegate >> evaluate: string [

	| output |
	1 halt.
	output := String streamContents: [ :out | 
		          [ 
		          | compiler result |
		          compiler := [ self class compiler ]
			                      on: MessageNotUnderstood
			                      do: [ 
			                      Smalltalk at: #Compiler "for Pharo 2.0" ].
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

{ #category : #responses }
WrFetchServerDelegate >> index: request html: html [
	| query |
	query := request uri queryAt: #q ifAbsent: [''].
	html
		tag: #p with: 'Type in any Smalltalk code, then hit the "Eval" button';
		tag: #form attributes: #(method 'GET') do: [
			html
				tag: #textarea attributes: #(id inputTextArea name q) with: query;
				tag: #button attributes: #(id evalButton) with: 'Eval';
				tag: #br; tag: #br.
				query isEmptyOrNil ifFalse: [
					html tag: #code with: (self evaluate: query)
				].
		]
]
