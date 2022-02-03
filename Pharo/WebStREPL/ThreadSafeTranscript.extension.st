Extension { #name : #ThreadSafeTranscript }

{ #category : #'*WebStREPL' }
ThreadSafeTranscript >> classSide [
	^ self
]

{ #category : #'*WebStREPL' }
ThreadSafeTranscript >> classToUseForJsConversion [

	^ WrTranscript
]

{ #category : #'*WebStREPL' }
ThreadSafeTranscript >> isClass [
	^ true
]

{ #category : #'*WebStREPL' }
ThreadSafeTranscript >> isDeprecated [
	^ false
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
ThreadSafeTranscript >> selectorsDo: aFullBlockClosure [ 

]

{ #category : #'*WebStREPL' }
ThreadSafeTranscript >> superclass [

	^ nil
]
