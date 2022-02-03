Extension { #name : #Object }

{ #category : #'*WebStREPL' }
Object >> asWRON [

	^ String streamContents: [ :s | self printWrOn: s ]
]

{ #category : #'*WebStREPL' }
Object >> printWrOn: aStream [

	self printJsOn: aStream
]
