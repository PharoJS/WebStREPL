Class {
	#name : #WrFetchServer,
	#superclass : #PjBridgeServer,
	#instVars : [
		'replRequestHandler',
		'alreadyClasses'
	],
	#classVars : [
		'AlreadyClasses',
		'GeneratingTranspiler'
	],
	#category : #'WebStREPL-Fetch'
}

{ #category : #accessing }
WrFetchServer class >> alreadyClasses [
	^ AlreadyClasses
]

{ #category : #accessing }
WrFetchServer class >> generatingTranspilerCopy [

^ GeneratingTranspiler copy
]

{ #category : #'initialize-release' }
WrFetchServer >> handleEvaluateRequest: request [

	Author useAuthor: 'WebStREPL' during: [^ self delegate handleEvaluateRequest: request]
]

{ #category : #accessing }
WrFetchServer >> handleRequest: request [

	^ self delegate handleRequest: request
]

{ #category : #'initialize-release' }
WrFetchServer >> initialize [

	| codeGenerator jsExporter |
	super initialize.
	codeGenerator := WrFetchCodeGenerator new.
	self css: codeGenerator css.
	self favicon: codeGenerator favicon.
	self html: codeGenerator html.
	jsExporter := PjExporter new.
	jsExporter initializeWithAppClass: WrFetchClient.
	self javascript: jsExporter javascriptCode.
	GeneratingTranspiler := jsExporter transpiler.

]

{ #category : #'initialize-release' }
WrFetchServer >> newServerDelegate [

	| delegate |
	delegate := super newServerDelegate.
	delegate
		map: WrFetchClient compileTag
		to: [ :request | self handleEvaluateRequest: request ].
	^ delegate
]

{ #category : #'initialize-release' }
WrFetchServer >> serverDelegateClass [ 
	^WrFetchServerDelegate 
]
