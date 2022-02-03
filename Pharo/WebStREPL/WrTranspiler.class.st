"
I am a transpiler to use WrStringGenerator
"
Class {
	#name : #WrTranspiler,
	#superclass : #PjDependentTranspiler,
	#category : #'WebStREPL-Fetch'
}

{ #category : #initialization }
WrTranspiler >> defaultGeneratorClass [

	^ WrStringGenerator
]
