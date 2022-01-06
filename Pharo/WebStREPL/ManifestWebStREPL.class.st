"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestWebStREPL,
	#superclass : #PackageManifest,
	#category : #'WebStREPL-Manifest'
}

{ #category : #'code-critics' }
ManifestWebStREPL class >> ruleSentNotImplementedRuleV1FalsePositive [
	^ #(#(#(#RGClassDefinition #(#WrFetchClient)) #'2021-12-23T12:44:15.389672-05:00') )
]

{ #category : #'code-critics' }
ManifestWebStREPL class >> ruleUtilityMethodsRuleV1FalsePositive [
	^ #(#(#(#RGClassDefinition #(#WrFetchServerDelegate)) #'2021-12-31T15:15:33.760092-05:00') )
]
