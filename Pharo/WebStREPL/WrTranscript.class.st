Class {
	#name : #WrTranscript,
	#superclass : #Object,
	#traits : 'PjTExtensionClass',
	#classTraits : 'PjTExtensionClass classTrait',
	#classInstVars : [
		'element'
	],
	#category : #'WebStREPL-Fetch'
}

{ #category : #visibility }
WrTranscript class >> cr [

	self show: 10 asCharacter asString
]

{ #category : #visibility }
WrTranscript class >> crShow: anObject [

	self cr.
		self show: anObject.

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

{ #category : #visibility }
WrTranscript class >> showlf: anObject [

	self show: anObject.
	self cr
]
