Class {
	#name : #WrRemoteTesting,
	#superclass : #PjWebAppTestCase,
	#traits : 'PjTAppRunsInJS',
	#classTraits : 'PjTAppRunsInJS classTrait',
	#instVars : [
		'server'
	],
	#category : #'WebStREPLTests-Fetch'
}

{ #category : #tests }
WrRemoteTesting class >> ignoreClasses [

	^ { 
		  WrFetchClient.
		  PjWebApplication.
		  PjBrowserGlobals.
		  PjDOMApplication.
		  PjDomGlobals.
		  PjApplication.
		  PjUniversalGlobals.
		  PjSharedPool.
		  PjMaterializer.
		  PjDomController.
		  PjRectangle.
		  Date.
		  PjMagnitude.
		  ArithmeticError.
		  PjProxyInfo.
		  PjSortedCollection.
		  PjCollection.
		  PjStringStream.
		  PjLookupKey. GeometryError . GeometryObject . Point }
]

{ #category : #tests }
WrRemoteTesting >> assert: command result: result [

	| response responseForComparison |
	response := (self send: command) asString.
	responseForComparison := response copyWithoutAll: String crlf.
	self assert: responseForComparison equals: result
]

{ #category : #tests }
WrRemoteTesting >> clickEvalButton [

	^ self evalBlock: [ 
		  WrFetchClient currentInstance evalButton click ]
]

{ #category : #tests }
WrRemoteTesting >> ignoreClasses [
	^ self class ignoreClasses
]

{ #category : #tests }
WrRemoteTesting >> inputText: aString [

	^ self evalBlock: [ 
		  WrFetchClient currentInstance inputTextArea value: aString ]
]

{ #category : #tests }
WrRemoteTesting >> outputZone [

	^ self evalBlock: [ 
		  WrFetchClient currentInstance outputZone]
]

{ #category : #tests }
WrRemoteTesting >> send: aString [

	| initialOutputZone |
	initialOutputZone := self outputZone.
	self inputText: aString.
	self clickEvalButton.
	self waitWhile: [ self outputZone == initialOutputZone ].
	^ self outputZone textContent
]

{ #category : #tests }
WrRemoteTesting >> server [
	^server
]

{ #category : #tests }
WrRemoteTesting >> serverClass [

	^ WrFetchServer
]

{ #category : #tests }
WrRemoteTesting >> setUp [

	super setUp.
	server := self serverClass new.
	server start.
	self bridge server znServer delegate
		map: WrFetchClient compileTag
		to: [ :request | self server handleRequest: request ].
	app serverUrl:
		(self bridge serverUrl / WrFetchClient compileTag) asString
]

{ #category : #tests }
WrRemoteTesting >> tearDown [

	super tearDown.
	server stop
]
