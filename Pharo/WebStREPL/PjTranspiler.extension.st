Extension { #name : #PjTranspiler }

{ #category : #'*WebStREPL' }
PjTranspiler >> postCopy [

	super postCopy.
	generatedMethods := generatedMethods copy.
	converter := self defaultConverterClass new.
	converter transpiler: self.
	converter addAllMessageConversions: self defaultMessageConversions.
	generator := self defaultGeneratorClass new transpiler: self.
	neededDNUs := neededDNUs copy.
	writtenDNUs := writtenDNUs copy.
	poolsUsed := poolsUsed copy.
	classesReferencingCache := classesReferencingCache copy
]
