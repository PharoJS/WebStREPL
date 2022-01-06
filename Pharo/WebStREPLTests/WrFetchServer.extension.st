Extension { #name : #WrFetchServer }

{ #category : #'*WebStREPLTests' }
WrFetchServer >> replUrl [

	^ self url / WrFetchClient compileTag
]
