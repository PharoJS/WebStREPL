Class {
	#name : #WrFetchServerTest,
	#superclass : #TestCase,
	#traits : 'WrTTestCase',
	#classTraits : 'WrTTestCase classTrait',
	#category : #'WebStREPLTests-Fetch'
}

{ #category : #tests }
WrFetchServerTest >> send: aString [

	^ ZnClient new
		  url: server replUrl;
		  contents: aString;
		  post
]
