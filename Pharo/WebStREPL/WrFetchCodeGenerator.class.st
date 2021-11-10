Class {
	#name : #WrFetchCodeGenerator,
	#superclass : #PjClientCodeGenerator,
	#category : #'WebStREPL-Fetch'
}

{ #category : #initialization }
WrFetchCodeGenerator >> initialize [
	super initialize.
	appClass := WrFetchClient.
	
]
