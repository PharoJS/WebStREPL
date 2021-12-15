Class {
	#name : #WrFetchClientTest,
	#superclass : #PjWebAppTestCase,
	#traits : 'PjTAppRunsInJS',
	#classTraits : 'PjTAppRunsInJS classTrait',
	#instVars : [
		'server'
	],
	#category : #'WebStREPLTests-Fetch'
}

{ #category : #'suite parameters' }
WrFetchClientTest class >> appClass [ 	
	^WrFetchClient 
]

{ #category : #tests }
WrFetchClientTest >> assert: command result: result [

	| response responseForComparison |
	response := (self send: command) asString.
	responseForComparison := response copyWithoutAll: String crlf.
	self assert: responseForComparison equals: result
]

{ #category : #tests }
WrFetchClientTest >> send: aString [

	| responseKey responseHandlingBlock |
	responseKey := #WebStReplResponse.
	window at: responseKey put: nil.
	responseHandlingBlock := self evalBlock: [ 
		                         [ :jsCode | 
		                         | jsSideBlock result |
		                         jsSideBlock := window eval: jsCode.
		                         result := jsSideBlock value.
		                         window at: responseKey put: result ] ].
	app send: aString withResponseDo: responseHandlingBlock.
	self
		waitWhile: [ (window at: responseKey) isNil ].
	^ window at: responseKey
]

{ #category : #tests }
WrFetchClientTest >> server [
	^server
]

{ #category : #tests }
WrFetchClientTest >> serverClass [

	^ WrFetchServer
]

{ #category : #tests }
WrFetchClientTest >> setUp [

	super setUp.
	server := self serverClass new.
	server start.
	self bridge server znServer delegate
		map: #repl
		to: [ :request | self server handleRequest: request ].
	app serverUrl: (self bridge serverUrl / 'repl') asString
]

{ #category : #tests }
WrFetchClientTest >> tearDown [

	super tearDown.
	server stop
]

{ #category : #tests }
WrFetchClientTest >> testArithmetics [

	self assert: '1+2' result: '3'.
	self assert: '1-2' result: '-1'.
	self assert: '6 * 7' result: '42'.
	self assert: '154 / 2' result: '77'.

]

{ #category : #tests }
WrFetchClientTest >> testEquality [

	#( '42=42' '''abc'' = ''abc''' ) do: [ :each | 
		self assert: each result: 'true' ].
	#( '42=#somethingElse' '''abc'' = 123' ) do: [ :each | 
		self assert: each result: 'false' ]
]

{ #category : #tests }
WrFetchClientTest >> testUI [

	| outputZone |
	(document getElementById: #inputTextArea) textContent: '6 * 7'.
	(document getElementById: #evalButton) click.
	outputZone := document getElementById: #outputZone.
	self waitUntil:  [outputZone textContent trim = '42']
]
