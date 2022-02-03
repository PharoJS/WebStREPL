"
I am a bridge class. My purpose is to hold methods that should be migrated up to PjString in a refactoring.
"
Class {
	#name : #WrString,
	#superclass : #PjString,
	#category : #'WebStREPL-PharoJS'
}

{ #category : #accessing }
WrString >> eighth [

	^ self at: 8
]

{ #category : #accessing }
WrString >> fifth [

	^ self at: 5
]

{ #category : #accessing }
WrString >> first [
	^ self at: 1
]

{ #category : #accessing }
WrString >> fourth [

	^ self at: 4
]

{ #category : #accessing }
WrString >> second [

	^ self at: 2
]

{ #category : #accessing }
WrString >> seventh [

	^ self at: 7
]

{ #category : #accessing }
WrString >> sixth [

	^ self at: 6
]

{ #category : #accessing }
WrString >> third [

	^ self at: 3
]
