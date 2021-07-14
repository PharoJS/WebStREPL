Trait {
	#name : #WrTTestCase,
	#instVars : [
		'server'
	],
	#category : #WebStREPLTests
}

{ #category : #tests }
WrTTestCase >> assert: command result: result [

	| response responseForComparison |
	response := (self send: command) asString.
	responseForComparison := response copyWithoutAll: String crlf.
	self assert: responseForComparison equals: result
]

{ #category : #tests }
WrTTestCase >> send: aString [
	self explicitRequirement 
]

{ #category : #tests }
WrTTestCase >> setUp [
	super setUp.
	server := WrServer new.
	server start
]

{ #category : #tests }
WrTTestCase >> tearDown [

	super tearDown.
	server stop
]

{ #category : #tests }
WrTTestCase >> testArithmetics [

	self assert: '1+2' result: '3'.
	self assert: '1-2' result: '-1'.
	self assert: '6 * 7' result: '42'.
	self assert: '154 / 2' result: '77'.

]

{ #category : #tests }
WrTTestCase >> testEquality [

	#( '42=42' '''abc'' = ''abc''' ) do: [ :each | 
		self assert: each result: 'true' ].
	#( '42=#somethingElse' '''abc'' = 123' ) do: [ :each | 
		self assert: each result: 'false' ]
]
