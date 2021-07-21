Class {
	#name : #WrWebSocketClient,
	#superclass : #WrFileBasedClient,
	#category : #'WebStREPL-WebSocket'
}

{ #category : #description }
WrWebSocketClient class >> appJsSubFolder [

	<pharoJsSkip>
	^ 'js'
]

{ #category : #evaluating }
WrWebSocketClient >> send: aString withResponseDo: aBlock [

	^nil
]
