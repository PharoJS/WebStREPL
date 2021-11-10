Class {
	#name : #WrFetchServer,
	#superclass : #PjBridgeServer,
	#instVars : [
		'replRequestHandler'
	],
	#category : #'WebStREPL-Fetch'
}

{ #category : #accessing }
WrFetchServer >> handleRequest: request [

	^ znServer delegate handleRequest: request
]

{ #category : #accessing }
WrFetchServer >> initialize [

	| codeGenerator jsExporter |
	super initialize.
	replRequestHandler := ZnReadEvalPrintDelegate new.
	codeGenerator := WrFetchCodeGenerator new.
	self css: codeGenerator css.
	self favicon: codeGenerator favicon.
	self html: codeGenerator html.
	jsExporter := PjExporter new.
	jsExporter initializeWithAppClass: WrFetchClient.
	self javascript: jsExporter javascriptCode
]

{ #category : #'instance creation' }
WrFetchServer >> newDefaultZnServerDelegate [

	| delegate |
	delegate := super newDefaultZnServerDelegate.
	delegate map: #repl to: [ :request | 
		replRequestHandler handleRequest: request ].
	^ delegate
]

{ #category : #accessing }
WrFetchServer >> replUrl [

	^ self url/  #repl
]
