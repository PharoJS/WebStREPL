"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestWebStREPL,
	#superclass : #PackageManifest,
	#category : #'WebStREPL-Manifest'
}

{ #category : #'code-critics' }
ManifestWebStREPL class >> ruleBadMessageRule2V1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#WrFormServerDelegate #handleRequest: #false)) #'2021-07-14T21:53:06.316455-04:00') )
]

{ #category : #'code-critics' }
ManifestWebStREPL class >> ruleUtilityMethodsRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#WrFormServerDelegate #index: #false)) #'2021-07-14T23:30:32.276741-04:00') #(#(#RGMethodDefinition #(#WrFormServerDelegate #css: #false)) #'2021-07-14T23:47:04.00281-04:00') )
]
