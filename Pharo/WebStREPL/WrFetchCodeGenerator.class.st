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
textarea,div,pre{font-family: Monaco, "Lucida Console", monospace;font-size: 1em; box-sizing: border-box; margin: 0.5em 0px}
textarea{width: 30em; height: 6ex; vertical-align:middle;}
button{min-width: 6em; padding: 5px; color: rgb(230, 250, 255); background-color: rgb(51, 153, 235); font-size: 1.1em; border-radius: 3px; border-color: rgb(51, 153, 235); margin-left:10px;}
button:hover, button:focus{
background-color: rgb(230, 250, 255); color: rgb(51, 153, 235);
}
pre.input{margin-top: 1.5em}
pre.output{background-color: rgb(200,200,200); padding: 5px; min-width: 30px}
.hiddenTranscript{display:none}
.transcript{background-color: rgb(230,230,230)}
pre.transcript{margin-top: 0; padding: 5px; min-width: 30px; border: thin solid black}
</style>
 </head>
<body>
	<div class="pjHeader">
		<a href="http://pharojs.org"><img alt="PharoJS Logo" src="https://pharojs.org/img/pharoJsBicolorLogo2016-08-12.png" style="width:200px;"></a>
		<h1>Smalltalk REPL using PharoJS</h1>
    </div>
	<script src="repl/index.js"></script>
</body>
</html>'
]

{ #category : #initialization }
WrFetchCodeGenerator >> initialize [
	super initialize.
	appClass := WrFetchClient.
	
]
