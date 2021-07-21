Class {
	#name : #WrClientTest,
	#superclass : #PjWebAppTestCase,
	#traits : '(PjTAppRunsInJS + (WrTTestCase @ {#basicSetUp->#setUp})) - {#setUp}',
	#classTraits : 'PjTAppRunsInJS classTrait + WrTTestCase classTrait',
	#category : #'WebStREPLTests-Fetch'
}

{ #category : #testing }
WrClientTest class >> isAbstract [

	^ self == WrClientTest or: [ ^super isAbstract ]
]
