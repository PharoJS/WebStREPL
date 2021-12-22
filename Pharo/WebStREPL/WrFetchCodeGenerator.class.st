Class {
	#name : #WrFetchCodeGenerator,
	#superclass : #PjClientCodeGenerator,
	#category : #'WebStREPL-Fetch'
}

{ #category : #initialization }
WrFetchCodeGenerator >> html [

	"Dirty. We should override method generateHtmlUsing: aHtmlGenerator"

	^ '<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<title>Smalltalk REPL using PharoJS</title>
<link rel="stylesheet" type="text/css" href="https://pharojs.org/css/pharoJS.css"/>
 </head>
<body style="padding:2px;">
	<div class="pjHeader">
		<a href="http://pharojs.org"><img alt="PharoJS Logo" src="https://pharojs.org/img/pharoJsBicolorLogo2016-08-12.png" style="width:200px;"></a>
		<h1 style="margin-top:2px;">Smalltalk REPL using PharoJS</h1>
    </div>
    <p>Type in any Smalltalk code, then hit the "Eval" button</p>
	<script src="index.js"></script>
</body>
</html>'
]

{ #category : #initialization }
WrFetchCodeGenerator >> initialize [
	super initialize.
	appClass := WrFetchClient.
	
]
