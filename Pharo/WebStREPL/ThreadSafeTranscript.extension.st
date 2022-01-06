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
ThreadSafeTranscript >> javascriptName [

	^ 'Transcript'
]

{ #category : #'*WebStREPL' }
ThreadSafeTranscript >> nameToUseForJsConversion [

" this is here because we want an *instance* of ThreadSafeTranscript to act like a class for PharoJS "
	^ 'Transcript'
]

{ #category : #'*WebStREPL' }
ThreadSafeTranscript >> superclass [

	^ nil
]
