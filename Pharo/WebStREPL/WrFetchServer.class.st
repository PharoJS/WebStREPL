Class {
	#name : #WrFetchServer,
	#superclass : #PjBridgeServer,
	#instVars : [
		'replRequestHandler'
	],
	#category : #'WebStREPL-Fetch'
}

{ #category : #'instance creation' }
WrFetchServer >> handleEvaluateRequest: request [

	^ self delegate handleEvaluateRequest: request
]

{ #category : #accessing }
WrFetchServer >> handleRequest: request [

	^ self delegate handleRequest: request
]

{ #category : #accessing }
WrFetchServer >> initialize [

	| codeGenerator jsExporter |
	super initialize.
	codeGenerator := WrFetchCodeGenerator new.
	self css: codeGenerator css.
	self favicon: codeGenerator favicon.
	self html: codeGenerator html.
	jsExporter := PjExporter new.
	jsExporter initializeWithAppClass: WrFetchClient.
	self javascript: jsExporter javascriptCode
]

{ #category : #'instance creation' }
WrFetchServer >> newServerDelegate [

	| delegate |
	delegate := super newServerDelegate.
	delegate
		map: #repl
		to: [ :request | self handleEvaluateRequest: request ].
	^ delegate
]

{ #category : #'instance creation' }
WrFetchServer >> serverDelegateClass [ 
	^WrFetchServerDelegate 
]
