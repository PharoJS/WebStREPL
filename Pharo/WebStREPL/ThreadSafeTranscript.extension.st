Extension { #name : #ThreadSafeTranscript }

{ #category : #'*WebStREPL' }
ThreadSafeTranscript >> classToUseForJsConversion [

	^ WrTranscript
]

{ #category : #'*WebStREPL' }
ThreadSafeTranscript >> isClass [
	^ true
]

{ #category : #'*WebStREPL' }
ThreadSafeTranscript >> javascriptIsExportableClass [

	^ true
]

{ #category : #'*WebStREPL' }
ThreadSafeTranscript >> nameToUseForJsConversion [

	^ 'WrThread'
]

{ #category : #'*WebStREPL' }
ThreadSafeTranscript >> superclass [

	^ nil
]
