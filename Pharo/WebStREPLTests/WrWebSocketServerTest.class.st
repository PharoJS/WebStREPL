Class {
	#name : #WrWebSocketServerTest,
	#superclass : #TestCase,
	#traits : 'WrTTestCase',
	#classTraits : 'WrTTestCase classTrait',
	#category : #'WebStREPLTests-WebSocket'
}

{ #category : #tests }
WrWebSocketServerTest >> send: aString [

	^ ZnClient new
		  url: server replUrl;
		  contents: aString;
		  post
]

{ #category : #tests }
WrWebSocketServerTest >> serverClass [

	^ WrWebSocketServer 
]
