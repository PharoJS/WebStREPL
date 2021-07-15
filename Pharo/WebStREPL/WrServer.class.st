"
I am a minimal Zinc web server.

To demo, do `server := WrServer new.	server start.` in a playground. Then visit `http://localhost:7042/index.html?q=61+factorial` in a web browser.
"
Class {
	#name : #WrServer,
	#superclass : #Object,
	#instVars : [
		'zincServer'
	],
	#category : #'WebStREPL-Server'
}

{ #category : #initialization }
WrServer class >> defaultPort [
	^7042
]

{ #category : #initialization }
WrServer >> defaultPort [
	^self class defaultPort
]

{ #category : #initialization }
WrServer >> initialize [

	super initialize.
	zincServer := ZnManagingMultiThreadedServer new.
	zincServer delegate: self webRequestHandlerClass new.
	self port: self defaultPort
]

{ #category : #running }
WrServer >> isReady [
	^zincServer isRunning and: [zincServer isListening]
]

{ #category : #accessing }
WrServer >> port [
	^zincServer port
]

{ #category : #initialization }
WrServer >> port: portNumber [
	zincServer port: portNumber
]

{ #category : #accessing }
WrServer >> replUrl [

	^ zincServer localUrl
		  addPathSegment: #repl;
		  yourself
]

{ #category : #running }
WrServer >> start [
	zincServer start
]

{ #category : #running }
WrServer >> stop [

	zincServer stop
]

{ #category : #initialization }
WrServer >> webRequestHandlerClass [
	^WrServerDelegate 
]
