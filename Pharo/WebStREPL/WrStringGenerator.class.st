"
I am a string generator to generate PjCharacters and PjSymbol rather than making everything strings
"
Class {
	#name : #WrStringGenerator,
	#superclass : #PjStringGenerator,
	#category : #'WebStREPL-Fetch'
}

{ #category : #accessing }
WrStringGenerator class >> transpilerClass [

	^ WrTranspiler
]

{ #category : #printing }
WrStringGenerator >> print: anObject [

	anObject ifNotNil: [Transcript
		crShow: anObject printString;
		nextPutAll: ' -> ';
		show: anObject asWRON].
	anObject printWrOn: self jsStream
]
