Class {
	#name : #WrFetchServer,
	#superclass : #WrFileBasedServer,
	#category : #'WebStREPL-Fetch'
}

{ #category : #initialization }
WrFetchServer class >> defaultPort [
	^7042
]

{ #category : #initialization }
WrFetchServer >> webRequestHandlerClass [
	^ZnReadEvalPrintDelegate 
]
