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
