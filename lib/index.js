var use = require('@use/it')

module.exports = function build(options) {
  var builder

  // make a new object each time.
  // it *could* have custom default options.
  builder = {
    use: (options && options.defaults)
           ? use.withOptions(options.defaults)
           : use
  }

  // if options have an array of plugins to load now...
  if (options && options.load && options.load.length > 0) {
    builder.use(options.load, options.options, options.root)
  }

  return builder
}
