Class {
	#name : #WrWebSocketClientTest,
	#superclass : #WrClientTest,
	#category : #'WebStREPLTests-WebSocket'
}

{ #category : #'suite parameters' }
WrWebSocketClientTest class >> appClass [

	^ WrWebSocketClient 
]

{ #category : #tests }
WrWebSocketClientTest >> send: aString [

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
WrWebSocketClientTest >> serverClass [

	^ WrWebSocketServer
]

{ #category : #tests }
WrWebSocketClientTest >> setUp [
	super setUp.
	self basicSetUp.
	app serverUrl: server replUrl printString
]

{ #category : #tests }
WrWebSocketClientTest >> testUI [

	| outputZone |
	(document getElementById: #inputTextArea) textContent: '6 * 7'.
	(document getElementById: #evalButton) click.
	outputZone := document getElementById: #outputZone.
	self assert: outputZone textContent equals: '42'
]
