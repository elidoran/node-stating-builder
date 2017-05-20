assert = require 'assert'
equal = require 'deep-eql'

build = require '../../lib/index.js'

describe 'test builder', ->

  it 'should build', -> assert build()


  it 'should accept defaults', ->

    builder = build defaults: some: 'default'
    options = null
    builder.use (o) -> options = o
    assert options
    assert.equal options.some, 'default'


  it 'should accept load array', ->

    pluginOptions = shared: 'plugin options'

    builder = build
      options: pluginOptions
      root: __dirname
      load: [
        '../helpers/a'
        '../helpers/b'
        '../helpers/c'
      ]

    assert.equal builder.a, true
    assert.equal builder.b, true
    assert.equal builder.c, true

    assert equal builder.aOptions, pluginOptions
    assert equal builder.bOptions, pluginOptions
    assert equal builder.cOptions, pluginOptions


  # it '', ->
