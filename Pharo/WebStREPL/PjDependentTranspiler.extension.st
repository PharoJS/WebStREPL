Extension { #name : #PjDependentTranspiler }

{ #category : #'*WebStREPL' }
PjDependentTranspiler >> postCopy [

	super postCopy.
	convertedMethods := convertedMethods copy.
	classesToConvert := classesToConvert copy.
	convertedClasses := convertedClasses copy.
	alreadyDefinedClasses := alreadyDefinedClasses copy.
	alreadyInitializedClasses := alreadyInitializedClasses copy.
	alreadyInheritanceLinkedClasses := alreadyInheritanceLinkedClasses copy.
	alreadyVariablesDeclaredClasses := alreadyVariablesDeclaredClasses copy.
	globalPools := globalPools copy
]
