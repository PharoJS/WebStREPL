Class {
	#name : #WrServerTest,
	#superclass : #TestCase,
	#instVars : [
		'server'
	],
	#category : #WebStREPLTests
}

{ #category : #'suite parameters' }
WrServerTest class >> appClass [ 
	^WrClient
]

{ #category : #tests }
WrServerTest >> assert: command result: result [

	| response |
	response := (self send: command) copyWithoutAll: String crlf.
	self assert: response equals: result
]

{ #category : #tests }
WrServerTest >> send: aString [
	^ZnClient new
		            url: server localUrl;
		            addPathSegment: #repl;
		            contents: aString;
		            post
]

{ #category : #tests }
WrServerTest >> setUp [
	super setUp.
	server := WrServer new.
	server start
]

{ #category : #tests }
WrServerTest >> tearDown [

	super tearDown.
	server stop
]

{ #category : #tests }
WrServerTest >> testArithmetics [

	self assert: '1+2' result: '3'.
	self assert: '1-2' result: '-1'.
	self assert: '6 * 7' result: '42'.
	self assert: '154 / 2' result: '77'.

]

{ #category : #tests }
WrServerTest >> testEquality [

	#( '42=42' '''abc'' = ''abc''' ) do: [ :each | 
		self assert: each result: 'true' ].
	#( '42=#somethingElse' '''abc'' = 123' ) do: [ :each | 
		self assert: each result: 'false' ]
]
