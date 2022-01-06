Class {
	#name : #WrTranscript,
	#superclass : #Object,
	#traits : 'PjTExtensionClass',
	#classTraits : 'PjTExtensionClass classTrait',
	#classInstVars : [
		'element'
	],
	#category : #'WebStREPL-Common'
}

{ #category : #visibility }
WrTranscript class >> cr [

	self show: '
'
]

{ #category : #visibility }
WrTranscript class >> show: anObject [

	WrFetchClient addToTranscript: anObject asString
]

{ #category : #visibility }
WrTranscript class >> showLf: anObject [

	self show: anObject.
	self cr
]
