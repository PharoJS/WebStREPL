Class {
	#name : #WrClientTest,
	#superclass : #PjWebAppTestCase,
	#traits : '(PjTAppRunsInJS + (WrTTestCase @ {#basicSetUp->#setUp})) - {#setUp}',
	#classTraits : 'PjTAppRunsInJS classTrait + WrTTestCase classTrait',
	#category : #WebStREPLTests
}

{ #category : #'suite parameters' }
WrClientTest class >> appClass [ 	
	^WrClient 
]

{ #category : #tests }
WrClientTest >> send: aString [

	| responseKey responseHandlingBlock |
	responseKey := #WebStReplResponse.
	window at: responseKey put: nil.
	responseHandlingBlock := self evalBlock: [ 
		                         [ :response | 
		                         window at: responseKey put: response ] ].
	app send: aString withResponseDo: responseHandlingBlock.
	self waitWhile: [ (window at: responseKey) isNil ] timeOut: 1 second.
	^ window at: responseKey
]

{ #category : #tests }
WrClientTest >> setUp [
	super setUp.
	self basicSetUp.
	app serverUrl: server replUrl printString
]

{ #category : #tests }
WrClientTest >> testUI [

	| outputZone |
	(document getElementById: #inputTextArea) textContent: '6 * 7'.
	(document getElementById: #evalButton) click.
	outputZone := document getElementById: #outputZone.
	self assert: outputZone textContent equals: '42'
]
