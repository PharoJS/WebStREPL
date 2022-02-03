Extension { #name : #Symbol }

{ #category : #'*WebStREPL' }
Symbol >> printWrOn: jsStream [

	jsStream nextPutAll: '(new PjSymbol().pj_with_('.
	self asString printJsOn: jsStream.
	jsStream nextPutAll: '))'
]
