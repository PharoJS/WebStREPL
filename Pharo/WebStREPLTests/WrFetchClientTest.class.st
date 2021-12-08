Class {
	#name : #WrFetchClientTest,
	#superclass : #PjWebAppTestCase,
	#traits : '(PjTAppRunsInJS + (WrTTestCase @ {#basicSetUp->#setUp})) - {#setUp}',
	#classTraits : 'PjTAppRunsInJS classTrait + WrTTestCase classTrait',
	#category : #'WebStREPLTests-Fetch'
}

{ #category : #'suite parameters' }
WrFetchClientTest class >> appClass [ 	
	^WrFetchClient 
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
WrFetchClientTest >> serverClass [

	^ WrFetchServer
]

{ #category : #tests }
WrFetchClientTest >> setUp [

	super setUp.
	self basicSetUp.
	self bridge server znServer delegate
		map: #repl
		to: [ :request |
			self server handleRequest: request ].
	app serverUrl: (self bridge serverUrl / 'repl') asString
]

{ #category : #tests }
WrFetchClientTest >> testUI [

	| outputZone |
	(document getElementById: #inputTextArea) textContent: '6 * 7'.
	(document getElementById: #evalButton) click.
	outputZone := document getElementById: #outputZone.
	self waitUntil:  [outputZone textContent trim = '42']
]
