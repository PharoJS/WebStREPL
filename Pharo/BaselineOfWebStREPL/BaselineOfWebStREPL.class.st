Class {
	#name : #BaselineOfWebStREPL,
	#superclass : #BaselineOf,
	#category : #BaselineOfWebStREPL
}

{ #category : #baselines }
BaselineOfWebStREPL >> baseline: spec [

	<baseline>
	spec
		baseline: 'PharoJS'
		with: [ spec repository: 'github://PharoJS/PharoJS:pharo9' ].

	spec package: 'WebStREPL' with: [ spec requires: #( 'PharoJS' ) ];
		package: 'WebStREPLTests' with: [ spec requires: #( 'WebStREPL' ) ].
]
