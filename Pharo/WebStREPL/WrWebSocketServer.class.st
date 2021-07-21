Class {
	#name : #WrWebSocketServer,
	#superclass : #WrFileBasedServer,
	#category : #'WebStREPL-WebSocket'
}

{ #category : #initialization }
WrWebSocketServer class >> defaultPort [
	^7042
]

{ #category : #initialization }
WrWebSocketServer >> webRequestHandlerClass [
	^ZnReadEvalPrintDelegate 
]
