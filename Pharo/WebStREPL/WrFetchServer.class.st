Class {
	#name : #WrFetchServer,
	#superclass : #WrCommonServer,
	#category : #'WebStREPL-Fetch'
}

{ #category : #initialization }
WrFetchServer class >> defaultPort [
	^7042
]

{ #category : #initialization }
WrFetchServer class >> webRequestHandlerClass [
	^ZnReadEvalPrintDelegate 
]

{ #category : #accessing }
WrFetchServer >> replUrl [

	^ self localUrl
		  addPathSegment: #repl;
		  yourself
]
