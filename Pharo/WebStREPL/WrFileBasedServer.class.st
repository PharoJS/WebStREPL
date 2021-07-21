Class {
	#name : #WrFileBasedServer,
	#superclass : #Object,
	#instVars : [
		'zincServer'
	],
	#category : #'WebStREPL-Common'
}

{ #category : #initialization }
WrFileBasedServer class >> defaultPort [
	^7042
]

{ #category : #initialization }
WrFileBasedServer >> defaultPort [
	^self class defaultPort
]

{ #category : #initialization }
WrFileBasedServer >> initialize [

	super initialize.
	zincServer := ZnManagingMultiThreadedServer new.
	zincServer delegate: self webRequestHandlerClass new.
	self port: self defaultPort
]

{ #category : #running }
WrFileBasedServer >> isReady [
	^zincServer isRunning and: [zincServer isListening]
]

{ #category : #accessing }
WrFileBasedServer >> port [
	^zincServer port
]

{ #category : #initialization }
WrFileBasedServer >> port: portNumber [
	zincServer port: portNumber
]

{ #category : #accessing }
WrFileBasedServer >> replUrl [

	^ zincServer localUrl
		  addPathSegment: #repl;
		  yourself
]

{ #category : #running }
WrFileBasedServer >> start [
	zincServer start
]

{ #category : #running }
WrFileBasedServer >> stop [

	zincServer stop
]

{ #category : #initialization }
WrFileBasedServer >> webRequestHandlerClass [

	^ self subclassResponsibility 
]
