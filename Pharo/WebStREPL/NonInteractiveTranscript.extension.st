Extension { #name : #NonInteractiveTranscript }

{ #category : #'*WebStREPL' }
NonInteractiveTranscript >> classToUseForJsConversion [

	^ WrTranscript
]

{ #category : #'*WebStREPL' }
NonInteractiveTranscript >> isClass [

	^ true
]

{ #category : #'*WebStREPL' }
NonInteractiveTranscript >> javascriptIsExportableClass [

	^ true
]

{ #category : #'*WebStREPL' }
NonInteractiveTranscript >> javascriptName [

	^ 'Transcript'
]

{ #category : #'*WebStREPL' }
NonInteractiveTranscript >> nameToUseForJsConversion [

	" this is here because we want an *instance* of ThreadSafeTranscript to act like a class for PharoJS "

	^ 'Transcript'
]

{ #category : #'*WebStREPL' }
NonInteractiveTranscript >> superclass [

	^ nil
]
