# WebStREPL

Smalltalk is almost unique in being (mostly) `image-based` - that is, code is usually part of an entire image of live objects, including classes and methods. ([GNU Smalltalk](https://smalltalk.gnu.org/) being a prominent exceptioni, and APL/J being the next most prominent image-based language.)

This has led to Smalltalk having a best-in-class development environment, but not really having a REPL (Read-Eval-Print Loop) which would be convenient for simple experimentation and web-based demonstrations (of course, this is unnecessary within a Smalltalk environment because virtually any expression anywhere can be selected and evaluated/inspected/printed).

This issue was highlighted by [Programming Idioms](https://programming-idioms.org/) because most of the other languages have a convenient web-based way to explore the idioms, and the way it is set up is oriented toward having a REPL.

So we decided to use [PharoJS](https://github.com/PharoJS/PharoJS) to implement a web-based, Smalltalk REPL.

## Warning

At the moment this is not ready to be exposed to a public link, because it does a simple `evaluate:` of whatever the remote browser sends which is a serious security hazard (they can do anything with your image!!!). However, it shows a simple client-server interaction which may be instructive.

We will shortly have a secure solution.

## Install
```st
Metacello new
  baseline: 'WebStREPL';
  repository: 'github://PharoJS/WebStREPL:main';
  load
  ```
