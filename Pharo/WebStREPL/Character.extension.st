Extension { #name : #Character }

{ #category : #'*WebStREPL' }
Character >> printWrOn: jsStream [

	jsStream nextPutAll: '(new PjCharacter().pj_with_('.
	self asString printJsOn: jsStream.
	jsStream nextPutAll: '))'
]
