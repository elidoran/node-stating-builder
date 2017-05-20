# @stating/builder
[![Build Status](https://travis-ci.org/elidoran/node-stating-builder.svg?branch=master)](https://travis-ci.org/elidoran/node-stating-builder)
[![Dependency Status](https://gemnasium.com/elidoran/node-stating-builder.png)](https://gemnasium.com/elidoran/node-stating-builder)
[![npm version](https://badge.fury.io/js/%40stating%2Fbuilder.svg)](http://badge.fury.io/js/%40stating%2Fbuilder)
[![Coverage Status](https://coveralls.io/repos/github/elidoran/node-stating-builder/badge.svg?branch=master)](https://coveralls.io/github/elidoran/node-stating-builder?branch=master)

Help build nodes for [stating](https://www.npmjs.com/package/stating).

Each stating node is a function. This package helps build common node functions.

See [stating](https://www.npmjs.com/package/stating) package to learn about how these nodes are added to a `stating` instance.


## Install

```sh
npm install --save @stating/builder
```


## Usage

```javascript
// returns a builder function
var buildBuilder = require('@stating/builder')

// build a new builder to add plugins to and use
var builder = buildBuilder()

// add a plugin which provides a static string consumer node.
builder.use('@stating/string-plugin')

// now build a node to match the word "true"
var trueNode = builder.string('true')

// trueNode is a function which will wait for 4 bytes of input
// and then test if the next 4 bytes is 'true'.
// it will control.fail() if it's not.
// it will control.next() if it is.

// add it to your stating instance:
stating.add('true', trueNode)

// create others ...
// and add more plugins and use them...

// load some plugins when building it:
builder = buildBuilder({

  // if some plugins to load are local modules set the root:
  root: __dirname,

  // provide shared options to plugins:
  options: {},

  load: [
    // list stuff to load.
    // the same things you'd provide to builder.use()
  ]
})
```


## Plugins

1. [@stating/string-plugin](https://www.npmjs.com/package/@stating/string-plugin)
2. TODO: more plugins...
3. feel free to ask to contribute plugins to the `@stating` scope


## Make a Plugin

Here's a super simple example to see the three parts:

1. the exported plugin function for `builder.use()`
2. the exported build function placed onto the builder
3. a stating node function which is used repeatedly

```javascript
// see `stating` package for what to do in a node.
// this one simply calls next(). it does nothing really.
function next(control, nodes) {
  // NOTE: this would do analysis work and choose to
  // wait() next() or fail()...
  control.next()
}

// the build function added to the builder by this plugin.
// it returns the same node function all the time.
function myBuild() {
  // NOTE: this could generate a closure based on
  // the args provided.
  return someFn
}

// export the plugin function added to @stating/builder
module.exports = function myPlugin(options, builder) {
  // simply add the build function to the builder
  builder.myBuild = myBuild

  // NOTE:
  //  could do more work here. make closures.
  //  assign multiple functions.
  //  some functions could rely on others by using `this`
  //  in them.
}
```


## Debugging Breakpoint

To add a debugging breakpoint wrap the generated function and set a breakpoint.

```javascript
function wrappedTrueNode(control, N, context) {
  // set a breakpoint here... then step into trueNode.
  trueNode.call(context, control, N, context)  
}

// add the wrapped version instead.
stating.add('true', wrappedTrueNode)
```


# [MIT License](LICENSE)
