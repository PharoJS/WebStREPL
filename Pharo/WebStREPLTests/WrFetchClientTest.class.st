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
WrFetchClientTest >> clickEvalButton [

	^ self evalBlock: [ 
		  WrFetchClient currentInstance evalButton click ]
]

{ #category : #tests }
WrFetchClientTest >> inputText: aString [

	^ self evalBlock: [ 
		  WrFetchClient currentInstance inputTextArea value: aString ]
]

{ #category : #tests }
WrFetchClientTest >> outputText [

	^ self evalBlock: [ WrFetchClient currentInstance outputZone textContent]
]

{ #category : #tests }
WrFetchClientTest >> outputText: aString [

	^ self evalBlock: [ 
		  WrFetchClient currentInstance outputZone textContent: aString ]
]

{ #category : #tests }
WrFetchClientTest >> send: aString [

	| waitForResultString |
	waitForResultString := '-- wait+For-Result String!!!'.
	self outputText: waitForResultString.
	self inputText: aString.
	self clickEvalButton.
	self waitWhile: [ 
		self outputText = waitForResultString ].
	^ self outputText
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
	self assert: '42/0' result: 'ZeroDivide'.
	self assert: 'Float infinity' result: 'Float infinity'
]

{ #category : #tests }
WrFetchClientTest >> testEmptyInput [

	self assert: '' result: 'nil'
]

{ #category : #tests }
WrFetchClientTest >> testEquality [

	#( '42=42' '''abc'' = ''abc''' ) do: [ :each | 
		self assert: each result: 'true' ].
	#( '42=#somethingElse' '''abc'' = 123' ) do: [ :each | 
		self assert: each result: 'false' ]
]

{ #category : #tests }
WrFetchClientTest >> testExceptions [

	self assert: 'ZeroDivide signal' result: 'ZeroDivide'.
	self assert: 'Error signal' result: 'Error'
]

{ #category : #tests }
WrFetchClientTest >> testStrings [

	self assert: '''Hello''' result: '''Hello'''.
	self assert: '''Hello Pharo!''' result: '''Hello Pharo!'''.
	self
		assert: '''String with ''''quotes'''' around some word'''
		result: '''String with ''''quotes'''' around some word'''
]

{ #category : #tests }
WrFetchClientTest >> testTemporaryAuthorNameSet [

	Author useAuthor: nil during: [ self assert: '4+3' result: '7' ]
]
