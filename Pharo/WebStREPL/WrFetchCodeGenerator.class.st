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
<style>
body{padding:2px}
h1{margin-top:2px}
textarea,div{font-family: Monaco, "Lucida Console", monospace}
textarea{width: 30em; height: 6ex; box-sizing: border-box}
button{min-width: 6em; padding: 5px; background-color: rgb(230, 250, 255); color: rgb(51, 153, 235); font-size: 1.1em; border-radius: 3px}
pre{box-sizing: border-box; background-color: lightgray; padding: 10px; min-width: 30px}
</style>
 </head>
<body>
	<div class="pjHeader">
		<a href="http://pharojs.org"><img alt="PharoJS Logo" src="https://pharojs.org/img/pharoJsBicolorLogo2016-08-12.png" style="width:200px;"></a>
		<h1>Smalltalk REPL using PharoJS</h1>
    </div>
	<script src="index.js"></script>
</body>
</html>'
]

{ #category : #initialization }
WrFetchCodeGenerator >> initialize [
	super initialize.
	appClass := WrFetchClient.
	
]
