Class {
	#name : #WrFetchClientTest,
	#superclass : #WrClientTest,
	#category : #'WebStREPLTests-Fetch'
}

{ #category : #'suite parameters' }
WrFetchClientTest class >> appClass [ 	
	^WrFetchClient 
]

{ #category : #tests }
WrFetchClientTest >> serverClass [

	^ WrFetchServer
]
