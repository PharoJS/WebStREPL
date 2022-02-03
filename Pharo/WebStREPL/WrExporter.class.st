"
I am an exporter to use the WrTranspiler.
"
Class {
	#name : #WrExporter,
	#superclass : #PjExporter,
	#category : #'WebStREPL-Fetch'
}

{ #category : #accessing }
WrExporter class >> transpilerClass [

	^ WrTranspiler
]
