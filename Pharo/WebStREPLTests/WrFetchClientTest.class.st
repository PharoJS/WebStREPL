Class {
	#name : #WrFetchClientTest,
	#superclass : #WrRemoteTesting,
	#traits : 'PjTAppRunsInJS',
	#classTraits : 'PjTAppRunsInJS classTrait',
	#category : #'WebStREPLTests-Fetch'
}

{ #category : #'suite parameters' }
WrFetchClientTest class >> appClass [ 	
	^WrFetchClient 
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
WrFetchClientTest >> testArrayStreams [

	self
		assert: 'Array streamContents: [ : stream |
	stream
		<< $I
		<< 17;
		nextPut: 42;
		<< 95 ]'
		result: '#(''I'' 42)' " should really be #($I 42)"
]

{ #category : #tests }
WrFetchClientTest >> testEmptyInput [

	{ ''. Character space. Character tab. } do: [ : each | 
		self assert: each asString result: 'nil'
	]

]

{ #category : #tests }
WrFetchClientTest >> testEnsureChangeFileIsUnchanged [
	| changesFile initialChangeSize |
	changesFile := Smalltalk changesName asFileReference.
	initialChangeSize := changesFile size.
	self assert: '1+2' result: '3'.
	self assert: changesFile size equals: initialChangeSize.

]

{ #category : #tests }
WrFetchClientTest >> testEquality [


	#( '42=42' '$I=$I' '''abc'' = ''abc''' '''123'' = 123'
	   '$I isCharacter' ) do: [ :each | self assert: each result: 'true' ]. " we'd like '123'~=123 but Javascript "
	#( '42=#somethingElse' '''I''=$I' '''I'' isCharacter'
	   '$I=''I''' '''abc'' = 123' ) do: [ :each | 
		self assert: each result: 'false' ]
]

{ #category : #tests }
WrFetchClientTest >> testExceptions [

	self assert: 'ZeroDivide signal' result: 'ZeroDivide'.
	self assert: 'Error signal' result: 'Error'
]

{ #category : #tests }
WrFetchClientTest >> testStreams [

	self assert: 'String streamContents: [:s| s << $I]' result: '''I'''
]

{ #category : #tests }
WrFetchClientTest >> testStringStreams [

String streamContents: [ : stream |
	stream
		<< $I
		<< ' love';
		space;
		nextPutAll: 'Pharo!' ].
	self
		assert: 'String streamContents: [ : stream |
	stream
		<< $I
		<< '' love'';
		space;
		nextPutAll: ''Pharo!'' ]'
		result: '''I love Pharo!'''
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

{ #category : #tests }
WrFetchClientTest >> testTranscript [

"	| jsCode |
	jsCode := WrFetchServerDelegate new transpile:
		          'Transcript show: ''hello'''.
"		self assert: '| loveString |
loveString := String streamContents: [ : stream |
	stream
		<< $I;
		space;
		<< ''love Pharo!'' ].
Transcript cr; show: loveString.' result: 42
]
