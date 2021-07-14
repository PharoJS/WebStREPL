Class {
	#name : #WrServerTest,
	#superclass : #TestCase,
	#traits : 'WrTTestCase',
	#classTraits : 'WrTTestCase classTrait',
	#category : #WebStREPLTests
}

{ #category : #tests }
WrServerTest >> send: aString [

	^ ZnClient new
		  url: server replUrl;
		  contents: aString;
		  post
]
