Class {
	#name : #WrFormServer,
	#superclass : #Object,
	#instVars : [
		'zincServer'
	],
	#category : #'WebStREPL-Server'
}

{ #category : #initialization }
WrFormServer class >> defaultPort [
	^7042
]

{ #category : #initialization }
WrFormServer >> defaultPort [
	^self class defaultPort
]

{ #category : #initialization }
WrFormServer >> initialize [

	super initialize.
	zincServer := ZnManagingMultiThreadedServer new.
	zincServer delegate: self webRequestHandlerClass new.
	self port: self defaultPort
]

{ #category : #running }
WrFormServer >> isReady [
	^zincServer isRunning and: [zincServer isListening]
]

{ #category : #accessing }
WrFormServer >> port [
	^zincServer port
]

{ #category : #initialization }
WrFormServer >> port: portNumber [
	zincServer port: portNumber
]

{ #category : #accessing }
WrFormServer >> replUrl [

	^ zincServer localUrl
		  addPathSegment: #repl;
		  yourself
]

{ #category : #running }
WrFormServer >> start [
	zincServer start
]

{ #category : #running }
WrFormServer >> stop [

	zincServer stop
]

{ #category : #initialization }
WrFormServer >> webRequestHandlerClass [
	^WrFormServerDelegate 
]
