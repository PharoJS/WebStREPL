Class {
	#name : #WrCommonServer,
	#superclass : #Object,
	#instVars : [
		'zincServer'
	],
	#category : #'WebStREPL-Common'
}

{ #category : #initialization }
WrCommonServer class >> defaultPort [
	^7042
]

{ #category : #initialization }
WrCommonServer class >> webRequestHandlerClass [
	^ self subclassResponsibility
]

{ #category : #initialization }
WrCommonServer >> initialize [

	super initialize.
	zincServer := ZnManagingMultiThreadedServer new.
	zincServer delegate: self class webRequestHandlerClass new.
	self port: self class defaultPort
]

{ #category : #running }
WrCommonServer >> isReady [
	^zincServer isRunning and: [zincServer isListening]
]

{ #category : #accessing }
WrCommonServer >> localUrl [
	^ zincServer localUrl
]

{ #category : #accessing }
WrCommonServer >> port [
	^zincServer port
]

{ #category : #initialization }
WrCommonServer >> port: portNumber [
	zincServer port: portNumber
]

{ #category : #running }
WrCommonServer >> start [
	zincServer start
]

{ #category : #running }
WrCommonServer >> stop [

	zincServer stop
]
