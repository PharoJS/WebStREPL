Extension { #name : #PjString }

{ #category : #'*WebStREPL' }
PjString >> asSymbolX [
^ PjSymbol with: self
	
]

{ #category : #'*WebStREPL' }
PjString >> firstX [

	^ PjCharacter with: (self at: 1)
]
