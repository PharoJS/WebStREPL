Class {
	#name : #WrFetchServer,
	#superclass : #Object,
	#instVars : [
		'zincServer'
	],
	#category : #'WebStREPL-Fetch'
}

{ #category : #initialization }
WrFetchServer class >> defaultPort [
	^7042
]

{ #category : #initialization }
WrFetchServer >> defaultPort [
	^self class defaultPort
]

{ #category : #initialization }
WrFetchServer >> initialize [

	super initialize.
	zincServer := ZnManagingMultiThreadedServer new.
	zincServer delegate: self webRequestHandlerClass new.
	self port: self defaultPort
]

{ #category : #running }
WrFetchServer >> isReady [
	^zincServer isRunning and: [zincServer isListening]
]

{ #category : #accessing }
WrFetchServer >> port [
	^zincServer port
]

{ #category : #initialization }
WrFetchServer >> port: portNumber [
	zincServer port: portNumber
]

{ #category : #accessing }
WrFetchServer >> replUrl [

	^ zincServer localUrl
		  addPathSegment: #repl;
		  yourself
]

{ #category : #running }
WrFetchServer >> start [
	zincServer start
]

{ #category : #running }
WrFetchServer >> stop [

	zincServer stop
]

{ #category : #initialization }
WrFetchServer >> webRequestHandlerClass [
	^ZnReadEvalPrintDelegate 
]
