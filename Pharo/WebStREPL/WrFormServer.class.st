Class {
	#name : #WrFormServer,
	#superclass : #WrCommonServer,
	#category : #'WebStREPL-Form'
}

{ #category : #initialization }
WrFormServer class >> defaultPort [
	^7042
]

{ #category : #initialization }
WrFormServer class >> webRequestHandlerClass [
	^ WrFetchServerDelegate
]
