"
I am a Server delegate used by WrServer to handle the actual requests.

I do all the actual work of the requests.

The current implementation of `evaluate:` is not sufficiently robust!
"
Class {
	#name : #WrServerDelegate,
	#superclass : #Object,
	#instVars : [
		'prefixMap'
	],
	#category : #'WebStREPL-Server'
}

{ #category : #responses }
WrServerDelegate >> css: request [
	| css |"#1E90FF"
	css :=
	'body { color: #2080E0; background: white; width: 900px; font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 13px }
p { width: 600px; padding: 0 20px 10px 20px }
ul, ol { width: 600px; padding: 0 5px 5px 30px }
code {
 background: #f8f8ff; color: black; margin: 30px 30px 30px 30px
}
#banner img {
    max-width: 100%;
    max-height: 150px;
}'
	.
	^ ZnResponse ok: (ZnEntity css: css)
]

{ #category : #'public access' }
WrServerDelegate >> evaluate: string [
	| output |
	output := String streamContents: [ :out | 
		[ 	| compiler result |
			compiler := [ self class compiler ] 
								on: MessageNotUnderstood 
								do: [ Smalltalk at: #Compiler "for Pharo 2.0" ].		
			result := compiler evaluate: string. 
			out print: result; cr ]
			on: Error
			do: [ :exception |
				out print: exception; cr.
				exception signalerContext printDetails: out.
				exception signalerContext sender debugStack: 8 on: out ].
		out cr ].
	^ String lf join: output lines
]

{ #category : #responses }
WrServerDelegate >> favicon: request [
	"Answer a nice favicon for browsers to display"

	| entity |
	entity := ZnEntity with: "ZnConstants" self faviconBytes type: 'image/vnd.microsoft.icon'. 
	^ ZnResponse ok: entity
]

{ #category : #data }
WrServerDelegate >> faviconBytes [
	^ #(
 0 0 1 0 1 0 16 16 0 0 1 0 4 0 40 1
 0 0 22 0 0 0 40 0 0 0 16 0 0 0 32 0
 0 0 1 0 4 0 0 0 0 0 0 1 0 0 0 0
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 254 249
 228 0 250 234 197 0 226 221 229 0 247 224 179 0 243 212
 156 0 193 188 225 0 240 204 141 0 237 194 121 0 233 184
 103 0 147 143 226 0 228 168 73 0 223 157 51 0 219 145
 29 0 97 91 220 0 63 59 222 0 34 30 220 0 0 0
 22 171 186 97 0 0 0 6 203 115 19 106 96 0 0 140
 128 0 0 0 103 0 6 200 0 0 0 0 4 64 12 189
 254 32 223 253 32 128 108 117 159 208 213 94 224 52 140 48
 13 224 0 9 245 7 172 16 9 242 0 159 242 7 172 16
 5 245 13 254 80 8 140 64 2 249 15 224 0 23 76 160
 0 253 14 226 37 99 11 196 0 222 5 239 253 160 3 204
 48 2 0 2 42 48 0 76 200 16 0 6 180 0 0 3
 172 203 171 202 48 0 0 0 3 120 135 48 0 0 0 0
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
) asByteArray
]

{ #category : #public }
WrServerDelegate >> handleRequest: request [
	| prefix prefixHandler |
	"self halt."
	prefix := request uri isSlash
		ifTrue: [ prefixMap at: '/' ifAbsent: [ nil ] ]
		ifFalse: [ request uri firstPathSegment ].
	prefixHandler := prefixMap at: prefix ifAbsent: [ nil ].
	prefixHandler ifNotNil: [ 
			^ prefixHandler isSymbol
				ifTrue: [ self perform: prefixHandler with: request ]
				ifFalse: [ prefixHandler value: request ] ].
	^ ZnResponse notFound: request uri
]

{ #category : #responses }
WrServerDelegate >> index: request [
	| page query |
	query := request uri queryAt: #q ifAbsent: [''].
	page := ZnHtmlOutputStream streamContents: [ :html | "self halt."
		html
			html5;
			tag: #html do: [
				html
					tag: #head do: [
						html
							tag: #title with: 'Smalltalk REPL using PharoJS';
							tag: #link attributes: #(rel stylesheet href 'all.css' type 'text/css') with: ''
					];
					tag: #body do: [
						html
							tag: #div id: #banner do: [
								html tag: #a attributes: #(href 'http://pharojs.org') do: [
									html tag: #img attributes: #(src 'https://pharojs.github.io/img/pharoJsBicolorLogo2016-08-12.png')]];
							tag: #h1 with: 'Smalltalk REPL using PharoJS';
							tag: #p with: 'Type in any Smalltalk code, then hit the "Eval" button';
							tag: #form attributes: #(method 'GET') do: [
								html
									tag: #textarea attributes: #(id inputTextArea name q) with: query;
									tag: #button attributes: #(id evalButton) with: 'Eval';
									tag: #br; tag: #br.
								query isEmptyOrNil ifFalse: [
									html tag: #code with: (self evaluate: query)
								].
							];
							tag: #script attributes: #(src 'index.js')

		]]].
	^ ZnResponse ok: (ZnEntity html: page)
]

{ #category : #initialization }
WrServerDelegate >> initialize [
	self
		map: 'ping' to: #ping:;
		map: 'favicon.ico' to: #favicon:;
		map: 'index.html' to: #index:;
		map: 'all.css' to: #css:;
		map: 'index.js' to: #js:;
		map: '/' to: 'ping'
]

{ #category : #responses }
WrServerDelegate >> js: request [

	^ ZnResponse ok: (ZnEntity javascript: '/* empty */')
]

{ #category : #accessing }
WrServerDelegate >> map: prefix to: handler [
	"Arrange for the receiver to dispatch requests matching prefix to handler.
	Handler can be a symbol naming a method in the receiver, 
	or a block accepting the request and producing the response.
	The special prefix '/' is resolved first and can refer to another prefix."
	
	self prefixMap 
		at: prefix
		put: handler
		
]

{ #category : #responses }
WrServerDelegate >> ping: request [
	^ ZnResponse ok: (ZnEntity html: 'pong')
]

{ #category : #accessing }
WrServerDelegate >> prefixMap [
	^ prefixMap ifNil: [ prefixMap := Dictionary new ]
]
